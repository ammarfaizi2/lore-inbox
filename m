Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUBUHbe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 02:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbUBUHbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 02:31:34 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:17387 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261522AbUBUHbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 02:31:25 -0500
Date: Fri, 20 Feb 2004 23:31:17 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.3-mjb1
Message-ID: <18930000.1077348677@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset is meant to be pretty stable, not so much a testing ground.
Main differences from mainline are:

1. Better performance & resource consumption, particularly on larger machines.
2. Diagnosis tools (kgdb, early_printk, etc).
3. Updated arch support for AMD64 + PPC64.
4. Better support for sound, especially OSS emulation over ALSA.
5. Better support for video (v4l2, bttv, ivtv).
6. Kexec support.

I'd be very interested in feedback from anyone willing to test on any 
platform, however large or small.

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.3/patch-2.6.3-mjb1.bz2

Since 2.6.2-mjb1 (~ = changed, + = added, - = dropped)

Notes:  

-----------------------------------------------------------------------

Now in Linus' tree:

- ppc64_update					Anton Blanchard
	PPC 64 update

- export_cpu_2_node				Pat Mansfield
	export cpu_2_node

- config_acpi_numa				Martin J. Bligh
	disable CONFIG_ACPI_NUMA for anything but ia64


Dropped:


New:

+ aio-retry					Suparna, Janet, et al.
+ 4g4g-aio-hang-fix
+ aio-retry-elevated-refcount
+ aio-splice-runlist
+ aio-wait-page
+ aio-fs_read
+ aio-upfront-readahead
+ O_SYNC-speedup
+ aio-O_SYNC
+ gang_lookup_next
+ aio-gang_lookup-fix
+ aio-O_SYNC-short-write
+ aio-read-immediate
	Filesystem AIO support

+ lazy-readahead-adapt					Ram Pai
	Improve the readahead algorithm

+ schedstat						Rick Lindsley
	Provide lotsa scheduler statistics

+ vsyscall_gtod_B2					John Stultz
	Vsyscall gettimeofday for faster syscalls

+ implicit_huge_pages 				Adam Litke / wli / Brian T.
	Implicit huge pages for mmap and shmem

+ mmu_context_to_struct					Adam Litke
	Prep to make hugetlb on PPC64 a dynamic area.

+ hugetlb_dyn_as					Adam Litke
	Make hugetlb on PPC64 a dynamic area.


Pending:
local_balance_exec
reluctance in cross-node balance (less_bouncy)
sched tunables patch
emulex update
NUMA membinding API
x86_64 update
config_numasched
sched tunables (reinstante)
list_of_lists
Child runs first (akpm)
Netdump
Netconsole

Present in this patch:

-mjb						Martin J. Bligh
	Add a tag to the makefile

netpoll						Jeff Garzik / mpm
	Polled net drivers for kgdb et al.

kgdb						Various
	Stolen from akpm's 2.6.0-mm1, includes fixes

kgdboe_netpoll					Matt Mackall et al.
	Kgdb over ethernet support that works with the netpoll infrastructure

kgdboe_build_fix				Andrew Morton
	Fix kgdboe stuff so non-ia32 platforms build

kgdb_x86_64					Jim Houston
	Support kgdb on x86_64

kgdb_gdb6_patches				Jim Houston
	Patches for gdb to support kgdb on x86_64, under scripts/kgdb/

ppc64_reloc_hide				Anton Blanchard / Paul Mackerras
	PPC 64 fixups

spinlock_inlining				Andrew Morton & Martin J. Bligh
	Inline spinlocks for profiling. Made into a ugly config option by me.

lockmeter					John Hawkes / Hanna Linder
	Locking stats.

lockmeter_ia64					Ray Bryant
	Add a config option for lockmeter on ia64

oops_dump_preceding_code			Andrew Morton
	dump opcodes preceding and after the offending EIP.

4g4g						Ingo Molnar
	Provide a 4G/4G user/kernel split for 32 bit memory lushes.

4g_zap_low_mappings					Martin Lorenz
	stop zap_low_mappings from being __init

4g4g_locked_copy					Dave McCracken
	Fix locking bug in 4/4 split

lotsa_sds					Badari
	Enable lots of scsi disks

build_options_on_oops				Andrew Morton
	Print out the build options when we oops.

sched_domains					Nick Piggin
	sched_domains code

sched_balance_fix				Rick Lindsley
	Fix balancing problem in the sched domains code.

early_printk					Dave Hansen / Keith Mannthey
	Allow printk before console_init

confighz					Andrew Morton / Dave Hansen
	Make HZ a config option of 100 Hz or 1000 Hz

