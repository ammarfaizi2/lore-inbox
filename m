Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267068AbTBQXxW>; Mon, 17 Feb 2003 18:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267412AbTBQXxW>; Mon, 17 Feb 2003 18:53:22 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:61847 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267068AbTBQXxT>; Mon, 17 Feb 2003 18:53:19 -0500
Date: Mon, 17 Feb 2003 15:54:27 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.5.61-mjb1 (scalability / NUMA patchset)
Message-ID: <4450000.1045526067@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, yeah. I know Linus beat me to it ... I'm just "fashionably late".

--------------------------------

The patchset contains mainly scalability and NUMA stuff, and anything 
else that stops things from irritating me. It's meant to be pretty stable, 
not so much a testing ground for new stuff.

I'd be very interested in feedback from anyone willing to test on any 
platform, however large or small.

http://www.aracnet.com/~fletch/linux/2.6.61/patch-2.5.61-mjb1.bz2

additional:

http://www.aracnet.com/~fletch/linux/2.5.59/pidmaps_nodepages

Since 2.5.59-mjb5 (~ = changed, + = added, - = dropped)

Notes: Just a merge from 59-mjb6 up with 2.5.61 really ... I'd like 
kprobes and lkcd tested though, if someone can.

Merged with Linus:
- summit_smp					John Stultz
- cyclone_fixes					John Stultz
- enable_cyclone				John Stultz
- lost_tick					John Stultz
- frlock_xtime					Stephen Hemminger et al.
- frlock-xtime-i386				Stephen Hemminger et al.
- frlock-xtime-ia64				Stephen Hemminger et al.
- frlock-xtime-other				Stephen Hemminger et al.
- numaq_ioapicids				William Lee Irwin
- oprofile_p4					John Levon
- starfire					Ion Badulescu
- tcp_fix					Alexey
- pgd_ctor					William Lee Irwin
- pfn_to_nid					William Lee Irwin
- oprofile_fixes				John Levon
- alt_sysrq_t					Russell King

New:
+ sighand_locking				Linus / Martin J. Bligh
+ percpu_loadavg				Martin J. Bligh
+ irq_affinity					Martin J. Bligh
+ kirq_clustered_fix				Dave Hansen / Martin J. Bligh

Pending:
fixes for kirq interrupt balancing patch
auto_disable_tsc (John Stultz)
scheduler callers profiling (Anton)
PPC64 NUMA patches (Anton)
Child runs first (akpm)
Kexec
e1000 fixes
Non-PAE aligned kernel splits (Dave Hansen)
Update the lost timer ticks code
Ingo scheduler updates

dcache_rcu					Dipankar / Maneesh
	Use RCU type locking for the dentry cache.

dcache_sunrpc					Maneesh
	Fix up NFS to work properly with dcache

early_printk					Dave Hansen et al.
	Allow printk before console_init

confighz					Andrew Morton / Dave Hansen
	Make HZ a config option of 100 Hz or 1000 Hz

config_page_offset				Dave Hansen / Andrea
	Make PAGE_OFFSET a config option

vmalloc_stats					Dave Hansen
	Expose useful vmalloc statistics

local_pgdat					William Lee Irwin
	Move the pgdat structure into the remapped space with lmem_map

numameminfo					Martin Bligh / Keith Mannthey
	Expose NUMA meminfo information under /proc/meminfo.numa

notsc						Martin Bligh
	Enable notsc option for NUMA-Q (new version for new config system)

mpc_apic_id					Martin J. Bligh
	Fix null ptr dereference (optimised away, but ...)

doaction					Martin J. Bligh
	Fix cruel torture of macros and small furry animals in io_apic.c

kgdb						Andrew Morton / Various People
	The older version of kgdb, synched with 2.5.54-mm1

noframeptr					Martin Bligh
	Disable -fomit_frame_pointer

ingosched					Ingo Molnar
	Modify NUMA scheduler to have independant tick basis.

schedstat					Rick Lindsley
	Provide stats about the scheduler under /proc/stat

sched_tunables					Robert Love
	Provide tunable parameters for the scheduler (+ NUMA scheduler)

discontig_x440					Pat Gaughen / IBM NUMA team
	SLIT/SRAT parsing for x440 discontigmem

acpi_x440_hack					Anonymous Coward
	Stops x440 crashing, but owner is ashamed of it ;-)

numa_pci_fix					Dave Hansen
	Fix a potential error in the numa pci code from Stanford Checker

pfn_to_nid					William Lee Irwin
	Turn pfn_to_nid into a macro

kprobes						Vamsi Krishna S
	Add kernel probes hooks to the kernel

dmc_exit1					Dave McCracken
	Speed up the exit path, pt 1.

dmc_exit2					Dave McCracken
	Speed up the exit path, pt 1.

shpte						Dave McCracken
	Shared pagetables (as a config option)

thread_info_cleanup (4K stacks pt 1)		Dave Hansen / Ben LaHaise
	Prep work to reduce kernel stacks to 4K
	
interrupt_stacks    (4K stacks pt 2)		Dave Hansen / Ben LaHaise
	Create a per-cpu interrupt stack.

stack_usage_check   (4K stacks pt 3)		Dave Hansen / Ben LaHaise
	Check for kernel stack overflows.

4k_stack            (4K stacks pt 4)		Dave Hansen
	Config option to reduce kernel stacks to 4K

fix_kgdb					Dave Hansen
	Fix interaction between kgdb and 4K stacks

stacks_from_slab				William Lee Irwin
	Take kernel stacks from the slab cache, not page allocation.

thread_under_page				William Lee Irwin
	Fix THREAD_SIZE < PAGE_SIZE case

lkcd						LKCD team
	Linux kernel crash dump support

sighand_locking					Linus / Martin J. Bligh
	Fix locking for task->sighand

percpu_loadavg					Martin J. Bligh
	Provide per-cpu loadaverages, and real load averages

irq_affinity					Martin J. Bligh
	Workaround for irq_affinity on clustered apic mode systems (eg x440)

kirq_clustered_fix				Dave Hansen / Martin J. Bligh
	Fix kirq for clustered apic systems (eg x440)

-mjb						Martin J. Bligh
	Add a tag to the makefile

