Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTCEUHF>; Wed, 5 Mar 2003 15:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTCEUHF>; Wed, 5 Mar 2003 15:07:05 -0500
Received: from franka.aracnet.com ([216.99.193.44]:5351 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261456AbTCEUHA>; Wed, 5 Mar 2003 15:07:00 -0500
Date: Wed, 05 Mar 2003 12:17:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.5.64-mjb1 (scalability / NUMA patchset)
Message-ID: <169550000.1046895443@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset contains mainly scalability and NUMA stuff, and anything 
else that stops things from irritating me. It's meant to be pretty stable, 
not so much a testing ground for new stuff.

I'd be very interested in feedback from anyone willing to test on any 
platform, however large or small.

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.64/patch-2.5.64-mjb1.bz2

additional:

http://www.aracnet.com/~fletch/linux/2.5.59/pidmaps_nodepages

Since 2.5.63-mjb2 (~ = changed, + = added, - = dropped)

Notes:

Merged with Linus:

- local_pgdat					William Lee Irwin
- mpc_apic_id					Martin J. Bligh
- pfn_to_nid					William Lee Irwin
- pcibus_to_cpumask				Matt Dobson
- no_kirq					Martin J. Bligh
- notsc						Martin Bligh
- numa_pci_fix					Dave Hansen
- early_ioremap					Dave Hansen
- x440disco_A0					Pat Gaughen / IBM NUMA team
- acpi_16way					John Stultz

New:

+ align_files_lock				Martin J. Bligh
+ objrmap_mapcount				Dave McCracken

Pending:
scheduler callers profiling (Anton)
PPC64 NUMA patches (Anton)
Child runs first (akpm)
Kexec
e1000 fixes
Non-PAE aligned kernel splits (Dave Hansen)
Update the lost timer ticks code
Ingo scheduler updates

Present in this patch:

common_physmap					Andy Whitcroft
	merge physnode_map implementations from numaq and summit

pfn_to_nid_inline				Andy Whitcroft
	converts the pfn_to_nid macro into an inline

numa_x86_pc					Andy Whitcroft
	adds basic numa support for flat systems

physnode_map_u8					Andy Whitcroft
	converts physnode_map array to u8 (save cache polution)

profiling_docs					Martin J. Bligh
	Basic profiling docs

align_files_lock				Martin J. Bligh
	Cacheline align files_lock

pfn_valid					Andy Whitcroft
	fixes up a bug in copy_page_range

early_printk					Dave Hansen et al.
	Allow printk before console_init

confighz					Andrew Morton / Dave Hansen
	Make HZ a config option of 100 Hz or 1000 Hz

config_page_offset				Dave Hansen / Andrea
	Make PAGE_OFFSET a config option

vmalloc_stats					Dave Hansen
	Expose useful vmalloc statistics

numameminfo					Martin Bligh / Keith Mannthey
	Expose NUMA meminfo information under /proc/meminfo.numa

doaction					Martin J. Bligh
	Fix cruel torture of macros and small furry animals in io_apic.c

kgdb						Andrew Morton / Various People
	The older version of kgdb, synched with 2.5.54-mm1

noframeptr					Martin Bligh
	Disable -fomit_frame_pointer

ingosched					Ingo Molnar
	Modify NUMA scheduler to have independant tick basis.

schedstat					Rick Lindsley
	Provide stats about the scheduler under /proc/schedstat

schedstat2					Rick Lindsley
	Provide more stats about the scheduler under /proc/schedstat

schedstat-scripts				Rick Lindsley
	Provide some scripts for schedstat analysis under scripts/

sched_tunables					Robert Love
	Provide tunable parameters for the scheduler (+ NUMA scheduler)

kprobes						Vamsi Krishna S
	Add kernel probes hooks to the kernel

# dmc_exit					Dave McCracken
	Speed up the exit path.

# shpte						Dave McCracken
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

percpu_loadavg					Martin J. Bligh
	Provide per-cpu loadaverages, and real load averages

irq_affinity					Martin J. Bligh
	Workaround for irq_affinity on clustered apic mode systems (eg x440)

cleaner_inodes					Andrew Morton
	Make noatime filesystems more efficient

nfs_fix						Trond Myklebust
	Fix some bug or other in NFS that seems to bite people as a race.

nonzero_apicid					Martin J. Bligh
	Cope with boot cpu != mpstable boot cpu.

partial_objrmap					Dave McCracken
	Object based rmap for filebacked pages.

objrmap_fix					Dave McCracken
	Fix detection of anon pages

objrmap_fixes					Dave McCracken / Hugh Dickins
	Fix up some mapped sizing bugs in objrmap

objrmap_mapcount				Dave McCracken
	Fix up some mapped sizing bugs in objrmap

-mjb						Martin J. Bligh
	Add a tag to the makefile

