provider "aws" {
  access_key = "AKIAV74BDHRRIOEL5ZYW" #replace with access key of your aws account
  secret_key = "UnjriC/0/GFucr+1UjrXooqrAzKph3feU512ZwC4" #replace with secret key of your aws account
  region     = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-06ffade19910cbfc0"
  instance_type = "t2.micro"
}

resource "aws_sqs_queue" "q" {
  name = "examplequeue"
}

resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.q.id

  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__owner_statement",
      "Effect": "Allow",
      "Principal": {
        "AWS": "412050734178"
      },
      "Action": [
        "SQS:*"
      ],
      "Resource": "arn:aws:sqs:us-west-2:412050734178:"
    }
  ]
}
POLICY
}
