Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281717AbRKQIEG>; Sat, 17 Nov 2001 03:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281714AbRKQID4>; Sat, 17 Nov 2001 03:03:56 -0500
Received: from sdsl-216-36-113-151.dsl.sea.megapath.net ([216.36.113.151]:20176
	"EHLO stomata.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S281715AbRKQIDn>; Sat, 17 Nov 2001 03:03:43 -0500
Subject: 2.4.15-pre5 -- Third attempt! -- Please help with PIRQ routing
	problems.
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 17 Nov 2001 00:03:00 -0800
Message-Id: <1005984180.17991.3.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred, about a month ago you sent out a request for 
reports from people who were seeing errors of the form:

   "IRQ routing conflict for 00:11.2, have irq 9, want irq 10

Here you go.

The initial PCI/ACPI setup:

Nov 16 10:54:28 stomata kernel: 3f9ff 00000000, vendor = 2
Nov 16 10:54:28 stomata kernel: Intel machine check architecture supported.
Nov 16 10:54:28 stomata kernel: Intel machine check reporting enabled on CPU#0.
Nov 16 10:54:28 stomata kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Nov 16 10:54:28 stomata kernel: CPU: L2 Cache: 512K (64 bytes/line)
Nov 16 10:54:28 stomata kernel: CPU: After vendor init, caps: 0183f9ff c1c3f9ff 00000000 00000000
Nov 16 10:54:28 stomata kernel: CPU:     After generic, caps: 0183f9ff c1c3f9ff 00000000 00000000
Nov 16 10:54:28 stomata kernel: CPU:             Common caps: 0183f9ff c1c3f9ff 00000000 00000000
Nov 16 10:54:28 stomata kernel: CPU: AMD Athlon(tm) Processor stepping 01
Nov 16 10:54:28 stomata kernel: Enabling fast FPU save and restore... done.
Nov 16 10:54:28 stomata kernel: Checking 'hlt' instruction... OK.
Nov 16 10:54:28 stomata kernel: POSIX conformance testing by UNIFIX
Nov 16 10:54:28 stomata kernel: PCI: BIOS32 Service Directory structure at 0xc00fdaa0
Nov 16 10:54:28 stomata kernel: PCI: BIOS32 Service Directory entry at 0xfdab0
Nov 16 10:54:28 stomata kernel: PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
Nov 16 10:54:28 stomata kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdad1, last bus=1
Nov 16 10:54:28 stomata kernel: PCI: Using configuration type 1
Nov 16 10:54:28 stomata kernel: PCI: Probing PCI hardware
Nov 16 10:54:28 stomata kernel: PCI: IDE base address fixup for 00:07.1
Nov 16 10:54:28 stomata kernel: PCI: Scanning for ghost devices on bus 0
Nov 16 10:54:28 stomata kernel: PCI: Scanning for ghost devices on bus 1
Nov 16 10:54:29 stomata kernel: PCI: IRQ init
Nov 16 10:54:29 stomata kernel: PCI: Fetching IRQ routing table... OK  ret=14, size=128, map=0
Nov 16 10:54:29 stomata kernel: PCI: Using BIOS Interrupt Routing Table
Nov 16 10:54:29 stomata kernel: 00:00 slot=00 0:00/def8 1:00/def8 2:00/def8 3:00/def8
Nov 16 10:54:29 stomata kernel: 01:05 slot=06 0:56/def8 1:d6/def8 2:00/0000 3:00/0000
Nov 16 10:54:29 stomata kernel: 00:07 slot=00 0:fe/4000 1:ff/8000 2:00/0000 3:d7/def8
Nov 16 10:54:29 stomata kernel: 00:11 slot=01 0:56/def8 1:d6/def8 2:57/def8 3:d7/def8
Nov 16 10:54:29 stomata kernel: 00:12 slot=02 0:d6/def8 1:57/def8 2:d7/def8 3:56/def8
Nov 16 10:54:29 stomata kernel: 00:13 slot=03 0:57/def8 1:d7/def8 2:56/def8 3:d6/def8
Nov 16 10:54:29 stomata kernel: 00:14 slot=04 0:d6/def8 1:57/def8 2:d7/def8 3:56/def8
Nov 16 10:54:29 stomata kernel: 00:0f slot=05 0:56/def8 1:d6/def8 2:57/def8 3:d7/def8
Nov 16 10:54:29 stomata kernel: PCI: Using BIOS for IRQ routing
Nov 16 10:54:29 stomata kernel: PCI: IRQ fixup
Nov 16 10:54:29 stomata kernel: IRQ for 00:14.0:0 -> PIRQ d6, mask def8, excl 0000 -> newirq=0 ... failed
Nov 16 10:54:29 stomata kernel: IRQ for 00:14.1:1 -> PIRQ 57, mask def8, excl 0000 -> newirq=0 ... failed
Nov 16 10:54:29 stomata kernel: PCI: Allocating resources
Nov 16 10:54:29 stomata kernel: PCI: Resource f8000000-fbffffff (f=1208, d=0, p=0)
Nov 16 10:54:29 stomata kernel: PCI: Resource fc9ff000-fc9fffff (f=1208, d=0, p=0)
Nov 16 10:54:29 stomata kernel: PCI: Resource 0000cb00-0000cb0f (f=101, d=0, p=0)
Nov 16 10:54:29 stomata kernel: PCI: Resource febfe000-febfefff (f=200, d=0, p=0)
Nov 16 10:54:30 stomata kernel: PCI: Resource 0000f800-0000f8ff (f=101, d=0, p=0)
Nov 16 10:54:30 stomata kernel: PCI: Resource febff000-febfffff (f=200, d=0, p=0)
Nov 16 10:54:30 stomata kernel: PCI: Resource febfb000-febfbfff (f=200, d=0, p=0)
Nov 16 10:54:30 stomata kernel: PCI: Resource febfc000-febfcfff (f=200, d=0, p=0)
Nov 16 10:54:30 stomata kernel: PCI: Resource febfdf00-febfdfff (f=200, d=0, p=0)
Nov 16 10:54:30 stomata kernel: PCI: Resource 0000ff80-0000ff9f (f=101, d=0, p=0)
Nov 16 10:54:30 stomata kernel: PCI: Resource 0000fff0-0000fff7 (f=101, d=0, p=0)
Nov 16 10:54:30 stomata kernel: PCI: Resource 0000fc00-0000fc7f (f=101, d=0, p=0)
Nov 16 10:54:30 stomata kernel: PCI: Resource febfde80-febfdeff (f=200, d=0, p=0)
Nov 16 10:54:30 stomata kernel: PCI: Resource fd000000-fdffffff (f=200, d=0, p=0)
Nov 16 10:54:30 stomata kernel: PCI: Resource e8000000-efffffff (f=1208, d=0, p=0)
Nov 16 10:54:30 stomata kernel: PCI: Resource 0000ffe4-0000ffe7 (f=105, d=1, p=1)
Nov 16 10:54:30 stomata kernel: PCI: Sorting device list...
Nov 16 10:54:30 stomata kernel: Linux NET4.0 for Linux 2.4
Nov 16 10:54:30 stomata kernel: Based upon Swansea University Computer Society NET3.039
Nov 16 10:54:31 stomata kernel: Starting kswapd
Nov 16 10:54:31 stomata kernel: VFS: Diskquotas version dquot_6.4.0 initialized
Nov 16 10:54:31 stomata kernel:  tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Nov 16 10:54:31 stomata kernel: Parsing Methods:...................................................................................
Nov 16 10:54:31 stomata kernel: 83 Control Methods found and parsed (271 nodes total)
Nov 16 10:54:32 stomata kernel: ACPI Namespace successfully loaded at root c0296a40
Nov 16 10:54:32 stomata kernel: ACPI: Core Subsystem version [20011018]
Nov 16 10:54:32 stomata kernel: evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode successful
Nov 16 10:54:32 stomata kernel: Executing device _INI methods:............... exfldio-0100 [21] Ex_setup_field        : Field access width (4 bytes) too large for region size (1)
Nov 16 10:54:32 stomata kernel:  exfldio-0109 [21] Ex_setup_field        : Field base+offset+width 0+0+4 exceeds region size (1 bytes) field=cff67368 region=cff671e8
Nov 16 10:54:32 stomata kernel: Ps_execute: method failed - \_SB_.PCI0.SBRG.PS2M._STA (cff754e8)
Nov 16 10:54:32 stomata kernel:   uteval-0335 [05] Ut_execute_STA        : _STA on PS2M failed AE_AML_REGION_LIMIT
Nov 16 10:54:33 stomata kernel: ...........
Nov 16 10:54:33 stomata kernel: 26 Devices found: 25 _STA, 2 _INI
Nov 16 10:54:33 stomata kernel: Completing Region and Field initialization:.............
Nov 16 10:54:33 stomata kernel: 12/15 Regions, 1/1 Fields initialized (271 nodes total)
Nov 16 10:54:33 stomata kernel: ACPI: Subsystem enabled


Results of "grep -i irq":

Nov 16 10:54:34 stomata kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI SERIAL_ACPI enabled
Nov 16 10:54:34 stomata kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Nov 16 10:54:34 stomata kernel: ttyS02 at 0x03e8 (irq = 4) is a 16550A
Nov 16 10:54:35 stomata kernel: AMD7409: not 100%% native mode: will probe irqs later
Nov 16 10:54:35 stomata kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 16 10:54:35 stomata kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 16 10:54:36 stomata kernel: IRQ for 00:14.1:1 -> PIRQ 57, mask def8, excl 0000 -> newirq=10 -> assigning IRQ 10 ... OK
Nov 16 10:54:36 stomata kernel: PCI: Assigned IRQ 10 for device 00:14.1
Nov 16 10:54:36 stomata kernel: IRQ routing conflict for 00:11.2, have irq 9, want irq 10
Nov 16 10:54:36 stomata kernel: IRQ routing conflict for 00:13.0, have irq 9, want irq 10
Nov 16 10:54:36 stomata kernel: IRQ for 00:14.0:0 -> PIRQ d6, mask def8, excl 0000 -> newirq=5 -> assigning IRQ 5 ... OK
Nov 16 10:54:37 stomata kernel: PCI: Assigned IRQ 5 for device 00:14.0
Nov 16 10:54:37 stomata kernel: PCI: Sharing IRQ 5 with 00:11.1
Nov 16 10:54:37 stomata kernel: PCI: Sharing IRQ 5 with 00:12.0
Nov 16 10:54:37 stomata kernel: Yenta IRQ list 0000, PCI irq10
Nov 16 10:54:37 stomata kernel: Yenta IRQ list 0000, PCI irq5
Nov 16 10:54:38 stomata kernel: IRQ for 02:00.0:0 -> not found in routing table
Nov 16 10:54:38 stomata kernel: IRQ for 00:07.4:3 -> PIRQ d7, mask def8, excl 0000 -> newirq=10 -> assigning IRQ 10 ... OK
Nov 16 10:54:38 stomata kernel: PCI: Assigned IRQ 10 for device 00:07.4
Nov 16 10:54:38 stomata kernel: usb-ohci.c: USB OHCI at membase 0xd2868000, IRQ 10
Nov 16 10:54:40 stomata kernel: IRQ for 00:11.1:1 -> PIRQ d6, mask def8, excl 0000 -> newirq=5 -> assigning IRQ 5 ... OK
Nov 16 10:54:40 stomata kernel: PCI: Assigned IRQ 5 for device 00:11.1
Nov 16 10:54:40 stomata kernel: PCI: Sharing IRQ 5 with 00:12.0
Nov 16 10:54:40 stomata kernel: PCI: Sharing IRQ 5 with 00:14.0
Nov 16 10:54:40 stomata kernel: usb-ohci.c: USB OHCI at membase 0xd286a000, IRQ 5
Nov 16 10:54:41 stomata kernel: IRQ for 00:11.0:0 -> PIRQ 56, mask def8, excl 0000 -> newirq=11 -> assigning IRQ 11 ... OK
Nov 16 10:54:41 stomata kernel: PCI: Assigned IRQ 11 for device 00:11.0
Nov 16 10:54:41 stomata kernel: PCI: Sharing IRQ 11 with 00:0f.0
Nov 16 10:54:41 stomata kernel: PCI: Sharing IRQ 11 with 01:05.0
Nov 16 10:54:41 stomata kernel: usb-ohci.c: USB OHCI at membase 0xd286c000, IRQ 11
Nov 16 10:54:48 stomata kernel: IRQ for 00:0f.0:0 -> PIRQ 56, mask def8, excl 0000 -> newirq=11 -> assigning IRQ 11 ... OK
Nov 16 10:54:48 stomata kernel: PCI: Assigned IRQ 11 for device 00:0f.0
Nov 16 10:54:48 stomata kernel: PCI: Sharing IRQ 11 with 00:11.0
Nov 16 10:54:48 stomata kernel: PCI: Sharing IRQ 11 with 01:05.0
Nov 16 10:54:48 stomata kernel: parport0: irq 7 detected
Nov 16 10:54:48 stomata kernel: IRQ for 00:0f.0:0 -> PIRQ 56, mask def8, excl 0000 -> newirq=11 -> assigning IRQ 11 ... OK
Nov 16 10:54:48 stomata kernel: PCI: Assigned IRQ 11 for device 00:0f.0
Nov 16 10:54:48 stomata kernel: PCI: Sharing IRQ 11 with 00:11.0
Nov 16 10:54:48 stomata kernel: PCI: Sharing IRQ 11 with 01:05.0
Nov 16 10:54:48 stomata kernel: IRQ for 00:13.0:0 -> PIRQ 57, mask def8, excl 0000 -> newirq=9 -> assigning IRQ 9 ... OK
Nov 16 10:54:48 stomata kernel: PCI: Assigned IRQ 9 for device 00:13.0
Nov 16 10:54:48 stomata kernel: PCI: Sharing IRQ 9 with 00:11.2
Nov 16 10:54:48 stomata kernel: IRQ routing conflict for 00:14.1, have irq 10, want irq 9
Nov 16 10:55:15 stomata kernel: IRQ for 00:12.0:0 -> PIRQ d6, mask def8, excl 0000 -> newirq=5 -> assigning IRQ 5 ... OK
Nov 16 10:55:15 stomata kernel: PCI: Assigned IRQ 5 for device 00:12.0
Nov 16 10:55:15 stomata kernel: PCI: Sharing IRQ 5 with 00:11.1
Nov 16 10:55:15 stomata kernel: PCI: Sharing IRQ 5 with 00:14.0
Nov 16 10:55:15 stomata kernel: emu10k1: EMU10K1 rev 7 model 0x8031 found, IO at 0xff80-0xff9f, IRQ 5


lspci -vvx:

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller (rev 25)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at fc9ff000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at ffe4 [disabled] [size=4]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 22 10 06 70 06 01 10 22 25 00 00 06 00 40 80 00
10: 08 00 00 f8 08 f0 9f fc e5 ff 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fca00000-feafffff
	Prefetchable memory behind bridge: e4800000-f48fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
00: 22 10 07 70 07 01 20 02 01 00 04 06 00 40 81 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 e1 e1 20 22
20: a0 fc a0 fe 80 e4 80 f4 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 00

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 22 10 08 74 0f 00 00 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE (rev 03) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at cb00 [size=16]
00: 22 10 09 74 05 00 00 02 03 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 cb 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 03)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 0b 74 00 00 80 02 03 00 80 06 00 16 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB (rev 06) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at febfe000 (32-bit, non-prefetchable) [size=4K]
00: 22 10 0c 74 07 00 80 02 06 10 03 0c 08 10 00 00
10: 00 e0 bf fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 04 00 50

