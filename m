Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263799AbUFQV35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbUFQV35 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 17:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUFQV34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 17:29:56 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:62445 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263799AbUFQV3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 17:29:45 -0400
Date: Thu, 17 Jun 2004 14:28:56 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.7-mjb1
Message-ID: <3200850000.1087507736@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
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
3. Kexec support.
4. ivtv drivers

I'd be very interested in feedback from anyone willing to test on any 
platform, however large or small.

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.7/patch-2.6.7-mjb1.bz2

Since the last release (~ = changed, + = added, - = dropped)

Notes: 

-----------------------------------------------------------------------

Now in Linus' tree:

- scheduler_2.6.5_rc3_mm1			Nick Piggin
	sched_domains code

- frameptr_stackdump				Adam Litke
- frameptr_stackdump_tweak			Adam Litke
	Dump stacks by frame pointers

- move_page_tables				Hugh Dickins
	Change move_page_tables from int to unsigned long

- object_based_objrmap				Dave McCracken
	Object based rmap for filebacked pages.

- ia64_rmap_build_fix				Hugh Dickins
- unmap_nonlinear				Hugh Dickins
- slab-panic					Hugh Dickins
- remove_pte_chains				Hugh Dickins
- add_anonmm_rmap				Hugh Dickins
- mremap_moves					Hugh Dickins
- pgtable_remove_rmap				Hugh Dickins
- include_asm_deletions				Hugh Dickins
- i_shared_lock					Martin J. Bligh / Andrew Morton
	Object based rmap work, round 1.

- numa_api					Andi Kleen
	Userspace NUMA API.

- i_shared_lock_fixes				Hugh Dickins
- vma_adjust					Hugh Dickins
- pretend_prio_tree				Hugh Dickins
- real_prio_tree				Rajesh Venkatasubramanian
- i_mmap_nonlinear				Hugh Dickins
- arch_prio_tree				Rajesh Venkatasubramanian
- exit_rmap					Hugh Dickins
	Object based rmap work, round 2 (ding, ding).

- irq_vector					James Cleverdon
	Fix irq vector limits for Summit

- max_mp_busses					James Cleverdon
	Increase MAX_MP_BUSSES

- find_busiest_group				Martin J. Bligh
	Ditch a spurions oops from find_busiest_group()


Dropped:

- implicit_hugetlb				Adam Litke
	Implicit allocation of huge pages

- hugetlb_dyn_as				Adam Litke
	Dynamic huge pages.

- aio-retry
- 4g4g-aio-hang-fix
- aio-retry-elevated-refcount
- aio-splice-runlist
- aio-wait-page
- aio-fs_read
- aio-upfront-readahead
- aio-cancel-fix
- aio-read-immediate
- aio-pipe
- aio-context-switch
- writepages_range
- fix_writeback_range
- fix_writepages_range
- fdatawrite_range
- O_SYNC-speedup
- aio_wait_on_page_writeback_range
- aio-O_SYNC
- aio-poll
- aio_putioctx_flushworkqueue
	AIO filesystem support			Suparna et al.

- sysfs_d_fsdata_race_fix_2			Maneesh Soni
- sysfs_symlinks_fix				Maneesh Soni
- kobject_set_name_cleanup_01			Maneesh Soni
- sysfs_rename_dir_cleanup			Maneesh Soni
- sysfs_backing_store1				Maneesh Soni
- sysfs_backing_store2				Maneesh Soni
- sysfs_backing_store3				Maneesh Soni
- sysfs_backing_store4				Maneesh Soni
- sysfs_backing_store5				Maneesh Soni
- sysfs_backing_store6				Maneesh Soni
	Make sysfs more efficient in its usage of lowmem

New:

+ no_clone_balance				Martin J. Bligh
	Disable balance on clone

+ kexec_fixup					Martin J. Bligh
	Port kexec forwards



Pending:

config_page_offset
per_node_rss
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

Present in this patch:

-mjb						Martin J. Bligh
	Add a tag to the makefile

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

lockmeter_notsc					Martin J. Bligh
	Lockmeter does not require CONFIG_X86_TSC.

oops_dump_preceding_code			Andrew Morton
	dump opcodes preceding and after the offending EIP.

confighz					Andrew Morton / Dave Hansen
	Make HZ a config option of 100 Hz or 1000 Hz

numameminfo					Martin Bligh / Keith Mannthey
	Expose NUMA meminfo information under /proc/meminfo.numa

reinline_copy_user				Martin J. Bligh
	Stick the damned thing back inline to resolve conflicts.

4g4g						Ingo Molnar
	Provide a 4G/4G user/kernel split for 32 bit memory lushes.

4g_zap_low_mappings				Martin Lorenz
	stop zap_low_mappings from being __init

4g4g_locked_copy				Dave McCracken
	Fix locking bug in 4/4 split

disable preempt					Martin J. Bligh
	I broke preempt somehow, temporarily disable it to stop accidents

aiofix2						Mingming Cao
	fixed a bug in ioctx_alloc()

percpu_real_loadavg				Dave Hansen / Martin J. Bligh
	Tell me what the real load average is, and tell me per cpu.

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

kswapd_divide_by_zero				

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

fasync_lock_rcu					Manfred Spraul
	Use RCU for fasync_lock

kexec						Eric Biederman et al.
	Exec a kernel for breakfast today.

kexec_fixup					Martin J. Bligh
	Port kexec forwards

vma_statistics					Martin J. Bligh
	Provide per VMA stats

per_task_TUB					Adam Litke
	Per task TASK_UNMAPPED_BASE

per_task_TUB_PPC32				Anton Blanchard
	Enable per-task TASK_UMAPPED_BASE on PPC32

ivtv						Kevin Thayer / Steven Fuerst
	Driver for ivtv (includes Hauppauge PVR 250 / 350)
	Written by Kevin Thayer, ported to 2.6 by Steven Fuerst
	Version 0.1.9

vgtod1						John Stultz
vgtod2						John Stultz
vgtod3						John Stultz
	Vsyscall gettimeofday for ia32

physnode_map					Martin J. Bligh
	Hack around problem of missing area in physnode_map

sched_tunables					R. Love / Darren Hart
	Provide sched tunables to play with on a rainy day.

zone_gap					Andy Whitcroft
	Fix up the gap between ZONE_NORMAL and ZONE_HIGHMEM on NUMA.

schedstats					Rick Lindsley
	Provide lotsa scheduler statistics

schedstats-tools				Rick Lindsley
	Grub around in lotsa scheduler statistics

amd64_sched					Darren Hart
	Make AMD scheduler behave as flat SMP, not NUMA

cpu_shutdown_race				Andy Whitcroft
	Fix up race during tlb_flush_others on shutdown


