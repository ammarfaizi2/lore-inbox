Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129146AbRCBPSp>; Fri, 2 Mar 2001 10:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129227AbRCBPSf>; Fri, 2 Mar 2001 10:18:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9344 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129146AbRCBPSY>; Fri, 2 Mar 2001 10:18:24 -0500
Date: Fri, 2 Mar 2001 10:18:00 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Admin Mailing Lists <mlist@intergrafix.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: gids in kernel
In-Reply-To: <Pine.LNX.4.10.10103020954140.11082-100000@athena.intergrafix.net>
Message-ID: <Pine.LNX.3.95.1010302100451.1504A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Admin Mailing Lists wrote:

> 
> apache documentation states:
> #  NOTE that some kernels refuse to setgid(Group) or semctl(IPC_SET)
> #  when the value of (unsigned)Group is above 60000;
> #  don't use Group nobody on these systems!
> 
> does this apply to linux in either the 2.2 or 2.4 kernels?
> i'd like to use a block of uids from maybe 63000-65000, with
> gids of the same number, for web domains, and want to know if i'll have
> any problems.
> 
> Thanx,

Works here.

foo:x:65534:65534:Foo test:/tmp:/bin/bash

Script started on Fri Mar  2 10:07:17 2001
# ls -ls /tmp
total 0
   0 -rw-r--r--   1 65534    65534           0 Mar  2 10:03 foo
# exit
Script done on Fri Mar  2 10:07:32 2001

Execute this as root. You will find that there's no problem.

int main()
{
    setuid(65535);
    setgid(65535);
    system("whoami");
    return 0;
}

FYI, you can readily test all this stuff yourself. The Apache
documentation you quote seems strange. I don't think the
UID/GID alias problem exists on systems where Apache is likely
to be run (20 MHz VAXen running Ultrix don't make good Web Servers) 


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


