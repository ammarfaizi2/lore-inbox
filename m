Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280467AbRKKT3V>; Sun, 11 Nov 2001 14:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280481AbRKKT3L>; Sun, 11 Nov 2001 14:29:11 -0500
Received: from jgateadsl.cais.net ([205.252.5.196]:47130 "EHLO
	tyan.doghouse.com") by vger.kernel.org with ESMTP
	id <S280467AbRKKT25>; Sun, 11 Nov 2001 14:28:57 -0500
Date: Sun, 11 Nov 2001 14:24:27 -0500 (EST)
From: Maxwell Spangler <maxwax@mindspring.com>
X-X-Sender: <maxwell@tyan.doghouse.com>
To: Erik Andersen <andersen@codepoet.org>, <andre@linux-ide.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Disk Performance
In-Reply-To: <20011109162028.A14567@codepoet.org>
Message-ID: <Pine.LNX.4.33.0111111420410.17275-100000@tyan.doghouse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001, Erik Andersen wrote:

> On Fri Nov 09, 2001 at 08:57:07PM -0200, Rik van Riel wrote:
> > >
> > > But wouldn't it make more sense to enable DMA by default, except
> > > for a set of blacklisted chipsets, rather then disabling it for
> > > everybody just because some older chipsets are crap?
> >
> > The kernel does this, but only if CONFIG_IDEDMA_AUTO
> > is enabled ...
>
> That seems to be the theory.  In practice every system in my house has
> that option enabled and yet only some controllers boot up with DMA enabled...
>
> For example lets look at the following case.  This system has
> an intel chipset builtin and a Promise PCI card.
>
>     Uniform Multi-Platform E-IDE driver Revision: 6.31
>     ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>     PIIX4: IDE controller on PCI bus 00 dev 39
>     PIIX4: chipset revision 1
>     PIIX4: not 100% native mode: will probe irqs later
> 	ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
> 	ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
>     PDC20267: IDE controller on PCI bus 00 dev 68
>     PCI: Found IRQ 5 for device 00:0d.0
>     PDC20267: chipset revision 2
>     PDC20267: not 100% native mode: will probe irqs later
> 	ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:DMA
> 	ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:DMA
>     hda: IBM-DPTA-373420, ATA DISK drive
>     hdd: PCRW804, ATAPI CD/DVD-ROM drive
>     hde: IBM-DTLA-307045, ATA DISK drive
>     hdg: IBM-DTLA-307045, ATA DISK drive
>     ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>     ide1 at 0x170-0x177,0x376 on irq 15
>     ide2 at 0xac00-0xac07,0xb002 on irq 5
>     ide3 at 0xb400-0xb407,0xb802 on irq 5
>     hda: 66055248 sectors (33820 MB) w/1961KiB Cache, CHS=4111/255/63, UDMA(33)
>     hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63
>     hdg: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63
>     Partition check:
>      hda: hda1 hda2
>      hde: hde1
>      hdg: hdg1
>
> So the Intel one came up with DMA enabled,  No problem there.
>
> The Promise controller has two identical 46.1GB IBM-DTLA-307045 7200
> rpm hard drives on it.  The controller is capable of ATA100.  The hard
> drives are capable of ATA100.  And yet even with CONFIG_IDEDMA_AUTO
> set, these drives both come up running 3.39 MB/s.

I've got the same setup and things work fine.  Do you have the "Special UDMA
feature" enabled in the Promise driver configuration portion of the kernel
config?  Perhaps it specifically needs that while any other EIDE driver (like
the embedded PIIX4) would already use DMA..

Perhaps Andre can give us a final answer :)
-------------------------------------------------------------------------------
Maxwell Spangler
Program Writer
Greenbelt, Maryland, U.S.A.
Washington D.C. Metropolitan Area

