Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318268AbSHDX5a>; Sun, 4 Aug 2002 19:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318271AbSHDX5a>; Sun, 4 Aug 2002 19:57:30 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:24589
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S318268AbSHDX5Z>; Sun, 4 Aug 2002 19:57:25 -0400
Subject: 2.4.19: no DMA for IDE with Intel i845e
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-aa/RGoS+9XAkH0KHs/4j"
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Aug 2002 17:00:57 -0700
Message-Id: <1028505657.1545.3.camel@ixodes.goop.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aa/RGoS+9XAkH0KHs/4j
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, 

I just rebooted with 2.4.19, and I find that there's no DMA on my ide
interface, and it is refusing to honour 'hdparm -d1 /dev/hda'. 

My system is an Asus P4B533 which uses an Intel 845e chipset (this
system has a 1.8GHz Northwood, 1G of memory).  I have BIOS version 1006
installed, which was the latest as of a few days ago (and the Asus site
seems dead right now). 

On boot, it says: 

...
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH4: (ide_setup_pci_device:) Could not enable device.
hda: IBM-DTLA-307030, ATA DISK drive
hdb: WDC WD400AW-00BYK0, ATA DISK drive
hdc: ATAPI 48X CDROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63
hdb: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63
hdc: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
 /dev/ide/host0/bus0/target1/lun0: p1 p2
...
lspci says for the IDE device: 

00:1f.1 IDE interface: Intel Corp. 82801DB IDE U100 (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned> [size=8]
	Region 1: I/O ports at <unassigned> [size=4]
	Region 2: I/O ports at <unassigned> [size=8]
	Region 3: I/O ports at <unassigned> [size=4]
	Region 4: I/O ports at f000 [size=16]
	Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]
I'm not sure what the "Resource collisions" actually refer to, but I'm
guessing its the unassigned IO ports.  I tried switching "PnP OS" on and
off in the BIOS settings; it makes no difference. 

Full boot messages, lspci, /proc/iomem, /proc/interrupts and /proc/pci
output attached. 

Update: 2.4.19-ac1 seems to work fine, so I hope this part of -ac gets
merged into mainline soon... (Is it just the changes in the IDE driver,
or is it something to do with PCI setup?)

Thanks, 
    J 
    

--=-aa/RGoS+9XAkH0KHs/4j
Content-Disposition: attachment; filename=pci
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; NAME=pci; CHARSET=ISO-8859-15

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev=
 17).
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 1=
7).
      Master Capable.  Latency=3D64.  Min Gnt=3D8.
  Bus  0, device  29, function  0:
    USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 1).
      IRQ 11.
      I/O at 0xd800 [0xd81f].
  Bus  0, device  29, function  1:
    USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 1).
      IRQ 5.
      I/O at 0xd400 [0xd41f].
  Bus  0, device  29, function  2:
    USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 1).
      IRQ 10.
      I/O at 0xd000 [0xd01f].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 129).
      Master Capable.  No bursts.  Min Gnt=3D6.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 1).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801DB IDE U100 (rev 1).
      IRQ 10.
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0xf000 [0xf00f].
      Non-prefetchable 32 bit memory at 0x40000000 [0x400003ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV15 (GeForce2 Pro) (rev =
163).
      IRQ 11.
      Master Capable.  Latency=3D248.  Min Gnt=3D5.Max Lat=3D1.
      Non-prefetchable 32 bit memory at 0xe6000000 [0xe6ffffff].
      Prefetchable 32 bit memory at 0xe8000000 [0xefffffff].
  Bus  2, device   3, function  0:
    Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 16).
      IRQ 9.
      Master Capable.  Latency=3D32.  Min Gnt=3D2.Max Lat=3D24.
      I/O at 0xb800 [0xb8ff].
  Bus  2, device  10, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21140 [Faste=
rNet] (rev 34).
      IRQ 9.
      Master Capable.  Latency=3D32.  Min Gnt=3D20.Max Lat=3D40.
      I/O at 0xb400 [0xb47f].
      Non-prefetchable 32 bit memory at 0xe5000000 [0xe500007f].
  Bus  2, device  12, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 7).
      IRQ 9.
      Master Capable.  Latency=3D32.  Min Gnt=3D2.Max Lat=3D20.
      I/O at 0xb000 [0xb01f].
  Bus  2, device  12, function  1:
    Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 7).
      Master Capable.  Latency=3D32. =20
      I/O at 0xa800 [0xa807].

