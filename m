Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287578AbSAFW1K>; Sun, 6 Jan 2002 17:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287573AbSAFW0x>; Sun, 6 Jan 2002 17:26:53 -0500
Received: from cptf-adsl.demon.co.uk ([62.49.1.93]:1170 "HELO
	boatman.intrepid.co.uk") by vger.kernel.org with SMTP
	id <S282967AbSAFW0l>; Sun, 6 Jan 2002 17:26:41 -0500
Date: Sun, 6 Jan 2002 22:26:00 +0000 (GMT)
From: Chris Pitchford <cpitchford@intrepid.co.uk>
X-X-Sender: <cpitchford@boatman.intrepnet>
To: <linux-kernel@vger.kernel.org>
Subject: Ethernet/SCSI/PCI problems when enabling SMP on 2.4.17: VP6, aix7xxx
 & 3c595
Message-ID: <Pine.LNX.4.33.0201062057400.18876-100000@boatman.intrepnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I am experiencing problems using a 3Com Network card and Adaptec SCSI
card under 2.4.17 in SMP mode. Since the only other PCI card in my system
is a very under used sound card I am wondering if this is a deeper
problem with SMP under Linux on my system.

I recently installed two Intel P3 Coppermine processors onto my Abit
VP6 motherboard and recompiled my kernel as SMP. I am seeing
problems that never once occured during the month I ran the system
with one P3 processor in UP mode.

During light network load I am seeing messages appear frequently in the
kernel messages and the network card stop receiving/transmitting traffic
out onto the network. This did not happen (and does not happen) when
running Uni-processor:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0c80 media 88c0 dma ffffffff.
eth0: Updating statistics failed, disabling stats as an interrupt source.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0c80 media 88c0 dma ffffffff.

Also I am seeing problems with the SCSI system:

scsi0: PCI error Interrupt at seqaddr = 0x8
scsi0: Data Parity Error Detected during address or write data phase

I have to devices on the SCSI bus: Yamaha 2100S scsi CDRW and a HP DDS3
DAT tape drive. Again, I have had no problems with these devices prior to
running with SMP.

I've included a rundown of the hard I'm using and some stats:


ABIT VP6 Dual intel Motherboard
VIA VT82C686 Chipset
2x 1Ghz PIII Coppermine
512 Mb Ram
3Com 3c595 100baseT NIC
Adaptec 29160N SCSI card
Creative SB512 sound card  ( Ensoniq 5880 AudioPCI )
Matrox G200 AGP graphics card
Slackware 8.0 with 2.4.17

#lspci -vv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
	Subsystem: ABIT Computer Corp.: Unknown device a204
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d4000000-d6ffffff
	Prefetchable memory behind bridge: d7000000-d7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
	Subsystem: ABIT Computer Corp.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at dc00 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 SCSI storage controller: Adaptec 7892A (rev 02)
	Subsystem: Adaptec: Unknown device 62a0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 17
	BIST result: 00
	Region 0: I/O ports at e000 [disabled] [size=256]
	Region 1: Memory at d9000000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Ethernet controller: 3Com Corporation 3c595 100BaseTX [Vortex]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at e400 [size=32]
	Expansion ROM at <unassigned> [disabled] [size=64K]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d7000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at d4000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2

#cat /proc/interrupts
           CPU0       CPU1
  0:     189811     129350    IO-APIC-edge  timer
  1:          2          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 14:       2384       2334    IO-APIC-edge  ide0
 15:       5523       4584    IO-APIC-edge  ide1
 16:       9646       9627   IO-APIC-level  es1371
 17:      28430      28517   IO-APIC-level  aic7xxx
 19:      45890      45280   IO-APIC-level  eth0, usb-uhci, usb-uhci
NMI:          0          0
LOC:     319056     319075
ERR:          0
MIS:          0

# dmesg
Hz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1992.29 BogoMIPS
Memory: 512688k/524224k available (1673k kernel code, 11148k reserved, 570k data, 248k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 730.97 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1992.29 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3984.58 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-18, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 20.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 003 03  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89
 10 003 03  1    1    0   1   0    1    1    91
 11 003 03  1    1    0   1   0    1    1    99
 12 000 00  1    0    0   0   0    0    0    00
 13 003 03  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 998.3772 MHz.
..... host bus clock speed is 133.1168 MHz.
cpu: 0, clocks: 1331168, slice: 443722
CPU0<T0:1331168,T1:887440,D:6,S:443722,C:1331168>
cpu: 1, clocks: 1331168, slice: 443722
CPU1<T0:1331168,T1:443712,D:12,S:443722,C:1331168>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I9,P0) -> 16
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI: Enabling Via external APIC routing
PCI: Via IRQ fixup for 00:07.2, from 10 to 3
PCI: Via IRQ fixup for 00:07.3, from 10 to 3
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.15)
apm: disabled - APM is not SMP safe (power off active).
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v1.7 (20011216) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport0: faking semi-colon
parport0: Multimedia device, Connectix Color QuickCam 2.0
parport_pc: Via 686A parallel port: io=0x378
matroxfb: Matrox Millennium G200 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26208)
matroxfb: framebuffer at 0xD7000000, mapped to 0xe0812000, size 16777216
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST320430A, ATA DISK drive
hdb: WDC AC420400D, ATA DISK drive
hdc: Maxtor 4G120J6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40079088 sectors (20520 MB) w/512KiB Cache, CHS=2494/255/63, UDMA(33)
hdb: 39876480 sectors (20417 MB) w/1966KiB Cache, CHS=2482/255/63, UDMA(33)
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
 /dev/ide/host0/bus0/target1/lun0: p1 p2
 /dev/ide/host0/bus1/target0/lun0: p1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0c.0: 3Com PCI 3c595 Vortex 100baseTx at 0xe400. Vers LK1.1.16
