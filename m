Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTLOWxX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTLOWxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:53:23 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:47236 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264266AbTLOWvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:51:55 -0500
Date: Mon, 15 Dec 2003 15:23:11 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.0-test11-mjb3
Message-ID: <21590000.1071530591@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
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

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.0-test11/patch-2.6.0-test11-mjb3.bz2

Since 2.6.0-test11-mjb2 (~ = changed, + = added, - = dropped)

Notes:  

Now in Linus' tree:

Dropped:

- page_lock					William Lee Irwin
	Conditionally convert mapping->page_lock back to an rwlock
	(conflicts with text replication)

New:

+ poll_8139too_fix				akpm
	Fix a locking bug

+ lotsa_sds					Badari
	Enable lots of scsi disks

+ readahead_fixes				Ram Pai
	Fix performance bugs in readahead

+ readahead_simplfiy				Ram Pai
	Simplify the readahead code

+ schedstat_arches				Rick Lindsley
	Make schedstats support PPC, PPC64, x86_64 as well as ia32

+ user_text_replication				Dave Hansen
	Replicate read-only user text.

+ amd_installkernel				Martin J. Bligh
	Allow user override of installkernel script

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

qlogic driver					Qlogic
	The qlogic driver

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

amd_sysrq_t					Badari
	Fix amd sysrq+t not to print the same stack for everyone. Doh!

-mjb						Martin J. Bligh
	Add a tag to the makefile


