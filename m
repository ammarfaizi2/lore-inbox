Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270076AbRHNTPN>; Tue, 14 Aug 2001 15:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269875AbRHNTPF>; Tue, 14 Aug 2001 15:15:05 -0400
Received: from GS176.SP.CS.CMU.EDU ([128.2.198.136]:63187 "EHLO
	gs176.sp.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S269866AbRHNTOv>; Tue, 14 Aug 2001 15:14:51 -0400
Message-Id: <200108141919.f7EJIul26987@gs176.sp.cs.cmu.edu>
To: linux-kernel@vger.kernel.org
cc: mukesh+@cs.cmu.edu, rajesh+@cs.cmu.edu
Subject: IRQ routing problems on Transmeta laptop
Date: Tue, 14 Aug 2001 15:18:56 -0400
From: John Langford <jcl@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please cc me in all replies.

I have a new NEC Lavie laptop which I'm trying to install linux on.  
http://www.dynamism.com/lavie/index.shtml

I have linux up and running but there are IRQ difficulties preventing
me from using the usb cdrom, the pcmcia slot, and power management.

exact symptoms:
Loading usb, I get:
Aug 12 09:32:29 localhost kernel: usb-ohci.c: USB OHCI at membase 0xc00d0000, IRQ 5
Aug 12 09:32:29 localhost kernel: usb-ohci.c: usb-00:14.0, Acer Laboratories Inc. [ALi] M5237 USB
Aug 12 09:32:29 localhost kernel: usb-ohci.c: USB HC TakeOver failed!
Aug 12 09:32:29 localhost kernel: usb.c: USB bus -1 deregistered

cardservices fails silently.

apm says:
[root@z linux]# apm
AC on-line, no system battery
or:
[root@z linux]# apm
AC off-line, no system battery

apm -s causes the system to hang without recovery and a blank screen.

Things done:
1. Disabled everything I could (USB cdrom & IR port) in the bios.  
2. Tested 2.4.8-ac1 with various settings.
   General setup -> PCI access mode = any
		    PCI access = any "pci=biosirq"
		    PCI access = direct
		    PCI access = bios

The problems persist across all settings.

I'll append several traces of things which seem like relevant
information.  Any help in solving this would be greatly appreciated
and I'm willing to forward any other information which will help.

-John

lspci -vv

00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:03.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: NEC Corporation: Unknown device 80e3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001c00-00001cff
	I/O window 1: 00002000-000020ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:04.0 Multimedia audio controller: ESS Technology ES1969 Solo-1 Audiodrive (rev 02)
	Subsystem: ESS Technology: Unknown device 8898
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1400 [size=64]
	Region 1: I/O ports at 1490 [size=16]
	Region 2: I/O ports at 1480 [size=16]
	Region 3: I/O ports at 14b4 [size=4]
	Region 4: I/O ports at 14b0 [size=4]
	Capabilities: [c0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M (rev 64) (prog-if 00 [VGA])
	Subsystem: NEC Corporation: Unknown device 810a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 1000 [size=256]
	Region 2: Memory at fc120000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 09)
	Subsystem: Intel Corporation: Unknown device 2411
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fc121000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1440 [size=64]
	Region 2: Memory at fc100000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D2 PME-Enable- DSel=0 DScale=2 PME-

00:06.1 Serial controller: Xircom: Unknown device 002b (prog-if 02 [16550])
	Subsystem: Intel Corporation: Unknown device 2411
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1800 [size=8]
	Region 1: Memory at fc122000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: NEC Corporation: Unknown device 1533
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3) (prog-if b0)
	Subsystem: NEC Corporation: Unknown device 0000
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 01f0 [size=16]
	Region 1: I/O ports at 03f4
	Region 2: I/O ports at 0170 [size=16]
	Region 3: I/O ports at 0374
	Region 4: I/O ports at 14a0 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: NEC Corporation: Unknown device 0000
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:14.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 000d0000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


General setup -> PCI access mode = any

Linux version 2.4.8-ac1 (root@localhost) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)) #4 Mon Aug 13 14:08:18 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000e6400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000006ff0000 (usable)
 BIOS-e820: 0000000006ff0000 - 0000000006fffc00 (ACPI data)
 BIOS-e820: 0000000006fffc00 - 0000000007000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 28656
