provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "TLAB7-VPC"
  }
}

resource "aws_security_group" "sabotaged_sg" {
  name        = "tlab7-exposed-sg"
  description = "A dangerously exposed security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["74.64.35.195/32"] # SABOTAGE: SSH exposed to the world
  }
}