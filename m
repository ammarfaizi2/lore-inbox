Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWJVNdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWJVNdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 09:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWJVNdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 09:33:15 -0400
Received: from 218-185-225-89-broadband.tpnet.co.nz ([218.185.225.89]:57557
	"EHLO whirlpool.medistat.net") by vger.kernel.org with ESMTP
	id S1750910AbWJVNdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 09:33:13 -0400
Message-ID: <453B7308.70307@reub.net>
Date: Sun, 22 Oct 2006 23:32:56 +1000
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 2.0b1pre (Windows/20061021)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [Nasty crash on boot] was Re: 2.6.19-rc2-mm2
References: <20061020015641.b4ed72e5.akpm@osdl.org>
In-Reply-To: <20061020015641.b4ed72e5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/10/2006 6:56 PM, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
> 
> - Added the IOAT tree as git-ioat.patch (Chris Leech)
> 
> - I worked out the git magic to make the wireless tree work
>   (git-wireless.patch).  Hopefully it will be in -mm more often now.

I've just moved country so haven't had anything to test with recently, but built 
up a 2.6.19-rc2-mm2 and it reliably fails to boot.  I'm not sure quite what part 
of the code has gone wrong here, although it blew up not long after ACPI stuff:

root (hd0,0)
  Filesystem type is ext2fs, partition type 0x83
kernel /vmlinuz-2.6.19-rc2-mm2 ro root=/dev/md0 panic=60 console=ttyS0,57600 si
ngle
    [Linux-bzImage, setup=0x1400, size=0x1ed62a]
initrd /initrd-2.6.19-rc2-mm2.img
    [Linux-initrd @ 0x37eba000, 0x1359d9 bytes]

Linux version 2.6.19-rc2-mm2 (root@tornado.reub.net) (gcc version 4.1.1 20061011 
(Red Hat 4.1.1-30)) #1 SMP Fri Oct 20 23:19:53 EST 2006
Command line: ro root=/dev/md0 panic=60 console=ttyS0,57600 single
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003f673000 (usable)
  BIOS-e820: 000000003f673000 - 000000003f6e9000 (ACPI NVS)
  BIOS-e820: 000000003f6e9000 - 000000003f6ec000 (usable)
  BIOS-e820: 000000003f6ec000 - 000000003f6ff000 (ACPI data)
  BIOS-e820: 000000003f6ff000 - 000000003f700000 (usable)
end_pfn_map = 259840
DMI 2.3 present.
Zone PFN ranges:
   DMA             0 ->     4096
   DMA32        4096 ->  1048576
   Normal    1048576 ->  1048576
early_node_map[4] active PFN ranges
     0:        0 ->      159
     0:      256 ->   259699
     0:   259817 ->   259820
     0:   259839 ->   259840
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e0000
Nosave address range: 00000000000e0000 - 0000000000100000
Nosave address range: 000000003f673000 - 000000003f6e9000
Nosave address range: 000000003f6ec000 - 000000003f6ff000
Allocating PCI resources starting at 40000000 (gap: 3f700000:c0900000)
PERCPU: Allocating 33152 bytes of per cpu data
Built 1 zonelists.  Total pages: 253941
Kernel command line: ro root=/dev/md0 panic=60 console=ttyS0,57600 single
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
  memory used by lock dependency info: 1328 kB
  per task-struct memory footprint: 1680 bytes
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
Memory: 1011960k/1039360k available (2543k kernel code, 25824k reserved, 1739k 
data, 240k init)
Calibrating delay using timer specific routine.. 6007.52 BogoMIPS (lpj=12015059)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
Freeing SMP alternatives: 28k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12500398
Detected 12.500 MHz APIC timer.
lockdep: not fixing up alternatives.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6000.33 BogoMIPS (lpj=12000670)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM1)
               Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Brought up 2 CPUs
