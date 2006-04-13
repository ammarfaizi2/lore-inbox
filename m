Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964769AbWDMRTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbWDMRTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 13:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964771AbWDMRTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 13:19:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:7177 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964769AbWDMRTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 13:19:48 -0400
X-IronPort-AV: i="4.04,118,1144047600"; 
   d="scan'208"; a="22907524:sNHT67358592"
Date: Thu, 13 Apr 2006 10:19:42 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: davej@codemonkey.org.uk, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture independent manner V2
Message-ID: <20060413171942.GA15047@agluck-lia64.sc.intel.com>
References: <20060412232036.18862.84118.sendpatchset@skynet> <20060413095207.GA4047@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413095207.GA4047@skynet.ie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 10:52:08AM +0100, Mel Gorman wrote:
> I didn't look at the test program output carefully enough! There was a
> double counting of some holes because of a missing "if" - obvious in the
> morning. Fix is this (applies on top of the debugging patch)

Back to not booting with tiger_defconfig on Intel Tiger box :-(

There are no lines like:

	On node 0 totalpages: 260725
	  DMA zone: 129700 pages, LIFO batch:7
	  Normal zone: 131025 pages, LIFO batch:7

in the log ... which might explain the OOM later.

Whole console log appended (The "Kill process 2" messages repeat
forever).

-Tony


Linux version 2.6.17-rc1-tiger-smpxx (aegl@linux-t10) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.1)) #2 SMP Thu Apr 13 09:54:33 PDT 2006
EFI v1.10 by INTEL: SALsystab=0x7fe54980 ACPI=0x7ff84000 ACPI 2.0=0x7ff83000 MPS=0x7ff82000 SMBIOS=0xf0000
Early serial console at I/O port 0x2f8 (options '115200')
Initial ramdisk at: 0xe0000001fedf5000 (1303557 bytes)
SAL 3.20: Intel Corp                       SR870BN4                         version 3.0
SAL Platform features: BusLock IRQ_Redirection
SAL: AP wakeup using external interrupt vector 0xf0
No logical to physical processor mapping available
iosapic_system_init: Disabling PC-AT compatible 8259 interrupts
ACPI: Local APIC address c0000000fee00000
PLATFORM int CPEI (0x3): GSI 22 (level, low) -> CPU 0 (0xc618) vector 30
register_intr: changing vector 39 from IO-SAPIC-edge to IO-SAPIC-level
4 CPUs available, 4 CPUs total
MCA related initialization done
add_active_range(0, 1024, 130688): New
add_active_range(0, 130984, 131020): New
add_active_range(0, 393216, 524164): New
add_active_range(0, 524192, 524269): New
free_area_init_nodes(262144, 262144, 524269, 524269)
free_area_init_nodes(): find_min_pfn = 1024
Dumping sorted node map
entry 0: 0  1024 -> 130688
entry 1: 0  130984 -> 131020
entry 2: 0  393216 -> 524164
entry 3: 0  524192 -> 524269
Hole found index 1: 130688 -> 130984
Hole found index 2: 131020 -> 262144
Hole found index 2: 131020 -> 393216
Hole found index 3: 524164 -> 524192
Hole found index 1: 130688 -> 130984
Hole found index 2: 131020 -> 262144
Hole found index 2: 131020 -> 393216
Hole found index 3: 524164 -> 524192
Virtual mem_map starts at 0xa0007ffffe400000
SMP: Allowing 4 CPUs, 0 hotplug CPUs
Built 1 zonelists
Kernel command line: BOOT_IMAGE=scsi0:EFI\redhat\l-tiger-smpxx.gz  root=LABEL=/ console=uart,io,0x2f8 ro
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 7, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 6, 1048576 bytes)
Placing software IO TLB between 0x4a84000 - 0x8a84000
Memory: 4073632k/4171600k available (6832k code, 96720k reserved, 2753k data, 256k init)
McKinley Errata 9 workaround not needed; disabling it
Mount-cache hash table entries: 1024
Boot processor id 0x0/0xc618
Fixed BSP b0 value from CPU 1
CPU 1: synchronized ITC with CPU 0 (last diff -10 cycles, maxerr 611 cycles)
CPU 2: synchronized ITC with CPU 0 (last diff 10 cycles, maxerr 593 cycles)
CPU 3: synchronized ITC with CPU 0 (last diff 10 cycles, maxerr 593 cycles)
Brought up 4 CPUs
Total of 4 processors activated (10158.08 BogoMIPS).
migration_cost=9941
checking if image is initramfs... it is
Freeing initrd memory: 1248kB freed
DMI 2.3 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOSAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0c00-0c7f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
ACPI: PCI Root Bridge [PCI1] (0000:02)
ACPI: PCI Root Bridge [PCI3] (0000:09)
ACPI: PCI Root Bridge [PCI4] (0000:0f)
ACPI: Device [CSFF] status [00000008]: functional but not present; setting present
ACPI: PCI Root Bridge [CSFF] (0000:ff)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
perfmon: version 2.0 IRQ 238
perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
PAL Information Facility v0.5
perfmon: added sampling format default_format
perfmon_default_smpl: default_format v2.0 registered
oom-killer: gfp_mask=0xd0, order=1

