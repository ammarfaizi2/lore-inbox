Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUJBO20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUJBO20 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 10:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUJBO20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 10:28:26 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:63119 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S266619AbUJBO1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 10:27:24 -0400
Subject: Re: 2.6.9-rc3-mm1
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041002014352.2b55e98d.akpm@osdl.org>
References: <20041002014352.2b55e98d.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1096727240.707.12.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 02 Oct 2004 16:27:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something suspicious hits my box when doing tune2fs -C 40 /dev/hda2 and rebooting into
-mm (I don't know if this happend in earlier -mm's too...).

What I did notice is that this doesn't appear to happen if I remove the serial output
(console=tty0 console=ttyS0,38400). This is a x64 with SMP & PREEMPT.

Looks like all 4 sysrq-t captures of aio/1 sits in _spin_unlock_irq+1, weird hmm?
I can start looking in which -mm this was introduced if you don't have any
patches under suspicioun, this doesn't happen with Linus bk-tree.



Bootdata ok (command line is root=/dev/hda2 ro debug console=tty0 console=ttyS0,38400)
Linux version 2.6.9-rc3-mm1 (alex@boxen) (gcc version 3.4.2 (Debian 3.4.2-2)) #3 SMP Sat Oct 2 14:15:01 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
No mptable found.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 258032 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000f6490
ACPI: XSDT (v001 A M I  OEMXSDT  0x05000410 MSFT 0x00000097) @ 0x000000003fff0100
ACPI: FADT (v001 A M I  OEMFACP  0x05000410 MSFT 0x00000097) @ 0x000000003fff0281
ACPI: MADT (v001 A M I  OEMAPIC  0x05000410 MSFT 0x00000097) @ 0x000000003fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x05000410 MSFT 0x00000097) @ 0x000000003ffff040
ACPI: HPET (v001 A M I  OEMHPET  0x05000410 MSFT 0x00000097) @ 0x000000003fff3330
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x000000003fff3370
ACPI: DSDT (v001  0AAAA 0AAAA000 0x00000000 INTL 0x02002026) @ 0x0000000000000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x102282a0 base: 0xfec01000
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda2 ro debug console=tty0 console=ttyS0,38400
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 1589.912 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1026692k/1048512k available (1664k kernel code, 21032k reserved, 850k data, 452k init)
Calibrating delay loop... 3137.53 BogoMIPS (lpj=1568768)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 242 stepping 01
per-CPU timeslice cutoff: 1024.15 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 1003ffb5f58
Initializing CPU#1
Calibrating delay loop... 3178.49 BogoMIPS (lpj=1589248)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 242 stepping 01
Total of 2 processors activated (6316.03 BogoMIPS).
Using local APIC timer interrupts.
Detected 12.421 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using HPET based timekeeping.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Initializing Cryptographic API
Real Time Clock Driver v1.12
hpet_acpi_add: no address or irqs in _CRS
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST380023A, ATA DISK drive
hdb: LITE-ON LTR-48126S, ATAPI CD/DVD-ROM drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ST3200822A, ATA DISK drive
hdd: SAMSUNG DVD-ROM SD-616E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: max request size: 1024KiB
hdc: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
swsusp: Resume From Partition: /dev/hda3
<3>swsusp: Invalid partition type.
pmdisk: Error -22 resuming
PM: Resume from disk failed.
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
PCI1 USB0 USB1 PS2K PS2M UAR1 UAR2 SMBC AC97 MODM PWRB 
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 452k freed

AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
^L^L^L^Al^[^[[A^[[B
INIT: version 2.86 booting
Setting disc parameters: done.
Activating swap.
Checking root file system...
fsck 1.35 (28-Feb-2004)
/dev/hda2: clean, 128179/2626560 files, 2266431/EXT3 FS on hda2, 5242880 blocks
internal journal
System time was Sat Oct  2 13:58:38 UTC 2004.
Setting the System Clock using the Hardware Clock as reference...
System Clock set. System local time is now Sat Oct  2 15:58:40 CEST 2004.
Cleaning up ifupdown...done.
Calculating module dependencies... done.
Loading modules...
    e1000
Intel(R) PRO/1000 Network Driver - version 5.3.19-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:01:03.0[A] -> GSI 18 (level, low) -> IRQ 18
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
    8139too
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 16 (level, low) -> IRQ 16
eth1: RealTek RTL8139 at 0x9800, 00:00:b4:c4:92:aa, IRQ 16
eth1:  Identified 8139 chip type 'RTL-8139B'
    snd-intel8x0
ACPI: PCI interrupt 0000:00:07.5[B] -> GSI 17 (level, low) -> IRQ 17
intel8x0_measure_ac97_clock: measured 50018 usecs
intel8x0: clocking to 48000
All modules loaded.
Checking all file systems...
fsck 1.35 (28-Feb-2004)
Setting kernel variables ...
net.ipv4.ip_forward = 1
net.ipv4.ip_no_pmtu_disc = 1
net.ipv4.ip_local_port_range = 2048 32767
vm.swappiness = 1
... done.
Mounting local filesystems...
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 0000000000000400     0     1      0     2               (NOTLB)
000001003ffa1d88 0000000000000002 ffffffff80322380 0000009f80333240 
       000001000214f7d0 0000000000000001 000001000214fb08 0000000000000000 
       0000000000000246 0000000000000000 
Call Trace:<ffffffff8013e660>{__mod_timer+352} <ffffffff8029c037>{schedule_timeout+167} 
       <ffffffff8013f2b0>{process_timeout+0} <ffffffff80187077>{do_select+999} 
       <ffffffff80186ba0>{__pollwait+0} <ffffffff80187445>{sys_select+885} 
       <ffffffff8010f366>{system_call+126} 
migration/0   S 000001003f48d240     0     2      1             3       (L-TLB)
000001003ff2de98 0000000000000046 000001003f407810 000000878012e582 
       000001003ff82810 000000003ff82bf0 000001003ff82b48 000001003ef51e98 
       000001003ef51ea0 0000000000000246 
Call Trace:<ffffffff8013295b>{migration_thread+555} <ffffffff80132730>{migration_thread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
ksoftirqd/0   S 0000010001e1b4a0     0     3      1             4     2 (L-TLB)
000001003ff2ff08 0000000000000046 ffffffff80322380 0000009f00000013 
       000001003ff82070 0000000001e134a0 000001003ff823a8 0000000000000001 
       000001003ff2fed8 ffffffff8029b99d 
Call Trace:<ffffffff8029b99d>{preempt_schedule+61} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8013b415>{ksoftirqd+69} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
migration/1   S 000001003f913240     0     4      1             5     3 (L-TLB)
000001003ff31e98 0000000000000046 000001003f47f070 0000008600000000 
       000001003ff837d0 0000000180130d60 000001003ff83b08 000001003eed5e98 
       000001003eed5ea0 0000000000000246 
Call Trace:<ffffffff8013295b>{migration_thread+555} <ffffffff80132730>{migration_thread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
ksoftirqd/1   S 000001003ff83368     0     5      1             6     4 (L-TLB)
000001003ff65f08 0000000000000046 000001000214f030 0000009f00000013 
       000001003ff83030 0000000101e1b4a0 000001003ff83368 0000000000000000 
       000001003ff65ed8 ffffffff8029b99d 
Call Trace:<ffffffff8029b99d>{preempt_schedule+61} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8013b415>{ksoftirqd+69} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
events/0      S ffffffff80160a20     0     6      1             7     5 (L-TLB)
000001003ff6fe58 0000000000000046 ffffffff80322380 0000009f01e16800 
       000001003ff3a810 000000003ffd9440 000001003ff3ab48 0000000000000000 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff80160a20>{cache_reap+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
events/1      R  running task       0     7      1             8     6 (L-TLB)
khelper       S 000001003ff3bb08     0     8      1             9     7 (L-TLB)
000001003ff7de58 0000000000000046 000001003ff3b030 00000078fffffff6 
       000001003ff3b7d0 0000000001e134a0 000001003ff3bb08 0000000000000000 
       000001003ff7de28 0000000000010000 
Call Trace:<ffffffff80146810>{worker_thread+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
kthread       S 0000010001e134a0     0     9      1    10      15     8 (L-TLB)
000001000219fe58 0000000000000046 000001000214f030 0000009f00000000 
       000001003ff3b030 000000013ffdae40 000001003ff3b368 0000000000000001 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
kacpid        S 0000010001e134a0     0    10      9            11       (L-TLB)
000001003fca1e58 0000000000000046 000001000214f030 0000009f00000000 
       000001003ffbe810 0000000100000000 000001003ffbeb48 0000000000000001 
       000001003fca1e38 0000000000010000 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff80146941>{worker_thread+305} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
kblockd/0     S ffffffff80225320     0    11      9            12    10 (L-TLB)
000001003fcd5e58 0000000000000046 ffffffff80322380 0000009fffffffff 
       000001003ffbe070 000000003ffdca40 000001003ffbe3a8 0000000000000000 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff80225320>{as_work_handler+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
kblockd/1     S ffffffff80225320     0    12      9            13    11 (L-TLB)
000001003fcd7e58 0000000000000046 000001000214f030 0000009fffffffff 
       000001003ff007d0 000000013ffdcac0 000001003ff00b08 0000000000000000 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff80225320>{as_work_handler+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
pdflush       S 0000010001e134a0     0    13      9            14    12 (L-TLB)
000001003fcf9ec8 0000000000000046 000001000214f030 0000009f0000000a 
       000001003ff00030 0000000101e1b4a0 000001003ff00368 0000000000000001 
       000001003fcf9e98 ffffffff8029b99d 
Call Trace:<ffffffff8029b99d>{preempt_schedule+61} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8015d62b>{pdflush+187} <ffffffff8015d570>{pdflush+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
pdflush       S ffffffff8014af30     0    14      9            16    13 (L-TLB)
000001003fcfdec8 0000000000000046 ffffffff80322380 0000009f00019993 
       000001003ff01810 0000000000000000 000001003ff01b48 0000000000000000 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8015d62b>{pdflush+187} 
       <ffffffff8015d570>{pdflush+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
kswapd0       S 0000000000000000     0    15      1            18     9 (L-TLB)
000001003fcffeb8 0000000000000046 ffffffff80322380 0000009f00000202 
       000001003fcc97d0 0000000000000000 000001003fcc9b08 0000000000000000 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80163e75>{kswapd+261} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8012ed70>{finish_task_switch+64} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8012edce>{schedule_tail+14} <ffffffff80110007>{child_rip+8} 
       <ffffffff8011d180>{flat_send_IPI_mask+0} <ffffffff80163d70>{kswapd+0} 
       <ffffffff8010ffff>{child_rip+0} 
aio/0         S ffffffff8014af30     0    16      9            17    14 (L-TLB)
000001003fd11e58 0000000000000046 ffffffff80322380 0000009f00000000 
       000001003ff01070 0000000000000000 000001003ff013a8 0000000000000000 
       000001003fd11e38 0000000000010000 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff80146941>{worker_thread+305} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
aio/1         S 0000010001e134a0     0    17      9                  16 (L-TLB)
000001003fd13e58 0000000000000046 000001000214f030 0000009f00000010 
       000001003ff02810 000000013ff02ee8 000001003ff02b48 0000000000000001 
       ffffffff8029cd1d 0000000000000010 
Call Trace:<ffffffff8029cd1d>{_spin_unlock_irq+13} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
kseriod       S 0000000000000000     0    18      1            19    15 (L-TLB)
000001003fd47eb8 0000000000000046 000001000214f030 0000009f000002fa 
       000001003fcc9030 00000001ffffff00 000001003fcc9368 0000000000000000 
       0000000000000202 000001003fd47e88 
Call Trace:<ffffffff8020f517>{serio_thread+455} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff80110007>{child_rip+8} 
       <ffffffff8020f350>{serio_thread+0} <ffffffff8010ffff>{child_rip+0} 
       
kjournald     S 0000000000000000     0    19      1            20    18 (L-TLB)
000001003f901e58 0000000000000046 000001000214f030 0000009f3f657870 
       000001003ff02070 000000013ff84e98 000001003ff023a8 0000000000000000 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
init          S 000001003f913b40     0    20      1    21     143    19 (NOTLB)
000001003fa85e58 0000000000000006 000001000214f7d0 000000873f9136c0 
       000001003f92b7d0 000000018043c760 000001003f92bb08 ffffffff80167461 
       000001003f92bb10 ffffffff801339a4 
Call Trace:<ffffffff80167461>{handle_mm_fault+369} <ffffffff801339a4>{copy_mm+852} 
       <ffffffff80139e77>{do_wait+3495} <ffffffff8011f24c>{do_page_fault+540} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801433c1>{sys_rt_sigaction+113} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8010f366>{system_call+126} 
       
rcS           S 0000000000000000     0    21     20   418               (NOTLB)
000001003fa99e58 0000000000000006 000001000214f030 0000009f3f912dc0 
       000001003f92b030 000000018043c760 000001003f92b368 0000000000000000 
       000001003f92b370 ffffffff801339a4 
Call Trace:<ffffffff801339a4>{copy_mm+852} <ffffffff80139e77>{do_wait+3495} 
       <ffffffff8011f24c>{do_page_fault+540} <ffffffff80143051>{do_sigaction+577} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801433e4>{sys_rt_sigaction+148} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8010f366>{system_call+126} 
       
kjournald     S 000001003f5cd6c0     0   143      1           144    20 (L-TLB)
000001003f37be58 0000000000000046 000001003f1b8810 0000008980130d60 
       000001003f1b8070 000000013ff8de98 000001003f1b83a8 0000000000000001 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
kjournald     S 0000010001e1b4a0     0   144      1           145   143 (L-TLB)
000001003ee4de58 0000000000000046 ffffffff80322380 0000009f80130d60 
       000001003f3627d0 000000003ff92298 000001003f362b08 0000000000000001 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
kjournald     S 0000000000000000     0   145      1                 144 (L-TLB)
000001003ee5fe58 0000000000000046 000001000214f030 0000009f80130d60 
       000001003f362030 0000000102170498 000001003f362368 0000000000000000 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
rcS           S 000001003fdc1e80     0   418     21                     (NOTLB)
000001003f46bda8 0000000000000006 000001000214f030 0000009f80211303 
       000001003f407810 0000000100000000 000001003f407b48 0000000000000000 
       0000000000000246 ffffffff803b59a0 
Call Trace:<ffffffff801ff4a4>{write_chan+980} <ffffffff801f8dd6>{tty_ldisc_try+70} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801d117d>{__up_read+29} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801ff0d0>{write_chan+0} 
       <ffffffff801f95d0>{tty_write+352} <ffffffff801734c7>{vfs_write+199} 
       <ffffffff80173603>{sys_write+83} <ffffffff8010f366>{system_call+126} 
       
SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 0000000000000400     0     1      0     2               (NOTLB)
000001003ffa1d88 0000000000000002 ffffffff80322380 0000009f80333240 
       000001000214f7d0 0000000000000001 000001000214fb08 0000000000000000 
       0000000000000246 0000000000000000 
Call Trace:<ffffffff8013e660>{__mod_timer+352} <ffffffff8029c037>{schedule_timeout+167} 
       <ffffffff8013f2b0>{process_timeout+0} <ffffffff80187077>{do_select+999} 
       <ffffffff80186ba0>{__pollwait+0} <ffffffff80187445>{sys_select+885} 
       <ffffffff8010f366>{system_call+126} 
migration/0   S 000001003f48d240     0     2      1             3       (L-TLB)
000001003ff2de98 0000000000000046 000001003f407810 000000878012e582 
       000001003ff82810 000000003ff82bf0 000001003ff82b48 000001003ef51e98 
       000001003ef51ea0 0000000000000246 
Call Trace:<ffffffff8013295b>{migration_thread+555} <ffffffff80132730>{migration_thread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
ksoftirqd/0   S 0000010001e1b4a0     0     3      1             4     2 (L-TLB)
000001003ff2ff08 0000000000000046 ffffffff80322380 0000009f00000013 
       000001003ff82070 0000000001e134a0 000001003ff823a8 0000000000000001 
       000001003ff2fed8 ffffffff8029b99d 
Call Trace:<ffffffff8029b99d>{preempt_schedule+61} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8013b415>{ksoftirqd+69} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
migration/1   S 000001003f913240     0     4      1             5     3 (L-TLB)
000001003ff31e98 0000000000000046 000001003f47f070 0000008600000000 
       000001003ff837d0 0000000180130d60 000001003ff83b08 000001003eed5e98 
       000001003eed5ea0 0000000000000246 
Call Trace:<ffffffff8013295b>{migration_thread+555} <ffffffff80132730>{migration_thread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
ksoftirqd/1   S 000001003ff83368     0     5      1             6     4 (L-TLB)
000001003ff65f08 0000000000000046 000001000214f030 0000009f00000013 
       000001003ff83030 0000000101e1b4a0 000001003ff83368 0000000000000000 
       000001003ff65ed8 ffffffff8029b99d 
Call Trace:<ffffffff8029b99d>{preempt_schedule+61} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8013b415>{ksoftirqd+69} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
events/0      S 000001003ff3ab48     0     6      1             7     5 (L-TLB)
000001003ff6fe58 0000000000000046 000001003ff01810 0000007801e16800 
       000001003ff3a810 000000003ffd9440 000001003ff3ab48 0000000000000001 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff80160a20>{cache_reap+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
events/1      R  running task       0     7      1             8     6 (L-TLB)
khelper       S 000001003ff3bb08     0     8      1             9     7 (L-TLB)
000001003ff7de58 0000000000000046 000001003ff3b030 00000078fffffff6 
       000001003ff3b7d0 0000000001e134a0 000001003ff3bb08 0000000000000000 
       000001003ff7de28 0000000000010000 
Call Trace:<ffffffff80146810>{worker_thread+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
kthread       S 0000010001e134a0     0     9      1    10      15     8 (L-TLB)
000001000219fe58 0000000000000046 000001000214f030 0000009f00000000 
       000001003ff3b030 000000013ffdae40 000001003ff3b368 0000000000000001 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
kacpid        S 0000010001e134a0     0    10      9            11       (L-TLB)
000001003fca1e58 0000000000000046 000001000214f030 0000009f00000000 
       000001003ffbe810 0000000100000000 000001003ffbeb48 0000000000000001 
       000001003fca1e38 0000000000010000 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff80146941>{worker_thread+305} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
kblockd/0     S ffffffff80225320     0    11      9            12    10 (L-TLB)
000001003fcd5e58 0000000000000046 ffffffff80322380 0000009fffffffff 
       000001003ffbe070 000000003ffdca40 000001003ffbe3a8 0000000000000000 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff80225320>{as_work_handler+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
kblockd/1     S ffffffff80225320     0    12      9            13    11 (L-TLB)
000001003fcd7e58 0000000000000046 000001000214f030 0000009fffffffff 
       000001003ff007d0 000000013ffdcac0 000001003ff00b08 0000000000000000 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff80225320>{as_work_handler+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
pdflush       S 0000010001e134a0     0    13      9            14    12 (L-TLB)
000001003fcf9ec8 0000000000000046 000001000214f030 0000009f0000000a 
       000001003ff00030 0000000101e1b4a0 000001003ff00368 0000000000000001 
       000001003fcf9e98 ffffffff8029b99d 
Call Trace:<ffffffff8029b99d>{preempt_schedule+61} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8015d62b>{pdflush+187} <ffffffff8015d570>{pdflush+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
pdflush       S 000001003f913b40     0    14      9            16    13 (L-TLB)
000001003fcfdec8 0000000000000046 000001000214f7d0 0000008600019993 
       000001003ff01810 0000000000000000 000001003ff01b48 0000000000000400 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8015d62b>{pdflush+187} 
       <ffffffff8015d570>{pdflush+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
kswapd0       S 0000000000000000     0    15      1            18     9 (L-TLB)
000001003fcffeb8 0000000000000046 ffffffff80322380 0000009f00000202 
       000001003fcc97d0 0000000000000000 000001003fcc9b08 0000000000000000 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80163e75>{kswapd+261} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8012ed70>{finish_task_switch+64} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8012edce>{schedule_tail+14} <ffffffff80110007>{child_rip+8} 
       <ffffffff8011d180>{flat_send_IPI_mask+0} <ffffffff80163d70>{kswapd+0} 
       <ffffffff8010ffff>{child_rip+0} 
aio/0         S ffffffff8014af30     0    16      9            17    14 (L-TLB)
000001003fd11e58 0000000000000046 ffffffff80322380 0000009f00000000 
       000001003ff01070 0000000000000000 000001003ff013a8 0000000000000000 
       000001003fd11e38 0000000000010000 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff80146941>{worker_thread+305} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
aio/1         S 0000010001e134a0     0    17      9                  16 (L-TLB)
000001003fd13e58 0000000000000046 000001000214f030 0000009f00000010 
       000001003ff02810 000000013ff02ee8 000001003ff02b48 0000000000000001 
       ffffffff8029cd1d 0000000000000010 
Call Trace:<ffffffff8029cd1d>{_spin_unlock_irq+13} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
kseriod       S 0000000000000000     0    18      1            19    15 (L-TLB)
000001003fd47eb8 0000000000000046 000001000214f030 0000009f000002fa 
       000001003fcc9030 00000001ffffff00 000001003fcc9368 0000000000000000 
       0000000000000202 000001003fd47e88 
Call Trace:<ffffffff8020f517>{serio_thread+455} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff80110007>{child_rip+8} 
       <ffffffff8020f350>{serio_thread+0} <ffffffff8010ffff>{child_rip+0} 
       
kjournald     S 0000000000000000     0    19      1            20    18 (L-TLB)
000001003f901e58 0000000000000046 000001000214f030 0000009f3f657870 
       000001003ff02070 000000013ff84e98 000001003ff023a8 0000000000000000 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
init          S 000001003f913b40     0    20      1    21     143    19 (NOTLB)
000001003fa85e58 0000000000000006 000001000214f7d0 000000873f9136c0 
       000001003f92b7d0 000000018043c760 000001003f92bb08 ffffffff80167461 
       000001003f92bb10 ffffffff801339a4 
Call Trace:<ffffffff80167461>{handle_mm_fault+369} <ffffffff801339a4>{copy_mm+852} 
       <ffffffff80139e77>{do_wait+3495} <ffffffff8011f24c>{do_page_fault+540} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801433c1>{sys_rt_sigaction+113} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8010f366>{system_call+126} 
       
rcS           S 0000000000000000     0    21     20   418               (NOTLB)
000001003fa99e58 0000000000000006 000001000214f030 0000009f3f912dc0 
       000001003f92b030 000000018043c760 000001003f92b368 0000000000000000 
       000001003f92b370 ffffffff801339a4 
Call Trace:<ffffffff801339a4>{copy_mm+852} <ffffffff80139e77>{do_wait+3495} 
       <ffffffff8011f24c>{do_page_fault+540} <ffffffff80143051>{do_sigaction+577} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801433e4>{sys_rt_sigaction+148} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8010f366>{system_call+126} 
       
kjournald     S 000001003f5cd6c0     0   143      1           144    20 (L-TLB)
000001003f37be58 0000000000000046 000001003f1b8810 0000008980130d60 
       000001003f1b8070 000000013ff8de98 000001003f1b83a8 0000000000000001 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
kjournald     S 0000010001e1b4a0     0   144      1           145   143 (L-TLB)
000001003ee4de58 0000000000000046 ffffffff80322380 0000009f80130d60 
       000001003f3627d0 000000003ff92298 000001003f362b08 0000000000000001 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
kjournald     S 0000000000000000     0   145      1                 144 (L-TLB)
000001003ee5fe58 0000000000000046 000001000214f030 0000009f80130d60 
       000001003f362030 0000000102170498 000001003f362368 0000000000000000 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
rcS           S 000001003fdc1e80     0   418     21                     (NOTLB)
000001003f46bda8 0000000000000006 000001000214f030 0000009f80211303 
       000001003f407810 0000000100000000 000001003f407b48 0000000000000000 
       0000000000000246 ffffffff803b59a0 
Call Trace:<ffffffff801ff4a4>{write_chan+980} <ffffffff801f8dd6>{tty_ldisc_try+70} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801d117d>{__up_read+29} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801ff0d0>{write_chan+0} 
       <ffffffff801f95d0>{tty_write+352} <ffffffff801734c7>{vfs_write+199} 
       <ffffffff80173603>{sys_write+83} <ffffffff8010f366>{system_call+126} 
       
SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 0000000000000400     0     1      0     2               (NOTLB)
000001003ffa1d88 0000000000000002 ffffffff80322380 0000009f80333240 
       000001000214f7d0 0000000000000001 000001000214fb08 0000000000000000 
       0000000000000246 0000000000000000 
Call Trace:<ffffffff8013e660>{__mod_timer+352} <ffffffff8029c037>{schedule_timeout+167} 
       <ffffffff8013f2b0>{process_timeout+0} <ffffffff80187077>{do_select+999} 
       <ffffffff80186ba0>{__pollwait+0} <ffffffff80187445>{sys_select+885} 
       <ffffffff8010f366>{system_call+126} 
migration/0   S 000001003f48d240     0     2      1             3       (L-TLB)
000001003ff2de98 0000000000000046 000001003f407810 000000878012e582 
       000001003ff82810 000000003ff82bf0 000001003ff82b48 000001003ef51e98 
       000001003ef51ea0 0000000000000246 
Call Trace:<ffffffff8013295b>{migration_thread+555} <ffffffff80132730>{migration_thread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
ksoftirqd/0   S 0000010001e1b4a0     0     3      1             4     2 (L-TLB)
000001003ff2ff08 0000000000000046 ffffffff80322380 0000009f00000013 
       000001003ff82070 0000000001e134a0 000001003ff823a8 0000000000000001 
       000001003ff2fed8 ffffffff8029b99d 
Call Trace:<ffffffff8029b99d>{preempt_schedule+61} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8013b415>{ksoftirqd+69} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
migration/1   S 000001003f913240     0     4      1             5     3 (L-TLB)
000001003ff31e98 0000000000000046 000001003f47f070 0000008600000000 
       000001003ff837d0 0000000180130d60 000001003ff83b08 000001003eed5e98 
       000001003eed5ea0 0000000000000246 
Call Trace:<ffffffff8013295b>{migration_thread+555} <ffffffff80132730>{migration_thread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
ksoftirqd/1   S 000001003ff83368     0     5      1             6     4 (L-TLB)
000001003ff65f08 0000000000000046 000001000214f030 0000009f00000013 
       000001003ff83030 0000000101e1b4a0 000001003ff83368 0000000000000000 
       000001003ff65ed8 ffffffff8029b99d 
Call Trace:<ffffffff8029b99d>{preempt_schedule+61} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8013b415>{ksoftirqd+69} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
events/0      S 000001003ff3ab48     0     6      1             7     5 (L-TLB)
000001003ff6fe58 0000000000000046 000001003ff01810 0000007801e16800 
       000001003ff3a810 000000003ffd9440 000001003ff3ab48 0000000000000001 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff80160a20>{cache_reap+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
events/1      R  running task       0     7      1             8     6 (L-TLB)
khelper       S 000001003ff3bb08     0     8      1             9     7 (L-TLB)
000001003ff7de58 0000000000000046 000001003ff3b030 00000078fffffff6 
       000001003ff3b7d0 0000000001e134a0 000001003ff3bb08 0000000000000000 
       000001003ff7de28 0000000000010000 
Call Trace:<ffffffff80146810>{worker_thread+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
kthread       S 0000010001e134a0     0     9      1    10      15     8 (L-TLB)
000001000219fe58 0000000000000046 000001000214f030 0000009f00000000 
       000001003ff3b030 000000013ffdae40 000001003ff3b368 0000000000000001 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
kacpid        S 0000010001e134a0     0    10      9            11       (L-TLB)
000001003fca1e58 0000000000000046 000001000214f030 0000009f00000000 
       000001003ffbe810 0000000100000000 000001003ffbeb48 0000000000000001 
       000001003fca1e38 0000000000010000 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff80146941>{worker_thread+305} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
kblockd/0     S ffffffff80225320     0    11      9            12    10 (L-TLB)
000001003fcd5e58 0000000000000046 ffffffff80322380 0000009fffffffff 
       000001003ffbe070 000000003ffdca40 000001003ffbe3a8 0000000000000000 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff80225320>{as_work_handler+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
kblockd/1     S ffffffff80225320     0    12      9            13    11 (L-TLB)
000001003fcd7e58 0000000000000046 000001000214f030 0000009fffffffff 
       000001003ff007d0 000000013ffdcac0 000001003ff00b08 0000000000000000 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff80225320>{as_work_handler+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
pdflush       S 0000010001e134a0     0    13      9            14    12 (L-TLB)
000001003fcf9ec8 0000000000000046 000001000214f030 0000009f0000000a 
       000001003ff00030 0000000101e1b4a0 000001003ff00368 0000000000000001 
       000001003fcf9e98 ffffffff8029b99d 
Call Trace:<ffffffff8029b99d>{preempt_schedule+61} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8015d62b>{pdflush+187} <ffffffff8015d570>{pdflush+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
pdflush       S 000001003f913b40     0    14      9            16    13 (L-TLB)
000001003fcfdec8 0000000000000046 000001000214f7d0 0000008600019993 
       000001003ff01810 0000000000000000 000001003ff01b48 00000000000003ff 
       0000000000000001 0000000000000000 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8015d62b>{pdflush+187} 
       <ffffffff8015d570>{pdflush+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
kswapd0       S 0000000000000000     0    15      1            18     9 (L-TLB)
000001003fcffeb8 0000000000000046 ffffffff80322380 0000009f00000202 
       000001003fcc97d0 0000000000000000 000001003fcc9b08 0000000000000000 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80163e75>{kswapd+261} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8012ed70>{finish_task_switch+64} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8012edce>{schedule_tail+14} <ffffffff80110007>{child_rip+8} 
       <ffffffff8011d180>{flat_send_IPI_mask+0} <ffffffff80163d70>{kswapd+0} 
       <ffffffff8010ffff>{child_rip+0} 
aio/0         S ffffffff8014af30     0    16      9            17    14 (L-TLB)
000001003fd11e58 0000000000000046 ffffffff80322380 0000009f00000000 
       000001003ff01070 0000000000000000 000001003ff013a8 0000000000000000 
       000001003fd11e38 0000000000010000 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff80146941>{worker_thread+305} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
aio/1         S 0000010001e134a0     0    17      9                  16 (L-TLB)
000001003fd13e58 0000000000000046 000001000214f030 0000009f00000010 
       000001003ff02810 000000013ff02ee8 000001003ff02b48 0000000000000001 
       ffffffff8029cd1d 0000000000000010 
Call Trace:<ffffffff8029cd1d>{_spin_unlock_irq+13} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
kseriod       S 0000000000000000     0    18      1            19    15 (L-TLB)
000001003fd47eb8 0000000000000046 000001000214f030 0000009f000002fa 
       000001003fcc9030 00000001ffffff00 000001003fcc9368 0000000000000000 
       0000000000000202 000001003fd47e88 
Call Trace:<ffffffff8020f517>{serio_thread+455} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff80110007>{child_rip+8} 
       <ffffffff8020f350>{serio_thread+0} <ffffffff8010ffff>{child_rip+0} 
       
kjournald     S 0000000000000000     0    19      1            20    18 (L-TLB)
000001003f901e58 0000000000000046 000001000214f030 0000009f3f657870 
       000001003ff02070 000000013ff84e98 000001003ff023a8 0000000000000000 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
init          S 000001003f913b40     0    20      1    21     143    19 (NOTLB)
000001003fa85e58 0000000000000006 000001000214f7d0 000000873f9136c0 
       000001003f92b7d0 000000018043c760 000001003f92bb08 ffffffff80167461 
       000001003f92bb10 ffffffff801339a4 
Call Trace:<ffffffff80167461>{handle_mm_fault+369} <ffffffff801339a4>{copy_mm+852} 
       <ffffffff80139e77>{do_wait+3495} <ffffffff8011f24c>{do_page_fault+540} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801433c1>{sys_rt_sigaction+113} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8010f366>{system_call+126} 
       
rcS           S 0000000000000000     0    21     20   418               (NOTLB)
000001003fa99e58 0000000000000006 000001000214f030 0000009f3f912dc0 
       000001003f92b030 000000018043c760 000001003f92b368 0000000000000000 
       000001003f92b370 ffffffff801339a4 
Call Trace:<ffffffff801339a4>{copy_mm+852} <ffffffff80139e77>{do_wait+3495} 
       <ffffffff8011f24c>{do_page_fault+540} <ffffffff80143051>{do_sigaction+577} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801433e4>{sys_rt_sigaction+148} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8010f366>{system_call+126} 
       
kjournald     S 000001003f5cd6c0     0   143      1           144    20 (L-TLB)
000001003f37be58 0000000000000046 000001003f1b8810 0000008980130d60 
       000001003f1b8070 000000013ff8de98 000001003f1b83a8 0000000000000001 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
kjournald     S 0000010001e1b4a0     0   144      1           145   143 (L-TLB)
000001003ee4de58 0000000000000046 ffffffff80322380 0000009f80130d60 
       000001003f3627d0 000000003ff92298 000001003f362b08 0000000000000001 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
kjournald     S 0000000000000000     0   145      1                 144 (L-TLB)
000001003ee5fe58 0000000000000046 000001000214f030 0000009f80130d60 
       000001003f362030 0000000102170498 000001003f362368 0000000000000000 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
rcS           S 000001003fdc1e80     0   418     21                     (NOTLB)
000001003f46bda8 0000000000000006 000001000214f030 0000009f80211303 
       000001003f407810 0000000100000000 000001003f407b48 0000000000000000 
       0000000000000246 ffffffff803b59a0 
Call Trace:<ffffffff801ff4a4>{write_chan+980} <ffffffff801f8dd6>{tty_ldisc_try+70} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801d117d>{__up_read+29} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801ff0d0>{write_chan+0} 
       <ffffffff801f95d0>{tty_write+352} <ffffffff801734c7>{vfs_write+199} 
       <ffffffff80173603>{sys_write+83} <ffffffff8010f366>{system_call+126} 
       
SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 0000000000000400     0     1      0     2               (NOTLB)
000001003ffa1d88 0000000000000002 ffffffff80322380 0000009f80333240 
       000001000214f7d0 0000000000000001 000001000214fb08 0000000000000000 
       0000000000000246 0000000000000000 
Call Trace:<ffffffff8013e660>{__mod_timer+352} <ffffffff8029c037>{schedule_timeout+167} 
       <ffffffff8013f2b0>{process_timeout+0} <ffffffff80187077>{do_select+999} 
       <ffffffff80186ba0>{__pollwait+0} <ffffffff80187445>{sys_select+885} 
       <ffffffff8010f366>{system_call+126} 
migration/0   S 000001003f48d240     0     2      1             3       (L-TLB)
000001003ff2de98 0000000000000046 000001003f407810 000000878012e582 
       000001003ff82810 000000003ff82bf0 000001003ff82b48 000001003ef51e98 
       000001003ef51ea0 0000000000000246 
Call Trace:<ffffffff8013295b>{migration_thread+555} <ffffffff80132730>{migration_thread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
ksoftirqd/0   S 0000010001e1b4a0     0     3      1             4     2 (L-TLB)
000001003ff2ff08 0000000000000046 ffffffff80322380 0000009f00000013 
       000001003ff82070 0000000001e134a0 000001003ff823a8 0000000000000001 
       000001003ff2fed8 ffffffff8029b99d 
Call Trace:<ffffffff8029b99d>{preempt_schedule+61} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8013b415>{ksoftirqd+69} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
migration/1   S 000001003f913240     0     4      1             5     3 (L-TLB)
000001003ff31e98 0000000000000046 000001003f47f070 0000008600000000 
       000001003ff837d0 0000000180130d60 000001003ff83b08 000001003eed5e98 
       000001003eed5ea0 0000000000000246 
Call Trace:<ffffffff8013295b>{migration_thread+555} <ffffffff80132730>{migration_thread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
ksoftirqd/1   S 000001003ff83368     0     5      1             6     4 (L-TLB)
000001003ff65f08 0000000000000046 000001000214f030 0000009f00000013 
       000001003ff83030 0000000101e1b4a0 000001003ff83368 0000000000000000 
       000001003ff65ed8 ffffffff8029b99d 
Call Trace:<ffffffff8029b99d>{preempt_schedule+61} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8013b415>{ksoftirqd+69} <ffffffff8013b3d0>{ksoftirqd+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
events/0      S 000001003ff3ab48     0     6      1             7     5 (L-TLB)
000001003ff6fe58 0000000000000046 000001003ff01810 0000007801e16800 
       000001003ff3a810 000000003ffd9440 000001003ff3ab48 0000000000000001 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff80160a20>{cache_reap+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
events/1      R  running task       0     7      1             8     6 (L-TLB)
khelper       S 000001003ff3bb08     0     8      1             9     7 (L-TLB)
000001003ff7de58 0000000000000046 000001003ff3b030 00000078fffffff6 
       000001003ff3b7d0 0000000001e134a0 000001003ff3bb08 0000000000000000 
       000001003ff7de28 0000000000010000 
Call Trace:<ffffffff80146810>{worker_thread+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
kthread       S 0000010001e134a0     0     9      1    10      15     8 (L-TLB)
000001000219fe58 0000000000000046 000001000214f030 0000009f00000000 
       000001003ff3b030 000000013ffdae40 000001003ff3b368 0000000000000001 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
kacpid        S 0000010001e134a0     0    10      9            11       (L-TLB)
000001003fca1e58 0000000000000046 000001000214f030 0000009f00000000 
       000001003ffbe810 0000000100000000 000001003ffbeb48 0000000000000001 
       000001003fca1e38 0000000000010000 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff80146941>{worker_thread+305} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
kblockd/0     S ffffffff80225320     0    11      9            12    10 (L-TLB)
000001003fcd5e58 0000000000000046 ffffffff80322380 0000009fffffffff 
       000001003ffbe070 000000003ffdca40 000001003ffbe3a8 0000000000000000 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff80225320>{as_work_handler+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
kblockd/1     S ffffffff80225320     0    12      9            13    11 (L-TLB)
000001003fcd7e58 0000000000000046 000001000214f030 0000009fffffffff 
       000001003ff007d0 000000013ffdcac0 000001003ff00b08 0000000000000000 
       0000000000000046 0000000000000003 
Call Trace:<ffffffff80225320>{as_work_handler+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
pdflush       S 0000010001e134a0     0    13      9            14    12 (L-TLB)
000001003fcf9ec8 0000000000000046 000001000214f030 0000009f0000000a 
       000001003ff00030 0000000101e1b4a0 000001003ff00368 0000000000000001 
       000001003fcf9e98 ffffffff8029b99d 
Call Trace:<ffffffff8029b99d>{preempt_schedule+61} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8015d62b>{pdflush+187} <ffffffff8015d570>{pdflush+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
pdflush       S 000001003f913b40     0    14      9            16    13 (L-TLB)
000001003fcfdec8 0000000000000046 000001000214f7d0 0000008600019993 
       000001003ff01810 0000000000000000 000001003ff01b48 00000000000003ed 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8015d62b>{pdflush+187} 
       <ffffffff8015d570>{pdflush+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
kswapd0       S 0000000000000000     0    15      1            18     9 (L-TLB)
000001003fcffeb8 0000000000000046 ffffffff80322380 0000009f00000202 
       000001003fcc97d0 0000000000000000 000001003fcc9b08 0000000000000000 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80163e75>{kswapd+261} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8012ed70>{finish_task_switch+64} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8012edce>{schedule_tail+14} <ffffffff80110007>{child_rip+8} 
       <ffffffff8011d180>{flat_send_IPI_mask+0} <ffffffff80163d70>{kswapd+0} 
       <ffffffff8010ffff>{child_rip+0} 
aio/0         S ffffffff8014af30     0    16      9            17    14 (L-TLB)
000001003fd11e58 0000000000000046 ffffffff80322380 0000009f00000000 
       000001003ff01070 0000000000000000 000001003ff013a8 0000000000000000 
       000001003fd11e38 0000000000010000 
Call Trace:<ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff80146941>{worker_thread+305} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014aee9>{kthread+217} <ffffffff80110007>{child_rip+8} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014ae10>{kthread+0} 
       <ffffffff8010ffff>{child_rip+0} 
aio/1         S 0000010001e134a0     0    17      9                  16 (L-TLB)
000001003fd13e58 0000000000000046 000001000214f030 0000009f00000010 
       000001003ff02810 000000013ff02ee8 000001003ff02b48 0000000000000001 
       ffffffff8029cd1d 0000000000000010 
Call Trace:<ffffffff8029cd1d>{_spin_unlock_irq+13} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff80146810>{worker_thread+0} <ffffffff80146941>{worker_thread+305} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff80130d10>{default_wake_function+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff80146810>{worker_thread+0} 
       <ffffffff8014af30>{keventd_create_kthread+0} <ffffffff8014aee9>{kthread+217} 
       <ffffffff80110007>{child_rip+8} <ffffffff8014af30>{keventd_create_kthread+0} 
       <ffffffff8014ae10>{kthread+0} <ffffffff8010ffff>{child_rip+0} 
       
kseriod       S 0000000000000000     0    18      1            19    15 (L-TLB)
000001003fd47eb8 0000000000000046 000001000214f030 0000009f000002fa 
       000001003fcc9030 00000001ffffff00 000001003fcc9368 0000000000000000 
       0000000000000202 000001003fd47e88 
Call Trace:<ffffffff8020f517>{serio_thread+455} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff80110007>{child_rip+8} 
       <ffffffff8020f350>{serio_thread+0} <ffffffff8010ffff>{child_rip+0} 
       
kjournald     S 0000000000000000     0    19      1            20    18 (L-TLB)
000001003f901e58 0000000000000046 000001000214f030 0000009f3f657870 
       000001003ff02070 000000013ff84e98 000001003ff023a8 0000000000000000 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
init          S 000001003f913b40     0    20      1    21     143    19 (NOTLB)
000001003fa85e58 0000000000000006 000001000214f7d0 000000873f9136c0 
       000001003f92b7d0 000000018043c760 000001003f92bb08 ffffffff80167461 
       000001003f92bb10 ffffffff801339a4 
Call Trace:<ffffffff80167461>{handle_mm_fault+369} <ffffffff801339a4>{copy_mm+852} 
       <ffffffff80139e77>{do_wait+3495} <ffffffff8011f24c>{do_page_fault+540} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801433c1>{sys_rt_sigaction+113} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8010f366>{system_call+126} 
       
rcS           S 0000000000000000     0    21     20   418               (NOTLB)
000001003fa99e58 0000000000000006 000001000214f030 0000009f3f912dc0 
       000001003f92b030 000000018043c760 000001003f92b368 0000000000000000 
       000001003f92b370 ffffffff801339a4 
Call Trace:<ffffffff801339a4>{copy_mm+852} <ffffffff80139e77>{do_wait+3495} 
       <ffffffff8011f24c>{do_page_fault+540} <ffffffff80143051>{do_sigaction+577} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801433e4>{sys_rt_sigaction+148} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff8010f366>{system_call+126} 
       
kjournald     S 000001003f5cd6c0     0   143      1           144    20 (L-TLB)
000001003f37be58 0000000000000046 000001003f1b8810 0000008980130d60 
       000001003f1b8070 000000013ff8de98 000001003f1b83a8 0000000000000001 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
kjournald     S 0000010001e1b4a0     0   144      1           145   143 (L-TLB)
000001003ee4de58 0000000000000046 ffffffff80322380 0000009f80130d60 
       000001003f3627d0 000000003ff92298 000001003f362b08 0000000000000001 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
kjournald     S 0000000000000000     0   145      1                 144 (L-TLB)
000001003ee5fe58 0000000000000046 000001000214f030 0000009f80130d60 
       000001003f362030 0000000102170498 000001003f362368 0000000000000000 
       0000000000000246 0000000000000003 
Call Trace:<ffffffff801c34b9>{kjournald+537} <ffffffff8014b530>{autoremove_wake_function+0} 
       <ffffffff8014b530>{autoremove_wake_function+0} <ffffffff801c3280>{commit_timeout+0} 
       <ffffffff80110007>{child_rip+8} <ffffffff801c32a0>{kjournald+0} 
       <ffffffff8010ffff>{child_rip+0} 
rcS           S 000001003fdc1e80     0   418     21                     (NOTLB)
000001003f46bda8 0000000000000006 000001000214f030 0000009f80211303 
       000001003f407810 0000000100000000 000001003f407b48 0000000000000000 
       0000000000000246 ffffffff803b59a0 
Call Trace:<ffffffff801ff4a4>{write_chan+980} <ffffffff801f8dd6>{tty_ldisc_try+70} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801d117d>{__up_read+29} 
       <ffffffff80130d10>{default_wake_function+0} <ffffffff801ff0d0>{write_chan+0} 
       <ffffffff801f95d0>{tty_write+352} <ffffffff801734c7>{vfs_write+199} 
       <ffffffff80173603>{sys_write+83} <ffffffff8010f366>{system_call+126} 
       


