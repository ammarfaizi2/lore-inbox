Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274171AbRISUdz>; Wed, 19 Sep 2001 16:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274169AbRISUdq>; Wed, 19 Sep 2001 16:33:46 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:42491 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274171AbRISUdd>; Wed, 19 Sep 2001 16:33:33 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 19 Sep 2001 14:31:31 -0600
To: boris <boris@macbeth.rhoen.de>
Cc: Fabian Arias <dewback@vtr.net>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: Re: 2.4.9-ac12 - problem mounting reiserfs (parse error?)
Message-ID: <20010919143131.Q14526@turbolinux.com>
Mail-Followup-To: boris <boris@macbeth.rhoen.de>,
	Fabian Arias <dewback@vtr.net>, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.33.0109191053400.1244-100000@portland.hansa.lan> <Pine.LNX.4.40.0109191248360.5460-100000@ronto.dewback.cl> <20010919214735.A932@macbeth.rhoen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010919214735.A932@macbeth.rhoen.de>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 19, 2001  21:47 +0200, boris wrote:
> On Wed, Sep 19, 2001 at 12:49:54PM -0400, Fabian Arias wrote:
> > - Debian Sid
> > - mount 2.11h
> > - gcc-2.95.4 (20010902 Debian prerelease) and 3.0.2pre010908.
> 
> dito ...
>  
> > But in my case I don't have "defaults" on fstab on my reiserfs partitions:
> > 
> > /dev/hdc1  /      ext2          defaults,errors=remount-ro      0 1
> > /dev/hdc5  /home  reiserfs      rw                              0 2
> 
> but I can boot :
> 
> /dev/scsi/host0/bus0/target5/lun0/part1	/	reiserfs	defaults,errors=remount-ro	0	0
> 
> with:
> reiserfs: Unrecognized mount option errors
> 
> everything is ok until I run lilo:
> 
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> 00000000
> *pde = 00000000
> 
> Entering kdb (current=0xc58d8000, pid 738) on processor 0 Oops: Oops
> due to oops @ 0x0
> eax = 0x00000000 ebx = 0xc5a7ebd4 ecx = 0xc7bb8c9c edx = 0xc1179bf0 
> esi = 0xc1179bd4 edi = 0x00000000 esp = 0xc58d9f20 eip = 0x00000000 
> ebp = 0xc58d9f54 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010246 
> xds = 0xc1170018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc58d9eec
> 
> ....
> 0xc5a5e000 00000588 00000578  0  001  stop  0xc5a5e370 bash
> 0xc5a4c000 00000737 00000588  0  000  stop  0xc5a4c370 lilo
> 0xc58d8000 00000738 00000737  1  000  run   0xc58d8370*lilo.real
> [0]kdb> btp 738
>     EBP       EIP         Function(args)
> 0xc012a310 0x00000000 <unknown> (0xc5a7ebd4, 0xc1179bd4)
>                                kernel <unknown> 0x0 0x0 0x0
>            0xc012a310 do_generic_file_read+0x364 (0xc5a7ebd4, 0xc5a7ebf4, 0xc58d9f88, 0xc012a6fc)
>                                kernel .text 0xc0100000 0xc0129fac 0xc012a51c
> 0xc58d9f98 0xc012a7d2 generic_file_read+0x7a (0xc5a7ebd4, 0x805a920, 0x200, 0xc5a7ebf4)
>                                kernel .text 0xc0100000 0xc012a758 0xc012a8dc
> 0xc58d9fbc 0xc0138e28 sys_read+0x98 (0x4, 0x805a920, 0x200, 0x805c768, 0x3)
>                                kernel .text 0xc0100000 0xc0138d90 0xc0138e64
>            0xc01071cb system_call+0x33
>                                kernel .text 0xc0100000 0xc0107198 0xc01071d0

What version of LILO are you using?  Versions >= 21.6 _should_ automatically
do tail unpacking for mapped files via ioctl, but maybe it is not well tested.
Even so, it should NOT be possible to cause it to oops with bad data to the
ioctl, if this is the case.  I've CC'd reiserfs-list on this as well.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