Call Trace:
 [<a0000001000117f0>] show_stack+0x50/0xa0
                                sp=e0000001816577c0 bsp=e000000181651328
 [<a000000100011870>] dump_stack+0x30/0x60
                                sp=e000000181657990 bsp=e000000181651310
 [<a0000001000dd330>] out_of_memory+0x70/0x380
                                sp=e000000181657990 bsp=e0000001816512b8
 [<a0000001000e03b0>] __alloc_pages+0x3d0/0x520
                                sp=e0000001816579b0 bsp=e000000181651250
 [<a0000001000e05c0>] __get_free_pages+0xc0/0x180
                                sp=e0000001816579c0 bsp=e000000181651228
 [<a00000010007d2f0>] dup_task_struct+0x30/0x140
                                sp=e0000001816579c0 bsp=e0000001816511f0
 [<a00000010007f0c0>] copy_process+0x80/0x1c20
                                sp=e0000001816579c0 bsp=e000000181651120
 [<a000000100080ee0>] do_fork+0x1c0/0x3a0
                                sp=e0000001816579c0 bsp=e0000001816510c0
 [<a000000100013aa0>] kernel_thread+0x160/0x180
                                sp=e0000001816579e0 bsp=e000000181651088
 [<a0000001000b4f00>] keventd_create_kthread+0x40/0x100
                                sp=e000000181657db0 bsp=e000000181651050
 [<a0000001000abb10>] run_workqueue+0x1f0/0x2a0
                                sp=e000000181657db0 bsp=e000000181651008
 [<a0000001000abd80>] worker_thread+0x1c0/0x260
                                sp=e000000181657db0 bsp=e000000181650fc0
 [<a0000001000b4e40>] kthread+0x180/0x200
                                sp=e000000181657e20 bsp=e000000181650f88
 [<a000000100013b90>] kernel_thread_helper+0xd0/0x100
                                sp=e000000181657e30 bsp=e000000181650f60
 [<a0000001000094c0>] start_kernel_thread+0x20/0x40
                                sp=e000000181657e30 bsp=e000000181650f60
Mem-info:
DMA per-cpu:
cpu 0 hot: high 42, batch 7 used:37
cpu 0 cold: high 14, batch 3 used:0
cpu 1 hot: high 42, batch 7 used:0
cpu 1 cold: high 14, batch 3 used:0
cpu 2 hot: high 42, batch 7 used:0
cpu 2 cold: high 14, batch 3 used:0
cpu 3 hot: high 42, batch 7 used:0
cpu 3 cold: high 14, batch 3 used:0
DMA32 per-cpu: empty
Normal per-cpu:
cpu 0 hot: high 42, batch 7 used:8
cpu 0 cold: high 14, batch 3 used:0
cpu 1 hot: high 42, batch 7 used:29
cpu 1 cold: high 14, batch 3 used:0
cpu 2 hot: high 42, batch 7 used:40
cpu 2 cold: high 14, batch 3 used:0
oom-killer: gfp_mask=0x200d2, order=0

