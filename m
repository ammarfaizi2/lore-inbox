Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbTCMFFX>; Thu, 13 Mar 2003 00:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262177AbTCMFFX>; Thu, 13 Mar 2003 00:05:23 -0500
Received: from franka.aracnet.com ([216.99.193.44]:52399 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262170AbTCMFFU>; Thu, 13 Mar 2003 00:05:20 -0500
Date: Wed, 12 Mar 2003 21:15:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.5.64-mjb3 (scalability / NUMA patchset)
Message-ID: <85960000.1047532556@[10.10.2.4]>
In-Reply-To: <475260000.1047172886@[10.10.2.4]>
References: <169550000.1046895443@[10.10.2.4]> <475260000.1047172886@[10.10.2.4]>
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

NOTE - you will have to apply -bk3 before applying this release.
ftp://ftp.kernel.org/pub/linux/kernel/v2.5/snapshots/patch-2.5.64-bk3.bz2
ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.64/patch-2.5.64-bk3-mjb3.bz2

additional:

http://www.aracnet.com/~fletch/linux/2.5.59/pidmaps_nodepages

Since 2.5.64-mjb2 (~ = changed, + = added, - = dropped)

Notes:  kill files_lock contention & bugfixes.

Merged with Linus:

New:
+ serial_console_warning			Martin J. Bligh
+ get_empty_filp				Manfred Spraul
+ files_lock_goodness				Andrew Morton
+ spinlock_inlining				Andrew Morton
+ sysfs_fix					Pat Mochel
+ kmem_cache_size				Christoph Hellwig
+ vm_area_struct				Hugh Dickens

Pending:
objrmap bugfixes (Dave McCracken)
ressurect shpte (Dave McCracken)
Hyperthreaded scheduler (Ingo Molnar)
Seperate kernel PMDs per process (Dave Hansen)
Non-PAE aligned kernel splits (Dave Hansen)
scheduler callers profiling (Anton or Bill Hartner)
PPC64 NUMA patches (Anton)
Child runs first (akpm)
Kexec
e1000 fixes
Update the lost timer ticks code

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

doaction					Martin J. Bligh
	Fix cruel torture of macros and small furry animals in io_apic.c

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

irq_affinity					Martin J. Bligh
	Workaround for irq_affinity on clustered apic mode systems (eg x440)

cleaner_inodes					Andrew Morton
	Make noatime filesystems more efficient

partial_objrmap					Dave McCracken
	Object based rmap for filebacked pages.

objrmap_fix					Dave McCracken
	Fix detection of anon pages

objrmap_fixes					Dave McCracken / Hugh Dickins
	Fix up some mapped sizing bugs in objrmap

objrmap_mapcount				Dave McCracken
	Fix up some mapped sizing bugs in objrmap

kgdb						Andrew Morton / Various People
	The older version of kgdb, synched with 2.5.54-mm1

noframeptr					Martin Bligh
	Disable -fomit_frame_pointer

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

serial_console_warning				Martin J. Bligh
	Fix silly compile warning for serial console

get_empty_filp					Manfred Spraul
	Kill the lock contention on files_lock from get_empty_filp ...

files_lock_goodness				Andrew Morton
	... and drive a silver stake through it's heart.

spinlock_inlining				Andrew Morton
	Inline spinlocks for profiling. Made into a ugly config option by me.

sysfs_fix					Pat Mochel
	Fix some bug or other in sysfs that's been annoying people

kmem_cache_size					Christoph Hellwig
	The new slab poisoning code broke kmem_cache_size(). Oops.

vm_area_struct					Hugh Dickens
	Fix vm_area_struct slab corruption due to mremap's move_vma suckage.

-mjb						Martin J. Bligh
	Add a tag to the makefile

