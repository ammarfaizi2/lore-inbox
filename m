Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274155AbRISUAP>; Wed, 19 Sep 2001 16:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274156AbRISUAH>; Wed, 19 Sep 2001 16:00:07 -0400
Received: from bigmama.rhoen.de ([62.67.55.51]:17675 "EHLO rhoen.de")
	by vger.kernel.org with ESMTP id <S274155AbRISUAB>;
	Wed, 19 Sep 2001 16:00:01 -0400
Date: Wed, 19 Sep 2001 21:47:35 +0200
To: Fabian Arias <dewback@vtr.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac12 - problem mounting reiserfs (parse error?)
Message-ID: <20010919214735.A932@macbeth.rhoen.de>
In-Reply-To: <Pine.LNX.4.33.0109191053400.1244-100000@portland.hansa.lan> <Pine.LNX.4.40.0109191248360.5460-100000@ronto.dewback.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0109191248360.5460-100000@ronto.dewback.cl>
User-Agent: Mutt/1.3.22i
From: boris <boris@macbeth.rhoen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 12:49:54PM -0400, Fabian Arias wrote:

> - Debian Sid
> - mount 2.11h
> - gcc-2.95.4 (20010902 Debian prerelease) and 3.0.2pre010908.

dito ...
 
> But in my case I don't have "defaults" on fstab on my reiserfs partitions:
> 
> /dev/hdc1  /      ext2          defaults,errors=remount-ro      0 1
> /dev/hdc5  /home  reiserfs      rw                              0 2

but I can boot :

/dev/scsi/host0/bus0/target5/lun0/part1	/	reiserfs	defaults,errors=remount-ro	0	0

with:
reiserfs: Unrecognized mount option errors

everything is ok until I run lilo:


Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000

Entering kdb (current=0xc58d8000, pid 738) on processor 0 Oops: Oops
due to oops @ 0x0
eax = 0x00000000 ebx = 0xc5a7ebd4 ecx = 0xc7bb8c9c edx = 0xc1179bf0 
esi = 0xc1179bd4 edi = 0x00000000 esp = 0xc58d9f20 eip = 0x00000000 
ebp = 0xc58d9f54 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010246 
xds = 0xc1170018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc58d9eec

....
0xc5a5e000 00000588 00000578  0  001  stop  0xc5a5e370 bash
0xc5a4c000 00000737 00000588  0  000  stop  0xc5a4c370 lilo
0xc58d8000 00000738 00000737  1  000  run   0xc58d8370*lilo.real
[0]kdb> btp 738
    EBP       EIP         Function(args)
0xc012a310 0x00000000 <unknown> (0xc5a7ebd4, 0xc1179bd4)
                               kernel <unknown> 0x0 0x0 0x0
           0xc012a310 do_generic_file_read+0x364 (0xc5a7ebd4, 0xc5a7ebf4, 0xc58d9f88, 0xc012a6fc)
                               kernel .text 0xc0100000 0xc0129fac 0xc012a51c
0xc58d9f98 0xc012a7d2 generic_file_read+0x7a (0xc5a7ebd4, 0x805a920, 0x200, 0xc5a7ebf4)
                               kernel .text 0xc0100000 0xc012a758 0xc012a8dc
0xc58d9fbc 0xc0138e28 sys_read+0x98 (0x4, 0x805a920, 0x200, 0x805c768, 0x3)
                               kernel .text 0xc0100000 0xc0138d90 0xc0138e64
           0xc01071cb system_call+0x33
                               kernel .text 0xc0100000 0xc0107198 0xc01071d0


             mfg 
                        b.
 

