Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277599AbRJ1DGZ>; Sat, 27 Oct 2001 23:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277601AbRJ1DGP>; Sat, 27 Oct 2001 23:06:15 -0400
Received: from astcc-134.astound.net ([24.219.123.215]:29700 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S277599AbRJ1DGF>; Sat, 27 Oct 2001 23:06:05 -0400
Date: Sat, 27 Oct 2001 20:06:36 -0700 (PDT)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Francois Romieu <romieu@cogenit.fr>
cc: Janne Liimatainen <jannel@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: HPT366 problems continued
In-Reply-To: <20011027234200.A2975@se1.cogenit.fr>
Message-ID: <Pine.LNX.4.10.10110272003180.5826-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Oct 2001, Francois Romieu wrote:

> Janne Liimatainen <jannel@iki.fi> :
> [...]
> > Uniform Multi-Platform E-IDE driver Revision: 6.31
> > ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
> > HPT366: IDE controller on PCI bus 00 dev 70
> > HPT366: chipset revision 1
> > HPT366: not 100% native mode: will probe irqs later
> > HPT366: simplex device:  DMA disabled
> > ide0: HPT366 Bus-Master DMA disabled (BIOS)
> > HPT366: IDE controller on PCI bus 00 dev 71
> > HPT366: chipset revision 1
> > HPT366: not 100% native mode: will probe irqs later
> > HPT366: simplex device:  DMA disabled
> > ide1: HPT366 Bus-Master DMA disabled (BIOS)
> > hda: Maxtor 4D080H4, ATA DISK drive
> > hdc: Maxtor 4D080H4, ATA DISK drive
> 
> drivers/ide/ide-dma.c::ide_get_or_set_dma_base
> 741     if (hwif->mate && hwif->mate->dma_base) {
> 742             dma_base = hwif->mate->dma_base - (hwif->channel ? 0 : 8);
>         } else {
>                 dma_base = pci_resource_start(dev, 4);
>                 -> We take this branch first (or I've missed where
>                    mate->dma_base is set)
> [...]
> 	if ((inb(dma_base+2) & 0x80)) { /* simplex device? */
> 793	        if ((!hwif->drives[0].present && !hwif->drives[1].present) ||
>                 -> do_identify is called later, we pass this test
> 794		    (hwif->mate && hwif->mate->dma_base)) {
>                     -> + we can't succeed this one or it means we would have
>                     -> passed through the other branch (742). It would imply 
> 		    -> at least one mate accepts to enable DMA.
> 			printk("%s: simplex device:  DMA disabled\n", name);
> 			dma_base = 0;
> 
> I'd say either mate->dma_base is set too soon for both mate (and they're both
> guaranteed to generate dma_base = 0 as soon as they reach 794) or do_identify
> is called too late (and dma_base = 0 because of 793).
> I haven't found a lot of dma_base field setting and they seem to happen late.

Ueimor,

If the BIOS does not configure the PCI space or if it is not listed to be
setup in the ./arch/*/kernel/pci-quirks.... then the driver ignores the
HOST.  So in short you are wrong, and the driver is doing its job
correctly.  The real problem is happening long before I ever get to touch
the chipset.

Let me guess, you are using one of the soft-raid modes of that host.

Regards,

Andre Hedrick
Linux Disk Certification Project		Linux ATA Development

