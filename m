Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265065AbUGGMC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbUGGMC7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbUGGMC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:02:59 -0400
Received: from boxa.alphawave.net ([207.218.5.130]:31909 "EHLO
	box.alphawave.net") by vger.kernel.org with ESMTP id S265065AbUGGMCf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:02:35 -0400
Date: Wed, 7 Jul 2004 13:02:32 +0100
From: Nick Craig-Wood <nick@craig-wood.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7 lockup shortly after boot
Message-ID: <20040707120232.GB3725@craig-wood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to get my main workstation running 2.6 (its been
running 2.4 for ages).  I built it myself out of parts last year based
around a Gigabyte 8KNXP rev 2 motherboard with P4 2.6C + HT. Its
running an up to date Debian/testing.

When I boot 2.6.7 it runs for about 30 seconds (I haven't timed that)
before locking up.  If I run without the serial console its long
enough to get all the way into multi-user mode and just enough time
for me to log in.  If I run with the serial console the log messages
are slowed down a great deal (at 9600 baud!) and it doesn't make it
out of init.

When its locked up it doesn't respond to the keyboard other than the
magic scroll lock.

I've tried noapic, nosmp, acpi=ht and acpi=off (and all together!).  I
also upgraded the bios to the latest.  The same kernel runs on my
other machine (P4 not HT) just fine.

The kernel is a vanilla 2.6.7 compiled with this config
http://www.craig-wood.com/nick/config-2.6.7-v1-p4smp
This is a modular p4 SMP SMT Preempt + HUGE PAGES kernel.

If anyone has some ideas on what to try next I'd be grateful!

Here is the lspci - yes its got a lot of stuff in!

0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
0000:00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]
0000:02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet Controller (LOM)
0000:03:02.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
0000:03:03.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
0000:03:03.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
0000:03:0a.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link)
0000:04:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
0000:04:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
0000:04:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
0000:04:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)

Here is the boot log taken with the serial console including a memory
dump and a process dump :-

