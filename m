Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129198AbRBJRAA>; Sat, 10 Feb 2001 12:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129489AbRBJQ7l>; Sat, 10 Feb 2001 11:59:41 -0500
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:1008 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S129198AbRBJQ7j>; Sat, 10 Feb 2001 11:59:39 -0500
Message-ID: <3A85726E.A66A56A0@didntduck.org>
Date: Sat, 10 Feb 2001 11:55:10 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IRQ conflicts
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems with 2.4.2-pre3 and IRQ conflicts.  Last kernel that
I tried and worked without conflict was 2.4.0-test11.  Here are the
relevant messages that I get:

Linux version 2.4.2-pre3 (root@neriak) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #1 Sat Feb 10 11:13:59 EST 2001
PCI: PCI BIOS revision 2.10 entry at 0xfb4d0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1106/0597] 000600 00
Found 00:08 [1106/8598] 000604 01
Found 00:38 [1106/0586] 000601 00
Found 00:39 [1106/0571] 000101 00
Found 00:3b [1106/3040] 000604 00
PCI: 00:07.3: class 604 doesn't match header type 00. Ignoring class.
Found 00:40 [102b/0519] 000300 00
Found 00:48 [1113/1211] 000200 00
Found 00:50 [10ec/8139] 000200 00
Fixups for bus 00
Scanning behind PCI bridge 00:01.0, config 010100, pass 0
Scanning bus 01
Fixups for bus 01
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:01.0, config 010100, pass 1
Bus scan for 00 returning with max=01
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
isapnp: Scanning for Pnp cards...
isapnp: SB audio device quirk - increasing port range
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB32 PnP'
isapnp: Card 'Rockwell K56Flex Plug & Play Modem'
isapnp: 2 Plug & Play cards detected total
DMI 2.1 present.
25 structures occupying 843 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 02/26/99
System Vendor: System Manufacturer.
Product Name: Product Name.
Version SYS-xxxxxx.
Serial Number Serial Number xxxxxx.
Board Vendor: First International Computer, Inc..
Board Name: PA-2013.
Board Version: PCB 2.X.
Asset Tag: Asset Tag Number xxxxxx.
8139too Fast Ethernet driver 0.9.13 loaded
PCI: Found IRQ 11 for device 00:09.0
eth0: SMC1211TX EZCard 10/100 (RealTek RTL8139) at 0xc4800000,
00:e0:29:6e:11:da, IRQ 11
PCI: Found IRQ 10 for device 00:0a.0
IRQ routing conflict in pirq table for device 00:0a.0
eth1: RealTek RTL8139 Fast Ethernet at 0xc4802000, 00:48:54:67:17:e9,
IRQ 5
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative SB32 PnP detected
sb: ISAPnP reports 'Creative SB32 PnP' at i/o 0x220, irq 9, dma 1, 5
sb: Interrupt test on IRQ9 failed - Probable IRQ conflict
sb: 1 Soundblaster PnP card(s) found.
ISAPnP reports AWE32 WaveTable at i/o 0x620
<SoundBlaster EMU8000 (RAM2048k)>
Sound: DMA (output) timed out - IRQ/DRQ config error?

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev
04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 16 set
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
[Apollo VP] (rev 47)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 4: I/O ports at e400 [size=16]

00:07.3 PCI bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
(prog-if 00 [Normal decode])
	!!! Header type 00 doesn't match class code 0604

00:08.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W
[Millennium] (rev 01) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
	Region 1: Memory at e5000000 (32-bit, prefetchable) [size=8M]
	Expansion ROM at e6000000 [disabled] [size=64K]

00:09.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX
(rev 10)
	Subsystem: Accton Technology Corporation: Unknown device 1211
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 min, 64 max, 64 set
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at e7000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+
	Capabilities: [60] Vital Product Data

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 min, 64 max, 64 set
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at ec00 [size=256]
	Region 1: Memory at e7001000 (32-bit, non-prefetchable) [size=256]

           CPU0       
  0:     146319          XT-PIC  timer
  1:        184          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       1889          XT-PIC  eth1
  9:          0          XT-PIC  soundblaster
 11:        356          XT-PIC  eth0
 12:          0          XT-PIC  PS/2 Mouse
 14:       2026          XT-PIC  ide0
 15:          5          XT-PIC  ide1
NMI:          0 
ERR:          0


PCI bus 01 is an AGP bus, but there is no AGP video card present.  eth1
does function, but the sound card does not.  More information available
on request.

-- 

						Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
