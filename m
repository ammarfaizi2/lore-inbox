Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317845AbSFSKmp>; Wed, 19 Jun 2002 06:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317846AbSFSKmo>; Wed, 19 Jun 2002 06:42:44 -0400
Received: from cust.94.194.adsl.cistron.nl ([195.64.94.194]:40832 "EHLO
	zutstation.gonzo.kelder.net") by vger.kernel.org with ESMTP
	id <S317845AbSFSKmi>; Wed, 19 Jun 2002 06:42:38 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Jaap Verhoeven <jaap@gonzo.kelder.net>
To: linux-kernel@vger.kernel.org
Subject: [2.4.19-pre10-ac1] SMP board (AMD 768) fails to initalise 64-bit PCI-irqs ('Probably buggy MP')
Date: Wed, 19 Jun 2002 12:42:28 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200206191242.28493.jaap@gonzo.kelder.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Kernel fails at initialisation of ALL PCI IRQs when a 64-bit PCI card needs to
be initialised. Without this card the other 32-bits PCI-cards get their IRQs 
without a problem.

Kernel source: 2.4.19-pre10-ac1
Compiler: gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)
  * hope this GCC 2.96 isn't a problem anymore
64-bit PCI card: HP NetRAID 2m
Motherboard: TYAN Tiger MPX S2466 (Dual Athlon) with AMD 768

The NetRAID card seems to be OK, initialises during BIOS boot up, BIOS 
configuration tool is accessible, etcetera. Also /proc/pci shows nicely the 
assigned IRQ's for all cards, while /proc/interrupts doesnt.

Anybody any idea what the problem is here?

thanks,

   Jaap

************** Without netRAID 2m:
[root@zutstation root]# cat /proc/interrupts 
           CPU0       CPU1       
  0:      58693      56228    IO-APIC-edge  timer
  1:          5          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
 10:     217414     217193   IO-APIC-level  usb-ohci, eth0, eth1
 14:      12652      11525    IO-APIC-edge  ide0
 15:          1          4    IO-APIC-edge  ide1
NMI:          0          0 
LOC:     114851     114851 
ERR:          0
MIS:          0

************** With netRAID 2m:
[root@zutstation root]# cat /proc/interrupts 
           CPU0       CPU1       
  0:       6140      10436    IO-APIC-edge  timer
  1:         86         80    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5:          0          0   IO-APIC-level  eth0
 10:          0          0   IO-APIC-level  usb-ohci
 14:       3607       5996    IO-APIC-edge  ide0
 15:          1          4    IO-APIC-edge  ide1
NMI:          0          0 
LOC:      16502      16501 
ERR:          0
MIS:          0

************** With netRAID 2m:
[root@zutstation root]# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller (rev 17).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xea000000 [0xebffffff].
      Prefetchable 32 bit memory at 0xe8d00000 [0xe8d00fff].
      I/O at 0x1010 [0x1013].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge 
(rev 0).
      Master Capable.  Latency=99.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 5).
  Bus  0, device   7, function  1:
    IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 4).
      I/O at 0xf000 [0xf00f].
  Bus  0, device   7, function  3:
    Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 3).
      Master Capable.  Latency=22.  
  Bus  0, device   9, function  0:
    PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 5).
      Master Capable.  Latency=64.  Min Gnt=4.
  Bus  2, device   0, function  0:
    PCI bridge: Digital Equipment Corporation DECchip 21154 (#2) (rev 5).
      Master Capable.  Latency=64.  Min Gnt=4.
  Bus  0, device  16, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 5).
      Master Capable.  Latency=64.  Min Gnt=4.
  Bus  1, device   5, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II] 
AGP (rev 0).
      IRQ 11.
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xec000000 [0xecffffff].
      Non-prefetchable 32 bit memory at 0xe8800000 [0xe8803fff].
      Non-prefetchable 32 bit memory at 0xe8000000 [0xe87fffff].
  Bus  2, device   1, function  0:
    SCSI storage controller: QLogic Corp. ISP12160 Dual Channel Ultra3 SCSI 
Processor (rev 6).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=64.
      I/O at 0x2000 [0x20ff].
      Non-prefetchable 32 bit memory at 0xe8900000 [0xe8900fff].
  Bus  3, device   0, function  0:
    RAID bus controller: American Megatrends Inc. MegaRAID (rev 32).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
  Bus  4, device   0, function  0:
    USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 7).
      IRQ 10.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xe8a00000 [0xe8a00fff].
  Bus  4, device   5, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 (rev 2).
      IRQ 11.
      Master Capable.  Latency=132.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xf8000000 [0xf8000fff].
  Bus  4, device   5, function  1:
    Multimedia controller: Brooktree Corporation Bt878 (rev 2).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xf8001000 [0xf8001fff].
  Bus  4, device   7, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 
