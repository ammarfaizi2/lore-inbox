Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbTBIDQx>; Sat, 8 Feb 2003 22:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267154AbTBIDQx>; Sat, 8 Feb 2003 22:16:53 -0500
Received: from franka.aracnet.com ([216.99.193.44]:27819 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267102AbTBIDQu>; Sat, 8 Feb 2003 22:16:50 -0500
Date: Sat, 08 Feb 2003 19:26:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.5.59-mjb5 (scalability / NUMA patchset)
Message-ID: <4700000.1044761178@[10.10.2.4]>
In-Reply-To: <359400000.1044603446@[10.10.2.4]>
References: <19270000.1038270642@flay><134580000.1039414279@titus>
 <32230000.1039502522@titus><568990000.1040112629@titus>
 <21380000.1040717475@titus> <821470000.1041579423@titus>
 <214500000.1041821919@titus> <676880000.1042101078@titus>
 <922170000.1042183282@titus> <437220000.1042531505@titus>
 <190030000.1042787514@titus> <19610000.1043137151@titus>
 <20200000.1043806571@flay> <125620000.1044238081@[10.10.2.4]>
 <359400000.1044603446@[10.10.2.4]>
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

http://www.aracnet.com/~fletch/linux/2.5.59/patch-2.5.59-mjb5.bz2

additional:

http://www.aracnet.com/~fletch/linux/2.5.59/pidmaps_nodepages
http://www.aracnet.com/~fletch/linux/2.5.59/mjb4-stacks

Since 2.5.59-mjb4 (~ = changed, + = added, - = dropped)

Notes:
Shared pagetables pt. 2 ... the revenge of shared pagetables.

~ discontig_x440				Pat Gaughen / IBM NUMA team
- srat_fixes					Pat Gaughen
+ kprobes					Vamsi Krishna S
+ dmc_exit1					Dave McCracken
+ dmc_exit2					Dave McCracken
+ shpte						Dave McCracken

Pending:
Linux Kernel Crash Dump
kirq interrupt balancing patch (Nitin Kamble)
auto_disable_tsc (John Stultz)
scheduler callers profiling (Anton)
PPC64 NUMA patches (Anton)
Child runs first (akpm)
Feral qlogic driver (Matthew Jacob and the SCSI crew)
Kexec
e1000 fixes
Non-PAE aligned kernel splits (Dave Hansen)


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

local_pgdat					William Lee Irwin
	Move the pgdat structure into the remapped space with lmem_map

numameminfo					Martin Bligh / Keith Mannthey
	Expose NUMA meminfo information under /proc/meminfo.numa

notsc						Martin Bligh
	Enable notsc option for NUMA-Q (new version for new config system)

mpc_apic_id					Martin J. Bligh
	Fix null ptr dereference (optimised away, but ...)

doaction					Martin J. Bligh
	Fix cruel torture of macros and small furry animals in io_apic.c

kgdb						Andrew Morton / Various People
	The older version of kgdb, synched with 2.5.54-mm1

noframeptr					Martin Bligh
	Disable -fomit_frame_pointer

ingosched					Ingo Molnar
	Modify NUMA scheduler to have independant tick basis.

schedstat					Rick Lindsley
	Provide stats about the scheduler under /proc/stat

sched_tunables					Robert Love
	Provide tunable parameters for the scheduler (+ NUMA scheduler)

# thread_info_cleanup (4K stacks pt 1)		Dave Hansen / Ben LaHaise
	Prep work to reduce kernel stacks to 4K
	
# interrupt_stacks    (4K stacks pt 2)		Dave Hansen / Ben LaHaise
	Create a per-cpu interrupt stack.

# stack_usage_check   (4K stacks pt 3)		Dave Hansen / Ben LaHaise
	Check for kernel stack overflows.

# 4k_stack            (4K stacks pt 4)		Dave Hansen
	Config option to reduce kernel stacks to 4K

discontig_x440					Pat Gaughen / IBM NUMA team
	SLIT/SRAT parsing for x440 discontigmem

acpi_x440_hack					Anonymous Coward
	Stops x440 crashing, but owner is ashamed of it ;-)

summit_smp					John Stultz
	Make Summit config options work on standard SMP

cyclone_fixes					John Stultz
	Fix up some stuff for the x440's cyclone timer

enable_cyclone					John Stultz
	Enable the x440's cyclone timer

lost_tick					John Stultz
	Detect lost timer ticks

frlock_xtime					Stephen Hemminger et al.
	Turn xtime_lock into an frlock to reduce contention 

frlock-xtime-i386				Stephen Hemminger et al.
	Turn xtime_lock into an frlock to reduce contention 

frlock-xtime-ia64				Stephen Hemminger et al.
	Turn xtime_lock into an frlock to reduce contention 

frlock-xtime-other				Stephen Hemminger et al.
	Turn xtime_lock into an frlock to reduce contention 

numaq_ioapicids					William Lee Irwin
	Stop 8 quad NUMA-Qs from panicing due to phys apicid "exhaustion".

oprofile_p4					John Levon
	Updates for oprofile for P4s. Needs new userspace tools.

starfire					Ion Badulescu
	64 bit aware starfire driver	

tcp_fix						Alexey
	Stop some tcp problem with hardware checksumming (e1000?)

numa_pci_fix					Dave Hansen
	Fix a potential error in the numa pci code from Stanford Checker

pgd_ctor					William Lee Irwin
	Use slabs for pgd

pfn_to_nid					William Lee Irwin
	Turn pfn_to_nid into a macro

-mjb						Martin Bligh
	Add a tag to the makefile

