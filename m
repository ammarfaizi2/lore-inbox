Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTFOEwk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 00:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTFOEwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 00:52:40 -0400
Received: from franka.aracnet.com ([216.99.193.44]:726 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261868AbTFOEwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 00:52:35 -0400
Date: Sat, 14 Jun 2003 22:06:17 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.5.71-mjb1
Message-ID: <461570000.1055653577@[10.10.2.4]>
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

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.71/patch-2.5.71-mjb1.bz2

additional patches that can be applied if desired:

(these two form the qlogic feral driver)
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm1/broken-out/linux-isp.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm1/broken-out/isp-update-1.patch

Since 2.5.70-mjb2 (~ = changed, + = added, - = dropped)

Notes: mostly just a merge forward + the *real* fix for proc_lock

Now in Linus' tree:

- numaq_apic_handling				Martin J. Bligh
- remove_x86_summit				Martin J. Bligh
- target_cpus					Martin J. Bligh
- summit_pcimap					Matt Dobson
- sched_idle					Martin J. Bligh


New:
+ proc_lock					Martin J. Bligh
	Fix proc_lock handling and SDET hangs.
+ flow_compile					Everyone and his dog.
	Fix silly compile error in 71.
+ gdb_fixes					Andrew Morton & Martin J. Bligh
	Fix up some compile time errors & warnings, and an ordering bug
~ config_debug					Dave Hansen
	Make the stupid thing actually work ;-)
+ ppc_kmalloc_bug				paulus
	Fix wierd ppc kmalloc bug

Dropped:

- backout_locking				The ghost of patches past
	I found the real problem with this, and fixed it.

	
Pending:
Hyperthreaded scheduler (Ingo Molnar)
scheduler callers profiling (Anton or Bill Hartner)
Child runs first (akpm)
Kexec
e1000 fixes
Update the lost timer ticks code
pidmaps_nodepages (Dave Hansen)
update membind code (Matt Dobson)
update config debug (Dave) 
update percpu_loadavg (Dave)
object based rmap list-o-lists (Martin / Dave Mc)
Locking obliteration (Dave Mc)

Present in this patch:

proc_lock					Martin J. Bligh
	Fix proc_lock handling and SDET hangs.

flow_compile					Everyone and his dog.
	Fix silly compile error in 71.

early_printk					Dave Hansen / Keith Mannthey
	Allow printk before console_init

confighz					Andrew Morton / Dave Hansen
	Make HZ a config option of 100 Hz or 1000 Hz

config_page_offset				Dave Hansen / Andrea
	Make PAGE_OFFSET a config option

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

kgdb						Andrew Morton
	The older version of kgdb, synched with 2.5.54-mm1

thread_info_cleanup (4K stacks pt 1)		Dave Hansen / Ben LaHaise
	Prep work to reduce kernel stacks to 4K
	
interrupt_stacks    (4K stacks pt 2)		Dave Hansen / Ben LaHaise
	Create a per-cpu interrupt stack.

stack_usage_check   (4K stacks pt 3)		Dave Hansen / Ben LaHaise
	Check for kernel stack overflows.

4k_stack            (4K stacks pt 4)		Dave Hansen
	Config option to reduce kernel stacks to 4K

4k_stacks_vs_kgdb				Dave Hansen
	Fix interaction between kgdb and 4K stacks

stacks_from_slab				William Lee Irwin
	Take kernel stacks from the slab cache, not page allocation.

thread_under_page				William Lee Irwin
	Fix THREAD_SIZE < PAGE_SIZE case

percpu_loadavg					Martin J. Bligh
	Provide per-cpu loadaverages, and real load averages

spinlock_inlining				Andrew Morton & Martin J. Bligh
	Inline spinlocks for profiling. Made into a ugly config option by me.

lockmeter					John Hawkes / Hanna Linder
	Locking stats.

reiserfs_dio					Mingming Cao
	DIO for Reiserfs

sched_interactive				Ingo Molnar
	Bugfix for interactive scheduler

kgdb_cleanup					Martin J. Bligh
	Stop kgdb renaming schedule to do_schedule when it's not even enabled

acenic_fix					Martin J. Bligh
	Fix warning in acenic driver

local_balance_exec				Martin J. Bligh
	Modify balance_exec to use node-local queues when idle

tcp_speedup					Martin J. Bligh
	Speedup TCP (avoid double copy) as suggested by Linus

disable preempt					Martin J. Bligh
	I broke preempt somehow, temporarily disable it to stop accidents

ppc64 fixes					Anton Blanchard
	Various PPC64 fixes / updates

numameminfo fix					Martin J. Bligh
	Correct /proc/meminfo.numa for zholes_size.

config_debug					Dave Hansen
	Make '-g' for the kernel a config option

akpm_bear_pit					Andrew Morton
	Add a printk for some buffer error I was hitting

32bit_dev_t					Andries Brouwer
	Make dev_t 32 bit

dynamic_hd_struct				Badari Pulavarty
	Allocate hd_structs dynamically

lotsa_sds					Badari Pulavarty
	Create some insane number of sds

iosched_hashes					Badari Pulavarty
	Twiddle with the iosched hash tables for fun & profit

per_node_idt					Zwane Mwaikambo
	Per node IDT so we can do silly numbers of IO-APICs on NUMA-Q

config_numasched				Dave Hansen
	Turn NUMA scheduler into a config option

lockmeter_tytso					Ted Tso
	Fix lockmeter

aiofix2						Mingming Cao
	fixed a bug in ioctx_alloc()

config_irqbal					Keith Mannthey
	Make irqbalance a config option

fs_aio_1_retry					Suparna Bhattacharya
	Filesystem aio. Chapter 1

fs_aio_2_read					Suparna Bhattacharya
	Filesystem aio. Chapter 2

fs_aio_3_write					Suparna Bhattacharya
	Filesystem aio. Chapter 3

fs_aio_4_down_wq				Suparna Bhattacharya
	Filesystem aio. Chapter 4

fs_aio_5_wrdown_wq				Suparna Bhattacharya
	Filesystem aio. Chapter 5

fs_aio_6_bread_wq				Suparna Bhattacharya
	Filesystem aio. Chapter 6

fs_aio_7_ext2getblk_wq				Suparna Bhattacharya
	Filesystem aio. Chapter 7

fs_aio_8_down_wq-ppc64				Suparna Bhattacharya
	Filesystem aio. Chapter 8

fs_aio_9_down_wq-x86_64				Suparna Bhattacharya
	Filesystem aio. Chapter 9

ppc_kmalloc_bug					paulus
	Fix wierd ppc kmalloc bug

-mjb						Martin J. Bligh
	Add a tag to the makefile

