Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131607AbRBJSUT>; Sat, 10 Feb 2001 13:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131608AbRBJSUJ>; Sat, 10 Feb 2001 13:20:09 -0500
Received: from elektra.higherplane.net ([203.37.52.137]:640 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S131607AbRBJST4>; Sat, 10 Feb 2001 13:19:56 -0500
Date: Sun, 11 Feb 2001 05:31:45 +1100
From: john slee <indigoid@higherplane.net>
To: linux-kernel@vger.kernel.org
Subject: hard lockup (no oops) on vanilla 2.4.2-pre3 with /dev/dsp
Message-ID: <20010211053145.A748@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'mpg123 foo.mp3' triggers this.  doesn't seem to be restricted to mpg123
however.  happens with everything using /dev/dsp.

it doesn't happen to me on 2.4.1-pre11 with andrew morton's low
scheduling latency patch.

symptoms are hard lockup, and random noise from speakers.  even magic
sysrq doesn't work.  i certainly don't get anything resembling the
intended sound.

soundcard is my beloved gravis ultrasound classic, which has never
failed me before.

diff'd drivers/sound/ between vanilla trees of 2.4.0, 2.4.1, and
2.4.2pre{1,2,3}.  the only changes i could see in sound*[ch] and
gus*[ch] were replacing malloc.h with slab.h.  i probably missed
something, it's past 5am now.  i can't remember seeing this lockup on
any previous kernel.

diagnostic stuff follows.  note that i am not currently using the
TRM-S1040, and have not applied the appropriate kernel patch for it.

thanks in advance,

j.

ver_linux: (all debian-testing versions of things, except kernel)
----------
Linux elektra 2.4.2-pre3 #10 Sun Feb 11 02:57:42 EST 2001 i686 unknown
Kernel modules         2.4.1
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.1.0.2
Linux C Library        2.2.1
Dynamic linker         ldd (GNU libc) 2.2.1
Procps                 2.0.7
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ipt_state iptable_nat iptable_filter iptable_mangle ip_conntrack_ftp ip_conntrack ppp_async ppp_generic slhc ip_tables floppy 3c59x ne2k-pci 8390

cpuinfo: (not overclocked)
--------
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 534.553
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 1064.96

lspci -vvv:
-----------
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d8000000-dbffffff
	Prefetchable memory behind bridge: e4000000-e4ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at d000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d400 [size=128]
	Region 1: Memory at e6001000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at e2000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 01)
	Subsystem: Tekram Technology Co.,Ltd. TRM-S1040
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d800 [size=256]
	Region 1: Memory at e6000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at e3000000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-if 00 [VGA])
	Subsystem: S3 Inc. ViRGE/DX
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at e5000000 [disabled] [size=64K]

00:0f.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c810 (rev 23)
	Subsystem: Symbios Logic Inc. (formerly NCR) 8100S
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at dc00 [size=256]
	Region 1: Memory at e6002000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e000 [size=32]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. MGA-G200 AGP
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at d9000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

dmesg:
------
Linux version 2.4.2-pre3 (root@elektra) (gcc version 2.95.3 20010125 (prerelease)) #10 Sun Feb 11 02:57:42 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000013ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 0000000013ff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 0000000013ff0000 (ACPI NVS)
On node 0 totalpages: 81920
zone(0): 4096 pages.
zone(1): 77824 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=242pre3 ro root=302 mem=320M
Initializing CPU#0
Detected 534.553 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1064.96 BogoMIPS
Memory: 320408k/327680k available (768k kernel code, 6884k reserved, 283k data, 168k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 05
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.2 present.
40 structures occupying 1070 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 11/09/99
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 212541kB/81469kB, 640 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DTLA-305040, ATA DISK drive
hdb: IBM-DTTA-350840, ATA DISK drive
hdc: CD-ROM 50X L, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=5005/255/63, UDMA(33)
hdb: 16514064 sectors (8455 MB) w/467KiB Cache, CHS=16383/16/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
 /dev/ide/host0/bus0/target1/lun0: p1
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 168k freed
Adding Swap: 112448k swap-space (priority -1)
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xe000, IRQ 10, 00:00:21:CD:C6:8E.
3c59x.c:LK1.1.12 06 Jan 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth1: 3Com PCI 3c905B Cyclone 100baseTx at 0xd400,  00:10:5a:64:6e:f2, IRQ 5
  product code 'QR' rev 00.12 date 12-03-98
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
inserting floppy driver for 2.4.2-pre3
FDC 0 is a post-1991 82077
eth1: using NWAY autonegotiation
ip_tables: (c)2000 Netfilter core team
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.1
ip_conntrack (2560 buckets, 20480 max)
Gravis Ultrasound audio driver Copyright (C) by Hannu Savolainen 1993-1996
<Gravis UltraSound 2.4 (512k)> at 0x260 irq 11 dma 7
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