zone(0): 4096 pages.
zone(1): 24560 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux ro root=302 BOOT_FILE=/boot/bzImage-2.4.8
Initializing CPU#0
Detected 592.658 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1179.64 BogoMIPS
Memory: 110760k/114624k available (882k kernel code, 3476k reserved, 267k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0084803f 0081813f 00000006, vendor = 7
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.3.1.3, 600 MHz
CPU: Code Morphing Software revision 4.1.4-7-51
CPU: 20000805 23:30 official release 4.1.4#2
CPU: After vendor init, caps: 0084813f 0081813f 00000006 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0080813f 0081813f 00000006 00000000
CPU:             Common caps: 0080813f 0081813f 00000006 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TMTM5600 stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfd8ae, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnP: PNP BIOS installation structure at 0xc00f7340
PnP: PNP BIOS version 1.0, entry at f0000:9cc5, dseg at 400
PnP: 14 devices detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
PCI: Assigned IRQ 9 for device 00:06.1
PCI: Sharing IRQ 9 with 00:03.0
IRQ routing conflict for 00:04.0, have irq 11, want irq 9
PCI: Sharing IRQ 9 with 00:06.0
Redundant entry in serial pci_table.  Please send the output of
lspci -vv, this message (4445,43,32902,9233)
and the manufacturer and name of serial board or modem board
to serial-pci-info@lists.sourceforge.net.
register_serial(): autoconfig failed
block: queued sectors max/low 73314kB/24438kB, 256 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 80
PCI: No IRQ known for interrupt pin A of device 00:10.0. Please try using pci=biosirq.
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x14a0-0x14a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x14a8-0x14af, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI_DK23CA-20, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=2432/255/63, UDMA(33)
ide-floppy driver 0.97
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
task queue still active
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 77M
agpgart: no supported devices found.
ide-floppy driver 0.97
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Assigned IRQ 9 for device 00:03.0
IRQ routing conflict for 00:04.0, have irq 11, want irq 9
PCI: Sharing IRQ 9 with 00:06.0
PCI: Sharing IRQ 9 with 00:06.1
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Yenta IRQ list 0cf8, PCI irq9
Socket status: 30000006
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 265032k swap-space (priority -1)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
solo1: version v0.19 time 14:27:40 Aug 13 2001
PCI: Assigned IRQ 11 for device 00:04.0
IRQ routing conflict for 00:03.0, have irq 9, want irq 11
IRQ routing conflict for 00:06.0, have irq 9, want irq 11
IRQ routing conflict for 00:06.1, have irq 9, want irq 11
solo1: joystick port at 0x14b1
solo1: ddma base address: 0x1480

    PCI access = any "pci=biosirq"

Linux version 2.4.8-ac1 (root@localhost) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)) #4 Mon Aug 13 14:08:18 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000e6400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000006ff0000 (usable)
 BIOS-e820: 0000000006ff0000 - 0000000006fffc00 (ACPI data)
 BIOS-e820: 0000000006fffc00 - 0000000007000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 28656
zone(0): 4096 pages.
zone(1): 24560 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux ro root=302 BOOT_FILE=/boot/bzImage-2.4.8 pci=biosirq
Initializing CPU#0
Detected 592.656 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1179.64 BogoMIPS
Memory: 110760k/114624k available (882k kernel code, 3476k reserved, 267k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0084803f 0081813f 00000006, vendor = 7
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.3.1.3, 600 MHz
CPU: Code Morphing Software revision 4.1.4-7-51
CPU: 20000805 23:30 official release 4.1.4#2
CPU: After vendor init, caps: 0084813f 0081813f 00000006 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0080813f 0081813f 00000006 00000000
CPU:             Common caps: 0080813f 0081813f 00000006 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TMTM5600 stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfd8ae, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnP: PNP BIOS installation structure at 0xc00f7340
PnP: PNP BIOS version 1.0, entry at f0000:9cc5, dseg at 400
PnP: 14 devices detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
PCI: Assigned IRQ 9 for device 00:06.1
PCI: Sharing IRQ 9 with 00:03.0
IRQ routing conflict for 00:04.0, have irq 11, want irq 9
PCI: Sharing IRQ 9 with 00:06.0
Redundant entry in serial pci_table.  Please send the output of
lspci -vv, this message (4445,43,32902,9233)
and the manufacturer and name of serial board or modem board
to serial-pci-info@lists.sourceforge.net.
register_serial(): autoconfig failed
block: queued sectors max/low 73314kB/24438kB, 256 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 80
PCI: No IRQ known for interrupt pin A of device 00:10.0.
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x14a0-0x14a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x14a8-0x14af, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI_DK23CA-20, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=2432/255/63, UDMA(33)
ide-floppy driver 0.97
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
task queue still active
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 77M
agpgart: no supported devices found.
ide-floppy driver 0.97
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Assigned IRQ 9 for device 00:03.0
IRQ routing conflict for 00:04.0, have irq 11, want irq 9
PCI: Sharing IRQ 9 with 00:06.0
PCI: Sharing IRQ 9 with 00:06.1
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
spurious 8259A interrupt: IRQ7.
Yenta IRQ list 0cf8, PCI irq9
Socket status: 30000006
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 265032k swap-space (priority -1)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
solo1: version v0.19 time 14:27:40 Aug 13 2001
PCI: Assigned IRQ 11 for device 00:04.0
IRQ routing conflict for 00:03.0, have irq 9, want irq 11
IRQ routing conflict for 00:06.0, have irq 9, want irq 11
IRQ routing conflict for 00:06.1, have irq 9, want irq 11
solo1: joystick port at 0x14b1
solo1: ddma base address: 0x1480
