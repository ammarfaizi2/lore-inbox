Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbVFJP4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbVFJP4m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVFJP4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:56:42 -0400
Received: from smtp813.mail.ukl.yahoo.com ([217.12.12.203]:18099 "HELO
	smtp813.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262587AbVFJP4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:56:13 -0400
Message-ID: <42A9C607.4030209@unixtrix.com>
Date: Fri, 10 Jun 2005 16:55:35 +0000
From: Alastair Poole <alastair@unixtrix.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: Unusual TCP Connect() results.
References: <42A8ABDB.6080804@unixtrix.com> <42A9B193.1020602@stud.feec.vutbr.cz>
In-Reply-To: <42A9B193.1020602@stud.feec.vutbr.cz>
Content-Type: multipart/mixed;
 boundary="------------080605000103080900020202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080605000103080900020202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michal Schmidt wrote:

>>> What is the last version that works as expected for you?
>>
Kernel 2.6.11, though I can't check others due to bandwidth 
restrictions.  2.6.11.10 through 2.6.12-rc6 all have the same issue.

>>> Are you testing your scanner only on localhost? Maybe you are just 
>>> lucky and connect your TCP socket to itself.
>>
This problem only occurs on localhost.  I don't think it is mere luck, 
these are too frequent and strange for this.

>>>
>>> What are these asterisks doing there? Next time when you copy&paste 
>>> code, please make sure you don't mangle it.
>>>
I apologise for this, included this time is an attatchment in the hope 
you are able to reproduce the strange results I and others have been 
able to.  Try testing multiple times, I find that 18 out of 20 runs 
produces the same type of results.

sincerely

Alastair Poole

--------------080605000103080900020202
Content-Type: text/plain;
 name="scan.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scan.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <time.h>
#include <string.h>

int
main (int argc, char **argv)
{
 int sd, result, server_port;
 struct hostent *he;
 struct sockaddr_in servaddr;

 printf ("Test TCP/IP port scanner:\n");

 if (argc != 2)
   {
     printf ("Usage: %s host\n", argv[0]);
     exit (1);
   }

 if ((he = gethostbyname (argv[1])) == NULL)
   {
     perror ("gethostbyname()");
     exit (1);
   }

 printf ("Scanning %s\n", argv[1]);

 for (server_port = 0; server_port < 65536; server_port++)
   {
     if ((sd = socket (PF_INET, SOCK_STREAM, IPPROTO_TCP)) == -1)
    {
      perror ("socket()");
      exit (1);
    }

     bzero (&servaddr, sizeof servaddr);
     servaddr.sin_family = AF_INET;
     servaddr.sin_port = htons (server_port);
     servaddr.sin_addr = *((struct in_addr *) he->h_addr);

     result = connect (sd, (struct sockaddr *) &servaddr, sizeof servaddr);

     if (result != -1)
    {
      printf ("open port:  %d\n",server_port);
    }
     close (sd);
   }
 return result;
}


--------------080605000103080900020202--
