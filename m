Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTLLAkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 19:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTLLAkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 19:40:47 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:30389 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263447AbTLLAkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 19:40:40 -0500
Date: Thu, 11 Dec 2003 16:40:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.0-test11-mjb2
Message-ID: <23320000.1071189630@flay>
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

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.0-test11/patch-2.6.0-test11-mjb2.bz2

Since 2.6.0-test11-mjb1 (~ = changed, + = added, - = dropped)

Notes:  Major resync with akpm, and merged 4/4 split

Now in Linus' tree:

Dropped:

- nolock					Dave McCracken
	Not really dropped, but folded into the objrmap patch

New:

~ kgdb						Various
	Grabbed updated version from akpm

+ ppc64_bar_0_fix				Anton Blanchard
+ ppc64_reloc_hide				Anton Blanchard / Paul Mackerras
+ ppc64_sched_clock_fix				Anton Blanchard / Paul Mackerras
+ ppc64_use_statfs64				Anton Blanchard
+ ppc64_compat_clock				Olaf Hering
+ ppc64_numa_sign_extn				Anton Blanchard
+ ppc64_IRQ_INPROGRESS_fix			Anton Blanchard
	PPC 64 fixups

~ lockmeter					John Hawkes / Hanna Linder
	Updated version from akpm + rolled in fixes

+ vm86_sysenter_fix				Brian Gerst
	Re-enable sysenter after task switch

+ oops_dump_preceding_code			Andrew Morton
	dump opcodes preceding and after the offending EIP.

+ 4g4g						Ingo Molnar
	Provide a 4G/4G user/kernel split for 32 bit memory lushes.

~ emulex					Emulex / Pat Mansfield
	New version that can be compiled in (not a module)

~ implicit_huge_pages				Adam Litke / wli / Brian T.
	New version to fix up some bogons on PPC64.

~ kcg						Adam Litke
	Seemed we lost the PPC64 support somehow. put it back.

+ multiple_emulex				Jose Santos
	Performance fix for multiple emulex cards.

Pending:
lotsa_sds
config_numasched
list_of_lists
Hyperthreaded scheduler (Ingo Molnar)
scheduler callers profiling (Anton or Bill Hartner)
Child runs first (akpm)
Kexec
e1000 fixes
pidmaps_nodepages (Dave Hansen)

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

page_lock					William Lee Irwin
	Conditionally convert mapping->page_lock back to an rwlock

irqbal_fast					Adam Litke
	Balance IRQs more readily

kcg						Adam Litke
	Acylic call graphs from the kernel. Wheeeeeeeeeeeee!

numa_mem_equals 				Dave Hansen
	mem= command line parameter NUMA awareness.

schedstat					Rick Lindsley
	Provide lotsa scheduler statistics

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


