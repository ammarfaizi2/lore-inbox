Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312487AbSCUUqw>; Thu, 21 Mar 2002 15:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312488AbSCUUqo>; Thu, 21 Mar 2002 15:46:44 -0500
Received: from GS176.SP.CS.CMU.EDU ([128.2.198.136]:35720 "EHLO
	gs176.sp.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S312487AbSCUUqd>; Thu, 21 Mar 2002 15:46:33 -0500
Message-Id: <200203212047.g2LKlrc28867@gs176.sp.cs.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.4.18 & ALI15X3 DMA hang on boot
Date: Thu, 21 Mar 2002 15:47:53 -0500
From: John Langford <jcl@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, I've been trying to tame a wild Fujitsu P2040 laptop (with a
crusoe TM5800 processor).  A writeup of the experience so far is at:

http://www-2.cs.cmu.edu/~jcl/linux/fujitsu/fujitsu_p.html

There seems to be some fundamental incompatibility between the kernel
and the IDE chipset.  On several kernels in the 2.4 series including
2.4.18, I observe a hang in the bootsequence at:

ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci=biosirq.
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
<hang>

By comparison with other boot sequences, it appears this is when DMA
is first detected.  Passing 'ide=nodma' to the kernel does _not_ work.

You must not enable the configuration flag 'CONFIG_BLK_DEV_IDEDMA_PCI'
when building a kernel.  

I confirmed that the problem is with the chipset and not the hard
drive by swapping a known-DMA-working hard drive in.  The same failure
mode persists.

Any help is greatly appreciated.

Aside from this serious DMA issue and an undetectable modem, this
seems to be an excellent linux laptop so I'd very much like to see
these caveats removed.

Various debug information is included below but is also on the
webpage.

-John

lspci -vv

00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 01)
	Subsystem: Citicorp TTI: Unknown device 110e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc100000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
	Subsystem: Citicorp TTI: Unknown device 110e
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
	Subsystem: Citicorp TTI: Unknown device 110e
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Subsystem: Citicorp TTI: Unknown device 10a2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fc004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Multimedia audio controller: Acer Laboratories Inc. [ALi]: Unknown device 5451 (rev 01)
	Subsystem: Citicorp TTI: Unknown device 112f
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at fc005000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Citicorp TTI: Unknown device 10a3
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1533 Aladdin IV ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Citicorp TTI: Unknown device 10c6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3) (prog-if fa)
	Subsystem: Citicorp TTI: Unknown device 10a4
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 1800 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Citicorp TTI: Unknown device 111c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 8000 [size=256]
	Region 1: Memory at fc007800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8026 (prog-if 10 [OHCI])
	Subsystem: Citicorp TTI: Unknown device 1162
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fc007000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at fc000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M (rev 64) (prog-if 00 [VGA])
	Subsystem: Citicorp TTI: Unknown device 1103
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 1400 [size=256]
	Region 2: Memory at fc006000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


dmesg (note this, is with a 2.4.17 kernel rather than 2.4.18.  The
same failure mode appears in both)

Linux version 2.4.17 (root@localhost.localdomain) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #2 Wed Mar 20 08:18:06 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c000 (usable)
 BIOS-e820: 000000000009c000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e7400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000efe0000 (usable)
 BIOS-e820: 000000000efe0000 - 000000000efefc00 (ACPI data)
 BIOS-e820: 000000000efefc00 - 000000000eff0000 (ACPI NVS)
 BIOS-e820: 000000000eff0000 - 000000000f100000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
On node 0 totalpages: 61408
zone(0): 4096 pages.
zone(1): 57312 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda1
Initializing CPU#0
Detected 793.215 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1464.72 BogoMIPS
Memory: 239256k/245632k available (1042k kernel code, 5976k reserved, 284k data, 216k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0080893f 0081813f 0000000e, vendor = 7
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.4.1.0, 800 MHz
CPU: Code Morphing Software revision 4.2.6-8-168
CPU: 20010703 00:29 official release 4.2.6#2
CPU: After vendor init, caps: 0080893f 0081813f 0000000e 00000000
CPU:     After generic, caps: 0080893f 0081813f 0000000e 00000000
CPU:             Common caps: 0080893f 0081813f 0000000e 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TM5800 stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xfd88e, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci=biosirq.
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
hda: IBM-DJSA-220, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-R2102, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB) w/1874KiB Cache, CHS=2432/255/63
ide-floppy driver 0.97.sv
Partition check:
 hda: hda1 hda2 hda3
floppy0: no floppy controllers found
ide-floppy driver 0.97.sv
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 321k freed
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 216k freed
Adding Swap: 522104k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 11 for device 00:02.0
usb-ohci.c: USB OHCI at membase 0xcf854000, IRQ 11
usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. [ALi] M5237 USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: USB new device connect on bus1/2, assigned device number 2
usb.c: USB device 2 (vend/prod 0x409/0x40) is not claimed by any active driver.
SCSI subsystem driver Revision: 1.00
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: NEC       Model: USB UF000x        Rev: 1.21
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
USB Mass Storage support registered.
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_conntrack (1919 buckets, 15352 max)
NET4: Linux IPX 0.47 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
NET4: AppleTalk 0.18a for Linux NET4.0
8139too Fast Ethernet driver 0.9.22
PCI: Found IRQ 9 for device 00:12.0
eth0: RealTek RTL8139 Fast Ethernet at 0xcf89f800, 00:e0:00:85:68:f5, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 9 for device 00:0c.0
Yenta IRQ list 04f8, PCI irq9
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 2880 512-byte hdwr sectors (1 MB)
sda: Write Protect is off
 sda:
EXT2-fs warning: checktime reached, running e2fsck is recommended
usb-ohci.c: USB suspend: usb-00:02.0
usb-ohci.c: odd PCI resume for usb-00:02.0
8139too Fast Ethernet driver 0.9.22
PCI: Found IRQ 9 for device 00:12.0
eth0: RealTek RTL8139 Fast Ethernet at 0xcf89f800, 00:e0:00:85:68:f5, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
eth0: Too much work at interrupt, IntrStatus=0x0001.
eth0: Too much work at interrupt, IntrStatus=0x0001.
