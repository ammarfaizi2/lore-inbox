Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262762AbRE3Vm7>; Wed, 30 May 2001 17:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262814AbRE3Vmu>; Wed, 30 May 2001 17:42:50 -0400
Received: from feeder.cyberbills.com ([64.41.210.81]:64018 "EHLO
	sjc-smtp1.cyberbills.com") by vger.kernel.org with ESMTP
	id <S262762AbRE3Vml>; Wed, 30 May 2001 17:42:41 -0400
Date: Wed, 30 May 2001 14:42:27 -0700 (PDT)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: Marcus Meissner <Marcus.Meissner@caldera.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Marcus Meissner <mm@ns.caldera.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ln -s broken on 2.4.5
In-Reply-To: <20010530233005.A27497@caldera.de>
Message-ID: <Pine.LNX.4.31ksi3.0105301435290.22829-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Marcus Meissner wrote:

> On Wed, May 30, 2001 at 09:08:56PM +0100, Alan Cox wrote:
> > > > What file system. Its find on my 2.4.5-ac with ext2
> > >
> > > 100% reproducible on NFS and EXT2 here, with following:
> >
> >
> > > $ ls -la bar
> > > lrwxrwxrwx   1 marcus   users           3 May 30 20:30 bar -> bar
> >
> > bash-2.04$ uname -a
> > Linux irongate.swansea.linux.org.uk 2.4.5-ac2 #163 Mon May 28
> 22:56:38 BST 2001 i686 unknown
> > bash-2.04$ ln -s frobnitz flop
> > bash-2.04$ ls -l f*
> > lrwxrwxrwx    1 alan     users           8 May 30 20:50 flop ->
> frobnitz
> >
> > bash-2.04$ gcc -v
> > Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> > gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81
>
> The problem is only there if you specify a directory for the linked to
> component.
>
> [marcus@wine /tmp]$ strace -f ln -s fupp/berk xxx
> execve("/bin/ln", ["ln", "-s", "fupp/berk", "xxx"], [/* 39 vars */]) =
> 0
> ... ld stuff ... locale stuff ...
> lstat64("xxx", 0xbffff47c)              = -1 ENOENT (No such file or
> directory)
> lstat64("xxx", 0xbffff47c)              = -1 ENOENT (No such file or
> directory)
> symlink("fupp/berk", "xxx")             = 0
> _exit(0)                                = ?
> [marcus@wine /tmp]$ ll xxx
> lrwxrwxrwx   1 marcus   users           3 May 30 22:36 xxx -> xxx
> [marcus@wine /tmp]$ uname -a
> Linux wine.lst.de 2.4.5-ac4 #3 SMP Tue May 29 18:24:07 CEST 2001 i686
> unknown
> [marcus@wine /tmp]$
>
> It works just wonderful with previous kernels.

Works here:

=== Cut ===
[root@nomad tmp]# uname -a
Linux nomad.cyberbills.com 2.4.5ac4 #1 SMP Wed May 30 11:55:15 PDT 2001 i686
unknown
[root@nomad tmp]# touch 2/dummy
[root@nomad tmp]# ln -s 2/dummy very_dummy
[root@nomad tmp]# ls -l very_dummy
lrwxrwxrwx    1 root     root            7 May 30 14:37 very_dummy -> 2/dummy
=== Cut ===

EXT2, loaded as module.

There are other problems (may be caused by R.Gooch's latest patch,
devfs-177) - no module autoloading complaining about "/dev//floppy/0" etc.
(there are 2 slashes after /dev, it's not a mistake). Recompiling ac5
without that patch, may be it'll help.

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8808
Henderson, NV 89014

