Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130663AbRCLVkp>; Mon, 12 Mar 2001 16:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130664AbRCLVk0>; Mon, 12 Mar 2001 16:40:26 -0500
Received: from ohiper1-33.apex.net ([209.250.47.48]:6916 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S130663AbRCLVkT>; Mon, 12 Mar 2001 16:40:19 -0500
Date: Mon, 12 Mar 2001 15:43:12 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Martin Diehl <home@mdiehl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE on 2.4.2
Message-ID: <20010312154312.A459@hapablap.dyn.dhs.org>
In-Reply-To: <20010311153752.A29108@hapablap.dyn.dhs.org> <Pine.LNX.4.21.0103120118480.571-100000@notebook.diehl.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103120118480.571-100000@notebook.diehl.home>; from home@mdiehl.de on Mon, Mar 12, 2001 at 08:50:23AM +0100
X-Uptime: 3:34pm  up 3 min,  1 user,  load average: 1.49, 0.72, 0.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2001 at 08:50:23AM +0100, Martin Diehl wrote:
> 
> On Sun, 11 Mar 2001, Steven Walter wrote:
> > I have this exact same chip on my board (a PCChips M599-LMR or something
> > like that) which works flawlessly on 2.4.2, even with UDMA66.
> 
> Do you have CONFIG_BLK_DEV_SIS5513 and autotuning enabled at the
> same time? Unless I enable them both it works flawlessly for me too - up
> to UDMA33. In fact, I've never seen any docs claiming the 5591/5513 would
> even provide UDMA66 support. How do you program the controler to do UDMA66
> cycles?
> Anyway, might be interesting to have a look at your lspci -d:5513 -vvvxxx
> report from working UDMA33/66 setups!

The big man himself, Andre Hedrick, has stated that the SiS5513 should
work in UDMA/66 mode, as is evidenced by my setup.

Yep, both are enabled (from .config):
CONFIG_BLK_DEV_SIS5513=y
CONFIG_IDEDMA_AUTO=y

I don't have to do anything to program it to UDMA66, as this is what it
defaults to on boot (from dmesg):

SIS5513: IDE controller on PCI bus 00 dev 01
PCI: No IRQ known for interrupt pin A of device 00:00.1. Please try using pci=biosirq.
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS530
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD84AA, ATA DISK drive
hdc: ATAPI 48X CDROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 16514064 sectors (8455 MB) w/2048KiB Cache, CHS=1027/255/63, UDMA(66)
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)

And, as you've requested, here is the lspci output from my system, which
is working and in UDMA66.

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0) (prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS]: Unknown device 5513
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 set
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at ffa0 [size=16]
00: 39 10 13 55 05 00 00 00 d0 80 01 01 00 80 80 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 39 10 13 55
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
40: 01 93 00 00 01 b3 00 00 23 07 e6 11 00 02 00 02
50: 00 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Be sure that you have an 80-conductor cable, however.  On my system,
there is a BIOS option for UDMA.  This apparently overrides/takes the
place of proper cable detection.  If I turn it on without an 80-pin
cable, Linux defaults to UDMA66 and I get drive major drive corruption.
When off, I can't use UDMA66.

I hope all this is helpful to you!
-- 
-Steven
Never ask a geek why, just nod your head and slowly back away.