00:0f.0 SCSI storage controller: Adaptec AHA-2930CU (rev 03)
	Subsystem: Adaptec: Unknown device 3869
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at f800 [disabled] [size=256]
	Region 1: Memory at febff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at febe0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 04 90 60 38 16 01 90 02 03 00 00 01 08 40 00 00
10: 01 f8 00 00 00 f0 bf fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 04 90 69 38
30: 00 00 be fe dc 00 00 00 00 00 00 00 0b 01 04 04

00:11.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 40 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at febfb000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 33 10 35 00 16 01 10 02 41 10 03 0c 08 28 80 00
10: 00 b0 bf fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 33 10 35 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 01 2a

00:11.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 40 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at febfc000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 33 10 35 00 16 01 10 02 41 10 03 0c 08 28 00 00
10: 00 c0 bf fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 33 10 35 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 02 01 2a

00:11.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 01) (prog-if 20)
	Subsystem: NEC Corporation: Unknown device 00e0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8500ns max), cache line size 08
	Interrupt: pin C routed to IRQ 9
	Region 0: Memory at febfdf00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 33 10 e0 00 16 01 10 02 01 20 03 0c 08 40 00 00
10: 00 df bf fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 33 10 e0 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 09 03 10 22

00:12.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
	Subsystem: Creative Labs CT4831 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at ff80 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 11 02 00 05 01 90 02 07 00 01 04 00 40 80 00