testing NMI watchdog ... OK.
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 3000.118 MHz processor.
migration_cost=5
checking if image is initramfs... it is
Freeing initrd memory: 1238k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [1] SMP
last sysfs file:
CPU 1
Modules linked in:
Pid: 5, comm: ksoftirqd/1 Not tainted 2.6.19-rc2-mm2 #1
RIP: 0010:[<ffffffff80267849>]  [<ffffffff80267849>] dump_trace+0x3a9/0x422
RSP: 0000:ffff81003f61bbd8  EFLAGS: 00010006
RAX: 0000000000000000 RBX: e203a5a4e203a4a4 RCX: ffffffff805831a0
RDX: ffff810037eb6140 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffff81003f61bd18 R08: 0000000000000002 R09: 0000000000000002
R10: ffffffff8029d801 R11: ffffffff80269149 R12: ffffffff827ffff9
R13: ffff81003f61bfc0 R14: ffffffff8057bb80 R15: ffffffff80727418
FS:  0000000000000000(0000) GS:ffff81003f6eb398(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000000201000 CR4: 00000000000006e0
Process ksoftirqd/1 (pid: 5, threadinfo ffff81003f610000, task ffff810037eb6140)
Stack:  ffff810037eb4040 0000000000000001 ffff81003f61bfc0 000000003f61bd40
  ffffffff80267553 ffffffff80689180 ffffffff804a5074 ffffffff80285ed2
  0000000000000001 ffff81003f601c40 00001025048b4865 0000000000000246
Call Trace:
  [<ffffffff8026c7f7>] save_stack_trace+0x22/0x3e
  [<ffffffff80296de0>] save_trace+0x50/0xf3
  [<ffffffff802980c2>] mark_lock+0x82/0x5ba
  [<ffffffff80298fef>] __lock_acquire+0x43f/0xbd1
  [<ffffffff802997d0>] lock_acquire+0x4f/0x6f
  [<ffffffff80262f82>] _spin_lock+0x25/0x34
  [<ffffffff802bfb18>] cache_flusharray+0x47/0x115
  [<ffffffff8020b381>] kfree+0xe1/0x120
  [<ffffffff80344320>] selinux_task_free_security+0x1e/0x20
  [<ffffffff802470ac>] __put_task_struct+0xb5/0x109
  [<ffffffff802842fe>] delayed_put_task_struct+0x21/0x23
  [<ffffffff80290898>] __rcu_process_callbacks+0x162/0x1ed
  [<ffffffff80290946>] rcu_process_callbacks+0x23/0x44
  [<ffffffff8028601f>] tasklet_action+0x6b/0xc0
  [<ffffffff8021173a>] __do_softirq+0x6f/0xf5
  [<ffffffff8025deec>] call_softirq+0x1c/0x30
  [<ffffffff80285ed2>] ksoftirqd+0x0/0xb9
  [<ffffe04480f76600>]
DWARF2 unwinder stuck at 0xffffe04480f76600
Leftover inexact backtrace:
Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [2] SMP
last sysfs file:
CPU 1
Modules linked in:
Pid: 5, comm: ksoftirqd/1 Not tainted 2.6.19-rc2-mm2 #1
RIP: 0010:[<ffffffff80267849>]  [<ffffffff80267849>] dump_trace+0x3a9/0x422
RSP: 0000:ffff81003f61b7c8  EFLAGS: 00010006
RAX: 0000000000000000 RBX: e203a5a4e203a4a4 RCX: ffffffff805831a0
RDX: 0000000000000000 RSI: 0000000000000020 RDI: e203a5a4e203a4a4
RBP: ffff81003f61b908 R08: ffff8100817a8e00 R09: 0000000000000003
R10: ffffffff802168d0 R11: 0000000000000000 R12: ffffffff827ffff9
R13: ffff81003f61bfc0 R14: ffffffff80579ce0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff81003f6eb398(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000000201000 CR4: 00000000000006e0
Process ksoftirqd/1 (pid: 5, threadinfo ffff81003f610000, task ffff810037eb6140)
Stack:  ffff81003f61b828 0000000000000001 ffff81003f61bfc0 0000000000000011
  ffff81003f617fc0 ffffffff80689180 ffffffff804a5074 ffffffff80285ed2
  0000000000000001 ffff81003f601c40 00001025048b4865 0000000000000246
Call Trace:
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff8026c7f7>] save_stack_trace+0x22/0x3e
  [<ffffffff80296de0>] save_trace+0x50/0xf3
  [<ffffffff802980c2>] mark_lock+0x82/0x5ba
  [<ffffffff80298fef>] __lock_acquire+0x43f/0xbd1
  [<ffffffff802997d0>] lock_acquire+0x4f/0x6f
  [<ffffffff80262f82>] _spin_lock+0x25/0x34
  [<ffffffff802bfb18>] cache_flusharray+0x47/0x115
  [<ffffffff8020b381>] kfree+0xe1/0x120
  [<ffffffff80344320>] selinux_task_free_security+0x1e/0x20
  [<ffffffff802470ac>] __put_task_struct+0xb5/0x109
  [<ffffffff802842fe>] delayed_put_task_struct+0x21/0x23
  [<ffffffff80290898>] __rcu_process_callbacks+0x162/0x1ed
  [<ffffffff80290946>] rcu_process_callbacks+0x23/0x44
  [<ffffffff8028601f>] tasklet_action+0x6b/0xc0
  [<ffffffff8021173a>] __do_softirq+0x6f/0xf5
  [<ffffffff8025deec>] call_softirq+0x1c/0x30
  [<ffffffff80285ed2>] ksoftirqd+0x0/0xb9
  [<ffffe04480f76600>]
DWARF2 unwinder stuck at 0xffffe04480f76600
Leftover inexact backtrace:
Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [3] SMP
last sysfs file:
CPU 1
Modules linked in:
Pid: 5, comm: ksoftirqd/1 Not tainted 2.6.19-rc2-mm2 #1
RIP: 0010:[<ffffffff80267849>]  [<ffffffff80267849>] dump_trace+0x3a9/0x422
RSP: 0000:ffff81003f61b3b8  EFLAGS: 00010006
RAX: 0000000000000000 RBX: e203a5a4e203a4a4 RCX: ffffffff805831a0
RDX: 0000000000000000 RSI: 0000000000000020 RDI: e203a5a4e203a4a4
RBP: ffff81003f61b4f8 R08: ffff8100817a8e00 R09: 0000000000000003
R10: ffffffff802168d0 R11: 0000000000000000 R12: ffffffff827ffff9
R13: ffff81003f61bfc0 R14: ffffffff80579ce0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff81003f6eb398(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000000201000 CR4: 00000000000006e0
Process ksoftirqd/1 (pid: 5, threadinfo ffff81003f610000, task ffff810037eb6140)
Stack:  ffff81003f61b418 0000000000000001 ffff81003f61bfc0 0000000000000011
  ffff81003f617fc0 ffffffff80689180 ffffffff804a5074 ffffffff80285ed2
  0000000000000001 ffff81003f601c40 00001025048b4865 0000000000000246
Call Trace:
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff8026c7f7>] save_stack_trace+0x22/0x3e
  [<ffffffff80296de0>] save_trace+0x50/0xf3
  [<ffffffff802980c2>] mark_lock+0x82/0x5ba
  [<ffffffff80298fef>] __lock_acquire+0x43f/0xbd1
  [<ffffffff802997d0>] lock_acquire+0x4f/0x6f
  [<ffffffff80262f82>] _spin_lock+0x25/0x34
  [<ffffffff802bfb18>] cache_flusharray+0x47/0x115
  [<ffffffff8020b381>] kfree+0xe1/0x120
  [<ffffffff80344320>] selinux_task_free_security+0x1e/0x20
  [<ffffffff802470ac>] __put_task_struct+0xb5/0x109
  [<ffffffff802842fe>] delayed_put_task_struct+0x21/0x23
  [<ffffffff80290898>] __rcu_process_callbacks+0x162/0x1ed
  [<ffffffff80290946>] rcu_process_callbacks+0x23/0x44
  [<ffffffff8028601f>] tasklet_action+0x6b/0xc0
  [<ffffffff8021173a>] __do_softirq+0x6f/0xf5
  [<ffffffff8025deec>] call_softirq+0x1c/0x30
  [<ffffffff80285ed2>] ksoftirqd+0x0/0xb9
  [<ffffe04480f76600>]
DWARF2 unwinder stuck at 0xffffe04480f76600
Leftover inexact backtrace:
Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [4] SMP
last sysfs file:
CPU 1
Modules linked in:
Pid: 5, comm: ksoftirqd/1 Not tainted 2.6.19-rc2-mm2 #1
RIP: 0010:[<ffffffff80267849>]  [<ffffffff80267849>] dump_trace+0x3a9/0x422
RSP: 0000:ffff81003f61afa8  EFLAGS: 00010006
RAX: 0000000000000000 RBX: e203a5a4e203a4a4 RCX: ffffffff805831a0
RDX: 0000000000000000 RSI: 0000000000000020 RDI: e203a5a4e203a4a4
RBP: ffff81003f61b0e8 R08: ffff8100817a8e00 R09: 0000000000000003
R10: ffffffff802168d0 R11: 0000000000000000 R12: ffffffff827ffff9
R13: ffff81003f61bfc0 R14: ffffffff80579ce0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff81003f6eb398(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000000201000 CR4: 00000000000006e0
Process ksoftirqd/1 (pid: 5, threadinfo ffff81003f610000, task ffff810037eb6140)
Stack:  ffff81003f61b008 0000000000000001 ffff81003f61bfc0 0000000000000011
  ffff81003f617fc0 ffffffff80689180 ffffffff804a5074 ffffffff80285ed2
  0000000000000001 ffff81003f601c40 00001025048b4865 0000000000000246
Call Trace:
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff8026c7f7>] save_stack_trace+0x22/0x3e
  [<ffffffff80296de0>] save_trace+0x50/0xf3
  [<ffffffff802980c2>] mark_lock+0x82/0x5ba
  [<ffffffff80298fef>] __lock_acquire+0x43f/0xbd1
  [<ffffffff802997d0>] lock_acquire+0x4f/0x6f
  [<ffffffff80262f82>] _spin_lock+0x25/0x34
  [<ffffffff802bfb18>] cache_flusharray+0x47/0x115
  [<ffffffff8020b381>] kfree+0xe1/0x120
  [<ffffffff80344320>] selinux_task_free_security+0x1e/0x20
  [<ffffffff802470ac>] __put_task_struct+0xb5/0x109
  [<ffffffff802842fe>] delayed_put_task_struct+0x21/0x23
  [<ffffffff80290898>] __rcu_process_callbacks+0x162/0x1ed
  [<ffffffff80290946>] rcu_process_callbacks+0x23/0x44
  [<ffffffff8028601f>] tasklet_action+0x6b/0xc0
  [<ffffffff8021173a>] __do_softirq+0x6f/0xf5
  [<ffffffff8025deec>] call_softirq+0x1c/0x30
  [<ffffffff80285ed2>] ksoftirqd+0x0/0xb9
  [<ffffe04480f76600>]
DWARF2 unwinder stuck at 0xffffe04480f76600
Leftover inexact backtrace:
Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [5] SMP
last sysfs file:
CPU 1
Modules linked in:
Pid: 5, comm: ksoftirqd/1 Not tainted 2.6.19-rc2-mm2 #1
RIP: 0010:[<ffffffff80267849>]  [<ffffffff80267849>] dump_trace+0x3a9/0x422
RSP: 0000:ffff81003f61ab98  EFLAGS: 00010006
RAX: 0000000000000000 RBX: e203a5a4e203a4a4 RCX: ffffffff805831a0
RDX: 0000000000000000 RSI: 0000000000000020 RDI: e203a5a4e203a4a4
RBP: ffff81003f61acd8 R08: ffff8100817a8e00 R09: 0000000000000003
R10: ffffffff802168d0 R11: 0000000000000000 R12: ffffffff827ffff9
R13: ffff81003f61bfc0 R14: ffffffff80579ce0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff81003f6eb398(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000000201000 CR4: 00000000000006e0
Process ksoftirqd/1 (pid: 5, threadinfo ffff81003f610000, task ffff810037eb6140)
Stack:  ffff81003f61abf8 0000000000000001 ffff81003f61bfc0 0000000000000011
  ffff81003f617fc0 ffffffff80689180 ffffffff804a5074 ffffffff80285ed2
  0000000000000001 ffff81003f601c40 00001025048b4865 0000000000000246
Call Trace:
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff8026c7f7>] save_stack_trace+0x22/0x3e
  [<ffffffff80296de0>] save_trace+0x50/0xf3
  [<ffffffff802980c2>] mark_lock+0x82/0x5ba
  [<ffffffff80298fef>] __lock_acquire+0x43f/0xbd1
  [<ffffffff802997d0>] lock_acquire+0x4f/0x6f
  [<ffffffff80262f82>] _spin_lock+0x25/0x34
  [<ffffffff802bfb18>] cache_flusharray+0x47/0x115
  [<ffffffff8020b381>] kfree+0xe1/0x120
  [<ffffffff80344320>] selinux_task_free_security+0x1e/0x20
  [<ffffffff802470ac>] __put_task_struct+0xb5/0x109
  [<ffffffff802842fe>] delayed_put_task_struct+0x21/0x23
  [<ffffffff80290898>] __rcu_process_callbacks+0x162/0x1ed
  [<ffffffff80290946>] rcu_process_callbacks+0x23/0x44
  [<ffffffff8028601f>] tasklet_action+0x6b/0xc0
  [<ffffffff8021173a>] __do_softirq+0x6f/0xf5
  [<ffffffff8025deec>] call_softirq+0x1c/0x30
  [<ffffffff80285ed2>] ksoftirqd+0x0/0xb9
  [<ffffe04480f76600>]
DWARF2 unwinder stuck at 0xffffe04480f76600
Leftover inexact backtrace:
Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [6] SMP
last sysfs file:
CPU 1
Modules linked in:
Pid: 5, comm: ksoftirqd/1 Not tainted 2.6.19-rc2-mm2 #1
RIP: 0010:[<ffffffff80267849>]  [<ffffffff80267849>] dump_trace+0x3a9/0x422
RSP: 0000:ffff81003f61a788  EFLAGS: 00010006
RAX: 0000000000000000 RBX: e203a5a4e203a4a4 RCX: ffffffff805831a0
RDX: 0000000000000000 RSI: 0000000000000020 RDI: e203a5a4e203a4a4
RBP: ffff81003f61a8c8 R08: ffff8100817a8e00 R09: 0000000000000003
R10: ffffffff802168d0 R11: 0000000000000000 R12: ffffffff827ffff9
R13: ffff81003f61bfc0 R14: ffffffff80579ce0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff81003f6eb398(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000000201000 CR4: 00000000000006e0
Process ksoftirqd/1 (pid: 5, threadinfo ffff81003f610000, task ffff810037eb6140)
Stack:  ffff81003f61a7e8 0000000000000001 ffff81003f61bfc0 0000000000000011
  ffff81003f617fc0 ffffffff80689180 ffffffff804a5074 ffffffff80285ed2
  0000000000000001 ffff81003f601c40 00001025048b4865 0000000000000246
Call Trace:
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff8026c7f7>] save_stack_trace+0x22/0x3e
  [<ffffffff80296de0>] save_trace+0x50/0xf3
  [<ffffffff802980c2>] mark_lock+0x82/0x5ba
  [<ffffffff80298fef>] __lock_acquire+0x43f/0xbd1
  [<ffffffff802997d0>] lock_acquire+0x4f/0x6f
  [<ffffffff80262f82>] _spin_lock+0x25/0x34
  [<ffffffff802bfb18>] cache_flusharray+0x47/0x115
  [<ffffffff8020b381>] kfree+0xe1/0x120
  [<ffffffff80344320>] selinux_task_free_security+0x1e/0x20
  [<ffffffff802470ac>] __put_task_struct+0xb5/0x109
  [<ffffffff802842fe>] delayed_put_task_struct+0x21/0x23
  [<ffffffff80290898>] __rcu_process_callbacks+0x162/0x1ed
  [<ffffffff80290946>] rcu_process_callbacks+0x23/0x44
  [<ffffffff8028601f>] tasklet_action+0x6b/0xc0
  [<ffffffff8021173a>] __do_softirq+0x6f/0xf5
  [<ffffffff8025deec>] call_softirq+0x1c/0x30
  [<ffffffff80285ed2>] ksoftirqd+0x0/0xb9
  [<ffffe04480f76600>]
DWARF2 unwinder stuck at 0xffffe04480f76600
Leftover inexact backtrace:
Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [7] SMP
last sysfs file:
CPU 1
Modules linked in:
Pid: 5, comm: ksoftirqd/1 Not tainted 2.6.19-rc2-mm2 #1
RIP: 0010:[<ffffffff80267849>]  [<ffffffff80267849>] dump_trace+0x3a9/0x422
RSP: 0000:ffff81003f61a378  EFLAGS: 00010006
RAX: 0000000000000000 RBX: e203a5a4e203a4a4 RCX: ffffffff805831a0
RDX: 0000000000000000 RSI: 0000000000000020 RDI: e203a5a4e203a4a4
RBP: ffff81003f61a4b8 R08: ffff8100817a8e00 R09: 0000000000000003
R10: ffffffff802168d0 R11: 0000000000000000 R12: ffffffff827ffff9
R13: ffff81003f61bfc0 R14: ffffffff80579ce0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff81003f6eb398(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000000201000 CR4: 00000000000006e0
Process ksoftirqd/1 (pid: 5, threadinfo ffff81003f610000, task ffff810037eb6140)
Stack:  ffff81003f61a3d8 0000000000000001 ffff81003f61bfc0 0000000000000011
  ffff81003f617fc0 ffffffff80689180 ffffffff804a5074 ffffffff80285ed2
  0000000000000001 ffff81003f601c40 00001025048b4865 0000000000000246
Call Trace:
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff8026c7f7>] save_stack_trace+0x22/0x3e
  [<ffffffff80296de0>] save_trace+0x50/0xf3
  [<ffffffff802980c2>] mark_lock+0x82/0x5ba
  [<ffffffff80298fef>] __lock_acquire+0x43f/0xbd1
  [<ffffffff802997d0>] lock_acquire+0x4f/0x6f
  [<ffffffff80262f82>] _spin_lock+0x25/0x34
  [<ffffffff802bfb18>] cache_flusharray+0x47/0x115
  [<ffffffff8020b381>] kfree+0xe1/0x120
  [<ffffffff80344320>] selinux_task_free_security+0x1e/0x20
  [<ffffffff802470ac>] __put_task_struct+0xb5/0x109
  [<ffffffff802842fe>] delayed_put_task_struct+0x21/0x23
  [<ffffffff80290898>] __rcu_process_callbacks+0x162/0x1ed
  [<ffffffff80290946>] rcu_process_callbacks+0x23/0x44
  [<ffffffff8028601f>] tasklet_action+0x6b/0xc0
  [<ffffffff8021173a>] __do_softirq+0x6f/0xf5
  [<ffffffff8025deec>] call_softirq+0x1c/0x30
  [<ffffffff80285ed2>] ksoftirqd+0x0/0xb9
  [<ffffe04480f76600>]
DWARF2 unwinder stuck at 0xffffe04480f76600
Leftover inexact backtrace:
Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [8] SMP
last sysfs file:
CPU 1
Modules linked in:
Pid: 5, comm: ksoftirqd/1 Not tainted 2.6.19-rc2-mm2 #1
RIP: 0010:[<ffffffff80267849>]  [<ffffffff80267849>] dump_trace+0x3a9/0x422
RSP: 0000:ffff81003f619f68  EFLAGS: 00010006
RAX: 0000000000000000 RBX: e203a5a4e203a4a4 RCX: ffffffff805831a0
RDX: 0000000000000000 RSI: 0000000000000020 RDI: e203a5a4e203a4a4
RBP: ffff81003f61a0a8 R08: ffff8100817a8e00 R09: 0000000000000003
R10: ffffffff802168d0 R11: 0000000000000000 R12: ffffffff827ffff9
R13: ffff81003f61bfc0 R14: ffffffff80579ce0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff81003f6eb398(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000000201000 CR4: 00000000000006e0
Process ksoftirqd/1 (pid: 5, threadinfo ffff81003f610000, task ffff810037eb6140)
Stack:  ffff81003f619fc8 0000000000000001 ffff81003f61bfc0 0000000000000011
  ffff81003f617fc0 ffffffff80689180 ffffffff804a5074 ffffffff80285ed2
  0000000000000001 ffff81003f601c40 00001025048b4865 0000000000000246
Call Trace:
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff802678fe>] show_trace+0x3c/0x55
  [<ffffffff80267a1f>] _show_stack+0xef/0xfe
  [<ffffffff80267abc>] show_registers+0x8e/0x103
  [<ffffffff80267c7e>] __die+0xa0/0xda
  [<ffffffff8020adbb>] do_page_fault+0x7bb/0x8ce
  [<ffffffff8026352d>] error_exit+0x0/0x96
  [<ffffffff80267849>] dump_trace+0x3a9/0x422
  [<ffffffff8026c7f7>] save_stack_trace+0x22/0x3e
  [<ffffffff80296de0>] save_trace+0x50/0xf3
  [<ffffffff802980c2>] mark_lock+0x82/0x5ba
  [<ffffffff80298fef>] __lock_acquire+0x43f/0xbd1
  [<ffffffff802997d0>] lock_acquire+0x4f/0x6f
  [<ffffffff80262f82>] _spin_lock+0x25/0x34
  [<ffffffff802bfb18>] cache_flusharray+0x47/0x115
  [<ffffffff8020b381>] kfree+0xe1/0x120
  [<ffffffff80344320>] selinux_task_free_security+0x1e/0x20
  [<ffffffff802470ac>] __put_task_struct+0xb5/0x109
  [<ffffffff802842fe>] delayed_put_task_struct+0x21/0x23
  [<ffffffff80290898>] __rcu_proces


Box is a 3.0GHZ x86_64 with 1GB DRAM built with Fedora Core rawhide.

2.6.19-rc1-mm1 is the last release that works OK and is stable for me, but I 
haven't tested any releases between that and this one.  If it's useful I can 
spend some time on this trying it out this week.

Reuben
