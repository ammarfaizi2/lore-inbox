Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261467AbSJADh4>; Mon, 30 Sep 2002 23:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261469AbSJADh4>; Mon, 30 Sep 2002 23:37:56 -0400
Received: from mesatop.zianet.com ([216.234.192.105]:46603 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S261467AbSJADhy>; Mon, 30 Sep 2002 23:37:54 -0400
Subject: Re: 2.5.39 Oops on boot (device_attach+0x3a)
From: Steven Cole <elenstev@mesatop.com>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209302147380.961-100000@dad.molina>
References: <Pine.LNX.4.44.0209302147380.961-100000@dad.molina>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 30 Sep 2002 21:38:33 -0600
Message-Id: <1033443514.3100.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 20:50, Thomas Molina wrote:
> On 30 Sep 2002, Steven Cole wrote:
> 
> > I tried to boot 2.5.39 on my home machine and got the
> > following oops on boot with CONFIG_KALLSYMS=y (thanks Ingo!).
> > 
> > *pde = 00000000
> > Oops: 0002
> > 
> > CPU:	0
> > EIP:	0060:[<c01a7979>]	Not tainted
> > EFLAGS:	00010286
> > EIP is at attach+0x1d/0x30
> > eax: c0276724	ebx: 00000000	ecx: c40c8060	edx: c40c8078
> > esi: c0276700	edi: 00000000	ebp: 00000000	esp: c40ddf94
> > ds:  0068 	es: 0068	ss: 0068
> > Process swapper (pid: 1, threadinfo=c40dc000 task=c40da040)
> > Stack: 00000000 c01a7a5a c40c8060 c40c8060 c01a7c20 c40c8060 c40c8060 c40c8060
> >        c40d7720 c028b879 c40c8060 00000001 c02b9bf4 00000000 00000000 00000000
> >        c027e6f2 c0105030 c010504c c0105030 00000000 00000000 00000000 c0105495
> > Call Trace:
> > [<c01a7a5a>] device_attach+0x3a/0x40
> > [<c01a7c20>] device_register+0xd0/0x120
> > [<c0105030>] init+0x0/0x160
> > [<c010504c>] init+0x1c/0x160
> > [<c0105030>] init+0x0/0x160
> > [<c0105495>] kernel_thread_helper+0x5/0x10
> > 
> 
> I believe the oops on boot people have been seeing in 2.5.39 may be 
> related to problems inserting ide-scsi modules (sr_mod, mod_scsi, 
> ide-scsi).  Since I have to get up early tomorrow I'm going to beg off for 
> tonight, but I can reliably produce the above oops.  I'll provide full 
> data and explanations when I'm not so tired.  
> 
It's good that the above oops can be reproduced, so here is some more
info on my setup:

[steven@localhost linux-2.5.39-linus]$ grep "=m" .config
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PRINTER=m
CONFIG_AUTOFS_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NLS_ISO8859_1=m

[steven@localhost linux-2.5.39-linus]$ grep SCSI .config
# SCSI device support
# CONFIG_SCSI is not set
# Old non-SCSI/ATAPI CD-ROM drives
# CONFIG_CD_NO_IDESCSI is not set
[steven@localhost linux-2.5.39-linus]$ find . -name Makefile | xargs grep sr_mod
./drivers/scsi/Makefile:obj-$(CONFIG_BLK_DEV_SR)        += sr_mod.o
./drivers/scsi/Makefile:sr_mod-objs     := sr.o sr_ioctl.o sr_vendor.o
[steven@localhost linux-2.5.39-linus]$ grep BLK_DEV_SR .config
[steven@localhost linux-2.5.39-linus]$

So, I'm not sure that a scsi-related module is the cause here.

Cheers,
Steven



