Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261519AbSJAIE5>; Tue, 1 Oct 2002 04:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261522AbSJAIE5>; Tue, 1 Oct 2002 04:04:57 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:28800 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261519AbSJAIE5>;
	Tue, 1 Oct 2002 04:04:57 -0400
Date: Tue, 1 Oct 2002 03:10:23 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Steven Cole <elenstev@mesatop.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.39 Oops on boot (device_attach+0x3a)
In-Reply-To: <1033443514.3100.24.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210010305110.1429-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Sep 2002, Steven Cole wrote:

> > I believe the oops on boot people have been seeing in 2.5.39 may be 
> > related to problems inserting ide-scsi modules (sr_mod, mod_scsi, 
> > ide-scsi).  Since I have to get up early tomorrow I'm going to beg off for 
> > tonight, but I can reliably produce the above oops.  I'll provide full 
> > data and explanations when I'm not so tired.  
> > 
> It's good that the above oops can be reproduced, so here is some more
> info on my setup:
> 
> [steven@localhost linux-2.5.39-linus]$ grep "=m" .config
> CONFIG_PARPORT=m
> CONFIG_PARPORT_PC=m
> CONFIG_PARPORT_PC_CML1=m
> CONFIG_PRINTER=m
> CONFIG_AUTOFS_FS=m
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_NLS_ISO8859_1=m
> 
> [steven@localhost linux-2.5.39-linus]$ grep SCSI .config
> # SCSI device support
> # CONFIG_SCSI is not set
> # Old non-SCSI/ATAPI CD-ROM drives
> # CONFIG_CD_NO_IDESCSI is not set
> [steven@localhost linux-2.5.39-linus]$ find . -name Makefile | xargs grep sr_mod
> ./drivers/scsi/Makefile:obj-$(CONFIG_BLK_DEV_SR)        += sr_mod.o
> ./drivers/scsi/Makefile:sr_mod-objs     := sr.o sr_ioctl.o sr_vendor.o
> [steven@localhost linux-2.5.39-linus]$ grep BLK_DEV_SR .config
> [steven@localhost linux-2.5.39-linus]$

That would seem to indicate problems within the module load/unload 
routines rather than specifically ide-scsi.  I could beleive that, 
although the only modules I could produce the oops with were sr_mod and 
ide-scsi.  I need more testing so I can produce a coherent report to lkml.

