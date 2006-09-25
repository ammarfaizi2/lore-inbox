Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWIYUwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWIYUwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWIYUwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:52:13 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:20878 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP
	id S1750710AbWIYUwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:52:11 -0400
Date: Mon, 25 Sep 2006 22:52:05 +0200
From: Arne Ahrend <aahrend@web.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-git4 crashes in sata_via
Message-Id: <20060925225205.a4e0a2d3.aahrend@web.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

don't know if this is of any interest, but on my Athlon64 2.6.18-git4 (like -git3) crashes on startup when initializing
the SATA ports. The machine does not actually have any SATA disks installed, but I compile in sata_via support anyway (and pata_via, of course).
Alans pata_via driver has been working for me on various kernels without any issues for half a year now.

Cheers,
	Arne



Bootdata ok (command line is root=/dev/sda1 ro console=ttyS1,9600e7r)
Linux version 2.6.18-git4 (root@phoenix) (gcc version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)) #1 PREEMPT Mon Sep 25 19:09:05 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bf780000)
Built 1 zonelists.  Total pages: 256749
Kernel command line: root=/dev/sda1 ro console=ttyS1,9600e7r
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 1802.320 MHz processor.
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 1120 kB
 per task-struct memory footprint: 1680 bytes
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |  ok  |
           recursive read-lock #2:             |  ok  |             |  ok  |
            mixed read-write-lock:             |  ok  |             |  ok  |
            mixed write-read-lock:             |  ok  |             |  ok  |
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
-------------------------------------------------------
Good, all 218 testcases passed! |
---------------------------------
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
CPU 0: aperture @ d0000000 size 256 MB
Memory: 1025008k/1048256k available (1863k kernel code, 22552k reserved, 964k data, 160k init)
Calibrating delay using timer specific routine.. 3607.80 BogoMIPS (lpj=1803901)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 02
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12516120
Detected 12.516 MHz APIC timer.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: enabled onboard AC97/MC97 devices
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14<7>Losing some ticks... checking if CPU frequency changed.
 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 256M @ 0xd0000000
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: fbd00000-fbffffff
  PREFETCH window: e8000000-faffffff
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 32768 (order: 9, 2359296 bytes)
TCP bind hash table entries: 16384 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 32768 bind 16384)
TCP reno registered
io scheduler noop registered
io scheduler cfq registered (default)
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.25 MHz
radeonfb: PLL min 20000 max 40000
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type CRT found
radeonfb: EDID probed
Console: switching to colour frame buffer device 240x75
radeonfb (0000:01:00.0): ATI Radeon Ya 
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
sata_via 0000:00:0f.0: routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB000 irq 17
general protection fault: 0000 [1] PREEMPT 
CPU 0 
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.18-git4 #1
RIP: 0010:[<ffffffff8027185e>]  [<ffffffff8027185e>] ata_port_init+0x64/0x24a
RSP: 0000:ffff810001fc1c60  EFLAGS: 00010286
RAX: 82ff810001fc1d50 RBX: ffff81003fdac7e8 RCX: 0000000000000001
RDX: ffff81003fdcf800 RSI: ffff81003fd63380 RDI: ffff81003fdac7e8
RBP: ffff810001fc1c90 R08: 0000000000008040 R09: 0000000000000000
R10: ffffffff8015c7a3 R11: ffffffff8015c7a3 R12: 0000000000000001
R13: 0000000000000001 R14: ffff81003fdcf800 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffffffff80723000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006a0
Process swapper (pid: 1, threadinfo ffff810001fc0000, task ffff810001fab040)
Stack:  ffff810001fc1c90 ffff81003fdac000 0000000000000001 0000000000000001
 ffff81003fdac7e8 ffff81003fdcf800 ffff810001fc1d00 ffffffff8027632f
 ffff810001fc1cd0 ffff81003fd63380 ffff81003ff5a870 000000113fdcf800
Call Trace:
 [<ffffffff8027632f>] ata_device_add+0x100/0x4e5
 [<ffffffff8027c91e>] svia_init_one+0x4cd/0x527
 [<ffffffff80154823>] kobject_get+0x1a/0x21
 [<ffffffff801fae36>] pci_device_probe+0x4c/0x74
 [<ffffffff80261f79>] driver_probe_device+0x5c/0xb7
 [<ffffffff80262047>] __driver_attach+0x0/0x98
 [<ffffffff80262096>] __driver_attach+0x4f/0x98
 [<ffffffff80261992>] bus_for_each_dev+0x49/0x7a
 [<ffffffff80261ea3>] driver_attach+0x1c/0x1e
 [<ffffffff802615a6>] bus_add_driver+0x89/0x138
 [<ffffffff802622ef>] driver_register+0x8f/0x93
 [<ffffffff801faff5>] __pci_register_driver+0x63/0x86
 [<ffffffff8074aa60>] svia_init+0x12/0x14
 [<ffffffff80162812>] init+0xbc/0x28a
 [<ffffffff8018b23b>] trace_hardirqs_on+0x100/0x124
 [<ffffffff801595f0>] child_rip+0xa/0x12
 [<ffffffff8015f638>] _spin_unlock_irq+0x2b/0x57
 [<ffffffff80159060>] restore_args+0x0/0x30
 [<ffffffff8021f4c7>] acpi_os_acquire_lock+0x9/0xb
 [<ffffffff80162756>] init+0x0/0x28a
 [<ffffffff801595e6>] child_rip+0x0/0x12


Code: 48 8b 40 10 89 87 cc 00 00 00 48 8b 82 38 04 00 00 48 8b 40 
RIP  [<ffffffff8027185e>] ata_port_init+0x64/0x24a
 RSP <ffff810001fc1c60>
 <0>Kernel panic - not syncing: Attempted to kill init!
 
