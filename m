Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132747AbRDNBF5>; Fri, 13 Apr 2001 21:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132745AbRDNBFr>; Fri, 13 Apr 2001 21:05:47 -0400
Received: from web5201.mail.yahoo.com ([216.115.106.95]:9487 "HELO
	web5201.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132739AbRDNBFf>; Fri, 13 Apr 2001 21:05:35 -0400
Message-ID: <20010414010504.2967.qmail@web5201.mail.yahoo.com>
Date: Fri, 13 Apr 2001 18:05:04 -0700 (PDT)
From: Rob Landley <telomerase@yahoo.com>
Subject: How do I make a circular pipe?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I do the following:

#  --> pppd notty | pppoe -I eth1 | --
   |_________________________________|

I.E. connect the stdout of a process  (or chain
thereof) to its own stdin?

So I wrote a program to do it, along the lines of:

sixty-nine /bin/sh -c "pppd notty | pppoe -I eth1"

With an executable approximately along the lines of
(warning, pseudo-code, the other machine isn't hooked
up to the internet at the moment for obvious reasons):

int main(int argc, char *argv[], char *envp[])
{
  int fd[2];
  pipe(fd);
  dup2(fd[0],0);
  dup2(fd[0],1);
  execve(argv[1],argv+1,envp);
  fprintf(stderr,"Bad.\n");
  exit(1);
}

And it didn't work.  I made a little test program that
writes to stdout and reads from stdin and reports to
stderr, and it gets nothing.  Apparently, the pipe
fd's evaporate when the process does an execve.

What do I do?  (If anybody else knows an easier way to
get pppoe working, that would be helpful too.

Rob

(P.S.  WHY does pppd want to talk to a tty by default
instead of stdin and stdout?  Were the people who
wrote it at all familiar with the unix philosophy? 
Just curious...)

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
