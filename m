Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbSLSPCy>; Thu, 19 Dec 2002 10:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265830AbSLSPCy>; Thu, 19 Dec 2002 10:02:54 -0500
Received: from f169.law11.hotmail.com ([64.4.17.169]:55561 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S265806AbSLSPCb>;
	Thu, 19 Dec 2002 10:02:31 -0500
X-Originating-IP: [64.81.213.195]
From: "dino klein" <dinoklein@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: devfs related oops
Date: Thu, 19 Dec 2002 15:09:49 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F169rRCE0OGqVr2fAFH0002e452@hotmail.com>
X-OriginalArrivalTime: 19 Dec 2002 15:09:49.0715 (UTC) FILETIME=[ACCDF630:01C2A770]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] I got the following while fdisk was writing a new partition table, and 
resyncing
[3.] devfs, kernel
[4.] I'm running 2.5.52bk3
[5.]===============================================
ksymoops 2.4.8 on i686 2.5.52bk3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.52bk3/ (default)
     -m /boot/System.map-2.5.52bk3 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at fs/devfs/base.c:1630!
invalid operand: 0000
CPU:    1
EIP:    0060:[<c01a884b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000000d   ebx: f7d6111c   ecx: 00000000   edx: c02e5f00
esi: f7d5d95c   edi: 00000001   ebp: ebda9f10   esp: ebda9ef8
ds: 0068   es: 0068   ss: 0068
Stack: c02950a0 c0295080 c02954e4 f7d6111c 5a5a5a5a f7d4e000 ebda9f20 
c0180c26
       f7d6111c f7d5d95c ebda9f58 c0180e8a f7da5cc4 00000001 f7d5d974 
f7d5d95c
       ec4cd6d0 ebda9f7c ebda9f7c 000c5445 00000000 ebda9f64 00000000 
ebda9f7c
Call Trace:
[<c0180c26>] delete_partition+0x5e/0x6c
[<c0180e8a>] rescan_partitions+0x5e/0x138
[<c0209630>] blkdev_reread_part+0x5c/0x78
[<c0209a56>] blkdev_ioctl+0x26a/0x38b
[<c015c14d>] sys_ioctl+0x22d/0x298
[<c01090ff>] syscall_call+0x7/0xb
Code: 0f 0b 5e 06 ae 50 29 c0 83 c4 14 83 7b 28 00 74 57 f6 05 70


>>EIP; c01a884b <devfs_unregister+33/a0>   <=====

>>edx; c02e5f00 <abi_table+e4/134>

Trace; c0180c26 <delete_partition+5e/6c>
Trace; c0180e8a <rescan_partitions+5e/138>
Trace; c0209630 <blkdev_reread_part+5c/78>
Trace; c0209a56 <blkdev_ioctl+26a/38b>
Trace; c015c14d <sys_ioctl+22d/298>
Trace; c01090ff <syscall_call+7/b>

Code;  c01a884b <devfs_unregister+33/a0>
00000000 <_EIP>:
Code;  c01a884b <devfs_unregister+33/a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01a884d <devfs_unregister+35/a0>
   2:   5e                        pop    %esi
Code;  c01a884e <devfs_unregister+36/a0>
   3:   06                        push   %es
Code;  c01a884f <devfs_unregister+37/a0>
   4:   ae                        scas   %es:(%edi),%al
Code;  c01a8850 <devfs_unregister+38/a0>
   5:   50                        push   %eax
Code;  c01a8851 <devfs_unregister+39/a0>
   6:   29 c0                     sub    %eax,%eax
Code;  c01a8853 <devfs_unregister+3b/a0>
   8:   83 c4 14                  add    $0x14,%esp
Code;  c01a8856 <devfs_unregister+3e/a0>
   b:   83 7b 28 00               cmpl   $0x0,0x28(%ebx)
Code;  c01a885a <devfs_unregister+42/a0>
   f:   74 57                     je     68 <_EIP+0x68> c01a88b3 
<devfs_unregister+9b/a0>
Code;  c01a885c <devfs_unregister+44/a0>
  11:   f6 05 70 00 00 00 00      testb  $0x0,0x70


1 error issued.  Results may not be reliable.
==============================================

[7.1]==============================================
Linux debian 2.5.52bk3 #2 SMP Wed Dec 18 09:56:48 EST 2002 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded
=========================================

[7.7] bellow is the output of dmesg.

served)
BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5700
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
ACPI: RSDP (v000 VIA694                     ) @ 0x000f7050
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x3fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x3fff3040
ACPI: MADT (v001 VIA694          00000.00000) @ 0x3fff5640
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] 
trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x0] 
trigger[0x0])
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2552 ro root=1603 
root=/dev/discs/disc2/part3
Initializing CPU#0
Detected 864.980 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1703.93 BogoMIPS
Memory: 1034456k/1048512k available (1499k kernel code, 13136k reserved, 
675k data, 272k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.64 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1728.51 BogoMIPS
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3432.44 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not 
connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
00 000 00  1    0    0   0   0    0    0    00
01 001 01  0    0    0   0   0    1    1    39
02 001 01  0    0    0   0   0    1    1    31
03 001 01  0    0    0   0   0    1    1    41
04 001 01  0    0    0   0   0    1    1    49
05 001 01  0    0    0   0   0    1    1    51
06 001 01  0    0    0   0   0    1    1    59
07 001 01  0    0    0   0   0    1    1    61
08 001 01  0    0    0   0   0    1    1    69
09 001 01  0    0    0   0   0    1    1    71
0a 001 01  0    0    0   0   0    1    1    79
0b 001 01  0    0    0   0   0    1    1    81
0c 001 01  0    0    0   0   0    1    1    89
0d 001 01  0    0    0   0   0    1    1    91
0e 001 01  0    0    0   0   0    1    1    99
0f 001 01  0    0    0   0   0    1    1    A1
10 000 00  1    0    0   0   0    0    0    00
11 000 00  1    0    0   0   0    0    0    00
12 000 00  1    0    0   0   0    0    0    00
13 000 00  1    0    0   0   0    0    0    00
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
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 865.0114 MHz.
..... host bus clock speed is 133.0094 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
device class 'cpu': registering
device class cpu: adding driver system:cpu
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
device class cpu: adding device CPU 0
interfaces: adding device CPU 0
device class cpu: adding device CPU 1
interfaces: adding device CPU 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20021217
tbxface-0098 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control 
Methods:......................................................................
Table [DSDT] - 303 Objects with 30 Devices 70 Methods 19 Regions
ACPI Namespace successfully loaded at root c039f9bc
evxfevnt-0073 [04] acpi_enable           : Transition to ACPI mode 
successful
   evgpe-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
Executing all Device _STA and_INI methods:..............................
30 Devices found containing: 30 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package 
initialization:........................................
Initialized 15/19 Regions 1/1 Fields 15/15 Buffers 9/9 Packages (303 nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:07.05 not present in 
PCI namespace
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:07.06 not present in 
PCI namespace
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.93 (c) Adam Belay
pnp: the driver 'system' has been registered
pnp: Enabling Plug and Play Card Services.
block request queues:
128 requests per read queue
128 requests per write queue
8 requests per batch
enter congestion at 31
exit congestion at 33
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16)
00:00:09[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)
00:00:09[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18)
00:00:09[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19)
00:00:09[D] -> 2-19 -> IRQ 19
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-16 already programmed
Pin 2-19 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
Enabling SEP on CPU 0
Enabling SEP on CPU 1
highmem bounce pool size: 64 pages
aio_setup: sizeof(struct page) = 40
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x0
PCI: Enabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU] (supports C1)
ACPI: Processor [CPU1] (supports C1)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0b.0: 3Com PCI 3c905C Tornado at 0xcc00. Vers LK1.1.18
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP AS40.0, ATA DISK drive
hdb: Maxtor 52049U4, ATA DISK drive
hda: DMA disabled
hdb: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD800BB-40BSA0, ATA DISK drive
hdd: IBM-DAQA-33240, ATA DISK drive
hdc: DMA disabled
hdd: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 80315072 sectors (41121 MB) w/1902KiB Cache, CHS=79677/16/63
/dev/ide/host0/bus0/target0/lun0: p1
hdb: host protected area => 1
hdb: 39882528 sectors (20420 MB) w/2048KiB Cache, CHS=39566/16/63
/dev/ide/host0/bus0/target1/lun0: p1 p2
hdc: host protected area => 1
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63
/dev/ide/host0/bus1/target0/lun0: p1 p2 p3 p4
hdd: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: task_no_data_intr: error=0x04 { DriveStatusError }
hdd: 6346368 sectors (3249 MB) w/96KiB Cache, CHS=6296/16/63
/dev/ide/host0/bus1/target1/lun0: p1 p2
device class 'input': registering
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
(fs/jbd/recovery.c, 253): journal_recover: JBD: recovery, exit status 0, 
recovered transactions 5910 to 5928
(fs/jbd/recovery.c, 255): journal_recover: JBD: Replayed 1386 and revoked 
0/0 blocks
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with journal data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 272k freed
Adding 999928k swap on /dev/hdc4.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide1(22,3), internal journal
(fs/jbd/recovery.c, 253): journal_recover: JBD: recovery, exit status 0, 
recovered transactions 5074 to 5577
(fs/jbd/recovery.c, 255): journal_recover: JBD: Replayed 40710 and revoked 
0/0 blocks
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide1(22,1), external journal on 
ide1(22,2)
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with journal data mode.
blk: queue c03a8c20, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c03a8e88, I/O limit 4095Mb (mask 0xffffffff)
/dev/ide/host0/bus1/target1/lun0: p1 p2
devfs_unregister(f7d6111c): bad magic value: 5a5a5a5a
Forcing Oops
------------[ cut here ]------------
kernel BUG at fs/devfs/base.c:1630!
invalid operand: 0000
CPU:    1
EIP:    0060:[<c01a884b>]    Not tainted
EFLAGS: 00010286
EIP is at devfs_unregister+0x33/0xa0
eax: 0000000d   ebx: f7d6111c   ecx: 00000000   edx: c02e5f00
esi: f7d5d95c   edi: 00000001   ebp: ebda9f10   esp: ebda9ef8
ds: 0068   es: 0068   ss: 0068
Process cfdisk (pid: 287, threadinfo=ebda8000 task=ec6152c0)
Stack: c02950a0 c0295080 c02954e4 f7d6111c 5a5a5a5a f7d4e000 ebda9f20 
c0180c26
       f7d6111c f7d5d95c ebda9f58 c0180e8a f7da5cc4 00000001 f7d5d974 
