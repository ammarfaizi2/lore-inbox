Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267036AbSL3WzR>; Mon, 30 Dec 2002 17:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbSL3WzR>; Mon, 30 Dec 2002 17:55:17 -0500
Received: from gate.mesa.nl ([194.151.5.70]:27153 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S267036AbSL3WzP>;
	Mon, 30 Dec 2002 17:55:15 -0500
Date: Tue, 31 Dec 2002 00:03:30 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Promise 20376 support
Message-ID: <20021231000330.A21224@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
References: <20021230204645.B20688@joshua.mesa.nl> <1041281643.13615.131.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1041281643.13615.131.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Dec 30, 2002 at 08:54:03PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 08:54:03PM +0000, Alan Cox wrote:
> On Mon, 2002-12-30 at 19:46, Marcel J.E. Mol wrote:
> > Hi,
> > 
> > I've got this Asus A7V8X motherboard that contains a promise 20376
> > sata-ide (raid) controller. In the latest kernel sources (2.4 and 2.5) 
> > I don't see any mention of this chip yet. Also a google search does
> > not reveal much about linux support. 
> > Is there already any work in progress for it?
> 
> No work, no documentation. If its just a SATA bridge with an existing
> ATA controller then you may find you can just add the PCI identifiers
> and pretend its a 20276. If it has other new and wonderous features you
> may be completely screwed

Pity...
According to the motherboard manual the promisce controller supports one ATA133
channel and two Serial ATA  connectors.

Tried to pretend it to be a 20276 but it seems to fail (redhat kernel 2.4.18-18.8.0custom):

    PCI: PCI BIOS revision 2.10 entry at 0xf1720, last bus=1
    PCI: Using configuration type 1
    PCI: Probing PCI hardware
    PCI: Using IRQ router VIA [1106/3177] at 00:11.0
    block: 1024 slots per queue, batch=256
    Uniform Multi-Platform E-IDE driver Revision: 6.31
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    PDC20276: IDE controller on PCI bus 00 dev 40
    PCI: Found IRQ 10 for device 00:08.0
    PCI: Sharing IRQ 10 with 00:07.0
    PDC20276: chipset revision 2
    ide: Found promise 20265 in RAID mode.
    PDC20276: not 100% native mode: will probe irqs later
    PDC20276: simplex device:  DMA disabled
    ide2: PDC20276 Bus-Master DMA disabled (BIOS)
        ide3: BM-DMA at 0xec800008-0xec80000f -- ERROR, PORT ADDRESSES ALREADY IN USE
    VP_IDE: IDE controller on PCI bus 00 dev 89
    PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
    VP_IDE: chipset revision 6
    VP_IDE: not 100% native mode: will probe irqs later
    VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
        ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
        ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:pio, hdd:pio
    hda: MAXTOR 6L080J4, ATA DISK drive
    hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
    ide3: ports already in use, skipping probe
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    ide1 at 0x170-0x177,0x376 on irq 15
    hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=9732/255/63, UDMA(133)
    ide-floppy driver 0.99.newide
    Partition check:
     hda: hda1 hda2 hda3

Using pci=biosirq makes no difference.

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