Call Trace:
 [<a0000001000117f0>] show_stack+0x50/0xa0
                                sp=e0000001ff927b70 bsp=e0000001ff921270
 [<a000000100011870>] dump_stack+0x30/0x60
                                sp=e0000001ff927d40 bsp=e0000001ff921258
 [<a0000001000dd330>] out_of_memory+0x70/0x380
                                sp=e0000001ff927d40 bsp=e0000001ff921200
 [<a0000001000e03b0>] __alloc_pages+0x3d0/0x520
                                sp=e0000001ff927d60 bsp=e0000001ff921190
 [<a0000001000f47a0>] do_wp_page+0x2c0/0x740
                                sp=e0000001ff927d70 bsp=e0000001ff921120
 [<a0000001000f6c90>] __handle_mm_fault+0x12b0/0x13c0
                                sp=e0000001ff927d70 bsp=e0000001ff921088
 [<a000000100058fd0>] ia64_do_page_fault+0x230/0xa00
                                sp=e0000001ff927d80 bsp=e0000001ff921030
 [<a00000010000c360>] ia64_leave_kernel+0x0/0x280
                                sp=e0000001ff927e30 bsp=e0000001ff921030
Mem-info:
DMA per-cpu:
cpu 0 hot: high 42, batch 7 used:37
cpu 0 cold: high 14, batch 3 used:0
cpu 1 hot: high 42, batch 7 used:0
cpu 1 cold: high 14, batch 3 used:0
cpu 2 hot: high 42, batch 7 used:0
cpu 2 cold: high 14, batch 3 used:0
cpu 3 hot: high 42, batch 7 used:0
cpu 3 cold: high 14, batch 3 used:0
DMA32 per-cpu: empty
Normal per-cpu:
cpu 0 hot: high 42, batch 7 used:8
cpu 0 cold: high 14, batch 3 used:0
cpu 1 hot: high 42, batch 7 used:29
cpu 1 cold: high 14, batch 3 used:0
cpu 2 hot: high 42, batch 7 used:40
cpu 2 cold: high 14, batch 3 used:0
cpu 3 hot: high 42, batch 7 used:2
cpu 3 cold: high 14, batch 3 used:0
HighMem per-cpu: empty
Free pages:     4055248kB (0kB HighMem)
Active:151 inactive:62 dirty:0 writeback:0 unstable:0 free:253453 slab:243 mapped:55 pagetables:8
DMA free:1998256kB min:5760kB low:7200kB high:8640kB active:0kB inactive:0kB present:2075200kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 72057594037927935 72057594037927935
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 72057594037927935 72057594037927935
Normal free:2056992kB min:2277358239360432kB low:2846697799200528kB high:3416037359040640kB active:2416kB inactive:992kB present:18446744073709550032kB pages_scanned:994 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:512kB low:512kB high:512kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 3*16kB 2*32kB 1*64kB 2*128kB 2*256kB 1*512kB 2*1024kB 2*2048kB 2*4096kB 2*8192kB 2*16384kB 3*32768kB 2*65536kB 1*131072kB 2*262144kB 2*524288kB 0*1048576kB = 1998256kB
DMA32: empty
Normal: 0*16kB 39*32kB 11*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 1*4096kB 2*8192kB 0*16384kB 2*32768kB 2*65536kB 2*131072kB 2*262144kB 2*524288kB 0*1048576kB = 2056992kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
261247 pages of RAM
6488 reserved pages
45 pages shared
0 pages swap cached
644 pages in page table cache
Out of Memory: Kill process 274 (udev) score 7 and children.
Out of memory: Killed process 274 (udev).
hotplug: page allocation failure. order:0, mode:0x20

