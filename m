Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbTAUIKR>; Tue, 21 Jan 2003 03:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266406AbTAUIKR>; Tue, 21 Jan 2003 03:10:17 -0500
Received: from franka.aracnet.com ([216.99.193.44]:959 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266379AbTAUIKP>; Tue, 21 Jan 2003 03:10:15 -0500
Date: Tue, 21 Jan 2003 00:19:11 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.5.59-mjb1 (scalability / NUMA patchset)
Message-ID: <19610000.1043137151@titus>
In-Reply-To: <190030000.1042787514@titus>
References: <19270000.1038270642@flay><134580000.1039414279@titus><32230000.1039502522@titus><568990000.1040112629@titus><21380000.1040717475@titus> <821470000.1041579423@titus> <214500000.1041821919@titus> <676880000.1042101078@titus> <922170000.1042183282@titus> <437220000.1042531505@titus> <190030000.1042787514@titus>
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

http://www.aracnet.com/~fletch/linux/2.5.59/patch-2.5.59-mjb1.bz2

Since 2.5.58-mjb2 (~ = changed, + = added, - = dropped)

Notes:
Lots of good stuff merged up with Linus. x440 distcontigmem seems to have
problems in some circumstances, but APCI should work in this release.

merged with Linus:

- summit1					James Cleverdon / John Stultz
- summit2					James Cleverdon / John Stultz
- summit3					James Cleverdon / John Stultz
- summit4					James Cleverdon / John Stultz
- summit5					James Cleverdon / John Stultz
- min_numasched					Martin J. Bligh
- numasched_ilb					Michael Hohnbaum
- numa_rebalancer				Erich Focht
- vm_enough_memory				Martin J. Bligh

Other:

+ ingosched					Ingo Molar
~ sched_tunables				Robert Love
+ acpi_x440_hack				Anonymous Coward
+ numaq_ioapicids				William Lee Irwin
+ oprofile_p4					John Levon
+ starfire					Ion Badulescu

Pending:
Notsc automatic enablement (someone, please ... anyone?)
scheduler callers profiling (Anton)
PPC64 NUMA patches (Anton)
Lockless xtime structures (Andi)
Child runs first (akpm)
New qlogic driver (Badari ??)


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

ingosched					Ingo Molnar
	Modify NUMA scheduler to have independant tick basis.

sched_tunables					Robert Love
	Provide tunable parameters for the scheduler (+ NUMA scheduler)

local_pgdat					William Lee Irwin
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

discontig_x440					Pat Gaughen / Chandra
	SLIT/SRAT parsing for x440 discontigmem

topo_hack					Pat Gaughen
	Disable some topo stuff for Summit because we're cowards.

acpi_x440_hack					Anonymous Coward
	Stops x440 crashing, but owner is ashamed of it ;-)

numaq_ioapicids					William Lee Irwin
	Stop 8 quad NUMA-Qs from panicing due to phys apicid "exhaustion".

oprofile_p4					John Levon
	Updates for oprofile for P4s. Needs new userspace tools.

starfire					Ion Badulescu
	64 bit aware starfire driver	

-mjb						Martin Bligh
	Add a tag to the makefile