Linux version 2.6.7-v1-p4smp (root@crate) (gcc version 3.3.4 (Debian)) #1 SMP Tue Jul 6 12:48:19 BST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5240
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 GBT                                       ) @ 0x000f6d30
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3040
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff7080
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: Skipping IOAPIC probe due to 'noapic' option.
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=LinuxSC ro root=301 noapic console=ttyS1,9600 console=tty0
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2612.624 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Memory: 1031280k/1048512k available (1541k kernel code, 16332k reserved, 711k data, 156k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5177.34 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
per-CPU timeslice cutoff: 1462.98 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5210.11 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
Total of 2 processors activated (10387.45 BogoMIPS).
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2612.0138 MHz.
..... host bus clock speed is 200.0933 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
Freeing initrd memory: 5016k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb5f0, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbfc0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbff0, dseg 0xf0000
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
Starting balanced_irq
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: (supports S0 S1 S4 S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 5016 blocks [1 disk] into ram disk...done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 156k freed
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 4G120J6, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: DVD1648/BKH, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
NET: Registered protocol family 1
SCSI subsystem initialized
hda: max request size: 1024KiB
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.

[[[freeze here]]]

Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 14, high 42, batch 7
cpu 0 cold: low 0, high 14, batch 7
cpu 1 hot: low 14, high 42, batch 7
cpu 1 cold: low 0, high 14, batch 7

Free pages:      996576kB (126952kB HighMem)
Active:6288 inactive:1132 dirty:0 writeback:0 unstable:0 free:249144 slab:1244 mapped:183 pagetables:9
DMA free:13424kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
protections[]: 8 476 540
Normal free:856200kB min:936kB low:1872kB high:2808kB active:22472kB inactive:4396kB present:901120kB
protections[]: 0 468 532
HighMem free:126952kB min:128kB low:256kB high:384kB active:2680kB inactive:132kB present:131008kB
protections[]: 0 0 64
DMA: 4*4kB 6*8kB 3*16kB 4*32kB 4*64kB 3*128kB 3*256kB 1*512kB 1*1024kB 1*2048kB 2*4096kB = 13424kB
Normal: 0*4kB 7*8kB 1*16kB 4*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 208*4096kB = 856200kB
HighMem: 0*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 30*4096kB = 126952kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:            0kB
262128 pages of RAM
32752 pages of HIGHMEM
2887 reserved pages
5768 pages shared
0 pages swap cached

                                               sibling
  task             PC      pid father child younger older
init          S C1815D20     0     1      0     2               (NOTLB)
f7f9df50 00000086 00000001 c1815d20 c18150a0 f7cc7320 00000002 f7f9f670 
       c0117ef6 f7cc7300 f7cc3318 c035adc0 c1815d20 00000001 00000000 9096e7c0 
       000f41fd f7f9f0e0 f7f9f670 f7f9f820 f7d721b0 00000003 fffffe00 f7f9c000 
Call Trace:
 [<c0117ef6>] do_page_fault+0x325/0x50d
 [<c0123445>] sys_wait4+0x1ac/0x272
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c01060af>] syscall_call+0x7/0xb

migration/0   S C180DD20     0     2      1             3       (L-TLB)
f7f97f98 00000046 f761e8c0 c180dd20 9f228c80 9f228c80 00000002 00000020 
       00000000 c180d060 f7d721b0 f7c9fe04 c180dd20 00000000 00000000 9f228c80 
       000f41fe f7d721b0 f7f9eb50 f7f9ed00 00000003 00000000 f7f96000 c180e660 
Call Trace:
 [<c011cd4f>] migration_thread+0x97/0x1bb
 [<c011ccb8>] migration_thread+0x0/0x1bb
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

ksoftirqd/0   S C180DD20     0     3      1             4     2 (L-TLB)
f7f95fa8 00000046 f7f9f0e0 c180dd20 c180d0a0 f7f9f670 00000002 00000020 
       00000000 c180d060 f7f9f670 f7f94000 c180dd20 00000000 00000000 60304500 
       000f41fc f7f9f670 f7f9e5c0 f7f9e770 00000003 00000246 f7f94000 f7f94000 
Call Trace:
 [<c012489f>] ksoftirqd+0x0/0xd7
 [<c012495c>] ksoftirqd+0xbd/0xd7
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

migration/1   S C1815D20     0     4      1             5     3 (L-TLB)
f7f93f98 00000046 f761e8c0 c1815d20 9f505340 9f505340 00000002 00000020 
       00000000 c1815060 f7d721b0 f7c9fe04 c1815d20 00000001 00000000 9f505340 
       000f41fe f7d721b0 f7f9e030 f7f9e1e0 00000003 00000000 f7f92000 c1816660 
Call Trace:
 [<c011cd4f>] migration_thread+0x97/0x1bb
 [<c011ccb8>] migration_thread+0x0/0x1bb
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

ksoftirqd/1   S C1815D20     0     5      1             6     4 (L-TLB)
c189ffa8 00000046 c02b9180 c1815d20 c18150a0 c1817774 00000002 00000020 
       00000000 c1815060 f7f9f670 c189e000 c1815d20 00000001 00000000 8f74fd00 
       000f41fd f7f9f670 c18a16f0 c18a18a0 00000003 00000246 c189e000 c189e000 
Call Trace:
 [<c012489f>] ksoftirqd+0x0/0xd7
 [<c012495c>] ksoftirqd+0xbd/0xd7
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

events/0      S C180DD20     0     6      1     9       7     5 (L-TLB)
c189df44 00000046 00000000 c180dd20 c180d0a0 ffffffef 00000002 c189c000 
       00000246 c180e6e0 c0388520 c035adc0 c180dd20 00000000 00000000 16906200 
       000f4214 c02b9180 f7ecf770 f7ecf920 00000000 00000003 c189df94 f7eff014 
Call Trace:
 [<c012fd7b>] worker_thread+0x2a0/0x2be
 [<c01eaa54>] console_callback+0x0/0xe9
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

events/1      S C18161D0     0     7      1     8      66     6 (L-TLB)
f7ecbf44 00000046 c18a16f0 c18161d0 000f41fc f7ecbf1c 00000002 00000020 
       00000000 c1815060 c18a16f0 f7eff0a4 c1815d20 00000001 00000000 fbfebe80 
       000f41fc c18a16f0 f7ecf1e0 f7ecf390 00000003 00000246 f7ecbf94 f7eff094 
Call Trace:
 [<c012fd7b>] worker_thread+0x2a0/0x2be
 [<c013376f>] keventd_create_kthread+0x0/0x53
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

khelper       S C1815D20     0     8      7            55       (L-TLB)
f7ec9f44 00000046 00000001 c1815d20 c18150a0 00000000 00000002 f7ecec50 
       00000000 c1815d20 00000001 c035adc0 c1815d20 00000001 00000000 90e33300 
       000f41fd f7f9f0e0 f7ecec50 f7ecee00 f7ec8000 00000003 f7ec9f94 f7efb814 
Call Trace:
 [<c012fd7b>] worker_thread+0x2a0/0x2be
 [<c012f7a6>] __call_usermodehelper+0x0/0x65
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

kacpid        S C180DD20     0     9      6            56       (L-TLB)
f7deff44 00000046 00000000 c180dd20 c180d0a0 00000000 00000002 00000000 
       00000000 00000000 00000000 c035adc0 c180dd20 00000000 00000000 5c5f3540 
       000f41fb c02b9180 c18a1160 c18a1310 c18a1694 00000003 f7deff94 c18ad014 
Call Trace:
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c012fd7b>] worker_thread+0x2a0/0x2be
 [<c027f7ff>] schedule+0x47b/0x8ca
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

