Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131714AbRCOOEQ>; Thu, 15 Mar 2001 09:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131722AbRCOOEH>; Thu, 15 Mar 2001 09:04:07 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:56020 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S131714AbRCOOD5>;
	Thu, 15 Mar 2001 09:03:57 -0500
Date: Thu, 15 Mar 2001 15:03:10 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ide-scsi: CoD != 0 in idescsi_pc_intr... -- what is this?
Message-ID: <Pine.GSO.4.30.0103151457100.17039-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

While copying a CD into harddisk, I got the following in the syslog (and
on the console):

Mar 15 14:36:23 brefatox kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Mar 15 14:36:23 brefatox kernel: hde: ATAPI reset complete
Mar 15 14:36:23 brefatox kernel: hde: status error: status=0x51 {
DriveReady SeekComplete Error }
Mar 15 14:36:23 brefatox kernel: hde: status error: error=0x00
Mar 15 14:36:23 brefatox kernel: ide-scsi: Strange, packet command
initiated yet DRQ isn't asserted
Mar 15 14:36:46 brefatox kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Mar 15 14:36:46 brefatox kernel: hde: ATAPI reset complete
Mar 15 14:36:46 brefatox kernel: hde: status error: status=0x51 {
DriveReady SeekComplete Error }
Mar 15 14:36:46 brefatox kernel: hde: status error: error=0x00
Mar 15 14:36:46 brefatox kernel: ide-scsi: Strange, packet command
initiated yet DRQ isn't asserted
Mar 15 14:37:02 brefatox kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Mar 15 14:37:02 brefatox kernel: hde: ATAPI reset complete
Mar 15 14:37:02 brefatox kernel: hde: status error: status=0x51 {
DriveReady SeekComplete Error }
Mar 15 14:37:02 brefatox kernel: hde: status error: error=0x00
Mar 15 14:37:02 brefatox kernel: ide-scsi: Strange, packet command
initiated yet DRQ isn't asserted
Mar 15 14:37:17 brefatox kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Mar 15 14:37:17 brefatox kernel: hde: ATAPI reset complete
Mar 15 14:37:17 brefatox kernel: hde: status error: status=0x51 {
DriveReady SeekComplete Error }
Mar 15 14:37:17 brefatox kernel: hde: status error: error=0x00
Mar 15 14:37:17 brefatox kernel: ide-scsi: Strange, packet command
initiated yet DRQ isn't asserted
Mar 15 14:37:27 brefatox kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Mar 15 14:37:27 brefatox kernel: hde: ATAPI reset complete
Mar 15 14:37:27 brefatox kernel: hde: status error: status=0x51 {
DriveReady SeekComplete Error }
Mar 15 14:37:27 brefatox kernel: hde: status error: error=0x00
Mar 15 14:37:27 brefatox kernel: ide-scsi: Strange, packet command
initiated yet DRQ isn't asserted
Mar 15 14:37:28 brefatox kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Mar 15 14:37:29 brefatox kernel: hde: ATAPI reset complete
Mar 15 14:37:29 brefatox kernel: hde: status error: status=0x51 {
DriveReady SeekComplete Error }
Mar 15 14:37:29 brefatox kernel: hde: status error: error=0x00
Mar 15 14:37:29 brefatox kernel: ide-scsi: Strange, packet command
initiated yet DRQ isn't asserted
Mar 15 14:37:32 brefatox kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Mar 15 14:37:32 brefatox kernel: hde: ATAPI reset complete
Mar 15 14:37:32 brefatox kernel: hde: status error: status=0x08 {
DataRequest }
Mar 15 14:37:32 brefatox kernel: hde: drive not ready for command
Mar 15 14:37:42 brefatox kernel: spurious 8259A interrupt: IRQ7.
Mar 15 14:37:49 brefatox kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Mar 15 14:37:49 brefatox kernel: hde: ATAPI reset complete
Mar 15 14:37:49 brefatox kernel: hde: status error: status=0x51 {
DriveReady SeekComplete Error }
Mar 15 14:37:49 brefatox kernel: hde: status error: error=0x00
Mar 15 14:37:49 brefatox kernel: ide-scsi: Strange, packet command
initiated yet DRQ isn't asserted
Mar 15 14:38:23 brefatox kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Mar 15 14:38:23 brefatox kernel: hde: ATAPI reset complete
Mar 15 14:38:23 brefatox kernel: hde: status error: status=0x51 {
DriveReady SeekComplete Error }
Mar 15 14:38:23 brefatox kernel: hde: status error: error=0x00
Mar 15 14:38:23 brefatox kernel: ide-scsi: Strange, packet command
initiated yet DRQ isn't asserted


The copy finished successfully. What is this? Should I care about it? Why
is it? :) (so many questions...)

I was copying copying from hde to hdg. dmesg is at the end.
The cdrom is connected to via a 80c udma66 cable to the first port of the
HPT370 on my Abit VP6 motherboard.

