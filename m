Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbTJCQzC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 12:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTJCQzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 12:55:01 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:18611 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263639AbTJCQy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 12:54:56 -0400
Date: Fri, 03 Oct 2003 09:54:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.0-test6-mjb1
Message-ID: <183510000.1065200087@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
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

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.0-test6/patch-2.6.0-test6-mjb1.bz2

additional patches that can be applied if desired:

Since 2.6.0-test2-mjb1 (~ = changed, + = added, - = dropped)

Notes: 
	Mostly a merge forwards.

Now in Linus' tree:

- config_debug					Dave Hansen
	Make '-g' for the kernel a config option
	(equivalent patch merged)

- 32bit_dev_t					Andries Brouwer
	Make dev_t 32 bit

- dynamic_hd_struct				Badari Pulavarty
	Allocate hd_structs dynamically

- 16way_x440					Matt Dobson
	Fix problem with booting on 16x x440

- iosched_hashes				Badari Pulavarty
	Twiddle with the iosched hash tables for fun & profit

Dropped:

- irq_affinity					Martin J. Bligh
	Workaround for irq_affinity on clustered apic mode systems (eg x440)
	(fixed differently)

- kgdb						Andrew Morton
	The older version of kgdb, synched with 2.5.54-mm1
	(need to pick up the new version of kgdb)

- thread_under_page				William Lee Irwin
	Fix THREAD_SIZE < PAGE_SIZE case
	(not needed for now)

- reiserfs_dio					Mingming Cao
	DIO for Reiserfs
	(doesn't compile)

- sched_interactive				Ingo Molnar
	Bugfix for interactive scheduler
	(not needed anymore)

- kgdb_cleanup					Martin J. Bligh
	Stop kgdb renaming schedule to do_schedule when it's not even enabled
	(need to pick up the new version of kgdb)

- lotsa_sds					Badari Pulavarty
	Create some insane number of sds
	(not easily mergable. Badari to give me a new version)

- config_numasched				Dave Hansen
	Turn NUMA scheduler into a config option
	(ummm. I lost it. Will try to find it again)

- separate_pmd					Dave Hansen
	Separate kernel pmd per task.
	(4/4 split will conflict heavily with this)

- banana_split					Dave Hansen
	Make PAGE_OFFSET play twister and limbo.
	(4/4 split will conflict heavily with this)

- proc_pid_readdir				Manfred Spraul
	Make proc_pid_readdir more efficent. Allegedly.
	(didn't merge easily, and I've never seen it do anything)

- lockmeter_tytso				Ted Tso
	Fix lockmeter
	(merged into main lockmeter patch)

- early_printk_fix				Dave Hansen
	Fix epk conflict with ppc64
	(merged into main epk patch)

New:

+ page_lock					William Lee Irwin
	Conditionally convert mapping->page_lock back to an rwlock


Pending:
lotsa_sds
config_numasched
4/4 split
new kgdb
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

partial_objrmap					Dave McCracken
	Object based rmap for filebacked pages.

spinlock_inlining				Andrew Morton & Martin J. Bligh
	Inline spinlocks for profiling. Made into a ugly config option by me.

lockmeter					John Hawkes / Hanna Linder
	Locking stats.

sched_interactive				Ingo Molnar
	Bugfix for interactive scheduler

local_balance_exec				Martin J. Bligh
	Modify balance_exec to use node-local queues when idle

tcp_speedup					Martin J. Bligh
	Speedup TCP (avoid double copy) as suggested by Linus

disable preempt					Martin J. Bligh
	I broke preempt somehow, temporarily disable it to stop accidents

ppc64 pci fix					Anton Blanchard
	Fix some ppc64 pci thing or other.

per_node_idt					Zwane Mwaikambo
	Per node IDT so we can do silly numbers of IO-APICs on NUMA-Q

aiofix2						Mingming Cao
	fixed a bug in ioctx_alloc()

config_irqbal					Keith Mannthey
	Make irqbalance a config option

percpu_real_loadavg				Dave Hansen / Martin J. Bligh
	Tell me what the real load average is, and tell me per cpu.

nolock						Dave McCracken
	Nah, we don't like locks.

mbind_part1					Matt Dobson
	Bind some memory for NUMA.

mbind_part2					Matt Dobson
	Bind some more memory for NUMA.

per_node_rss					Matt Dobson
	Track which nodes tasks mem is on, so sched can be sensible.

pfn_to_nid					Martin J. Bligh
	Dance around the twisted rats nest of crap in i386 include.

gfp_node_strict					Dave Hansen
	Add a node strict binding as a gfp mask option

page_lock					William Lee Irwin
	Conditionally convert mapping->page_lock back to an rwlock

-mjb						Martin J. Bligh
	Add a tag to the makefile


