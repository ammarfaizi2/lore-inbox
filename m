Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282728AbRLKU7i>; Tue, 11 Dec 2001 15:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283675AbRLKU73>; Tue, 11 Dec 2001 15:59:29 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:12928
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S282829AbRLKU7P>; Tue, 11 Dec 2001 15:59:15 -0500
Date: Tue, 11 Dec 2001 12:59:04 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200112112059.fBBKx4U09316@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: German Gomez Garcia <german@piraos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tian Tiger MP (AMD760MP chipset) and UDMA ATA 66/100
In-Reply-To: <20011211154155.A4264@hal9000.piraos.com>
In-Reply-To: <20011211154155.A4264@hal9000.piraos.com>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

> I would like to know what is the current status (in the 2.4.x
> series) of the UDMA driver for the AMD760MP chipset.

One of the machines I am involved with has the Tyan Tiger MP 1.03
motherboard.  It has a Maxtor 6L080J4 as the ide0 master, /dev/hda.  

The stock 2.4.16 amd74xx driver defaults to UDMA2 on /dev/hda, and
with that configuration I get an hdparm -T of 21.40 MB/sec.  The
ide0=ata66 kernel option successfully forces the drive and interface
to UDMA4, giving an hdparm -T of 38.1 MB/sec.  I seem to recall that
without ide0=ata66, I was limited to UDMA2 (with hdparm -X), but I
can't verify that at this time.

The relevant boot messages from stock 2.4.16 with the ide0=ata66
kernel option are below.  Note the message "hda: setting to mode 4,
driver problems in mode 5."  That must be why I get UDMA4 instead of
UDMA5 in this configuration.  But UDMA4 is plenty, I think; I have not
tried "hdparm -X69 /dev/hda".

I actually am usually running with Andre Hedrick's ATA patch (the
2001-11-24 version, I'm about to try the 2001-12-10 version).  This is
because I have two PDC20268 cards (Promise Ultra100TX2), and the stock
kernel gives the "ERROR, PORT ADDRESSES ALREADY IN USE" messages below
for the second card.  Then I can only do MDMA2 on the first PDC20268
and PIO on the second PDC20268.  Ander Hedrick's ATA patch gives me
UDMA5 on all the interfaces.

Cheers,
Wayne


Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7411: IDE controller on PCI bus 00 dev 39
AMD7411: chipset revision 1
AMD7411: not 100%% native mode: will probe irqs later
AMD7411: disabling single-word DMA support (revision < C4)
AMD7411: ATA-66/100 forced bit set (WARNING)!!
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
PDC20268: IDE controller on PCI bus 00 dev 48
PDC20268: chipset revision 1
PDC20268: not 100%% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0x1410-0x1417, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1418-0x141f, BIOS settings: hdg:pio, hdh:pio
PDC20268: IDE controller on PCI bus 00 dev 50
PDC20268: chipset revision 1
PDC20268: not 100%% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide4: BM-DMA at 0x1420-0x1427 -- ERROR, PORT ADDRESSES ALREADY IN USE
    ide5: BM-DMA at 0x1428-0x142f -- ERROR, PORT ADDRESSES ALREADY IN USE
hda: MAXTOR 6L080J4, ATA DISK drive
hdc: OnStream ADR Series, ATAPI TAPE drive
hde: MAXTOR 6L080J4, ATA DISK drive
hdg: HL-DT-ST RW/DVD GCC-4120B, ATAPI CD/DVD-ROM drive
hdi: MAXTOR 6L080J4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x1448-0x144f,0x1442 on irq 10
ide3 at 0x1438-0x143f,0x1436 on irq 10
ide4 at 0x1460-0x1467,0x145a on irq 5
hda: setting to mode 4, driver problems in mode 5.
hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, UDMA(66)
hde: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, (U)DMA
hdi: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63
