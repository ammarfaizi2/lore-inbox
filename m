Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291154AbSAaQzJ>; Thu, 31 Jan 2002 11:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291153AbSAaQzB>; Thu, 31 Jan 2002 11:55:01 -0500
Received: from flubber.jvb.tudelft.nl ([130.161.76.47]:36997 "EHLO
	mail.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S291152AbSAaQys>; Thu, 31 Jan 2002 11:54:48 -0500
Date: Thu, 31 Jan 2002 17:52:46 +0100 (CET)
From: Robbert Kouprie <robbert@jvb.tudelft.nl>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
In-Reply-To: <3C597199.6050301@candelatech.com>
Message-ID: <Pine.LNX.4.44.0201311741430.5601-100000@flubber.jvb.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The box is an Abit BP6 with Dual Celerons 433 and 192 Mb RAM. No
PCI-Riser cards. It is connected at 100 Mbit full duplex to a 100
Mbit switch. APIC is enabled. No kind of power management is enabled.

Below is my /proc/interrupts, lspci -vx and dmesg output.

Regards,
- Robbert



radium:/# cat /proc/interrupts
           CPU0       CPU1
  0:    2944301    2940065    IO-APIC-edge  timer
  1:         39         41    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:       3074       3208    IO-APIC-edge  serial
  8:          2          0    IO-APIC-edge  rtc
 14:         20         29    IO-APIC-edge  ide0
 17:     627932     628166   IO-APIC-level  eth0
 18:     121201     121973   IO-APIC-level  ide2
 19:     522304     521928   IO-APIC-level  es1371
NMI:          0          0
LOC:    5884708    5884706
ERR:        170
MIS:          0

radium:/# lspci -vx
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev
03)
        Flags: bus master, medium devsel, latency 32
        Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
00: 86 80 90 71 06 00 10 22 03 00 00 06 00 20 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        Memory behind bridge: d4000000-d7ffffff
        Prefetchable memory behind bridge: d8000000-d8ffffff
00: 86 80 91 71 07 01 20 02 03 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 f0 00 a0 22
20: 00 d4 f0 d7 00 d8 f0 d8 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 88 00

00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0
00: 86 80 10 71 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80
[Master])
        Flags: bus master, medium devsel, latency 32
        I/O ports at f000 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00
[UHCI])
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at c000 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 04 00 00

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
        Flags: medium devsel, IRQ 9
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Flags: bus master, slow devsel, latency 32, IRQ 19
        I/O ports at c400 [size=64]
        Capabilities: [dc] Power Management version 1
00: 74 12 71 13 05 01 10 34 06 00 01 04 00 20 00 00
10: 01 c4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 74 12 71 13
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0c 01 0c 80

00:0d.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 09)
        Subsystem: Intel Corp.: Unknown device 0011
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at da020000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at c800 [size=64]
        Memory at da000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
00: 86 80 29 12 07 00 90 02 09 00 00 02 08 20 00 00
10: 00 00 02 da 01 c8 00 00 00 00 00 da 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 11 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 08 38

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366
/ HPT370 (rev 01)
        Flags: bus master, medium devsel, latency 120, IRQ 18
        I/O ports at cc00 [size=8]
        I/O ports at d000 [size=4]
        I/O ports at d400 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
00: 03 11 04 00 05 00 00 02 01 00 80 01 08 78 80 00
10: 01 cc 00 00 01 d0 00 00 00 00 00 00 00 00 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 08 08

00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366
/ HPT370 (rev 01)
        Flags: bus master, medium devsel, latency 120, IRQ 18
        I/O ports at d800 [size=8]
        I/O ports at dc00 [size=4]
        I/O ports at e000 [size=256]
00: 03 11 04 00 07 00 00 02 01 00 80 01 08 78 80 00
10: 01 d8 00 00 01 dc 00 00 00 00 00 00 00 00 00 00
20: 01 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 08 08

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev
01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at d8000000 (32-bit, prefetchable) [size=16M]
        Memory at d4000000 (32-bit, non-prefetchable) [size=16K]
        Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
        Capabilities: [f0] AGP version 1.0
00: 2b 10 21 05 07 00 90 02 01 00 00 03 08 20 00 00
10: 08 00 00 d8 00 00 00 d4 00 00 00 d5 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 03 ff
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 10 20

radium:/# cat /var/log/dmesg
Linux version 2.4.18-pre7-ac1 (root@radium) (gcc version 2.95.4 (Debian
prerelease)) #1 SMP Thu Jan 31 01:06:59 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000c000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
found SMP MP-table at 000f5ae0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 49152
zone(0): 4096 pages.
zone(1): 45056 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=Linux ro root=2101
Initializing CPU#0
Detected 434.324 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 865.07 BogoMIPS
Memory: 191360k/196608k available (1316k kernel code, 4864k reserved, 383k
data, 240k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Celeron (Mendocino) stepping 05
per-CPU timeslice cutoff: 365.86 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 868.35 BogoMIPS
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU1: Intel Celeron (Mendocino) stepping 05
Total of 2 processors activated (1733.42 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-12, 2-20, 2-21, 2-22, 2-23
not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 19.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
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
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 003 03  0    0    0   0   0    1    1    71
 0e 003 03  0    0    0   0   0    1    1    79
 0f 003 03  0    0    0   0   0    1    1    81
 10 003 03  1    1    0   1   0    1    1    89
 11 003 03  1    1    0   1   0    1    1    91
 12 003 03  1    1    0   1   0    1    1    99
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
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 434.3005 MHz.
..... host bus clock speed is 66.8152 MHz.
cpu: 0, clocks: 668152, slice: 222717
CPU0<T0:668144,T1:445424,D:3,S:222717,C:668152>
cpu: 1, clocks: 668152, slice: 222717
CPU1<T0:668144,T1:222704,D:6,S:222717,C:668152>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb5c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I9,P0) -> 19
PCI->APIC IRQ transform: (B0,I13,P0) -> 17
PCI->APIC IRQ transform: (B0,I19,P0) -> 18
PCI->APIC IRQ transform: (B0,I19,P1) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.09 <tigran@veritas.com>
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
Journalled Block Device driver loaded
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: Legacy device
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller on PCI bus 00 dev 98
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:DMA, hdf:pio
HPT366: IDE controller on PCI bus 00 dev 99
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide3: BM-DMA at 0xe000-0xe007, BIOS settings: hdg:pio, hdh:pio
hda: Maxtor 91728D8, ATA DISK drive
hde: ST38421A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xcc00-0xcc07,0xd002 on irq 18
hda: 33750864 sectors (17280 MB) w/512KiB Cache, CHS=2100/255/63, UDMA(33)
hde: 16498944 sectors (8447 MB) w/256KiB Cache, CHS=16368/16/63, UDMA(66)
Partition check:
 hda: hda1
 hde: [PTBL] [1027/255/63] hde1 hde2 < hde5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:D0:B7:E8:A2:02, IRQ 17.
  Board assembly 749658-005, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xdbd8681d).
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 150M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] AGP 0.99 on Intel 440BX @ 0xd0000000 64MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
es1371: version v0.30 time 01:10:14 Jan 31 2002
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x06
es1371: found es1371 rev 6 at io 0xc400 irq 19
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack (1536 buckets, 12288 max)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 240k freed
Adding Swap: 72256k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.




On Thu, 31 Jan 2002, Ben Greear wrote:

> What does the rest of the hardware-config look like?  Is
> the NIC attached to a 10bt hub?  Are you using PCI-Riser
> cards?
>
> Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
>
>
>

