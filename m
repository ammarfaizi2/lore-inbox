Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268089AbTB1Slc>; Fri, 28 Feb 2003 13:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268061AbTB1Slc>; Fri, 28 Feb 2003 13:41:32 -0500
Received: from franka.aracnet.com ([216.99.193.44]:46771 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268060AbTB1SlX>; Fri, 28 Feb 2003 13:41:23 -0500
Date: Fri, 28 Feb 2003 10:51:35 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.5.63-mjb2 (scalability / NUMA patchset)
Message-ID: <34060000.1046458295@[10.10.2.4]>
In-Reply-To: <5880000.1046301577@[10.10.2.4]>
References: <5880000.1046301577@[10.10.2.4]>
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

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.63/patch-2.5.63-mjb2.bz2

additional:

http://www.aracnet.com/~fletch/linux/2.5.59/pidmaps_nodepages

Since 2.5.62-mjb3 (~ = changed, + = added, - = dropped)

Notes:
	Contains some critical objrmap fixes.

Dropped temporarily:
- dmc_exit					Dave McCracken
- shpte						Dave McCracken

New:

+ schedstat-scripts				Rick Lindsley
+ objrmap_fixes					Dave McCracken / Hugh Dickins
+ common_physmap				Andy Whitcroft
+ pfn_to_nid_inline				Andy Whitcroft
+ pfn_valid					Andy Whitcroft
+ numa_x86_pc					Andy Whitcroft
+ physnode_map_u8				Andy Whitcroft
+ profiling_docs				Martin J. Bligh

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
	Provide stats about the scheduler under /proc/schedstat

schedstat2					Rick Lindsley
	Provide more stats about the scheduler under /proc/schedstat

schedstat-scripts				Rick Lindsley
	Provide some scripts for schedstat analysis under scripts/

sched_tunables					Robert Love
	Provide tunable parameters for the scheduler (+ NUMA scheduler)

early_ioremap					Dave Hansen
	Provide ioremap in very early boot when we only have 8Mb address space

x440disco_A0					Pat Gaughen / IBM NUMA team
	SLIT/SRAT parsing for x440 discontigmem

acpi_16way					John Stultz
	Make ACPI cope with multi-page something-or-others.

numa_pci_fix					Dave Hansen
	Fix a potential error in the numa pci code from Stanford Checker

pfn_to_nid					William Lee Irwin
	Turn pfn_to_nid into a macro

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

no_kirq						Martin J. Bligh
	Allow disabling of kirq to work properly

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

common_physmap					Andy Whitcroft
	merge physnode_map implementations from numaq and summit

pfn_to_nid_inline				Andy Whitcroft
	converts the pfn_to_nid macro into an inline

pfn_valid					Andy Whitcroft
	fixes up a bug in copy_page_range

numa_x86_pc					Andy Whitcroft
	adds basic numa support for flat systems

physnode_map_u8					Andy Whitcroft
	converts physnode_map array to u8 (save cache polution)

profiling_docs					Martin J. Bligh
	Basic profiling docs

-mjb						Martin J. Bligh
	Add a tag to the makefile

