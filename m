Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTKXSIP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 13:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTKXSIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 13:08:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11907 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261294AbTKXSIN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 13:08:13 -0500
Date: Mon, 24 Nov 2003 13:10:46 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
cc: Jakob Lell <jlell@JakobLell.de>, linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
In-Reply-To: <20031124183757.A2507@ss1000.ms.mff.cuni.cz>
Message-ID: <Pine.LNX.4.53.0311241307560.18675@chaos>
References: <200311241736.23824.jlell@JakobLell.de> <Pine.LNX.4.53.0311241205500.18425@chaos>
 <20031124183757.A2507@ss1000.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Rudo Thomas wrote:

> > A setuid binary created with a hard-link will only work as a setuid
> > binary if the directory it's in is owned by root. [...]
>
> This is not true, just verified it.
>
> Rudo.
>
Really? Has your system been hacked?

Script started on Mon Nov 24 12:56:36 2003
# cat xxx.c

#include <stdio.h>
#include <unistd.h>

int main()
{
   setuid(0);
   setgid(0);
   system("whoami");
   return 0;
}
# gcc -o /tmp/xxx xxx.c
# cd /tmpo 
# chmod 4755 xxx
# su johnson
$ pwd
/tmp
$ ./xxx
root
$ cd ~
$ cp /tmp/xxx .
$ ls -la xxx
-rwxr-xr-x   1 rjohnson guru         4887 Nov 24 12:57 xxx
$ ./xxx
rjohnson
$ chmod 4755 xxx
$ ./xxx
rjohnson
$ rm xxx
$ ln /tmp/xxx xxx
$ ./xxx
rjohnson
You have new mail in /var/spool/mail/root
$ exit
exit

Script done on Mon Nov 24 13:00:08 2003


This clearly shows that once the file exists in a non-root
directory, it will not function as setuid root.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


