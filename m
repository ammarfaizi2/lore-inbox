Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135865AbRAMDEr>; Fri, 12 Jan 2001 22:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135837AbRAMDEb>; Fri, 12 Jan 2001 22:04:31 -0500
Received: from slinky.scrye.com ([216.17.174.109]:43794 "EHLO slinky.scrye.com")
	by vger.kernel.org with ESMTP id <S135556AbRAMDER>;
	Fri, 12 Jan 2001 22:04:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14943.50581.978539.26089@slinky.scrye.com>
Date: Fri, 12 Jan 2001 20:03:49 -0700 (MST)
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
CC: vojtech@suse.cz (Vojtech Pavlik), linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <E14HDqv-0005Fm-00@the-village.bc.nu>
In-Reply-To: <20010112204626.A2740@suse.cz> <E14HDqv-0005Fm-00@the-village.bc.nu>
X-Mailer: VM 6.62 under 21.1 "20 Minutes to Nikko" XEmacs Lucid (patch 2)
From: Tkil <tkil@scrye.com>
X-Attribution: Tkil
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan asked:
> I think its significant that two reports I have are FIC PA-2013 but
> not all.  What combination of chips is on the 2013 ?

My board here is a FIC PA-2013A (if I recall correctly; the
motherboard only has "PA-2013" on it, no "A") rev 1.1.

It's worth noting that there is at least another full revision level
(2.x), and the BIOSes for these different revisions are *not*
compatible (as I found out to my chagrin ;-).

Also, the FIC PA-513 (maybe 512?) should be a very similar board, only
wired for an AT power supply where the PA-2013 is an ATX board.

I've never seen the DMA data corruption on this box, but I'd really
really like to get something better than 3MB/s off my UDMA/66-capable
drives.  I'm pretty sure that (prior to the 2.2.18 squelching of all
VIA IDE UDMA) that hda and hdc would come up with DMA enabled, at the
very least.  Is there a safe way to test various hdparm settings?  I'm 
even willing to buy a scratch disk if that would help...

Looking at the chips, I have:

1. VIA
   VT82C598MVP
   9828CE Taiwan
   13G003900

2. VIA
   VT82C586B
   S7-SB
   9826CD Taiwan
   14B013511

It has an Award BIOS with a variety of WinBond support chips (looks
like at least 4 on-board cache chips, and one near the BIOS EEPROM).

Here's the relevant dmesg bits:

| PCI: PCI BIOS revision 2.10 entry at 0xfb490
| PCI: Using configuration type 1
| PCI: Probing PCI hardware
| PCI: 00:38 [1106/0586]: Work around ISA DMA hangs (00)
| Activating ISA DMA hang workarounds.
| Detected PS/2 Mouse Port.
| Serial driver version 4.27 with no serial options enabled
| ttyS00 at 0x03f8 (irq = 4) is a 16550A
| ttyS01 at 0x02f8 (irq = 3) is a 16550A
| Real Time Clock Driver v1.09
| VP_IDE: IDE controller on PCI bus 00 dev 39
| VP_IDE: not 100% native mode: will probe irqs later
|     ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
| ide0: VIA Bus-Master (U)DMA Timing Config Success
|     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
| ide1: VIA Bus-Master (U)DMA Timing Config Success
| hda: WDC WD307AA, ATA DISK drive
| hdc: Maxtor 96147H8, ATA DISK drive
| ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
| ide1 at 0x170-0x177,0x376 on irq 15
| hda: WDC WD307AA, 29333MB w/2048kB Cache, CHS=59598/16/63
| hdc: Maxtor 96147H8, 58623MB w/2048kB Cache, CHS=7473/255/63
| Floppy drive(s): fd0 is 1.44M
| FDC 0 is a post-1991 82077
| Partition check:
|  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
|  hda: [PTBL] [3739/255/63] hda1
|  hdc: hdc1
| apm: BIOS version 1.2 Flags 0x07 (Driver version 1.13)

Short version of lspci:

| 00:00.0 Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 04)
| 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
| 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586 ISA [Apollo VP] (rev 41)
| 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
| 00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02)
| 00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
| 00:08.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 03)
| 00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
| 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP [Millennium G200 AGP] (rev 01)

I've included "hdparm" and "lspci -vvxxx" output below, omitting
non-chipset related things (SCSI, Ethernet, and VGA).  If it matters,
this board is running 100MHz FSB with a 450MHz K6-3 CPU and 384MB (3 x
128MB DIMMs) of PC-100 SDRAM.

If I can provide any more information, please don't hesitate to ask.

Thanks,
t.

hdparm output:

| # for i in hda hdc ; do hdparm /dev/$i ; hdparm -i /dev/$i ; done
| 
| /dev/hda:
|  multcount    =  0 (off)
|  I/O support  =  0 (default 16-bit)
|  unmaskirq    =  0 (off)
|  using_dma    =  0 (off)
|  keepsettings =  0 (off)
|  nowerr       =  0 (off)
|  readonly     =  0 (off)
|  readahead    =  8 (on)
|  geometry     = 3739/255/63, sectors = 60074784, start = 0
| 
| /dev/hda:
| 
|  Model=WDC WD307AA, FwRev=05.05B05, SerialNo=WD-WMA11
|  Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
|  RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
|  BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=off
|  DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=0(slow)
|  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=60074784
|  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2 
|  IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4 
| 
| 
| /dev/hdc:
|  multcount    =  0 (off)
|  I/O support  =  0 (default 16-bit)
|  unmaskirq    =  0 (off)
|  using_dma    =  0 (off)
|  keepsettings =  0 (off)
|  nowerr       =  0 (off)
|  readonly     =  0 (off)
|  readahead    =  8 (on)
|  geometry     = 7473/255/63, sectors = 120060864, start = 0
| 
| /dev/hdc:
| 
|  Model=Maxtor 96147H8, FwRev=BAC51KJ0, SerialNo=N80CP5KC
|  Config={ Fixed }
|  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
|  BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=off
|  DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=0(slow)
|  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=120060864
|  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2 
|  IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4 

lspci -vvxxx output:

| 00:00.0 Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 04)
| 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
| 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 16 set
| 	Region 0: Memory at e0000000 (32-bit, prefetchable)
| 	Capabilities: [a0] AGP version 1.0
| 		Status: RQ=7 SBA+ 64bit- FW- Rate=1
| 		Command: RQ=7 SBA+ AGP- 64bit- FW- Rate=1
| 00: 06 11 97 05 06 00 90 02 04 00 00 06 00 10 00 00
| 10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
| 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
| 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 50: 80 0a 05 40 00 00 00 00 98 80 10 10 20 20 28 30
| 60: 3f 2a 00 23 e4 e4 e4 00 01 00 50 00 60 67 00 00
| 70: e1 0a 6c 00 00 80 40 00 00 00 00 00 00 00 00 40
| 80: 00 00 00 00 c0 00 00 00 02 00 00 00 00 00 00 00
| 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| a0: 02 00 10 00 01 02 00 07 00 00 00 00 0a 00 00 00
| b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| f0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 97 05
|
| 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
| 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
| 	Latency: 0 set
| 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
| 	I/O behind bridge: 0000d000-0000dfff
| 	Memory behind bridge: e4000000-e7ffffff
| 	Prefetchable memory behind bridge: e8000000-e8ffffff
| 	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
| 00: 06 11 98 85 07 00 20 22 00 00 04 06 00 00 01 00
| 10: 00 00 00 00 00 00 00 00 00 01 01 00 d0 d0 00 00
| 20: 00 e4 f0 e7 00 e8 f0 e8 00 00 00 00 00 00 00 00
| 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00
| 40: f0 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
|
| 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586 ISA [Apollo VP] (rev 41)
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
| 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 0 set
| 00: 06 11 86 05 8f 00 00 02 41 00 01 06 00 00 80 00
| 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 40: 00 05 00 00 01 00 10 a0 21 00 c4 00 00 00 00 f3
| 50: 24 00 00 00 00 00 a0 90 00 06 f7 00 10 00 00 00
| 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
|
| 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a)
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
| 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 64 set
| 	Region 4: I/O ports at e000
| 00: 06 11 71 05 07 00 80 02 06 8a 01 01 00 40 00 00
| 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 20: 01 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 40: 0b f2 09 3a 69 00 f0 00 a8 a8 a8 a8 ff 00 ff ff
| 50: 03 03 03 03 00 00 00 00 a8 a8 a8 a8 00 00 00 00
| 60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
| 70: 22 00 00 00 00 00 00 00 42 00 00 00 00 00 00 00
| 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| d0: 06 00 71 05 00 00 00 00 00 00 00 00 00 00 00 00
| e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
|
| 00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02)
| 	Subsystem: Unknown device 0925:1234
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
| 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 64 set, cache line size 08
| 	Interrupt: pin D routed to IRQ 9
| 	Region 4: I/O ports at e400
| 00: 06 11 38 30 07 00 00 02 02 00 03 0c 08 40 00 00
| 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 20: 01 e4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
| 30: 00 00 00 00 00 00 00 00 00 00 00 00 09 04 00 00
| 40: 00 00 00 00 c6 00 11 18 00 00 00 00 00 00 00 00
| 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
|
| 00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
| 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
| 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
| 00: 06 11 40 30 00 00 80 02 10 00 80 06 00 00 00 00
| 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 40: 40 88 09 00 78 38 00 00 01 60 00 00 00 00 00 00
| 50: 00 7c ee 88 00 00 00 00 00 00 00 00 00 00 00 00
| 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