16).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0x3000 [0x30ff].
      Non-prefetchable 32 bit memory at 0xe8a01000 [0xe8a010ff].
  Bus  4, device   8, function  0:
    Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 120).
      IRQ 5.
      Master Capable.  Latency=80.  Min Gnt=10.Max Lat=10.
      I/O at 0x3400 [0x347f].
      Non-prefetchable 32 bit memory at 0xe8a01400 [0xe8a0147f].

************** With netRAID 2m:
[root@zutstation root]# dmesg
Linux version 2.4.19-pre10-ac1 (tj@leptop) (gcc version 2.96 20000731 (Red Hat 
Linux 7.1 2.96-98)) #1 SMP Tue Jun 4 18:50:27 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ca000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000000f00000 (usable)
 BIOS-e820: 0000000000f00000 - 0000000001000000 (reserved)
 BIOS-e820: 0000000001000000 - 000000001ff80000 (usable)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec04000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f71e0
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 130944
zone(0): 4096 pages.
zone(1): 126848 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: TYAN     Product ID: PAULANER     APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 16
Processor #0 Pentium(tm) Pro APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=new ro root=307 
BOOT_FILE=/boot/vmlinuz-2.4.19-pre10-ac1 pci=noacpi,usepirqmask
PCI: Unknown option `noacpi'
PCI: Unknown option `usepirqmask'
Initializing CPU#0
Detected 1533.402 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3060.53 BogoMIPS
Memory: 512908k/523776k available (1569k kernel code, 9456k reserved, 409k 
data, 244k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU0: AMD Athlon(tm) MP 1800+ stepping 02
per-CPU timeslice cutoff: 731.39 usecs.
task migration cache decay timeout: 10 msecs.
masked ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3067.08 BogoMIPS
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU1: AMD Athlon(tm) Processor stepping 02
Total of 2 processors activated (6127.61 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 22.
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
 05 003 03  1    1    0   1   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  0    0    0   0   0    1    1    A9
 11 003 03  0    0    0   0   0    1    1    B1
 12 003 03  0    0    0   0   0    1    1    B9
 13 003 03  0    0    0   0   0    1    1    C1
 14 003 03  0    0    0   0   0    1    1    C9
 15 003 03  1    1    0   1   0    1    1    D1
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
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1533.4782 MHz.
..... host bus clock speed is 266.6918 MHz.
cpu: 0, clocks: 2666918, slice: 888972
CPU0<T0:2666912,T1:1777936,D:4,S:888972,C:2666918>
cpu: 1, clocks: 2666918, slice: 888972
CPU1<T0:2666912,T1:888960,D:8,S:888972,C:2666918>
checking TSC synchronization across CPUs: passed.
migration_task 0 on cpu=0
migration_task 1 on cpu=1
PCI: PCI BIOS revision 2.10 entry at 0xfd7e0, last bus=4
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
PCI: Using IRQ router AMD768 [1022/7443] at 00:07.3
BIOS failed to enable PCI standards compliance, fixing this error.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: disabled - APM is not SMP safe.
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
amd768_rng: AMD768 system management I/O registers at 0x8000.
amd768_rng hardware driver 0.1.0 loaded
AMD768_pm: enabling W4SG<6>AMD768_pm: AMD768 system management I/O registers 
at 0x8000.
block: 992 slots per queue, batch=248
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 93652U8, ATA DISK drive
hdb: Maxtor 98196H8, ATA DISK drive
hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 71346240 sectors (36529 MB) w/2048KiB Cache, CHS=4441/255/63, UDMA(66)
hdb: host protected area => 1
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63, UDMA(100)
hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(16)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
 hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
SCSI subsystem driver Revision: 1.00
megaraid: v1.18 (Release Date: Thu Oct 11 15:02:53 EDT 2001)
PCI: No IRQ known for interrupt pin A of device 03:00.0. Probably buggy MP 
table.
megaraid: found 0x101e:0x1960:idx 0:bus 3:slot 0:func 0
scsi0 : Found a MegaRAID controller at 0xe0800000, IRQ: 0
scsi0 : Enabling 64 bit support
megaraid: Couldn't register IRQ 0!
Trying to free nonexistent resource <e0800000-e080000f>
megaraid: no BIOS enabled.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
es1371: version v0.30 time 18:53:16 Jun  4 2002
LVM version 1.0.3(19/02/2002)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 244k freed
Adding Swap: 265032k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xe0839000, IRQ 10
usb-ohci.c: usb-04:00.0, Advanced Micro Devices [AMD] AMD-768 [Opus] USB
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c17a8540, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e0839000
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c17a8540
usb.c: kusbd: /sbin/hotplug add 1
reiserfs: checking transaction log (device 3a:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:04) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:00) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack (4092 buckets, 32736 max)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
04:08.0: 3Com PCI 3c905C Tornado at 0x3400. Vers LK1.1.16
8139too Fast Ethernet driver 0.9.24
eth1: RealTek RTL8139 Fast Ethernet at 0xe0d50000, 00:00:c5:b5:2f:6e, IRQ 10
eth1:  Identified 8139 chip type 'RTL-8139C'
eth1: Setting half-duplex based on auto-negotiated partner ability 0000.
eth1: Setting half-duplex based on auto-negotiated partner ability 0000.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e201.
  diagnostics: net 0ccc media 8880 dma 00000032.
eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
  Flags; bus-master 1, dirty 16(0) current 16(0)
  Transmit list 00000000 vs. dc502200.
  0: @dc502200  length 8000002a status 0001002a
  1: @dc502240  length 8000002a status 0001002a
  2: @dc502280  length 8000002a status 0001002a
  3: @dc5022c0  length 8000002a status 0001002a
  4: @dc502300  length 8000002a status 0001002a
  5: @dc502340  length 8000002a status 0001002a
  6: @dc502380  length 8000002a status 0001002a
  7: @dc5023c0  length 8000002a status 0001002a
  8: @dc502400  length 8000002a status 0001002a
  9: @dc502440  length 8000002a status 0001002a
  10: @dc502480  length 8000002a status 0001002a
  11: @dc5024c0  length 8000002a status 0001002a
  12: @dc502500  length 8000002a status 0001002a
  13: @dc502540  length 8000002a status 0001002a
  14: @dc502580  length 8000002a status 8001002a
  15: @dc5025c0  length 8000002a status 8001002a
eth0: Resetting the Tx ring pointer.

************** With netRAID 2m:
[root@zutstation root]# lspci -v
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 
11)
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Memory at ea000000 (32-bit, prefetchable) [size=32M]
        Memory at e8d00000 (32-bit, prefetchable) [size=4K]
        I/O ports at 1010 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d (prog-if 
00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 99
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        Memory behind bridge: e8000000-e88fffff
        Prefetchable memory behind bridge: ec000000-ecffffff

00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7440 (rev 05)
        Flags: bus master, 66Mhz, medium devsel, latency 0

00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7441 (rev 
04) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 7441
        Flags: bus master, medium devsel, latency 0
        [virtual] I/O ports at 01f0
        [virtual] I/O ports at 03f4
        [virtual] I/O ports at 0170
        [virtual] I/O ports at 0374
        I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev 03)
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 7443
        Flags: medium devsel

