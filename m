Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTFBJd1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTFBJd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:33:27 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:24328
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262066AbTFBJd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:33:26 -0400
Date: Mon, 2 Jun 2003 02:22:45 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
cc: reid@reidspencer.com, Linus Torvalds <torvalds@transmeta.com>,
       jgarzik@pobox.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>
Subject: Re: Any experience with Promise PDC20376 and SATA RAID?
In-Reply-To: <3ED8D709.9060807@gmx.net>
Message-ID: <Pine.LNX.4.10.10306020215530.23914-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I need to sit down with JG, AC, BZ, JA and work out a TF <> FIS lib for
First Party DMA.

I need to rip the SATA 1.0 out of drivers/ide/* and move it to a
scsi-sata.c,h and create a sas.c,h then generate a sata-sas-lib.c,h
solution.  Then abstract way the timings and setups to the scsi-template.

Obviously TCQ in FPDMA via direct FIS will map to SCSI with less pain.

I have FPDMA cores.

Cheers,

On Sat, 31 May 2003, Carl-Daniel Hailfinger wrote:

> Reid Spencer wrote:
> > I think the kernel doesn't know about the device number (105a:3376 =
> > PDC20376) since it isn't in the kernel's drivers/pci/pci.ids file
> > (latest device is 7275 PDC20277)and it doesn't recognize the device when
> > it processes the IDE devices at boot up. All I get is:
> > 
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx
> > VP_IDE: IDE controller at PCI slot 00:11.1
> > VP_IDE: chipset revision 6
> > VP_IDE: not 100% native mode: will probe irqs later
> > VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
> >     ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:pio
> > hda: WDC WD400AB-32BVA0, ATA DISK drive
> > blk: queue c03c58e0, I/O limit 4095Mb (mask 0xffffffff)
> > hdc: ATAPI 52X CDROM, ATAPI CD/DVD-ROM drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > hda: attached ide-disk driver.
> > hda: host protected area => 1
> > hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63,
> > UDMA(100)
> > ide-floppy driver 0.99.newide
> > Partition check:
> >  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
> > ide-floppy driver 0.99.newide
> > 
> > Note that ide2 isn't found even though I specifically gave the ports for
> > it on the "append line" of the boot.  I don't know enough about the
> > IDE/PDC support to be able to add support for this new PDC20376 chip.
> > 
> > Anyone out there done this?
> > 
> > Reid.
> > 
> 

Andre Hedrick
LAD Storage Consulting Group

