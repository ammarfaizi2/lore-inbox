Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263017AbUDTN2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbUDTN2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 09:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbUDTN2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 09:28:42 -0400
Received: from acrogw.sw.ru ([195.133.213.225]:35022 "EHLO dhcp6-7.acronis.ru")
	by vger.kernel.org with ESMTP id S263017AbUDTN2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 09:28:20 -0400
Date: Tue, 20 Apr 2004 17:28:09 +0400
From: Andrey Ulanov <drey@acronis.com>
To: linux-kernel@vger.kernel.org
Subject: wrong irq rouing on centrino laptop
Message-ID: <20040420132808.GA22516@dhcp6-7.acronis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm trying to use Intel Wireless 2100 adapter on my centrino based
notebook. I use ipw2100 drivers from ipw2100.sf.net. The thing is that
hardware says that the device should generate irq11, but it really
generates irq5. I tryed both 2.4.26 and 2.6.5. I also tryed to compile
kernel with and without ACPI. I tryed to compile kernel with and
without APIC support. I also tryed to pass some parameters to kernel
(acpi=off, acpi=force, pci=biosirq). But anyway kernel says irq 11 and
device generates irq5. Of course it is possible to be hardware
problem, but it works under windows.

Any suggestions?

Here is information about the system:

# lspci -vv -b
00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 21)
	Subsystem: Unknown device 161f:202d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable)
	Capabilities: [e4] #09 [4104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 21) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Unknown device 161f:202d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 1800

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Unknown device 161f:202d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 3
	Region 4: I/O ports at 1820

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Unknown device 161f:202d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at 1840

00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Unknown device 161f:202d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 7
	Region 0: Memory at d0000000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: d0200000-d02fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Unknown device 161f:202d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 255
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860
	Region 5: Memory at 20000000 (32-bit, non-prefetchable)

00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 03)
	Subsystem: Unknown device 161f:202d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1880

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio Controller (rev 03)
	Subsystem: Unknown device 161f:202d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 1c00
	Region 1: I/O ports at 18c0
	Region 2: Memory at d0000c00 (32-bit, non-prefetchable)
	Region 3: Memory at d0000800 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Unknown device 161f:202d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 2400
	Region 1: I/O ports at 2000
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4e50 (prog-if 00 [VGA])
	Subsystem: Unknown device 161f:202d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d8000000 (32-bit, prefetchable)
	Region 1: I/O ports at 3000
	Region 2: Memory at d0100000 (32-bit, non-prefetchable)
	Capabilities: [58] AGP version 2.0
		Status: RQ=79 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:07.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a9)
	Subsystem: Unknown device 161f:202d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 20001000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

02:07.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a9)
	Subsystem: Unknown device 161f:202d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 0
	Region 0: Memory at 20002000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

02:07.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 01) (prog-if 10 [OHCI])
	Subsystem: Unknown device 161f:202d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at d0201000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME+

02:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Unknown device 161f:202d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 4000
	Region 1: Memory at d0201800 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
	Subsystem: Intel Corp.: Unknown device 2527
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0200000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-


# dmesg
Linux version 2.4.22-1.2174.nptl.asp (root@dhcp6-121.acronis.ru) (gcc version 3.3.2 20031022 (ASPLinux 3.3.2-1)) #20 Tue Apr 20 07:00:48 MSD 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7b000 (ACPI data)
 BIOS-e820: 000000001ff7b000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffff000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 130928
