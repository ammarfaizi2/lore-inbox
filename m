Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135759AbREIB7x>; Tue, 8 May 2001 21:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135772AbREIB7o>; Tue, 8 May 2001 21:59:44 -0400
Received: from c921250-a.frmt1.sfba.home.com ([24.19.220.93]:63534 "EHLO
	c921250-a.frmt1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S135759AbREIB7k>; Tue, 8 May 2001 21:59:40 -0400
Date: Tue, 8 May 2001 18:57:50 -0700 (PDT)
From: "J. S. Connell" <ankh@canuck.gen.nz>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 Kernel - ASUS CUV4X-DLS Question
In-Reply-To: <200105031751.LAA24795@iiwi.lanl.gov>
Message-ID: <Pine.LNX.4.21.0105081841530.12740-100000@canuck.gen.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I unfortunately don't have the time this evening to produce actual kernel
messages, but I did want to throw out that I have an ASUS CUV4X-DLS board
too, with two PIII/1GHz processors in it, and I cannot get it to boot an
SMP kernel at all.  In addition to the built-in devices, the following
cards are also present:

* Netgear FA310TX (rev. D, I believe - lspci reports it as a Lite-On
  LNE100TX rev 21)
* Promise PDC20267 Ultra100 controller
* Creative SB Live! Value
* Matrox G200 AGP

When it gets to the point of activating the second processor, kernel
2.4.3-ac13 starts spewing:


probable hardware bug: clock timer configuration lost - probably a VIA686a motherboard.
probable hardware bug: restoring chip configuration.


continuously.  Older kernels simply hang at this point.  I'll try to get
the actual messages leading up to this tomorrow.  Also, if there's
any other information I can collect from my system that could help,
feel free to ask.  I'll also build 2.4.4-ac6 on it tomorrow and try
booting it SMP. Here's the output of lspci -vvvvvv:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
	Subsystem: Asustek Computer, Inc.: Unknown device 8038
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: f9800000-fadfffff
	Prefetchable memory behind bridge: faf00000-fbffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: Asustek Computer, Inc.: Unknown device 8038
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f9000000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at b800 [size=64]
	Region 2: Memory at f8800000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:08.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c1010 Ultra3 SCSI Adapter (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b400 [size=256]
	Region 1: Memory at f8000000 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at f7800000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c1010 Ultra3 SCSI Adapter (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 4500ns max), cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at b000 [size=256]
	Region 1: Memory at f7000000 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at f6800000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 21)
	Subsystem: Netgear FA310TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a800 [size=256]
	Region 1: Memory at f6000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 4d33
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a400 [size=8]
	Region 1: I/O ports at a000 [size=4]
	Region 2: I/O ports at 9800 [size=8]
	Region 3: I/O ports at 9400 [size=4]
	Region 4: I/O ports at 9000 [size=64]
	Region 5: Memory at f5800000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 8800 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at 8400 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fb000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at fa000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at f9800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at faff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2

Here is the dmesg output from a single-processor boot of 2.4.3-ac13,
although I don't know how much use this is:

Linux version 2.4.3-ac13 (root@balance) (gcc version 2.95.4 20010319 (Debian prerelease)) #104 Sat Apr 28 19:42:43 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffc000 (usable)
 BIOS-e820: 000000000fffc000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=243ac13 ro root=302 mem=256M ether=0,0,eth0 ether=0,0,eth1 nmi_watchdog=0
Initializing CPU#0
Detected 1004.542 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2005.40 BogoMIPS
Memory: 255168k/262144k available (1268k kernel code, 6588k reserved, 474k data, 228k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0d00, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Disabled enhanced CPU to PCI posting
PCI: Disabled enhanced CPU to PCI posting #2
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
Starting kswapd v1.8
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
block: queued sectors max/low 169506kB/56502kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
PDC20267: IDE controller on PCI bus 00 dev 58
PCI: Found IRQ 10 for device 00:0b.0
PCI: The same IRQ used for device 00:07.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x9000-0x9007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x9008-0x900f, BIOS settings: hdg:DMA, hdh:pio
hda: QUANTUM FIREBALL ST4.3A, ATA DISK drive
hdc: Pioneer CD-ROM ATAPI Model DR-A14S 0104, ATAPI CD/DVD-ROM drive
hdd: PLEXTOR CD-R PX-W1610A, ATAPI CD/DVD-ROM drive
hdg: IBM-DTLA-307075, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide3 at 0x9800-0x9807,0x9402 on irq 10
hda: 8418816 sectors (4310 MB) w/81KiB Cache, CHS=14848/9/63, UDMA(33)
hdg: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
 /dev/ide/host2/bus1/target0/lun0: p1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
loop: loaded (max 8 devices)
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Linux Tulip driver version 0.9.14e (April 20, 2001)
PCI: Found IRQ 5 for device 00:0a.0
00:0a.0:  MII transceiver #1 config 1000 status 782d advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 33 at 0xa800, 00:A0:CC:3C:A8:DB, IRQ 5.
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 10 for device 00:07.0
PCI: The same IRQ used for device 00:0b.0
eth1: Intel Corporation 82557 [Ethernet Pro 100], 00:E0:18:05:A9:70, IRQ 10.
  Board assembly 733470-006, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 9 for device 00:08.0
sym53c8xx: at PCI bus 0, device 8, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c1010-33 detected with Symbios NVRAM
PCI: Found IRQ 11 for device 00:08.1
PCI: The same IRQ used for device 00:0c.0
PCI: The same IRQ used for device 01:00.0
sym53c8xx: at PCI bus 0, device 8, function 1
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c1010-33 detected with Symbios NVRAM
sym53c1010-33-0: rev 0x1 on pci bus 0 device 8 function 0 irq 9
sym53c1010-33-0: Symbios format NVRAM, ID 7, Fast-80, Parity Checking
sym53c1010-33-0: on-chip RAM at 0xf7800000
sym53c1010-33-0: restart (scsi reset).
sym53c1010-33-0: handling phase mismatch from SCRIPTS.
sym53c1010-33-0: Downloading SCSI SCRIPTS.
sym53c1010-33-1: rev 0x1 on pci bus 0 device 8 function 1 irq 11
sym53c1010-33-1: Symbios format NVRAM, ID 7, Fast-80, Parity Checking
sym53c1010-33-1: on-chip RAM at 0xf6800000
sym53c1010-33-1: restart (scsi reset).
sym53c1010-33-1: handling phase mismatch from SCRIPTS.
sym53c1010-33-1: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx-1.7.3b-20010407
scsi1 : sym53c8xx-1.7.3b-20010407
  Vendor: SEAGATE   Model: ST39103LW         Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym53c1010-33-0-<0,0>: tagged command queue depth set to 32
scsi2 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PIONEER   Model: CD-ROM DR-A14S    Rev: 1.04
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W1610A  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sym53c1010-33-0-<0,0>: phase change 6-7 11@015734b8 resid=2.
sym53c1010-33-0-<0,*>: FAST-40 WIDE SCSI 80.0 MB/s (25.0 ns, offset 15)
SCSI device sda: 17783240 512-byte hdwr sectors (9105 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 >
Attached scsi CD-ROM sr0 at scsi2, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi2, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack (2048 buckets, 16384 max)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 228k freed
Adding Swap: 65732k swap-space (priority 1)
Adding Swap: 128480k swap-space (priority 2)
reiserfs: checking transaction log (device 03:03) ...
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25


