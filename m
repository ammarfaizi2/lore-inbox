Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267412AbTAQHDD>; Fri, 17 Jan 2003 02:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbTAQHDC>; Fri, 17 Jan 2003 02:03:02 -0500
Received: from franka.aracnet.com ([216.99.193.44]:37763 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267412AbTAQHDA>; Fri, 17 Jan 2003 02:03:00 -0500
Date: Thu, 16 Jan 2003 23:11:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.5.58-mjb2 (scalability / NUMA patchset)
Message-ID: <190030000.1042787514@titus>
In-Reply-To: <437220000.1042531505@titus>
References: <19270000.1038270642@flay><134580000.1039414279@titus><32230000.1039502522@titus><568990000.1040112629@titus><21380000.1040717475@titus> <821470000.1041579423@titus> <214500000.1041821919@titus> <676880000.1042101078@titus> <922170000.1042183282@titus> <437220000.1042531505@titus>
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

http://www.aracnet.com/~fletch/linux/2.5.58/patch-2.5.58-mjb2.bz2

Since 2.5.58-mjb1 (~ = changed, + = added, - = dropped)

~ summit1					James Cleverdon / John Stultz
~ summit2					James Cleverdon / John Stultz
~ summit3					James Cleverdon / John Stultz
~ summit4					James Cleverdon / John Stultz
~ summit5					James Cleverdon / John Stultz
~ min_numasched					Martin J. Bligh
~ numasched_ilb					Michael Hohnbaum
+ numa_rebalancer				Erich Focht
+ mpc_apic_id					Martin J. Bligh
+ doaction					Martin J. Bligh
+ vm_enough_memory				Martin J. Bligh
+ discontig_x440				Pat Gaughen / Chandra
+ topo_hack					Pat Gaughen

Notes:
NUMA scheduler is fully there now. Please let me know of tuning data.
Summit code should be fully working, with no more interrupt distribution 
problems. Discontigmem code for x440 may not work without a small ACPI fix. 

Pending:
Speed up page init on boot (Bill Irwin)
Notsc automatic enablement (someone, please ... anyone?)
scheduler callers profiling (Anton)
PPC64 NUMA patches (Anton)
Lockless xtime structures (Andi)
P4 oprofile support (movement)
Child runs first (akpm)
New starfire driver (Ion)
New qlogic driver (Badari ??)


summit1						James Cleverdon / John Stultz
	Summit support part 1

summit2						James Cleverdon / John Stultz
	Summit support part 2

summit3						James Cleverdon / John Stultz
	Summit support part 3

summit4						James Cleverdon / John Stultz
	Summit support part 4

summit5						James Cleverdon / John Stultz
	Summit support part 5

dcache_rcu					Dipankar / Maneesh
	Use RCU type locking for the dentry cache.
 
early_printk					Dave Hansen et al.
	Allow printk before console_init

confighz					Andrew Morton / Dave Hansen
	Make HZ a config option of 100 Hz or 1000 Hz

config_page_offset				Dave Hansen / Andrea
	Make PAGE_OFFSET a config option

vmalloc_stats					Dave Hansen
	Expose useful vmalloc statistics

min_numasched					Martin J. Bligh
	Minimal NUMA scheduler to make balancing node-local

numasched_ilb					Michael Hohnbaum
	NUMA scheduler lightweight initial load balancing.

numa_rebalancer					Erich Focht
	NUMA inter-node rebalancer tunable by architecture.

sched_tunables					Robert Love
	Provide tunable parameters for the scheduler

local_pgdat					Bill Irwin
	Move the pgdat structure into the remapped space with lmem_map

notsc						Martin Bligh
	Enable notsc option for NUMA-Q (new version for new config system)

numameminfo					Martin Bligh / Keith Mannthey
	Expose NUMA meminfo information under /proc/meminfo.numa

kgdb						Andrew Morton / Various People
	The older version of kgdb, synched with 2.5.54-mm1

noframeptr					Martin Bligh
	Disable -fomit_frame_pointer

thread_info_cleanup (4K stacks pt 1)		Dave Hansen / Ben LaHaise
	Prep work to reduce kernel stacks to 4K
	
interrupt_stacks    (4K stacks pt 2)		Dave Hansen / Ben LaHaise
	Create a per-cpu interrupt stack.

stack_usage_check   (4K stacks pt 3)		Dave Hansen / Ben LaHaise
	Check for kernel stack overflows.

4k_stack            (4K stacks pt 4)		Dave Hansen
	Config option to reduce kernel stacks to 4K

mpc_apic_id					Martin J. Bligh
	Fix null ptr dereference (optimised away, but ...)

doaction					Martin J. Bligh
	Fix cruel torture of macros and small furry animals in io_apic.c

vm_enough_memory				Martin J. Bligh
	Make vm_enough_memory more efficient (for overcommit = 2)

discontig_x440					Pat Gaughen / Chandra
	SLIT/SRAT parsing for x440 discontigmem

topo_hack					Pat Gaughen
	Disable some topo stuff for Summit because we're cowards.

-mjb						Martin Bligh
	Add a tag to the makefile