kblockd/0     S C180DD20     0    55      7            67     8 (L-TLB)
f7d99f44 00000046 00000000 c180dd20 c180d0a0 00000000 00000002 00000000 
       00000000 00000000 00000000 c035adc0 c180dd20 00000000 00000000 b1f6d440 
       000f41fb c02b9180 f7ece6c0 f7ece870 f7ecebf4 00000003 f7d99f94 f7efb014 
Call Trace:
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c012fd7b>] worker_thread+0x2a0/0x2be
 [<c027f7ff>] schedule+0x47b/0x8ca
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

kblockd/1     S C1815D20     0    56      6            68     9 (L-TLB)
f7debf44 00000046 00000001 c1815d20 c18150a0 00000075 00000002 c0362020 
       c0362020 00000000 00000003 c035adc0 c1815d20 00000001 00000000 ce930c40 
       000f41fb f7f9f0e0 c18a0bd0 c18a0d80 c18a1104 00000003 f7debf94 f7efb094 
Call Trace:
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c012fd7b>] worker_thread+0x2a0/0x2be
 [<c027f7ff>] schedule+0x47b/0x8ca
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

kirqd         S C180DD20     0    66      1            69     7 (L-TLB)
f7d75fa0 00000046 00000000 c180dd20 c180d0a0 00000000 00000002 f7d74000 
       00000001 c01149d1 00000000 c035adc0 c180dd20 00000000 00000000 50055b40 
       000f4213 c02b9180 f7ece130 f7ece2e0 00000000 00000003 fffd25cd f7d75fb4 
Call Trace:
 [<c01149d1>] smp_call_function_interrupt+0x44/0x97
 [<c02802b3>] schedule_timeout+0x6b/0xbf
 [<c0128b34>] process_timeout+0x0/0x9
 [<c0116613>] balanced_irq+0x4b/0x71
 [<c01165c8>] balanced_irq+0x0/0x71
 [<c0104271>] kernel_thread_helper+0x5/0xb

pdflush       S C1815D20     0    67      7            70    55 (L-TLB)
f7d71f7c 00000046 00000001 c1815d20 c18150a0 00000086 00000002 00000001 
       00000000 d02f0900 000f41fb c035adc0 c1815d20 00000001 00000000 d02f0900 
       000f41fb f7f9f0e0 f7d737f0 f7d739a0 c027fc78 00000003 f7d70000 f7d71fb0 
