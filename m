Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272770AbTG3F6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 01:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272773AbTG3F6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 01:58:50 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:63923 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S272770AbTG3F6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 01:58:18 -0400
Date: Tue, 29 Jul 2003 22:56:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.0-test2-mjb1
Message-ID: <2770000.1059544580@[10.10.2.4]>
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

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.0-test2/patch-2.6.0-test2-mjb1.bz2

additional patches that can be applied if desired:

(these three form the qlogic feral driver)
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.72/2.5.72-mm1/broken-out/linux-isp.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.72/2.5.72-mm1/broken-out/isp-update-1.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.72/2.5.72-mm1/broken-out/isp-remove-pci_detect.patch

Since 2.5.74-mjb1 (~ = changed, + = added, - = dropped)

Notes:  Just a merge up. Dropped a bunch o' stuff.

Now in Linus' tree:
- stacks_from_slab				William Lee Irwin
	Take kernel stacks from the slab cache, not page allocation.
- swsusp_state_check				Matt Dobson
	Fix a check in s/w suspend code
- node_spanned_pages				Dave Hansen
	Fix up NUMA beancounting

New:

Dropped:
- thread_info_cleanup (4K stacks pt 1)		Dave Hansen / Ben LaHaise
- interrupt_stacks    (4K stacks pt 2)		Dave Hansen / Ben LaHaise
- stack_usage_check   (4K stacks pt 3)		Dave Hansen / Ben LaHaise
- 4k_stack            (4K stacks pt 4)		Dave Hansen
- 4k_stacks_vs_kgdb				Dave Hansen
(will conflict with 4/4 split)

- fs_aio_1_retry					Suparna Bhattacharya
- fs_aio_2_read					Suparna Bhattacharya
- fs_aio_3_write					Suparna Bhattacharya
- fs_aio_4_down_wq				Suparna Bhattacharya
- fs_aio_5_wrdown_wq				Suparna Bhattacharya
- fs_aio_6_bread_wq				Suparna Bhattacharya
- fs_aio_7_ext2getblk_wq				Suparna Bhattacharya
- fs_aio_8_down_wq-ppc64				Suparna Bhattacharya
- fs_aio_9_down_wq-x86_64				Suparna Bhattacharya
(didn't merge cleanly, awaiting update from Suparna).


Pending:
4/4 split
list_of_lists
Hyperthreaded scheduler (Ingo Molnar)
scheduler callers profiling (Anton or Bill Hartner)
Child runs first (akpm)
Kexec
e1000 fixes
Update the lost timer ticks code
pidmaps_nodepages (Dave Hansen)

Present in this patch:

early_printk					Dave Hansen / Keith Mannthey
	Allow printk before console_init

confighz					Andrew Morton / Dave Hansen
	Make HZ a config option of 100 Hz or 1000 Hz

config_page_offset				Dave Hansen / Andrea
	Make PAGE_OFFSET a config option

numameminfo					Martin Bligh / Keith Mannthey
	Expose NUMA meminfo information under /proc/meminfo.numa

sched_tunables					Robert Love
	Provide tunable parameters for the scheduler (+ NUMA scheduler)

irq_affinity					Martin J. Bligh
	Workaround for irq_affinity on clustered apic mode systems (eg x440)

partial_objrmap					Dave McCracken
	Object based rmap for filebacked pages.

kgdb						Andrew Morton
	The older version of kgdb, synched with 2.5.54-mm1

thread_under_page				William Lee Irwin
	Fix THREAD_SIZE < PAGE_SIZE case

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

reslabify-pmd-pgd				William Lee Irwin
	Stick things back in the slab. Or something.

separate_pmd					Dave Hansen
	Separate kernel pmd per task.

banana_split					Dave Hansen
	Make PAGE_OFFSET play twister and limbo.

percpu_real_loadavg				Dave Hansen / Martin J. Bligh
	Tell me what the real load average is, and tell me per cpu.

nolock						Dave McCracken
	Nah, we don't like locks.

proc_pid_readdir				Manfred Spraul
	Make proc_pid_readdir more efficent. Allegedly.

mbind_part1					Matt Dobson
	Bind some memory for NUMA.

mbind_part2					Matt Dobson
	Bind some more memory for NUMA.

per_node_rss					Matt Dobson
	Track which nodes tasks mem is on, so sched can be sensible.

pfn_to_nid					Martin J. Bligh
	Dance around the twisted rats nest of crap in i386 include.

-mjb						Martin J. Bligh
	Add a tag to the makefile