f7d5d95c
       ec4cd6d0 ebda9f7c ebda9f7c 000c5445 00000000 ebda9f64 00000000 
ebda9f7c
Call Trace:
[<c0180c26>] delete_partition+0x5e/0x6c
[<c0180e8a>] rescan_partitions+0x5e/0x138
[<c0209630>] blkdev_reread_part+0x5c/0x78
[<c0209a56>] blkdev_ioctl+0x26a/0x38b
[<c015c14d>] sys_ioctl+0x22d/0x298
[<c01090ff>] syscall_call+0x7/0xb

Code: 0f 0b 5e 06 ae 50 29 c0 83 c4 14 83 7b 28 00 74 57 f6 05 70
------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:97!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c011ca99>]    Not tainted
EFLAGS: 00010002
EIP is at do_syslog+0x1a9/0x6c4
eax: 00003a01   ebx: c02e5f34   ecx: 00000000   edx: 00003a01
esi: 00000099   edi: 00000fff   ebp: ec51ff64   esp: ec51ff34
ds: 0068   es: 0068   ss: 0068
Process klogd (pid: 173, threadinfo=ec51e000 task=ec614090)
Stack: 00000000 00000000 f6f8a914 ec51ff50 00000000 00000000 00000000 
00000000
       ec614090 c0118484 c02e5fb4 c02e5fb4 ec51ff78 c017ef44 00000002 
0804dd39
       00000fff ec51ff9c c014a727 f6f8a914 0804dca0 00000fff f6f8a934 
f6f8a914
Call Trace:
[<c0118484>] default_wake_function+0x0/0x28
[<c017ef44>] kmsg_read+0x10/0x14
[<c014a727>] vfs_read+0xa7/0x144
[<c014a9dc>] sys_read+0x28/0x3c
[<c01090ff>] syscall_call+0x7/0xb

Code: 0f 0b 61 00 f8 14 28 c0 86 15 e4 5f 2e c0 fb 31 c0 8b 55 0c


_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail

