Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbTLHQqR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTLHQoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:44:02 -0500
Received: from ms-smtp-03-lbl.southeast.rr.com ([24.25.9.102]:56811 "EHLO
	ms-smtp-03-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S265030AbTLHQmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:42:21 -0500
Message-ID: <3FD4AA11.6010806@kanar.net>
Date: Mon, 08 Dec 2003 11:42:57 -0500
From: Matthew Kanar <mkanarlists@kanar.net>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
References: <ZAwx-88m-3@gated-at.bofh.it> <ZAGd-8ma-5@gated-at.bofh.it> <ZAQ7-6X-13@gated-at.bofh.it> <ZAZB-pS-11@gated-at.bofh.it> <ZCoI-2oz-9@gated-at.bofh.it> <ZCyh-2Bv-1@gated-at.bofh.it> <ZCI5-2Pv-3@gated-at.bofh.it> <ZCIb-2Pv-11@gated-at.bofh.it>
In-Reply-To: <ZCIb-2Pv-11@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is one of my SMP systems (Dell-Dual P3), although noirqbalance 
doesn't seem to change things --

uname -nrvm:
k12.kanar.net 2.6.0-test11 #2 SMP Wed Dec 3 18:50:36 EST 2003 i686

_Without_ noirqbalance -

uptime:
  10:31:51  up 4 days, 15:07, 10 users,  load average: 0.00, 0.02, 0.00

/proc/interrupts:
            CPU0       CPU1
   0:      27505  400084866    IO-APIC-edge  timer
   1:       1438          1    IO-APIC-edge  i8042
   2:          0          0          XT-PIC  cascade
   8:          1          0    IO-APIC-edge  rtc
  12:       1837        161    IO-APIC-edge  i8042
  14:     661467     822411    IO-APIC-edge  ide0
  15:          1          0    IO-APIC-edge  ide1
  16:  104949011         10   IO-APIC-level  eth0
NMI:          0          0
LOC:  400153184  400153183
ERR:          0
MIS:         10

_With_ noirqbalance -

uptime:
  11:36:12  up  1:01,  4 users,  load average: 0.00, 0.09, 0.28

/proc/interrupts:
            CPU0       CPU1
   0:      16726    3707690    IO-APIC-edge  timer
   1:          3          8    IO-APIC-edge  i8042
   2:          0          0          XT-PIC  cascade
   8:          0          1    IO-APIC-edge  rtc
  12:         14         36    IO-APIC-edge  i8042
  14:      28140        659    IO-APIC-edge  ide0
  15:          1          0    IO-APIC-edge  ide1
  16:      12775         12   IO-APIC-level  eth0
NMI:          0          0
LOC:    3724639    3724638
ERR:          0
MIS:          0

CPU0 timer: value 16726 hasn't changed since boot an hour ago.

dmesg:
Linux version 2.6.0-test11 (root@k12.kanar.net) (gcc version 3.2.2 
20030222 (Red Hat Linux 3.2.2-5)) #2 SMP Wed Dec 3 18:50:36 EST 2003
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001ff9e000 (usable)
  BIOS-e820: 000000001ff9e000 - 0000000020000000 (reserved)
  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
found SMP MP-table at 000fe710
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 130974
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 126878 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                      ) @ 0x000fd720
ACPI: RSDT (v001 DELL    WS 420  0x00000008 ASL  0x00000061) @ 0x000fd734
ACPI: FADT (v001 DELL    WS 420  0x00000008 ASL  0x00000061) @ 0x000fd760
ACPI: MADT (v001 DELL    WS 420  0x00000008 ASL  0x00000061) @ 0x000fd7d4
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x1] trigger[0x1] lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: WS 420       APIC at: 0xFEE00000
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda2 noirqbalance
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 930.947 MHz processor.
Console: colour VGA+ 80x25
Memory: 514112k/523896k available (2409k kernel code, 9044k reserved, 
579k data, 352k init, 0k highmem)
Calibrating delay loop... 1839.10 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 732.06 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1859.58 BogoMIPS
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3698.68 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
  IO-APIC (apicid-pin) 2-0, 2-13, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 44.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0020
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
  0d 000 00  1    0    0   0   0    0    0    00
  0e 001 01  0    0    0   0   0    1    1    91
  0f 001 01  0    0    0   0   0    1    1    99
  10 001 01  1    1    0   1   0    1    1    A1
  11 001 01  1    1    0   1   0    1    1    A9
  12 001 01  1    1    0   1   0    1    1    B1
  13 001 01  1    1    0   1   0    1    1    B9
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
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 930.0810 MHz.
..... host bus clock speed is 132.0972 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 8
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfc03e, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/2410] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I31,P3) -> 19
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B2,I4,P0) -> 16
PCI->APIC IRQ transform: (B2,I6,P0) -> 18
PCI->APIC IRQ transform: (B2,I11,P0) -> 19
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
VFS: Disk quotas dquot_6.5.1
SGI XFS for Linux with no debug enabled
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.12
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH: IDE controller at PCI slot 0000:00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD1200JB-75CRA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITEON DVD-ROM LTD163, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
         current capacity is 234375000 sectors (120000 MB)
         native  capacity is 234375120 sectors (120000 MB)
hda: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=65535/16/63, 
UDMA(66)
  hda: hda1 hda2 hda3
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 352k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS on hda2, internal journal
Adding 1044216k swap on /dev/hda3.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kudzu: numerical sysctl 1 23 is obsolete.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(08)
parport0: assign_addrs: aa5500ff(08)
parport0: cpp_daisy: aa5500ff(08)
parport0: assign_addrs: aa5500ff(08)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:04.0: 3Com PCI 3c905C Tornado at 0xec80. Vers LK1.1.19
divert: allocating divert_blk for eth0

/proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 930.947
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1839.10

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 930.947
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1859.58

