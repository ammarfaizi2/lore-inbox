Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbTLYRHb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 12:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTLYRHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 12:07:31 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:62598 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264325AbTLYRHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 12:07:23 -0500
Date: Thu, 25 Dec 2003 08:35:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.0-mjb1
Message-ID: <165810000.1072370137@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset contains mainly performance, scalability and NUMA stuff, 
and anything else that stops things from irritating me. It's meant to be 
pretty stable, not so much a testing ground for new stuff.

I'd be very interested in feedback from anyone willing to test on any 
platform, however large or small.

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.0/patch-2.6.0-mjb1.bz2

Since 2.6.0-test11-mjb3 (~ = changed, + = added, - = dropped)

Notes:  

Now in Linus' tree:

Dropped:

New:

~ qlogic					Qlogic / Mike Anderson
	Now qla2xxx-8.00.00b8-1

+ x86-64					Andi Kleen et al.
	x86_64 patch kit, 2.6.0-1

~ user_text_replication				Dave Hansen
        Fix a silly include buglet.

+ fasync_lock_rcu				Manfred Spraul
	Use RCU for fasync_lock

+ lockmeter_ia64				Ray Bryant
	Add a config option for lockmeter on ia64

+ slab_reclaim_accounting			Manfred Spraul
	Fix slab reclaim accounting

+ 4g4g_sep_fix					Ingo Molnar
	Fix SEP on 4g/4g split

+ 4g4g_sysenter_test_fix			Arjan
	Fix sysenter detection

+ 4g4g_locked_copy				Dave McCracken
	Locked copy to userspace

Pending:
config_numasched
list_of_lists
Hyperthreaded scheduler (Ingo Molnar)
scheduler callers profiling (Anton or Bill Hartner)
Child runs first (akpm)
Kexec
pidmaps_nodepages (Dave Hansen)
Netdump
Netconsole

Present in this patch:

kgdb						Various
	Stolen from akpm's 2.6.0-test10-mm1

poll_eepro100
	Polled net driver for kgdb.

poll_tlan
	Polled net driver for kgdb.

poll_tulip
	Polled net driver for kgdb.

poll_tg3
	Polled net driver for kgdb.

poll_8139too
	Polled net driver for kgdb.

poll_8139too_fix				akpm
	Fix a locking bug

ppc64_bar_0_fix					Anton Blanchard
	PPC 64 fixups

ppc64_reloc_hide				Anton Blanchard / Paul Mackerras
	PPC 64 fixups

ppc64_sched_clock_fix				Anton Blanchard / Paul Mackerras
	PPC 64 fixups

ppc64_use_statfs64				Anton Blanchard
	PPC 64 fixups

ppc64_compat_clock				Olaf Hering
	PPC 64 fixups

ppc64_numa_sign_extn				Anton Blanchard
	PPC 64 fixups

ppc64_IRQ_INPROGRESS_fix			Anton Blanchard
	PPC 64 fixups

spinlock_inlining				Andrew Morton & Martin J. Bligh
	Inline spinlocks for profiling. Made into a ugly config option by me.

lockmeter					John Hawkes / Hanna Linder
	Locking stats.

vm86_sysenter_fix				Brian Gerst
	Re-enable sysenter after task switch

oops_dump_preceding_code			Andrew Morton
	dump opcodes preceding and after the offending EIP.

4g4g						Ingo Molnar
	Provide a 4G/4G user/kernel split for 32 bit memory lushes.

lotsa_sds					Badari
	Enable lots of scsi disks

readahead_fixes					Ram Pai
	Fix performance bugs in readahead

readahead_simplfiy				Ram Pai
	Simplify the readahead code

x86-64						Andi Kleen et al.
	x86_64 patch kit, 2.6.0-1

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

local_balance_exec				Martin J. Bligh
	Modify balance_exec to use node-local queues when idle

tcp_speedup					Martin J. Bligh
	Speedup TCP (avoid double copy) as suggested by Linus

disable preempt					Martin J. Bligh
	I broke preempt somehow, temporarily disable it to stop accidents

aiofix2						Mingming Cao
	fixed a bug in ioctx_alloc()

config_irqbal					Keith Mannthey
	Make irqbalance a config option

percpu_real_loadavg				Dave Hansen / Martin J. Bligh
	Tell me what the real load average is, and tell me per cpu.

per_node_rss					Matt Dobson
	Track which nodes tasks mem is on, so sched can be sensible.

pfn_to_nid					Martin J. Bligh
	Dance around the twisted rats nest of crap in i386 include.

gfp_node_strict					Dave Hansen
	Add a node strict binding as a gfp mask option

irqbal_fast					Adam Litke
	Balance IRQs more readily

kcg						Adam Litke
	Acylic call graphs from the kernel. Wheeeeeeeeeeeee!

numa_mem_equals 				Dave Hansen
	mem= command line parameter NUMA awareness.

schedstat					Rick Lindsley
	Provide lotsa scheduler statistics

schedstat_arches				Rick Lindsley
	Make schedstats support PPC, PPC64, x86_64 as well as ia32

autoswap					Con Kolivas
	Auto-tune swapiness

mbind_part1					Matt Dobson
	Bind some memory for NUMA.

mbind_part2					Matt Dobson
	Bind some more memory for NUMA.

emulex driver					Emulex
	Driver for emulex fiberchannel cards

qlogic						Qlogic / Mike Anderson
	Now qla2xxx-8.00.00b8-1

protocol254					Paul Mackerras / Omkhar 
	Allow protocol 254

slabtune					Dave McCracken
	Take slab in bigger bites on larger machines

less_bouncy					Martin J. Bligh
	Stop bouncing warm tasks cross node

topdown						Bill Irwin
	Turn userspace upside down for fun & profit

sysfs_vs_dcache					Maneesh Soni
	Fix race.

pci_topology					Matt Dobson
	Expose PCI NUMA topology to userspace

stacktrace					Adam Litke
	Stack backtracing via frame pointers

implicit_huge_pages 				Adam Litke / wli / Brian T.
	Implicit huge pages for mmap and shmem

user_text_replication				Dave Hansen
        Replicate read-only user text.

fasync_lock_rcu					Manfred Spraul
	Use RCU for fasync_lock

lockmeter_ia64					Ray Bryant
	Add a config option for lockmeter on ia64

slab_reclaim_accounting				Manfred Spraul
	Fix slab reclaim accounting

4g4g_sep_fix					Ingo Molnar
	Fix SEP on 4g/4g split

4g4g_sysenter_test_fix				Arjan
	Fix sysenter detection

4g4g_locked_copy				Dave McCracken
	Locked copy to userspace

-mjb						Martin J. Bligh
	Add a tag to the makefile