dmesg:
Linux version 2.4.2 (root@brefatox.hell) (gcc version 2.95.3 19991030 (prerelease)) #1 SMP Wed Mar 7 22:58:36 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000017ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 0000000017ff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 0000000017ff0000 (ACPI NVS)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f5770
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 98288
zone(0): 4096 pages.
zone(1): 94192 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    Bootup CPU
Bus #0 is PCI
Bus #1 is PCI
Bus #2 is ISA
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 1, trig 1, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 3, trig 3, bus 2, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 3, trig 3, bus 2, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 3, trig 3, bus 2, IRQ 0a, APIC ID 2, APIC INT 0a
Lint: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 0, trig 0, bus 2, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 1
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: root=/dev/hdg4 apm=power-off noapic hde=ide-scsi hdf=ide-scsi mem=393152K
ide_setup: hde=ide-scsi
ide_setup: hdf=ide-scsi
Initializing CPU#0
Detected 434.807 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 865.07 BogoMIPS
Memory: 384580k/393152k available (856k kernel code, 8184k reserved, 294k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Celeron (Mendocino) stepping 05
per-CPU timeslice cutoff: 365.86 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
CPU present map: 1
Before bogomips.
Error: only one processor found.
Boot done.
calibrating APIC timer ...
..... CPU clock speed is 434.8241 MHz.
..... host bus clock speed is 66.8958 MHz.
cpu: 0, clocks: 668958, slice: 334479
CPU0<T0:668944,T1:334464,D:1,S:334479,C:668958>
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 255296kB/124224kB, 768 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
HPT370: IDE controller on PCI bus 00 dev 70
PCI: Found IRQ 11 for device 00:0e.0
PCI: The same IRQ used for device 00:0d.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
hde: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
hdf: Pioneer DVD-ROM ATAPIModel DVD-105S 012, ATAPI CD/DVD-ROM drive
hdg: QUANTUM FIREBALLlct20 20, ATA DISK drive
ide2 at 0xdc00-0xdc07,0xe002 on irq 11
ide3 at 0xe400-0xe407,0xe802 on irq 11
hdg: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=39560/16/63, UDMA(100)
Partition check:
 /dev/ide/host2/bus1/target0/lun0: p1 p2 p3 p4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 184k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
SCSI subsystem driver Revision: 1.00
CSLIP: code copyright 1989 Regents of the University of California
ISDN subsystem Rev: 1.114.6.6/1.94/1.140.6.3/1.85.6.2/1.21/1.5.6.1 loaded
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (module)
HiSax: Layer1 Revision 2.41.6.1
HiSax: Layer2 Revision 2.25
HiSax: TeiMgr Revision 2.17
HiSax: Layer3 Revision 2.17
HiSax: LinkLayer Revision 2.51
HiSax: Approval certification valid
HiSax: Approved with ELSA Microlink PCI cards
HiSax: Approved with Eicon Technology Diva 2.01 PCI cards
HiSax: Approved with Sedlbauer Speedfax + cards
HiSax: Total 1 card defined
HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
HiSax: AVM PCI driver Rev. 1.22.6.2
PCI: Found IRQ 5 for device 00:0b.0
AVM PCI: stat 0x3020a
AVM PCI: Class A Rev 2
HiSax: AVM Fritz!PCI config irq:5 base:0xCC00
AVM PCI: ISAC version (0): 2086/2186 V1.1
AVM Fritz PnP/PCI: IRQ 5 count 0
AVM Fritz PnP/PCI: IRQ 5 count 3
HiSax: DSS1 Rev. 2.30
HiSax: 2 channels added
HiSax: MAX_WAITING_CALLS added
isdn: Verbose-Level is 2
PCI: Found IRQ 10 for device 00:0c.0
3c59x.c:LK1.1.12 06 Jan 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905 Boomerang 100baseTx at 0xd000,  00:10:4b:43:68:64, IRQ 10
  product code 'MN' rev 00.0 date 06-12-00
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 7849.
  Enabling bus-master transmits and whole-frame receives.
eth0: first available media type: MII
ippp, open, slot: 0, minor: 0, state: 0000
ippp_ccp: allocated reset data structure d6688800
HiSax: debugging flags card 1 set to 3ff
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: YAMAHA    Model: CRW2100E          Rev: 1.0H
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
  Vendor: PIONEER   Model: DVD-ROM DVD-105   Rev: 1.22
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Creative EMU10K1 PCI Audio Driver, version 0.7, 23:28:00 Mar  7 2001
PCI: Found IRQ 11 for device 00:0d.0
PCI: The same IRQ used for device 00:0e.0
emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xd400-0xd41f, IRQ 11


/proc/interrupts:
           CPU0
  0:      55395          XT-PIC  timer
  1:       3298          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       9131          XT-PIC  HiSax
 10:          0          XT-PIC  eth0
 11:       2431          XT-PIC  ide2, ide3, EMU10K1
 12:       4197          XT-PIC  PS/2 Mouse
NMI:          0
LOC:      55344
ERR:          0

lspci:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
00:0b.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH
A1 ISDN [Fritz] (rev 02)
00:0c.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev
08)
00:0d.1 Input device controller: Creative Labs SB Live! (rev 08)
00:0e.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev
03)
01:00.0 VGA compatible controller: nVidia Corporation GeForce 256 (rev 10)


regards,
Balazs Pozsar.

