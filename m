Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293452AbSC0Xgu>; Wed, 27 Mar 2002 18:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293635AbSC0Xgl>; Wed, 27 Mar 2002 18:36:41 -0500
Received: from 12-252-146-102.client.attbi.com ([12.252.146.102]:18451 "EHLO
	archimedes") by vger.kernel.org with ESMTP id <S293452AbSC0Xg3>;
	Wed, 27 Mar 2002 18:36:29 -0500
Date: Wed, 27 Mar 2002 16:38:12 -0700
To: linux-kernel@vger.kernel.org
Subject: [bug] 2.4.19-pre4-ac2 hang at boot with ALI15x3 chipset support
Message-ID: <20020327233812.GA7310@galileo>
Mail-Followup-To: James Mayer <james.mayer@acm.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Debian: Debian GNU/Linux http://www.debian.org/
X-Uptime: 16:32 up  30 days,    5:21,    1 user, load 0.00 0.00 0.00
From: James Mayer <james.mayer@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing a kernel hang at boot with the ALI15x3 driver on a Sony
PCG-C1MV/M with 2.4.19-pre4-ac2.

The kernel hangs right after printing
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later

After adding printk calls to alim15x3.c, it seems to hang during the
pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02) call on line 588.

The kernel successfully loads if I build without ALI15x3 support,
printing these messages:

ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
ALI15X3: simplex device:  DMA disabled
ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
ALI15X3: simplex device:  DMA disabled
ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
hda: IC25N020ATDA04-0, ATA DISK drive

Is the ALI15x3 driver falsely enabling udma on my system?

ide0=nodma doesn't help, either...

I'm appending the output from lspci -vv in case that helps.

Thanks for any help... 
 - James

00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 01)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI South Bridge Audio (rev 02)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1800 [size=256]
	Region 1: Memory at e8100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

00:08.0 Modem: Acer Laboratories Inc. [ALi]: Unknown device 5457 (prog-if 00 [Generic])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8101000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Region 1: I/O ports at 1c00 [disabled] [size=256]
	Capabilities: <available only to root>

00:09.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8021 (rev 02) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8102000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at e8104000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <available only to root>

00:0a.0 Multimedia controller: Citicorp TTI: Unknown device 2011
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 2000 [disabled] [size=256]
	Region 1: Memory at e8200000 (32-bit, non-prefetchable) [disabled] [size=1M]
	Capabilities: <available only to root>

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 2400 [size=256]
	Region 1: Memory at e8102800 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:0c.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 2800 [size=256]
	Region 2: Memory at e8110000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

00:0f.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8103000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: <available only to root>

00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) (prog-if a0)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: [virtual] I/O ports at 01f0 [size=16]
	Region 1: [virtual] I/O ports at 03f4
	Region 2: [virtual] I/O ports at 0170 [size=16]
	Region 3: [virtual] I/O ports at 0374
	Region 4: I/O ports at 1400 [size=16]
	Capabilities: <available only to root>

00:11.0 Non-VGA unclassified device: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:12.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:14.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 000e0000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

