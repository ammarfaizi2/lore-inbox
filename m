Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263986AbTDJGlR (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 02:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263987AbTDJGlR (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 02:41:17 -0400
Received: from franka.aracnet.com ([216.99.193.44]:49377 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263986AbTDJGlN (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 02:41:13 -0400
Date: Wed, 09 Apr 2003 23:52:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.5.67-mjb1
Message-ID: <201640000.1049957562@[10.10.2.4]>
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

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.67/patch-2.5.67-mjb1.bz2

additional:

(these two form the qlogic feral driver)
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm1/broken-out/linux-isp.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm1/broken-out/isp-update-1.patch

(shared pagetables - will appear later ;-))
ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.67/shpte

(some NUMA info, but scuppers some things)
http://www.aracnet.com/~fletch/linux/2.5.59/pidmaps_nodepages

Since 2.5.66-mjb2 (~ = changed, + = added, - = dropped)

Notes:

Now in Linus' tree:

3c509_fix					Martin J. Bligh
scsi_sysfs_fix					Various People
d_notify					Andrew Morton
cs46xx_lib					Martin J. Bligh

New: 

+ ppc64 fixes					Anton Blanchard
	Various PPC64 fixes / updates
+ numameminfo fix				Martin J. Bligh
	Correct /proc/meminfo.numa for zholes_size.
+ queuestat					William Lee Irwin
	Provide queueing statistics for the scheduler
+ rmap_speedups					Andrew Morton
	Speed up various things in rmap
~ objrmap					Dave McCracken
	Partial object based rmap
+ more_async					Andrew Morton
	Make MS_ASYNC more async
+ separate_pmd					Dave Hansen
	Separate kernel pmd per process
+ config_debug					Martin J. Bligh
	Make '-g' for the kernel a config option

Pending:
Hyperthreaded scheduler (Ingo Molnar)
Seperate kernel PMDs per process (Dave Hansen)
Non-PAE aligned kernel splits (Dave Hansen)
scheduler callers profiling (Anton or Bill Hartner)
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

rmap_speedups					Andrew Morton
	Speed up various things in rmap

partial_objrmap					Dave McCracken
	Object based rmap for filebacked pages.

objrmap_fix					Dave McCracken
	Fix detection of anon pages

objrmap_fixes					Dave McCracken / Hugh Dickins
	Fix up some mapped sizing bugs in objrmap

objrmap_mapcount				Dave McCracken
	Fix up some mapped sizing bugs in objrmap

kgdb						Andrew Morton
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

acenic_fix					Martin J. Bligh
	Fix warning in acenic driver

sisfix						Martin J. Bligh
	Fix warning & bug in sis900 driver

local_balance_exec				Martin J. Bligh
	Modify balance_exec to use node-local queues when idle

membind						Matt Dobson
	NUMA memory binding API

tcp_speedup					Martin J. Bligh
	Speedup TCP (avoid double copy) as suggested by Linus

early_printk_fix				Keith Mannthey
	Fix commandline parsing in early printk (yay!)

disable preempt					Martin J. Bligh
	I broke preempt somehow, temporarily disable it to stop accidents

sched_idle					Martin J. Bligh
	Call load_balance with proper idle flag (pointed out by John Hawkes)

diskstats					Rick Lindsley
	Make disk stats available in /proc so they scale to lotsa disks.

ppc64 fixes					Anton Blanchard
	Various PPC64 fixes / updates

numameminfo fix					Martin J. Bligh
	Correct /proc/meminfo.numa for zholes_size.

more_async					Andrew Morton
	Make MS_ASYNC more async

separate_pmd					Dave Hansen
	Separate kernel pmd per process

config_debug					Martin J. Bligh
	Make '-g' for the kernel a config option

-mjb						Martin J. Bligh
	Add a tag to the makefile

