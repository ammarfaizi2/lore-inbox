Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262776AbSJ0XjV>; Sun, 27 Oct 2002 18:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSJ0XjV>; Sun, 27 Oct 2002 18:39:21 -0500
Received: from mario.gams.at ([194.42.96.10]:33078 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S262776AbSJ0XjS>;
	Sun, 27 Oct 2002 18:39:18 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20pre11aa1 freezes after inserting a PCMCIA ethernet card
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-14737978800"
Date: Mon, 28 Oct 2002 00:45:35 +0100
Message-ID: <14349.1035762335@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-14737978800
Content-Type: text/plain; charset=us-ascii

Hi all!

I have a Toshiba Satellite 2540 CDT laptop. It works with a stock 
Redat-6.2 2.2.14 kernel RPM (but not with the 2.2.19 Update RPM - 
symptoms are similar to below). The system is basically a RedHat-7.3 
with the 2.2.14 kernel from RedHat-6.2 and some newer RPMS from 
RawHide.
The Kernel (probably) freezes after inserting a Surecom PCMCIA 
Ethernet Card (EP-427/EP-427-T) since it always fsck'es the
filesystems during the next boot. If the laptop is booted without
the card, everything is working properly (though I do not do much
without the network card).
This happens if the PCMCIA card already is inserted during startup or 
if it is inserted later on (after a successful boot as described above).

The last output before the freeze is:
----  snip  ----
Starting pcmcia: PCI: Enabling device 00:13.0 (0000 -> 0002)
PCI: Enabling device 00:13.1 (0000 -> 0002)
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000011
Yenta IRG list 06b8, PCI irq11
Socket status: 30000007
----  snip  ----

12#gcc --version
gcc (GCC) 3.2 20021021 (Red Hat Linux 8.0 3.2-11)
13# cardmgr -V
cardmgr version 3.2.1
14#lsmod
Module                  Size  Used by    
pcnet_cs                8540   1 
8390                    6136   0  [pcnet_cs]
ds                      6716   2  [pcnet_cs]
i82365                 29802   2 
pcmcia_core            44480   0  [pcnet_cs ds i82365]
lockd                  31612   1  (autoclean)
sunrpc                 53540   1  (autoclean) [lockd]
nls_iso8859-1           2264   1  (autoclean)
nls_cp437               3768   1  (autoclean)
vfat                    9488   1  (autoclean)
fat                    31168   1  (autoclean) [vfat]

`lspci -vvv` and `dmesg` output in the attachments.

Is there other interesting debug info?

	Bernd

--==_Exmh_-14737978800
Content-Type: text/plain ; name="lspci"; charset=us-ascii
Content-Description: lspci
Content-Disposition: attachment; filename="lspci"

00:00.0 Host bridge: Toshiba America Info Systems 601 (rev a2)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0, cache line size 08

00:07.0 Communication controller: Lucent Microelectronics 56k WinModem (rev 01)
	Subsystem: Toshiba America Info Systems Internal V.90 Modem
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at ffefff00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at 02f8 [size=8]
	Region 2: I/O ports at 1c00 [size=256]
	Capabilities: <available only to root>

00:08.0 VGA compatible controller: S3 Inc. ViRGE/MX (rev 06) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems ViRGE/MX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at 000c0000 [disabled] [size=64K]

00:0b.0 USB Controller: NEC Corporation USB (rev 02) (prog-if 10 [OHCI])
	Subsystem: Toshiba America Info Systems USB
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 5250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f7fff000 (32-bit, non-prefetchable) [size=4K]

00:10.0 IDE interface: Toshiba America Info Systems: Unknown device 0102 (rev 34) (prog-if f0)
	Subsystem: Toshiba America Info Systems: Unknown device 0002
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 10000ns max)
	Region 4: I/O ports at 1800 [size=16]

00:11.0 Communication controller: Toshiba America Info Systems FIR Port (rev 23)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ffe0 [size=32]

00:13.0 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=14, subordinate=14, sec-latency=0
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:13.1 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=15, subordinate=15, sec-latency=0
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001


--==_Exmh_-14737978800
Content-Type: text/plain ; name="dmesg"; charset=us-ascii
Content-Description: dmesg
Content-Disposition: attachment; filename="dmesg"

Linux version 2.4.20-pre11aa1 (bernd@sam.at.home) (gcc version 3.2 20021021 (Red Hat Linux 8.0 3.2-11)) #2 Sun Oct 27 23:33:49 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000004010000 (usable)
 BIOS-e820: 0000000004010000 - 0000000004020000 (ACPI data)
 BIOS-e820: 0000000004020000 - 0000000004040000 (reserved)
 BIOS-e820: 00000000fef80000 - 00000000ff000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 00000000fffe6e00 (reserved)
 BIOS-e820: 00000000fffe6e00 - 00000000fffe7000 (ACPI NVS)
 BIOS-e820: 00000000fffe7000 - 0000000100000000 (reserved)
64MB LOWMEM available.
On node 0 totalpages: 16400
zone(0): 4096 pages.
zone(1): 12304 pages.
zone(2): 0 pages.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=x ro root=303 BOOT_FILE=/boot/vmlinuz-2.4.20pre11aa1
No local APIC present or hardware disabled
Initializing CPU#0
Detected 333.276 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 665.19 BogoMIPS
Memory: 62872k/65600k available (906k kernel code, 2340k reserved, 365k data, 84k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfd82b, last bus=21
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
bigpage subsystem: allocated 0 bigpages (=0MB).
aio_setup: num_physpages = 4100
aio_setup: sizeof(struct page) = 44
pty: 256 Unix98 ptys configured
Toshiba System Managment Mode driver v1.11 26/9/2001
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device 80, VID=1179, DID=0102
PCI_IDE: chipset revision 52
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK4309MAT, ATA DISK drive
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c028b5e4, I/O limit 4095Mb (mask 0xffffffff)
hda: 8452080 sectors (4327 MB), CHS=526/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3
es1371: version v0.30 time 23:39:36 Oct 27 2002
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 84k freed
Real Time Clock Driver v1.10e
Adding Swap: 136544k swap-space (priority -1)
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdc: DMA disabled
inserting floppy driver for 2.4.20-pre11aa1
Floppy drive(s): fd0 is 1.44M
DOR0=4
floppy interrupt on bizarre fdc 2
handler=00000000
FDC 0 is an 8272A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
apm: BIOS version 1.2 Flags 0x02 (Driver version 1.16)
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Intel PCIC probe: not found.
PCI: Enabling device 00:13.0 (0000 -> 0002)
PCI: Enabling device 00:13.1 (0000 -> 0002)
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000007
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000007
cs: IO port probe 0x1000-0x17ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x330-0x337 0x378-0x37f 0x388-0x38f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.

--==_Exmh_-14737978800
Content-Type: text/plain; charset=iso-8859-1

Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at

--==_Exmh_-14737978800--