00:0c.0: Overriding PCI latency timer (CFLT) setting of 32, new value is 248.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xd0000000
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 29160N Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: HP        Model: C1537A            Rev: L706
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 32)
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0H
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 7)
st: Version 20011103, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
es1371: version v0.30 time 20:04:37 Jan  6 2002
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: found es1371 rev 2 at io 0xdc00 irq 16
es1371: features: joystick 0x0
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR A5)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1728.400 MB/sec
   32regs    :  1225.200 MB/sec
   pIII_sse  :  2058.400 MB/sec
   pII_mmx   :  2242.000 MB/sec
   p5_mmx    :  2360.000 MB/sec
raid5: using function: pIII_sse (2058.400 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 0000002d]
 [events: 00000026]
 [events: 0000002d]
 [events: 00000026]
 [events: 0000002a]
md: autorun ...
md: considering ide/host0/bus1/target0/lun0/part1 ...
md:  adding ide/host0/bus1/target0/lun0/part1 ...
md: created md10
md: bind<ide/host0/bus1/target0/lun0/part1,1>
md: running: <ide/host0/bus1/target0/lun0/part1>
md: ide/host0/bus1/target0/lun0/part1's event counter: 0000002a
md: RAID level 1 does not need chunksize! Continuing anyway.
md10: max total readahead window set to 124k
md10: 1 data-disks, max readahead per data-disk: 124k
raid1: device ide/host0/bus1/target0/lun0/part1 operational as mirror 0
raid1: md10, not all disks are operational -- trying to recover array
raid1: raid set md10 active with 1 out of 2 mirrors
md: recovery thread got woken up ...
md10: no spare disk to reconstruct array! -- continuing in degraded mode
md: recovery thread finished ...
md: updating md10 RAID superblock on device
md: ide/host0/bus1/target0/lun0/part1 [events: 0000002b]<6>(write) ide/host0/bus1/target0/lun0/part1's sb offset: 120060736
md: considering ide/host0/bus0/target1/lun0/part2 ...
md:  adding ide/host0/bus0/target1/lun0/part2 ...
md:  adding ide/host0/bus0/target0/lun0/part2 ...
md: created md2
md: bind<ide/host0/bus0/target0/lun0/part2,1>
md: bind<ide/host0/bus0/target1/lun0/part2,2>
md: running: <ide/host0/bus0/target1/lun0/part2><ide/host0/bus0/target0/lun0/part2>
md: ide/host0/bus0/target1/lun0/part2's event counter: 00000026
md: ide/host0/bus0/target0/lun0/part2's event counter: 00000026
md: RAID level 1 does not need chunksize! Continuing anyway.
md2: max total readahead window set to 124k
md2: 1 data-disks, max readahead per data-disk: 124k
raid1: device ide/host0/bus0/target1/lun0/part2 operational as mirror 1
raid1: device ide/host0/bus0/target0/lun0/part2 operational as mirror 0
raid1: raid set md2 active with 2 out of 2 mirrors
md: updating md2 RAID superblock on device
md: ide/host0/bus0/target1/lun0/part2 [events: 00000027]<6>(write) ide/host0/bus0/target1/lun0/part2's sb offset: 530048
md: ide/host0/bus0/target0/lun0/part2 [events: 00000027]<6>(write) ide/host0/bus0/target0/lun0/part2's sb offset: 530048
md: considering ide/host0/bus0/target1/lun0/part1 ...
md:  adding ide/host0/bus0/target1/lun0/part1 ...
md:  adding ide/host0/bus0/target0/lun0/part1 ...
md: created md1
md: bind<ide/host0/bus0/target0/lun0/part1,1>
md: bind<ide/host0/bus0/target1/lun0/part1,2>
md: running: <ide/host0/bus0/target1/lun0/part1><ide/host0/bus0/target0/lun0/part1>
md: ide/host0/bus0/target1/lun0/part1's event counter: 0000002d
md: ide/host0/bus0/target0/lun0/part1's event counter: 0000002d
md: RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device ide/host0/bus0/target1/lun0/part1 operational as mirror 0
raid1: device ide/host0/bus0/target0/lun0/part1 operational as mirror 1
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: ide/host0/bus0/target1/lun0/part1 [events: 0000002e]<6>(write) ide/host0/bus0/target1/lun0/part1's sb offset: 19406400
md: ide/host0/bus0/target0/lun0/part1 [events: 0000002e]<6>(write) ide/host0/bus0/target0/lun0/part1's sb offset: 19502784
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 248k freed
Adding Swap: 530040k swap-space (priority -1)
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on md(9,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usb-uhci.c: $Revision: 1.268 $ time 20:05:57 Jan  6 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
VFS: Disk change detected on device sr(11,0)
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0c80 media 88c0 dma ffffffff.
eth0: Updating statistics failed, disabling stats as an interrupt source.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0c80 media 88c0 dma ffffffff.
scsi0: PCI error Interrupt at seqaddr = 0x8
scsi0: Data Parity Error Detected during address or write data phase
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0c80 media 88c0 dma ffffffff.


