Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318063AbSGRONz>; Thu, 18 Jul 2002 10:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318083AbSGRONz>; Thu, 18 Jul 2002 10:13:55 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12418 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318063AbSGRONy>; Thu, 18 Jul 2002 10:13:54 -0400
Date: Thu, 18 Jul 2002 10:18:49 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: zhengchuanbo <zhengcb@netpower.com.cn>
cc: Rudmer van Dijk <rudmer@legolas.dynup.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: problem of linux-2.4.19
In-Reply-To: <200207182159820.SM00792@zhengcb>
Message-ID: <Pine.LNX.3.95.1020718100527.16097A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, zhengchuanbo wrote:

> 
> i   replaced 'read-only' in lilo with 'read-write'. and it worked.

No!  The file-system must be mounted read-only upon startup! There
are exceptions in embedded systems and special systems that build
file-systems (root file-system ram-disks) upon startup.

> ><snip>
> >VFS: Mounted root (reiserfs filesystem) readonly.

Correct.

The init scripts should check the file-systems (using fsck) and
then mount them read-write. If you (or init) executes fsck
on r/w mounted file-systems, you may (read will) destroy them.
Look in /etc/rc.d to see what happens upon startup. Something
like `fsck -A -V -a` gets executed. Then, after than happens,
something like `mount -n -o remount,rw /` gets executed. Then,
to update /etc/mtab, somewhere there will be a `mount -f /`.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

