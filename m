Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTEVT7a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 15:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbTEVT7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 15:59:30 -0400
Received: from greenie.frogspace.net ([64.6.248.2]:19871 "EHLO
	greenie.frogspace.net") by vger.kernel.org with ESMTP
	id S263201AbTEVT7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 15:59:25 -0400
Date: Thu, 22 May 2003 13:12:27 -0700 (PDT)
From: Peter <cogwepeter@cogweb.net>
X-X-Sender: cogwepeter@greenie.frogspace.net
To: linux-kernel@vger.kernel.org
Subject: Re: DMA gone on ALI 1533
Message-ID: <Pine.LNX.4.44.0305221240040.15298-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had included kernel support for the ALI 15X3 chipset, but as a module --
and it obviously didn't load. If I include the module in /etc/modules, it
loads too late (details below). I'm assuming this means "make menuconfig"
mistakenly provides the module option? I've recompiled it into the kernel
and got DMA back (although only dma2, as before) -- thanks for the quick
feedback!

Cheers,
Peter


Details on what happens when you compile ALI 15X3 as a module -- I'm 
guessing this should not be an option?

A. Should the module have loaded automatically? I had 

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

B. I then included the module in /etc/modules and got this in dmesg:
   
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
hda: IC25N040ATCS04-0, ATA DISK drive
hdc: MATSHITACD-RW CW-8121, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=77520/16/63
 
-- that is to say, no change in first pass detection. Then this:

ALI15X3: IDE controller at PCI slot 00:10.0
ACPI: No IRQ known for interrupt pin A of device 00:10.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:pio, hdd:pio
ide0: I/O resource 0x1F0-0x1F0 not free.

I guess it was too late. 

So no performance improvement:
# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.46 seconds =275.90 MB/sec
 Timing buffered disk reads:  64 MB in 19.69 seconds =  3.25 MB/sec

lsmod:
alim15x3                7052  1 [unsafe]




