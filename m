Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277103AbRJIMuK>; Tue, 9 Oct 2001 08:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276225AbRJIMuA>; Tue, 9 Oct 2001 08:50:00 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46208 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S277103AbRJIMtw>; Tue, 9 Oct 2001 08:49:52 -0400
Date: Tue, 9 Oct 2001 08:50:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Peter Moscatt <pmoscatt@yahoo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can't exec /usr/sbin/sendmail  (After Kernel Install) ??
In-Reply-To: <20011008220328.2217.qmail@web14708.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1011009083517.3739A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001, Peter Moscatt wrote:

> I have just recently compiled my first kernel (2.4.10)
> onto my Mandrake 8.0 system.
> 
> All seems to be working fine, so I had a look at the
> 'dmesg' file in /var/log just to see it any errors
> were appearing.
> 
> I have noticed that the following is occuring:
> 
> Oct 8 19:46:53 qld anacron[818]: Job 'cron.daily'
> terminate (mailing output)
> Oct 8 19:46:53 qld anacron[1302]: Can't exec
> /usr/sbin/sendmail: No such file or directory

Merely installing a new kernel should not have affected any
of the executables. First, see if the file exists:

ls -la /usr/sbin/sendmail

If it doesn't, try to find it:

which sendmail

or:


find / -name "sendmail"

If it doesn't exist, find it in your distribution and install it.
You can actually just do the following from the root account:

cp /wherever_on_distribution/sendmail /usr/sbin/sendmail
chown 0.0 /usr/sbin/sendmail
chmod 4755 /usr/sbin/sendmail

If it exists somewhere else, like  /usr/sendmail, do:

ln -s /usr/sendmail /usr/sbin/sendmail

It may exist in /lost+found. If so, don't use it. It's probably
corrupt, having been put there by fsck during startup.

If it does exist, try to find out why it blows up when being
executed, do:

strace /usr/sbin/sendmail -q

If that works, try:

strace /usr/sbin/sendmail

It should print a message and wait for input if it's working. Just
^C out. It seems to work.

Otherwise, see from strace, what system call failed and report it.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