zone(0): 4096 pages.
zone(1): 126832 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7950
ACPI: RSDT (v001 PTLTD  CooperSp 0x06040000  LTP 0x00000000) @ 0x1ff762bc
ACPI: FADT (v001 INTEL  ODEM     0x06040000 PTL  0x00000050) @ 0x1ff7aed2
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1ff7afd8
ACPI: SSDT (v001  INTEL  EISTRef 0x00002000 INTL 0x20021002) @ 0x1ff762ec
ACPI: DSDT (v001 INTEL  ODEM     0x06040000 MSFT 0x0100000e) @ 0x00000000
Kernel command line: root=/dev/hda6  rhgb acpi=force
Initializing CPU#0
Detected 1594.859 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3185.04 BogoMIPS
Memory: 513684k/523712k available (1535k kernel code, 9640k reserved, 1147k data, 132k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: a7e9f9bf 00000000 00000000 00000000
CPU:             Common caps: a7e9f9bf 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfd943, last bus=2
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...................................................................................................................................................
Table [DSDT](id F005) - 550 Objects with 53 Devices 147 Methods 15 Regions
Parsing all Control Methods:....
Table [SSDT](id F003) - 7 Objects with 0 Devices 4 Methods 0 Regions
ACPI Namespace successfully loaded at root c03f6d3c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 0000000000001028 on int 9
Completing Region/Field/Buffer/Package initialization:..............................................................
Initialized 15/15 Regions 0/0 Fields 22/22 Buffers 25/25 Packages (565 nodes)
Executing all Device _STA and_INI methods:..[ACPI Debug] String: ---------------------------- AC _STA
...................................................
54 Devices found containing: 54 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
nsxfeval-0241 [08] acpi_evaluate_object  : Handle is NULL and Pathname is relative
nsxfeval-0241 [08] acpi_evaluate_object  : Handle is NULL and Pathname is relative
nsxfeval-0241 [08] acpi_evaluate_object  : Handle is NULL and Pathname is relative
nsxfeval-0241 [08] acpi_evaluate_object  : Handle is NULL and Pathname is relative
[ACPI Debug] String: ---------------------------- AC _STA
[ACPI Debug] String: ---------------------------- AC _STA
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5)
ACPI: PCI Interrupt Link [LNKB] (IRQs 10)
ACPI: PCI Interrupt Link [LNKC] (IRQs 10)
ACPI: PCI Interrupt Link [LNKD] (IRQs 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 *7 11 12 14 15)
ACPI: Embedded Controller [EC] (gpe 28)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
00:00:07[A] -> IRQ 10 Mode 1 Trigger 1
PIC: IRQ (10) already programmed
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
00:00:1d[B] -> IRQ 3 Mode 1 Trigger 1
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
00:00:1d[C] -> IRQ 11 Mode 1 Trigger 1
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 7
00:00:1d[D] -> IRQ 7 Mode 1 Trigger 1
PIC: IRQ (11) already programmed
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
00:00:1f[B] -> IRQ 5 Mode 1 Trigger 1
PIC: IRQ (10) already programmed
PIC: IRQ (3) already programmed
PIC: IRQ (5) already programmed
PIC: IRQ (11) already programmed
PIC: IRQ (5) already programmed
PIC: IRQ (11) already programmed
PIC: IRQ (5) already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Real Time Clock Driver v1.10e
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: IC25N020ATMR04-0, ATA DISK drive
blk: queue c041e8e0, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA DVD-ROM SD-R9012, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/1740KiB Cache, CHS=2432/255/63, UDMA(100)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
ide: late registration of driver.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 163k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 132k freed
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel(R) 855PM chipset
agpgart: AGP aperture is 256M @ 0xe0000000
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 00:1d.7: Intel Corp. 82801DB USB2
ehci_hcd 00:1d.7: irq 7, pci mem e08b7000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 32 is not supported by device 00:1d.7
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 06:25:46 Apr 20 2004
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x1800, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x1820, IRQ 3
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0x1840, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
Adding Swap: 265032k swap-space (priority -1)
ohci1394: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[d0201000-d02017ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0003252122080fc9]
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
microcode: CPU0 no microcode found! (sig=695, pflags=32)
uhci.c: USB Universal Host Controller Interface driver v1.1
SCSI subsystem driver Revision: 1.00
inserting floppy driver for 2.4.22-1.2174.nptl.asp
floppy0: no floppy controllers found
8139too Fast Ethernet driver 0.9.26
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 Fast Ethernet at 0xe093a800, 00:03:25:09:54:65, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8101'
 

# dump_pirq (from the pcmcia-cs distribution)
Interrupt routing table found at address 0xfdef0:
  Version 1.0, size 0x00f0
  Interrupt router is device 00:1f.0
  PCI exclusive interrupt mask: 0x0000 []
  Compatible router: vendor 0x8086 device 0x122e

Device 00:1e.0 (slot 0): PCI bridge
  INTA: link 0x60, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTB: link 0x61, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTC: link 0x62, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTD: link 0x63, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]

Device 02:07.0 (slot 0): CardBus bridge
  INTA: link 0x63, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTB: link 0x61, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTC: link 0x62, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]

Device 02:08.0 (slot 0): Ethernet controller
  INTA: link 0x61, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]

Device 02:09.0 (slot 0): Network controller
  INTA: link 0x62, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]

Device 02:0a.0 (slot 0): 
  INTA: link 0x61, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]

Device 03:01.0 (slot 4): 
  INTA: link 0x63, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTB: link 0x60, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTC: link 0x61, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTD: link 0x62, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]

Device 03:02.0 (slot 5): 
  INTA: link 0x62, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTB: link 0x63, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTC: link 0x60, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTD: link 0x61, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]

Device 03:03.0 (slot 6): 
  INTA: link 0x61, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTB: link 0x62, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTC: link 0x63, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTD: link 0x60, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]

Device 03:04.0 (slot 7): 
  INTA: link 0x60, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTB: link 0x61, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTC: link 0x62, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTD: link 0x63, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]

Device 00:00.0 (slot 0): Host bridge
  INTA: link 0x60, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTB: link 0x61, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTC: link 0x62, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTD: link 0x63, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]

Device 00:1f.0 (slot 0): ISA bridge
  INTA: link 0x62, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTB: link 0x61, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]

Device 00:1d.0 (slot 0): USB Controller
  INTA: link 0x60, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTB: link 0x63, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTC: link 0x62, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTD: link 0x6b, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]

Device 00:01.0 (slot 0): PCI bridge
  INTA: link 0x60, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]
  INTB: link 0x61, irq mask 0x1ef8 [3,4,5,6,7,9,10,11,12]

Interrupt router at 00:1f.0: Intel 82371FB PIIX PCI-to-ISA bridge
  PIRQ1 (link 0x60): irq 10
  PIRQ2 (link 0x61): irq 5
  PIRQ3 (link 0x62): irq 11
  PIRQ4 (link 0x63): irq 3
  Serial IRQ: [enabled] [quiet] [frame=21] [pulse=4]
  Level mask: 0x0ea8 [3,5,7,9,10,11]


-- 
with best regards, Andrey Ulanov.