Call Trace:
 [<c027fc78>] preempt_schedule+0x2a/0x43
 [<c0140f97>] __pdflush+0x9b/0x215
 [<c0141111>] pdflush+0x0/0x2c
 [<c0141139>] pdflush+0x28/0x2c
 [<c0141111>] pdflush+0x0/0x2c
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

pdflush       S C1815D20     0    68      6            71    56 (L-TLB)
f7d77f7c 00000046 00000001 c1815d20 c18150a0 fffd4c9b 00000002 00000000 
       00000000 f7d77f30 00000400 c035adc0 c1815d20 00000001 00000000 a0222ac0 
       000f4215 f7f9f0e0 c18a0640 c18a07f0 00000000 00000003 f7d76000 f7d77fb0 
Call Trace:
 [<c0140f97>] __pdflush+0x9b/0x215
 [<c0141111>] pdflush+0x0/0x2c
 [<c0141139>] pdflush+0x28/0x2c
 [<c0141111>] pdflush+0x0/0x2c
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

kswapd0       S C180DD20     0    69      1           207    66 (L-TLB)
f7d6ff8c 00000046 00000000 c180dd20 c180d0a0 c02bcf80 00000002 f7d6ffb4 
       00000003 00000282 c02bcf7c c035adc0 c180dd20 00000000 00000000 d02f0900 
       000f41fb c02b9180 f7d73260 f7d73410 00000246 00000003 f7d6e000 f7d6ffc0 
Call Trace:
 [<c0147c1c>] kswapd+0xb7/0xee
 [<c011d9e2>] autoremove_wake_function+0x0/0x57
 [<c0105f86>] ret_from_fork+0x6/0x14
 [<c011d9e2>] autoremove_wake_function+0x0/0x57
 [<c0147b65>] kswapd+0x0/0xee
 [<c0104271>] kernel_thread_helper+0x5/0xb

aio/0         S C180DD20     0    70      7           230    67 (L-TLB)
f7d1df44 00000046 00000000 c180dd20 c180d0a0 00000000 00000002 00000000 
       00000000 00000000 00000000 c035adc0 c180dd20 00000000 00000000 d502ff40 
       000f41fb c02b9180 f7d72cd0 f7d72e80 f7d73204 00000003 f7d1df94 f7d3e014 
Call Trace:
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c012fd7b>] worker_thread+0x2a0/0x2be
 [<c027f7ff>] schedule+0x47b/0x8ca
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

aio/1         S C1815D20     0    71      6                  68 (L-TLB)
f7d19f44 00000046 00000001 c1815d20 c18150a0 00000000 00000002 00000000 
       00000000 00000000 00000000 c035adc0 c1815d20 00000001 00000000 f785d600 
       000f41fb f7f9f0e0 c18a00b0 c18a0260 c18a05e4 00000003 f7d19f94 f7d3e094 
Call Trace:
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c012fd7b>] worker_thread+0x2a0/0x2be
 [<c027f7ff>] schedule+0x47b/0x8ca
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

kseriod       S C1815D20     0   207      1           292    69 (L-TLB)
f7cf3fb0 00000046 00000001 c1815d20 c18150a0 c02bcf80 00000002 00000000 
       c0128fdc c02bcf80 c02bcf7c c035adc0 c1815d20 00000001 044aa200 0eb58140 
       000f41fc f7f9f0e0 f7cf5870 f7cf5a20 f7cf3fa8 00000003 f7cf2000 ffffe000 
Call Trace:
 [<c0128fdc>] free_uid+0x1f/0x7d
 [<c020bfd0>] serio_thread+0x143/0x170
 [<c0105f86>] ret_from_fork+0x6/0x14
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c020be8d>] serio_thread+0x0/0x170
 [<c0104271>] kernel_thread_helper+0x5/0xb

ata/0         S C180DD20     0   230      7           231    70 (L-TLB)
f76aff44 00000046 f7ecf1e0 c180dd20 c180d060 00000075 00000002 00000020 
       00000000 c180d060 f7d721b0 c18150a0 c180dd20 00000000 00000000 fbfebe80 
       000f41fc f7d721b0 f76d3360 f76d3510 00000003 00000246 f76aff94 f76ee014 