10: 81 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 31 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 02 14

00:12.1 Input device controller: Creative Labs SB Live! (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at fff0 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 11 02 70 05 01 90 02 07 00 80 09 00 40 80 00
10: f1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 20 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00

00:13.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at fc00 [size=128]
	Region 1: Memory at febfde80 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at febc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: b7 10 00 92 17 01 10 02 78 00 00 02 08 40 00 00
10: 01 fc 00 00 80 de bf fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
30: 00 00 bc fe dc 00 00 00 00 00 00 00 09 01 0a 0a

00:14.0 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001
00: 80 11 78 04 07 00 10 02 03 00 07 06 00 a8 82 00
10: 00 00 00 10 dc 00 00 22 00 02 05 b0 00 00 c0 10
20: 00 f0 ff 10 00 00 00 11 00 f0 3f 11 00 48 00 00
30: fc 48 00 00 00 4c 00 00 fc 4c 00 00 00 01 00 05
40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.1 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 80 11 78 04 07 00 10 02 03 00 07 06 00 a8 82 00
10: 00 10 00 10 dc 00 00 02 00 06 09 b0 00 00 40 10
20: 00 f0 7f 10 00 00 80 10 00 f0 bf 10 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 00 02 80 05
40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:05.0 VGA compatible controller: nVidia Corporation GeForce 256 DDR (rev 10) (prog-if 00 [VGA])
	Subsystem: VISIONTEK: Unknown device 000b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at feaf0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: de 10 01 01 07 00 b0 02 10 00 00 03 00 40 00 00
10: 00 00 00 fd 08 00 00 e8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 45 15 0b 00
30: 00 00 af fe 60 00 00 00 00 00 00 00 0b 01 05 01

02:00.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00cd (rev 01) (prog-if 10 [OHCI])
	Subsystem: Orange Micro: Unknown device 8011
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 11000000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at 11001000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at 11001100 (32-bit, non-prefetchable) [size=256]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 33 10 cd 00 02 00 90 02 01 10 00 0c 00 00 00 00
10: 00 00 00 11 00 10 00 11 00 11 00 11 00 00 00 00
20: 00 00 00 00 00 00 00 00 80 00 00 00 ee 12 11 80
30: 00 00 00 00 60 00 00 00 00 00 00 00 05 01 00 00

