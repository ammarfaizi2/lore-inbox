Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132650AbRAKQyp>; Thu, 11 Jan 2001 11:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132618AbRAKQyg>; Thu, 11 Jan 2001 11:54:36 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:57350 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S132610AbRAKQyV>;
	Thu, 11 Jan 2001 11:54:21 -0500
Date: Thu, 11 Jan 2001 16:54:14 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: <andre@linux-ide.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IDE DMA problem in 2.4.0
Message-ID: <Pine.LNX.4.30.0101111640120.5788-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When copying huge files from one disk to another (hda->hdc), I get the
following error (after some hundred megabytes):

hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0xd1 { Busy }
hdc: DMA disabled
ide1: reset: success

I got this using dd with a block size of 32kB, reading a large file on
hda, writing directly to hdc1.  I tried with another disk as hdc
(a Samsung), and I have tried two different cables.  Still no go.  Well,
it does work, of course, but much slower since DMA has been disabled.

I have been unable to reproduce this error using
	dd bs=32k if=/dev/zero of=/dev/hdc1
or
	dd bs=32k if=/dev/hdc1 of=/dev/null

Everything works fine in 2.2.16-22 from RedHat 7 (with DMA enabled using
hdparm).

Here is a relevant part of the startup log (I hope):

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c596b IDE UDMA66 controller on pci0:7.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: SAMSUNG SV2044D, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: ST38421A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39862368 sectors (20410 MB) w/472KiB Cache, CHS=2481/255/63, UDMA(66)
hdc: 16498944 sectors (8447 MB) w/256KiB Cache, CHS=16368/16/63, UDMA(33)

Did I miss anything?

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
