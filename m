Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267280AbSK3S1h>; Sat, 30 Nov 2002 13:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267281AbSK3S1h>; Sat, 30 Nov 2002 13:27:37 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:32266 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267280AbSK3S1g>; Sat, 30 Nov 2002 13:27:36 -0500
Date: Sat, 30 Nov 2002 19:34:56 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-ac1
Message-ID: <20021130183456.GJ18259@louise.pinerecords.com>
References: <20021130114049.GA1735@steffen-moser.de> <200211301345.gAUDjJO16145@devserv.devel.redhat.com> <20021130164022.GH18259@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021130164022.GH18259@louise.pinerecords.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So would the following make things more explicit?
> 
> diff -urN linux-2.4.20-ac1/drivers/ide/ide-dma.c linux-2.4.20-ac1.x/drivers/ide/ide-dma.c
> --- linux-2.4.20-ac1/drivers/ide/ide-dma.c	2002-11-30 17:37:32.000000000 +0100
> +++ linux-2.4.20-ac1.x/drivers/ide/ide-dma.c	2002-11-30 17:34:22.000000000 +0100
> @@ -627,6 +627,7 @@
>  {
>  	drive->using_dma = 1;
>  	ide_toggle_bounce(drive, 1);
> +	printk(KERN_INFO "%s: DMA enabled\n", drive->name);
>  	return HWIF(drive)->ide_dma_host_on(drive);
>  }

with the above applied:

VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST380021A, ATA DISK drive
hda: DMA disabled
blk: queue c02d28a0, I/O limit 4095Mb (mask 0xffffffff)
hda: DMA enabled
hdc: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
hdd: CD-532E-B, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
hdc: DMA enabled
hdd: DMA disabled
hdd: DMA enabled
...

Not all that cool, is it?  I'm pretty sure the "hda: DMA disabled"
message is printed after via_init_one() completes, but that's just
about all I've been able to find out. :(

-- 
T.