Call Trace:
 [<a0000001000117f0>] show_stack+0x50/0xa0
                                sp=e0000001ff927b60 bsp=e0000001ff921540
 [<a000000100011870>] dump_stack+0x30/0x60
                                sp=e0000001ff927d30 bsp=e0000001ff921528
 [<a0000001000e04b0>] __alloc_pages+0x4d0/0x520
                                sp=e0000001ff927d30 bsp=e0000001ff9214c0
 [<a0000001001173d0>] cache_alloc_refill+0x790/0xde0
                                sp=e0000001ff927d40 bsp=e0000001ff921448
 [<a000000100116be0>] kmem_cache_alloc+0xa0/0x100
                                sp=e0000001ff927d40 bsp=e0000001ff921420
 [<a00000010009e110>] __sigqueue_alloc+0xb0/0x160
                                sp=e0000001ff927d40 bsp=e0000001ff9213e8
 [<a00000010009f200>] send_signal+0x80/0x2a0
                                sp=e0000001ff927d40 bsp=e0000001ff9213b0
 [<a00000010009f580>] specific_send_sig_info+0x160/0x1e0
                                sp=e0000001ff927d40 bsp=e0000001ff921378
 [<a00000010009f6e0>] force_sig_info+0xe0/0x120
                                sp=e0000001ff927d40 bsp=e0000001ff921338
 [<a0000001000a01f0>] force_sig+0x30/0x60
                                sp=e0000001ff927d40 bsp=e0000001ff921310
 [<a0000001000dcf60>] __oom_kill_task+0x240/0x260
                                sp=e0000001ff927d40 bsp=e0000001ff9212d8
 [<a0000001000dd010>] oom_kill_task+0x90/0x1e0
                                sp=e0000001ff927d40 bsp=e0000001ff921290
 [<a0000001000dd290>] oom_kill_process+0x130/0x160
                                sp=e0000001ff927d40 bsp=e0000001ff921258
 [<a0000001000dd5b0>] out_of_memory+0x2f0/0x380
                                sp=e0000001ff927d40 bsp=e0000001ff921200
 [<a0000001000e03b0>] __alloc_pages+0x3d0/0x520
                                sp=e0000001ff927d60 bsp=e0000001ff921190
 [<a0000001000f47a0>] do_wp_page+0x2c0/0x740
                                sp=e0000001ff927d70 bsp=e0000001ff921120
 [<a0000001000f6c90>] __handle_mm_fault+0x12b0/0x13c0
                                sp=e0000001ff927d70 bsp=e0000001ff921088
 [<a000000100058fd0>] ia64_do_page_fault+0x230/0xa00
                                sp=e0000001ff927d80 bsp=e0000001ff921030
 [<a00000010000c360>] ia64_leave_kernel+0x0/0x280
                                sp=e0000001ff927e30 bsp=e0000001ff921030
Mem-info:
DMA per-cpu:
cpu 0 hot: high 42, batch 7 used:37
cpu 0 cold: high 14, batch 3 used:0
cpu 1 hot: high 42, batch 7 used:0
cpu 1 cold: high 14, batch 3 used:0
cpu 2 hot: high 42, batch 7 used:0
cpu 2 cold: high 14, batch 3 used:0
cpu 3 hot: high 42, batch 7 used:0
cpu 3 cold: high 14, batch 3 used:0
DMA32 per-cpu: empty
Normal per-cpu:
cpu 0 hot: high 42, batch 7 used:8
cpu 0 cold: high 14, batch 3 used:0
cpu 1 hot: high 42, batch 7 used:29
cpu 1 cold: high 14, batch 3 used:0
cpu 2 hot: high 42, batch 7 used:40
cpu 2 cold: high 14, batch 3 used:0
cpu 3 hot: high 42, batch 7 used:2
cpu 3 cold: high 14, batch 3 used:0
HighMem per-cpu: empty
Free pages:     4055248kB (0kB HighMem)
Active:151 inactive:62 dirty:0 writeback:0 unstable:0 free:253453 slab:243 mapped:55 pagetables:8
DMA free:1998256kB min:5760kB low:7200kB high:8640kB active:0kB inactive:0kB present:2075200kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 72057594037927935 72057594037927935
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 72057594037927935 72057594037927935
Normal free:2056992kB min:2277358239360432kB low:2846697799200528kB high:3416037359040640kB active:2416kB inactive:992kB present:18446744073709550032kB pages_scanned:994 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:512kB low:512kB high:512kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 3*16kB 2*32kB 1*64kB 2*128kB 2*256kB 1*512kB 2*1024kB 2*2048kB 2*4096kB 2*8192kB 2*16384kB 3*32768kB 2*65536kB 1*131072kB 2*262144kB 2*524288kB 0*1048576kB = 1998256kB
DMA32: empty
Normal: 0*16kB 39*32kB 11*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 1*4096kB 2*8192kB 0*16384kB 2*32768kB 2*65536kB 2*131072kB 2*262144kB 2*524288kB 0*1048576kB = 2056992kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
261247 pages of RAM
6488 reserved pages
45 pages shared
0 pages swap cached
644 pages in page table cache
oom-killer: gfp_mask=0x280d2, order=0

