Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263292AbSITR0Y>; Fri, 20 Sep 2002 13:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263298AbSITR0Y>; Fri, 20 Sep 2002 13:26:24 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:28937 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S263292AbSITR0W>; Fri, 20 Sep 2002 13:26:22 -0400
Date: Fri, 20 Sep 2002 19:31:25 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: ServerWorks CSB5 in recent -ac
Message-ID: <20020920173125.GE14336@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 1 day, 18:11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan/Andre,

it seems (U)DMA on CSB5 has only been possible to switch on w/ (a) recent
-ac kernel(s).  Of 2.4.17, 2.4.19-pre2, 2.4.19, 2.4.20-pre7, and 2.4.20-
-pre7-ac3, only the last one is capable of running the disks/cdroms in
our HP tc3100 netserver in DMA.

While it won't let us use anything above UDMA2 unless we pass ideX=ata66,
the driver still seems to work just fine when forced into, say, UDMA5.

A bit rough around the edges but perfectly usable, thanks!

Relevant boot messages follow:

Kernel command line: root=/dev/md0 ide1=ata66 rw vga=4
ide_setup: ide1=ata66
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks CSB5: IDE controller at PCI slot 00:0f.1
SvrWks CSB5: chipset revision 147
SvrWks CSB5: not 100% native mode: will probe irqs later
SvrWks CSB5: simplex device: DMA forced
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:pio, hdb:pio
SvrWks CSB5: simplex device: DMA forced
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:DMA, hdd:DMA
hdc: WDC WD800AB-00CBA0, ATA DISK drive
hdd: LTN486S, ATAPI CD/DVD-ROM drive
blk: queue c033256c, I/O limit 4095Mb (mask 0xffffffff)
ide1 at 0x170-0x177,0x376 on irq 15
hdc: host protected area => 1
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
hdd: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)

The CDROM gets autotuned to:
/dev/hdd:
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  1 (on)
 readahead    =  8 (on)

... and makes the driver spit the following upon initial read attempts:

hdd: DMA interrupt recovery
hdd: lost interrupt
hdd: status timeout: status=0xd0 { Busy }
hdd: status timeout: error=0x00
hdd: DMA disabled
hdd: drive not ready for command
hdd: ATAPI reset complete

... after which everything works ook.  Contrary to what the driver
reports, DMA doesn't get disabled.

So how's integration into vanilla going? :)

T.