--=-aa/RGoS+9XAkH0KHs/4j
Content-Disposition: attachment; filename=lspci
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; NAME=lspci; CHARSET=ISO-8859-15

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge =
(rev 11)
	Subsystem: Asustek Computer, Inc.: Unknown device 8088
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
	Capabilities: [e4] #09 [a104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D31 SBA+ 64bit- FW+ Rate=3Dx1,x2
		Command: RQ=3D0 SBA- AGP+ 64bit- FW- Rate=3D<none>

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (r=
ev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e6000000-e7dfffff
	Prefetchable memory behind bridge: e7f00000-efffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub 1) (rev 01) (prog-if 0=
0 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at d800 [size=3D32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub 2) (rev 01) (prog-if 0=
0 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at d400 [size=3D32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub 3) (rev 01) (prog-if 0=
0 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at d000 [size=3D32]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81) (prog-if =
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D32
	I/O behind bridge: 0000a000-0000bfff
	Memory behind bridge: e5000000-e57fffff
	Prefetchable memory behind bridge: e7e00000-e7efffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DB IDE U100 (rev 01) (prog-if 8a [M=
aster SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned> [size=3D8]
	Region 1: I/O ports at <unassigned> [size=3D4]
	Region 2: I/O ports at <unassigned> [size=3D8]
	Region 3: I/O ports at <unassigned> [size=3D4]
	Region 4: I/O ports at f000 [size=3D16]
	Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=3D1K]

01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2 GTS] (=
rev a3) (prog-if 00 [VGA])
	Subsystem: Elsa AG: Unknown device 0c50
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 1: Memory at e8000000 (32-bit, prefetchable) [size=3D128M]
	Expansion ROM at e7ff0000 [disabled] [size=3D64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=3D31 SBA- 64bit- FW+ Rate=3Dx1,x2
		Command: RQ=3D31 SBA- AGP+ 64bit- FW- Rate=3D<none>

02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10=
)
	Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b800 [size=3D256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

02:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [F=
asterNet] (rev 22)
	Subsystem: Netgear FA310TX Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b400 [size=3D128]
	Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D256K]

02:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07=
)
	Subsystem: Creative Labs CT4830 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b000 [size=3D32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

02:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev=
 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at a800 [size=3D8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-


--=-aa/RGoS+9XAkH0KHs/4j
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; NAME=dmesg; CHARSET=ISO-8859-15

Linux version 2.4.19 (root@ixodes.goop.org) (gcc version 2.96 20000731 (Red=
 Hat Linux 7.2 2.96-108.7.2)) #8 Sat Aug 3 20:56:51 PDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffec000 (usable)
 BIOS-e820: 000000003ffec000 - 000000003ffef000 (ACPI data)
 BIOS-e820: 000000003ffef000 - 000000003ffff000 (reserved)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262124
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32748 pages.
Kernel command line: ro root=3D/dev/hda3
Found and enabled local APIC!
Initializing CPU#0
Detected 1817.926 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3630.69 BogoMIPS
Memory: 1033496k/1048496k available (1374k kernel code, 14612k reserved, 38=
8k data, 244k init, 130992k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1817.9218 MHz.
..... host bus clock speed is 100.9955 MHz.
cpu: 0, clocks: 1009955, slice: 504977
CPU0<T0:1009952,T1:504960,D:15,S:504977,C:1009955>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1e90, last bus=3D2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH4: (ide_setup_pci_device:) Could not enable device.
hda: IBM-DTLA-307030, ATA DISK drive
hdb: WDC WD400AW-00BYK0, ATA DISK drive
hdc: ATAPI 48X CDROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3D59560/16/63
hdb: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=3D4865/255/63
hdc: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
 /dev/ide/host0/bus0/target1/lun0: p1 p2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre11 (May 11, 2002)
PCI: Found IRQ 9 for device 02:0a.0
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #0 config 1000 status 782d advertising 01e1.
eth0: Digital DS21140 Tulip rev 34 at 0xb400, 00:40:05:A1:8A:22, IRQ 9.
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 09:29:25 Aug  3 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:1d.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 5 for device 00:1d.1
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 10 for device 00:1d.2
PCI: Sharing IRQ 10 with 00:1f.1
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 244k freed
hub.c: USB new device connect on bus2/1, assigned device number 2
usb-uhci.c: interrupt, status 2, frame# 555
usb.c: USB device not accepting new address=3D2 (error=3D-110)
hub.c: USB new device connect on bus2/1, assigned device number 3
usb.c: USB device not accepting new address=3D3 (error=3D-110)
hub.c: USB new device connect on bus2/2, assigned device number 4
input0,hiddev0: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse=AE Op=
tical] on usb2:4.0
Adding Swap: 524624k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,66), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
/dev/vmmon: Module vmmon: registered with major=3D10 minor=3D165 tag=3D$Nam=
e: build-1790 $
/dev/vmmon: Module vmmon: initialized
parport0: PC-style at 0x378 [PCSPP(,...)]
/dev/vmnet: open called by PID 714 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: up
bridge-eth0: attached
/dev/vmnet: open called by PID 737 (vmnet-natd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 1125 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 1126 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 1153 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 1154 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:4=
2 PDT 2002
Creative EMU10K1 PCI Audio Driver, version 0.19, 09:32:44 Aug  3 2002
PCI: Found IRQ 9 for device 02:0c.0
emu10k1: EMU10K1 rev 7 model 0x8026 found, IO at 0xb000-0xb01f, IRQ 9
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)

--=-aa/RGoS+9XAkH0KHs/4j
Content-Disposition: attachment; filename=iomem
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; NAME=iomem; CHARSET=ISO-8859-15

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffebfff : System RAM
  00100000-00257ad7 : Kernel code
  00257ad8-002b8af7 : Kernel data
3ffec000-3ffeefff : ACPI Tables
3ffef000-3fffefff : reserved
3ffff000-3fffffff : ACPI Non-volatile Storage
40000000-400003ff : Intel Corp. 82801DB IDE U100
e5000000-e57fffff : PCI Bus #02
  e5000000-e500007f : Digital Equipment Corporation DECchip 21140 [FasterNe=
t]
    e5000000-e500007f : tulip
e6000000-e7dfffff : PCI Bus #01
  e6000000-e6ffffff : nVidia Corporation NV15 (GeForce2 Pro)
e7e00000-e7efffff : PCI Bus #02
e7f00000-efffffff : PCI Bus #01
  e8000000-efffffff : nVidia Corporation NV15 (GeForce2 Pro)
f0000000-f7ffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

--=-aa/RGoS+9XAkH0KHs/4j
Content-Disposition: attachment; filename=interrupts
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; NAME=interrupts; CHARSET=ISO-8859-15

           CPU0      =20
  0:     316683          XT-PIC  timer
  1:       5354          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:      29560          XT-PIC  usb-uhci
  8:          1          XT-PIC  rtc
  9:      41323          XT-PIC  eth0, EMU10K1
 10:          0          XT-PIC  usb-uhci
 11:     236864          XT-PIC  usb-uhci, nvidia
 14:      61146          XT-PIC  ide0
 15:         23          XT-PIC  ide1
NMI:          0=20
LOC:     316644=20
ERR:          0
MIS:          0

--=-aa/RGoS+9XAkH0KHs/4j--