Call Trace:
 [<a0000001000117f0>] show_stack+0x50/0xa0
                                sp=e0000001ff8c7b70 bsp=e0000001ff8c1268
 [<a000000100011870>] dump_stack+0x30/0x60
                                sp=e0000001ff8c7d40 bsp=e0000001ff8c1250
 [<a0000001000dd330>] out_of_memory+0x70/0x380
                                sp=e0000001ff8c7d40 bsp=e0000001ff8c11f0
 [<a0000001000e03b0>] __alloc_pages+0x3d0/0x520
                                sp=e0000001ff8c7d60 bsp=e0000001ff8c1188
 [<a0000001000f5ce0>] __handle_mm_fault+0x300/0x13c0
                                sp=e0000001ff8c7d70 bsp=e0000001ff8c10f0
 [<a000000100058fd0>] ia64_do_page_fault+0x230/0xa00
                                sp=e0000001ff8c7d80 bsp=e0000001ff8c1098
 [<a00000010000c360>] ia64_leave_kernel+0x0/0x280
                                sp=e0000001ff8c7e30 bsp=e0000001ff8c1098
Mem-info:
DMA per-cpu:
cpu 0 hot: high 42, batch 7 used:37
cpu 0 cold: high 14, batch 3 used:0
cpu 1 hot: high 42, batch 7 used:0
cpu 1 cold: high 14, batch 3 used:0
cpu 2 hot: high 42, batch 7 used:0
cpu 2 cold: high 14, batch 3 used:0
cpu 3 hot: high 42, batch 7 used:0
cpu 3 cold: high 14, batch 3 used:0
DMA32 per-cpu: empty
Normal per-cpu:
cpu 0 hot: high 42, batch 7 used:8
cpu 0 cold: high 14, batch 3 used:0
cpu 1 hot: high 42, batch 7 used:28
cpu 1 cold: high 14, batch 3 used:0
cpu 2 hot: high 42, batch 7 used:40
cpu 2 cold: high 14, batch 3 used:0
cpu 3 hot: high 42, batch 7 used:2
cpu 3 cold: high 14, batch 3 used:0
HighMem per-cpu: empty
Free pages:     4055248kB (0kB HighMem)
Active:160 inactive:53 dirty:0 writeback:0 unstable:0 free:253453 slab:244 mapped:55 pagetables:8
DMA free:1998256kB min:5760kB low:7200kB high:8640kB active:0kB inactive:0kB present:2075200kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 72057594037927935 72057594037927935
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 72057594037927935 72057594037927935
Normal free:2056992kB min:2277358239360432kB low:2846697799200528kB high:3416037359040640kB active:2560kB inactive:848kB present:18446744073709550032kB pages_scanned:1135 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:512kB low:512kB high:512kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 3*16kB 2*32kB 1*64kB 2*128kB 2*256kB 1*512kB 2*1024kB 2*2048kB 2*4096kB 2*8192kB 2*16384kB 3*32768kB 2*65536kB 1*131072kB 2*262144kB 2*524288kB 0*1048576kB = 1998256kB
DMA32: empty
Normal: 0*16kB 39*32kB 11*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 1*4096kB 2*8192kB 0*16384kB 2*32768kB 2*65536kB 2*131072kB 2*262144kB 2*524288kB 0*1048576kB = 2056992kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
261247 pages of RAM
6488 reserved pages
45 pages shared
0 pages swap cached
644 pages in page table cache
cpu 3 hot: high 42, batch 7 used:2
oom-killer: gfp_mask=0x200d2, order=0

Call Trace:
 [<a0000001000117f0>] show_stack+0x50/0xa0
                                sp=e0000001ff927b70 bsp=e0000001ff921270
 [<a000000100011870>] dump_stack+0x30/0x60
                                sp=e0000001ff927d40 bsp=e0000001ff921258
 [<a0000001000dd330>] out_of_memory+0x70/0x380
                                sp=e0000001ff927d40 bsp=e0000001ff921200
 [<a0000001000e03b0>] __alloc_pages+0x3d0/0x520
                                sp=e0000001ff927d60 bsp=e0000001ff921190
 [<a0000001000f47a0>] do_wp_page+0x2c0/0x740
                                sp=e0000001ff927d70 bsp=e0000001ff921120
 [<a0000001000f6c90>] __handle_mm_fault+0x12b0/0x13c0
                                sp=e0000001ff927d70 bsp=e0000001ff921088
 [<a000000100058fd0>] ia64_do_page_fault+0x230/0xa00
                                sp=e0000001ff927d80 bsp=e0000001ff921030
 [<a00000010000c360>] ia64_leave_kernel+0x0/0x280
                                sp=e0000001ff927e30 bsp=e0000001ff921030
