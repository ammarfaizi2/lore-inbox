Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262642AbRE3VbI>; Wed, 30 May 2001 17:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbRE3Va6>; Wed, 30 May 2001 17:30:58 -0400
Received: from ns.caldera.de ([212.34.180.1]:29165 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S262642AbRE3Vas>;
	Wed, 30 May 2001 17:30:48 -0400
Date: Wed, 30 May 2001 23:30:05 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcus Meissner <mm@ns.caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: ln -s broken on 2.4.5
Message-ID: <20010530233005.A27497@caldera.de>
In-Reply-To: <200105301923.f4UJNl815303@ns.caldera.de> <E155CH3-0006XA-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E155CH3-0006XA-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, May 30, 2001 at 09:08:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 09:08:56PM +0100, Alan Cox wrote:
> > > What file system. Its find on my 2.4.5-ac with ext2
> > 
> > 100% reproducible on NFS and EXT2 here, with following:
> 
> 
> > $ ls -la bar
> > lrwxrwxrwx   1 marcus   users           3 May 30 20:30 bar -> bar
> 
> bash-2.04$ uname -a
> Linux irongate.swansea.linux.org.uk 2.4.5-ac2 #163 Mon May 28 22:56:38 BST 2001 i686 unknown
> bash-2.04$ ln -s frobnitz flop
> bash-2.04$ ls -l f*
> lrwxrwxrwx    1 alan     users           8 May 30 20:50 flop -> frobnitz
> 
> bash-2.04$ gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81

The problem is only there if you specify a directory for the linked to
component.

[marcus@wine /tmp]$ strace -f ln -s fupp/berk xxx
execve("/bin/ln", ["ln", "-s", "fupp/berk", "xxx"], [/* 39 vars */]) = 0
... ld stuff ... locale stuff ... 
lstat64("xxx", 0xbffff47c)              = -1 ENOENT (No such file or directory)
lstat64("xxx", 0xbffff47c)              = -1 ENOENT (No such file or directory)
symlink("fupp/berk", "xxx")             = 0
_exit(0)                                = ?
[marcus@wine /tmp]$ ll xxx
lrwxrwxrwx   1 marcus   users           3 May 30 22:36 xxx -> xxx
[marcus@wine /tmp]$ uname -a
Linux wine.lst.de 2.4.5-ac4 #3 SMP Tue May 29 18:24:07 CEST 2001 i686 unknown
[marcus@wine /tmp]$ 

It works just wonderful with previous kernels.

Ciao, Marcus