00:09.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05) 
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=02, subordinate=03, sec-latency=68
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: e8900000-e89fffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f7f00000
        Capabilities: [dc] Power Management version 1

00:10.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7448 (rev 05) 
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=69
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: e8a00000-e8afffff
        Prefetchable memory behind bridge: f8000000-f80fffff

01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium 
II] AGP (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc.: Unknown device 1100
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
        Memory at ec000000 (32-bit, prefetchable) [size=16M]
        Memory at e8800000 (32-bit, non-prefetchable) [size=16K]
        Memory at e8000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [f0] AGP version 1.0

02:00.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05) 
(prog-if 00 [Normal decode])
        Flags: bus master, fast Back2Back, medium devsel, latency 64
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=68
        Prefetchable memory behind bridge: 00000000f0000000-00000000f7f00000
        Capabilities: [dc] Power Management version 1

02:01.0 SCSI storage controller: Q Logic QLA12160 (rev 06)
        Subsystem: American Megatrends Inc. QLA12160 on AMI MegaRAID
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
        I/O ports at 2000 [size=256]
        Memory at e8900000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [44] Power Management version 1

03:00.0 RAID bus controller: American Megatrends Inc. MegaRAID (rev 20)
        Subsystem: Hewlett-Packard Company: Unknown device 60e8
        Flags: bus master, fast Back2Back, medium devsel, latency 64
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=32K]
        Capabilities: [80] Power Management version 2

04:00.0 USB Controller: Advanced Micro Devices [AMD]: Unknown device 7449 (rev 
07) (prog-if 10 [OHCI])
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at e8a00000 (32-bit, non-prefetchable) [size=4K]

04:05.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Flags: medium devsel, IRQ 11
        Memory at f8000000 (32-bit, prefetchable) [size=4K]

04:05.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Flags: medium devsel, IRQ 11
        Memory at f8001000 (32-bit, prefetchable) [size=4K]

04:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Addtron Technology Co, Inc.: Unknown device 1360
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at 3000 [size=256]
        Memory at e8a01000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

04:08.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 
78)
        Subsystem: Tyan Computer: Unknown device 2466
        Flags: bus master, medium devsel, latency 80, IRQ 5
        I/O ports at 3400 [size=128]
        Memory at e8a01400 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

---