Mem-info:
DMA per-cpu:
cpu 0 hot: high 42, batch 7 used:37
cpu 0 cold: high 14, batch 3 used:0
cpu 1 hot: high 42, batch 7 used:0
cpu 1 cold: high 14, batch 3 used:0
cpu 2 hot: high 42, batch 7 used:0
cpu 2 cold: high 14, batch 3 used:0
cpu 3 hot: high 42, batch 7 used:0
cpu 3 cold: high 14, batch 3 used:0
DMA32 per-cpu: empty
Normal per-cpu:
cpu 0 hot: high 42, batch 7 used:8
cpu 0 cold: high 14, batch 3 used:0
cpu 1 hot: high 42, batch 7 used:34
cpu 1 cold: high 14, batch 3 used:0
cpu 2 hot: high 42, batch 7 used:40
cpu 2 cold: high 14, batch 3 used:0
cpu 3 hot: high 42, batch 7 used:2
cpu 3 cold: high 14, batch 3 used:0
HighMem per-cpu: empty
Free pages:     4055248kB (0kB HighMem)
Active:157 inactive:50 dirty:0 writeback:0 unstable:0 free:253453 slab:244 mapped:23 pagetables:4
DMA free:1998256kB min:5760kB low:7200kB high:8640kB active:0kB inactive:0kB present:2075200kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 72057594037927935 72057594037927935
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 72057594037927935 72057594037927935
Normal free:2056992kB min:2277358239360432kB low:2846697799200528kB high:3416037359040640kB active:2512kB inactive:800kB present:18446744073709550032kB pages_scanned:1471 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:512kB low:512kB high:512kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 3*16kB 2*32kB 1*64kB 2*128kB 2*256kB 1*512kB 2*1024kB 2*2048kB 2*4096kB 2*8192kB 2*16384kB 3*32768kB 2*65536kB 1*131072kB 2*262144kB 2*524288kB 0*1048576kB = 1998256kB
DMA32: empty
Normal: 0*16kB 39*32kB 11*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 1*4096kB 2*8192kB 0*16384kB 2*32768kB 2*65536kB 2*131072kB 2*262144kB 2*524288kB 0*1048576kB = 2056992kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
261247 pages of RAM
6488 reserved pages
19 pages shared
0 pages swap cached
651 pages in page table cache
Out of Memory: Kill process 275 (hotplug) score 5 and children.
Out of memory: Killed process 275 (hotplug).
cpu 3 cold: high 14, batch 3 used:0
HighMem per-cpu: empty
Free pages:     4055248kB (0kB HighMem)
Active:152 inactive:50 dirty:0 writeback:0 unstable:0 free:253453 slab:245 mapped:0 pagetables:0
DMA free:1998256kB min:5760kB low:7200kB high:8640kB active:0kB inactive:0kB present:2075200kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 72057594037927935 72057594037927935
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 72057594037927935 72057594037927935
Normal free:2056992kB min:2277358239360432kB low:2846697799200528kB high:3416037359040640kB active:2432kB inactive:800kB present:18446744073709550032kB pages_scanned:1471 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:512kB low:512kB high:512kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 3*16kB 2*32kB 1*64kB 2*128kB 2*256kB 1*512kB 2*1024kB 2*2048kB 2*4096kB 2*8192kB 2*16384kB 3*32768kB 2*65536kB 1*131072kB 2*262144kB 2*524288kB 0*1048576kB = 1998256kB
DMA32: empty
Normal: 0*16kB 39*32kB 11*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 1*4096kB 2*8192kB 0*16384kB 2*32768kB 2*65536kB 2*131072kB 2*262144kB 2*524288kB 0*1048576kB = 2056992kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
261247 pages of RAM
6488 reserved pages
0 pages shared
0 pages swap cached
658 pages in page table cache
Out of Memory: Kill process 2 (migration/0) score 0 and children.
Out of Memory: Kill process 2 (migration/0) score 0 and children.
