Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132658AbRDQIAJ>; Tue, 17 Apr 2001 04:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132659AbRDQIAA>; Tue, 17 Apr 2001 04:00:00 -0400
Received: from mail.axisinc.com ([193.13.178.2]:32521 "EHLO roma.axis.se")
	by vger.kernel.org with ESMTP id <S132658AbRDQH7r>;
	Tue, 17 Apr 2001 03:59:47 -0400
From: johan.adolfsson@axis.com
Message-ID: <032e01c0c714$ba76e000$a4b270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: "Rob Landley" <telomerase@yahoo.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010414010504.2967.qmail@web5201.mail.yahoo.com>
Subject: Re: How do I make a circular pipe?
Date: Tue, 17 Apr 2001 10:02:19 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't you do it like this?
# mkfifo fifo
# pppd notty < fifo | pppoe -I eth1 >fifo
/Johan

----- Original Message -----
From: Rob Landley <telomerase@yahoo.com>
To: <linux-kernel@vger.kernel.org>
Sent: Saturday, April 14, 2001 3:05 AM
Subject: How do I make a circular pipe?


> How do I do the following:
>
> #  --> pppd notty | pppoe -I eth1 | --
>    |_________________________________|
>
> I.E. connect the stdout of a process  (or chain
> thereof) to its own stdin?
>
> So I wrote a program to do it, along the lines of:
>
> sixty-nine /bin/sh -c "pppd notty | pppoe -I eth1"
>
> With an executable approximately along the lines of
> (warning, pseudo-code, the other machine isn't hooked
> up to the internet at the moment for obvious reasons):
>
> int main(int argc, char *argv[], char *envp[])
> {
>   int fd[2];
>   pipe(fd);
>   dup2(fd[0],0);
>   dup2(fd[0],1);
>   execve(argv[1],argv+1,envp);
>   fprintf(stderr,"Bad.\n");
>   exit(1);
> }
>
> And it didn't work.  I made a little test program that
> writes to stdout and reads from stdin and reports to
> stderr, and it gets nothing.  Apparently, the pipe
> fd's evaporate when the process does an execve.
>
> What do I do?  (If anybody else knows an easier way to
> get pppoe working, that would be helpful too.
>
> Rob
>
> (P.S.  WHY does pppd want to talk to a tty by default
> instead of stdin and stdout?  Were the people who
> wrote it at all familiar with the unix philosophy?
> Just curious...)
>
> __________________________________________________
> Do You Yahoo!?
> Get email at your own domain with Yahoo! Mail.
> http://personal.mail.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

