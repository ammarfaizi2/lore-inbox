Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262260AbTC1Hot>; Fri, 28 Mar 2003 02:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262264AbTC1Hot>; Fri, 28 Mar 2003 02:44:49 -0500
Received: from franka.aracnet.com ([216.99.193.44]:23441 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262260AbTC1Hop>; Fri, 28 Mar 2003 02:44:45 -0500
Date: Thu, 27 Mar 2003 23:55:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.5.66-mjb1
Message-ID: <35520000.1048838154@[10.10.2.4]>
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

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.66/patch-2.5.66-mjb
1.bz2

additional:

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.66/shpte
http://www.aracnet.com/~fletch/linux/2.5.59/pidmaps_nodepages

Since 2.5.65-mjb1 (~ = changed, + = added, - = dropped)

Notes:

Now in Linus' tree:
- doaction					Martin J. Bligh
- cleaner_inodes				Andrew Morton
- get_empty_filp				Manfred Spraul
- files_lock_goodness				Andrew Morton
- debkl_ext2_readdir				Alex Tomas
- numa_protector				Martin Bligh / Dave Hansen
- vm_enough_memory				Andrew Morton

New: 
+ kgdb_fixes					Dave McCracken
+ x440_16way					Dave Hansen  / Pat Gaughen
+ d_notify					Andrew Morton
+ membind					Matt Dobson

Pending:
Hyperthreaded scheduler (Ingo Molnar)
objrmap bugfixes for nonlinear vma's (Dave McCracken)
Seperate kernel PMDs per process (Dave Hansen)
Non-PAE aligned kernel splits (Dave Hansen)
scheduler callers profiling (Anton or Bill Hartner)
PPC64 NUMA patches (Anton)
Child runs first (akpm)
Kexec
e1000 fixes
Update the lost timer ticks code

Present in this patch:

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

kprobes						Vamsi Krishna S
	Add kernel probes hooks to the kernel

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

spinlock_inlining				Andrew Morton
	Inline spinlocks for profiling. Made into a ugly config option by me.

summit_pcimap					Matt Dobson
	Provide pci bus -> node mapping for x440

# shpte						Dave McCracken
	Shared pagetables

reiserfs_dio					Mingming Cao
	DIO for Reiserfs

concurrent_balloc				Alex Tomas
	Concurrent ext2 block allocation - makes SDET & dbench go whizzy fast.

concurrent_inode				Alex Tomas
	Concurrent ext2 inode allocation - makes SDET & dbench go whizzy fast.

sched_interactive				Ingo Molnar
	Bugfix for interactive scheduler

kgdb_cleanup					Martin J. Bligh
	Stop kgdb renaming schedule to do_schedule when it's not even enabled

3c509_fix					Martin J. Bligh
	Fix warning in 3c509 driver.

acenic_fix					Martin J. Bligh
	Fix warning in acenic driver

sisfix						Martin J. Bligh
	Fix warning & bug in sis900 driver

scsi_sysfs_fix					Martin J. Bligh
	Fix error in scsi_sysfs.

local_balance_exec				Martin J. Bligh
	Modify balance_exec to use node-local queues when idle

d_notify					Andrew Morton
	Convert dparent_lock do dentry->d_lock

membind						Matt Dobson
	NUMA memory binding API

-mjb						Martin J. Bligh
	Add a tag to the makefile