config_page_offset				Dave Hansen / Andrea
	Make PAGE_OFFSET a config option

numameminfo					Martin Bligh / Keith Mannthey
	Expose NUMA meminfo information under /proc/meminfo.numa

partial_objrmap					Dave McCracken
	Object based rmap for filebacked pages.

tcp_speedup					Martin J. Bligh
	Speedup TCP (avoid double copy) as suggested by Linus

disable preempt					Martin J. Bligh
	I broke preempt somehow, temporarily disable it to stop accidents

aiofix2						Mingming Cao
	fixed a bug in ioctx_alloc()

config_irqbal					Keith Mannthey
	Make irqbalance a config option

percpu_real_loadavg				Dave Hansen / Martin J. Bligh
	Tell me what the real load average is, and tell me per cpu.

per_node_rss					Matt Dobson
	Track which nodes tasks mem is on, so sched can be sensible.

pfn_to_nid					Martin J. Bligh
	Dance around the twisted rats nest of crap in i386 include.

pfn_valid					Martin J. Bligh
	Fix pfn_valid to cope with memory holes

no_numa_pc					Martin J. Bligh
	Disallow NUMA on PC subarch

gcov						Hubertus / Paul Larson
	Code coverage monitor

gfp_node_strict					Dave Hansen
	Add a node strict binding as a gfp mask option

irqbal_fast					Adam Litke
	Balance IRQs more readily

kcg						Adam Litke
	Acylic call graphs from the kernel. Wheeeeeeeeeeeee!

kcg_gcc_detect					Adam Litke
	Detect older gcc versions that don't work with mcount, and crap out

numa_mem_equals 				Dave Hansen
	mem= command line parameter NUMA awareness.

autoswap					Con Kolivas
	Auto-tune swapiness

emulex driver					Emulex
	Driver for emulex fiberchannel cards

multiple_emulex					Mike Anderson
	Allow multiple Emulex cards

protocol254					Paul Mackerras / Omkhar 
	Allow protocol 254

slabtune					Dave McCracken
	Take slab in bigger bites on larger machines

topdown						Bill Irwin
	Turn userspace upside down for fun & profit

stacktrace					Adam Litke
	Stack backtracing via frame pointers

fasync_lock_rcu					Manfred Spraul
	Use RCU for fasync_lock

aio-retry					Suparna, Janet, et al.
4g4g-aio-hang-fix
aio-retry-elevated-refcount
aio-splice-runlist
aio-wait-page
aio-fs_read
aio-upfront-readahead
O_SYNC-speedup
aio-O_SYNC
gang_lookup_next
aio-gang_lookup-fix
aio-O_SYNC-short-write
aio-read-immediate
	Filesystem AIO support

lazy-readahead-adapt				Ram Pai
	Improve the readahead algorithm

kexec						Eric Biederman et al.
	Exec a kernel for breakfast today.

alsa_100rc2					ALSA project
	New code drop of sound infrastructure - fixes various bugs.

force_wholefrag					Martin J. Bligh et al.
	OSS emulation sounds like crap without wholefrag. Revert that change.

lockmeter_notsc					Martin J. Bligh
	Lockmeter does not require CONFIG_X86_TSC.

smp_boot_id					Martin J. Bligh
	Fix panic if boot cpu's phys apicid doesn't match expected.

sysfs_backing_store1					Maneesh Soni
sysfs_backing_store2					Maneesh Soni
sysfs_backing_store3					Maneesh Soni
sysfs_backing_store4					Maneesh Soni
sysfs_backing_store5					Maneesh Soni
sysfs_backing_store6					Maneesh Soni
	Sysfs backing store to stop it gobbling so much mem.

ivtv						Kevin Thayer / Steven Fuerst
	Driver for ivtv (includes Hauppauge PVR 250 / 350)
	Written by Kevin Thayer, ported to 2.6 by Steven Fuerst

gcov_warning_fix					
	Fix warning in gcov

tiocgdev						Gerd Knorr

distribute_boot_allocs					Manfred Spraul
	Distribute boot allocations across NUMA nodes

vma_statistics						Martin J. Bligh
	Provide per VMA stats

schedstats						Rick Lindsley
	Provide lotsa scheduler statistics

vsyscall_gtod_B2					John Stultz
	Vsyscall gettimeofday for faster syscalls

implicit_huge_pages 				Adam Litke / wli / Brian T.
	Implicit huge pages for mmap and shmem

mmu_context_to_struct					Adam Litke
	Prep to make hugetlb on PPC64 a dynamic area.

hugetlb_dyn_as						Adam Litke
	Make hugetlb on PPC64 a dynamic area.