Call Trace:
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c012fd7b>] worker_thread+0x2a0/0x2be
 [<c027f7ff>] schedule+0x47b/0x8ca
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

ata/1         S C1815D20     0   231      7                 230 (L-TLB)
f76adf44 00000046 00000001 c1815d20 c18150a0 f76adf08 00000002 f76d2dd0 
       00000000 00000000 00000000 c035adc0 c1815d20 00000001 00000000 fbfebe80 
       000f41fc f7f9f0e0 f76d2dd0 f76d2f80 f76d3304 00000003 f76adf94 f76ee094 
Call Trace:
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c012fd7b>] worker_thread+0x2a0/0x2be
 [<c027f7ff>] schedule+0x47b/0x8ca
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c012fadb>] worker_thread+0x0/0x2be
 [<c0133769>] kthread+0xb7/0xbd
 [<c01336b2>] kthread+0x0/0xbd
 [<c0104271>] kernel_thread_helper+0x5/0xb

init          S C1815D58     0   292      1   308     304   207 (NOTLB)
f7cd1f50 00000086 f761ee50 c1815d58 000f41fe f75e8320 00000002 00000020 
       00000000 c1815060 f761ee50 0805f33c c1815d20 00000001 00000000 9f505340 
       000f41fe f761ee50 f7d721b0 f7d72360 00000003 00000246 fffffe00 f7cd0000 
Call Trace:
 [<c0123445>] sys_wait4+0x1ac/0x272
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c011bb91>] default_wake_function+0x0/0x12
 [<c01060af>] syscall_call+0x7/0xb

kjournald     S C180DD20     0   304      1                 292 (L-TLB)
f7d07f64 00000046 00000000 c180dd20 c180d0a0 f7d07f3c 00000002 f761ee50 
       00000003 00000000 00000000 c035adc0 c180dd20 00000000 01406f40 a6776140 
       000f41fe c02b9180 f761e8c0 f761ea70 00000246 00000003 f7d06000 f7fad800 
Call Trace:
 [<f8867210>] kjournald+0x29e/0x2e2 [jbd]
 [<c011d9e2>] autoremove_wake_function+0x0/0x57
 [<c011d9e2>] autoremove_wake_function+0x0/0x57
 [<c0105f86>] ret_from_fork+0x6/0x14
 [<f8866f72>] kjournald+0x0/0x2e2 [jbd]
 [<f8866f68>] commit_timeout+0x0/0x9 [jbd]
 [<f8866f72>] kjournald+0x0/0x2e2 [jbd]
 [<c0104271>] kernel_thread_helper+0x5/0xb

umount        D C1815D20     0   308    292                     (NOTLB)
f7c9fea4 00000082 00000001 c1815d20 c18150a0 00000000 00000002 f7c9fe94 
       00000000 c0145e47 f7c9fe8c c035adc0 c1815d20 00000001 00000000 a6776140 
       000f41fe f7f9f0e0 f761ee50 f761f000 00000000 00000003 f7c9e000 f7c9e000 
Call Trace:
 [<c0145e47>] truncate_inode_pages+0x121/0x284
 [<f88673ec>] journal_kill_thread+0x102/0x137 [jbd]
 [<c011bb91>] default_wake_function+0x0/0x12
 [<f88a30c9>] ext3_destroy_inode+0x1d/0x21 [ext3]
 [<f8868610>] journal_destroy+0x12/0x21d [jbd]
 [<f88a2edf>] ext3_put_super+0x29/0x1b4 [ext3]
 [<c0160fa3>] generic_shutdown_super+0x1c3/0x1e4
 [<c0161d22>] kill_block_super+0x1d/0x40
 [<c0160cc6>] deactivate_super+0x63/0x92
 [<c0178815>] sys_umount+0x3f/0x86
 [<c0124474>] __do_softirq+0xa8/0xaa
 [<c0178873>] sys_oldumount+0x17/0x1b
 [<c01060af>] syscall_call+0x7/0xb

...

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2612.593
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5216.66

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2612.593
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5216.66

-- 
Nick Craig-Wood <nick@craig-wood.com> -- http://www.craig-wood.com/nick
