Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbTAFCuR>; Sun, 5 Jan 2003 21:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265830AbTAFCuQ>; Sun, 5 Jan 2003 21:50:16 -0500
Received: from franka.aracnet.com ([216.99.193.44]:12760 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265828AbTAFCuO>; Sun, 5 Jan 2003 21:50:14 -0500
Date: Sun, 05 Jan 2003 18:58:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.5.54-mjb2 (scalability / NUMA patchset)
Message-ID: <214500000.1041821919@titus>
In-Reply-To: <821470000.1041579423@titus>
References: <19270000.1038270642@flay><134580000.1039414279@titus><32230000.1039502522@titus><568990000.1040112629@titus><21380000.1040717475@titus> <821470000.1041579423@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset contains mainly scalability and NUMA stuff, and anything
else that stops things from irritating me. It's meant to be pretty stable,
not so much a testing ground for new stuff.

I'd be very interested in feedback from anyone willing to test on any platform, however large or small.

http://www.aracnet.com/~fletch/linux/2.5.54/patch-2.5.54-mjb2.bz2

Since 2.5.54-mjb1 (mainly finished moving NUMA-Q into subarch).

- kgdb
+ kgdb (new version)				Andrew Morton / Various People
~ i386_caching_topo (rejigged)
+ cleanup_cpu_apicid				Martin Bligh
+ smpboot_cam					Martin Bligh
+ nuke_clustered_apic				Martin Bligh
~ interrupt_stacks (fixed a warning)
~ stack_usage_check (fixed a warning)
+ do_boot_error (this was in -mjb1, but I forgot it in the notes)

Also reordered a bunch of stuff.

Pending:
Speed up page init on boot (Bill Irwin)
Notsc automatic enablement
Full Summit support (James C / John)
scheduler callers profiling (Anton)
PPC64 NUMA patches (Anton)
Scheduler tunables (rml)
Lockless xtime structures (Andi)

kgdb						Andrew Morton / Various People
	The older version of kgdb, synched with 2.5.54-mm1

noframeptr					Martin Bligh
	Disable -fomit_frame_pointer

apicid_to_node					Martin Bligh
	Create an machine specific apicid_to_node for everyone

i386_topo					Matt Dobson
	Some i386 topology cleanups to make it cache the data.

do_boot_error					James Cleverdon
	Change do_boot_cpu to return an error code instead of fishing globally

fix_starfire_warning				Martin Bligh
	Fix trivial starfire compile warning that keeps annoying me.

shpte						Dave McCracken
	Shared pagetables (as a config option)

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

numasched1					Erich Focht
	Numa scheduler general foundation work + pooling

numasched2					Michael Hohnbaum
	Numa scheduler lightweight initial load balancing.

local_pgdat					Bill Irwin
	Move the pgdat structure into the remapped space with lmem_map

more_numaq1					James Cleverdon / Martin Bligh
	yet more Numa-Q subarch splitup

cleanup_cpu_apicid				Martin J. Bligh
	Cleanup & simplify the apicid <-> cpu mapping stuff I put in ages ago.

smpboot_cam					Martin J. Bligh
	Remove clustered_apic_mode stuff from smpboot.c

nuke_clustered_apic				Martin J. Bligh
	Kill clustered_apic_mode and CONFIG_CLUSTERED_APIC forever.

thread_info_cleanup (4K stacks pt 1)		Dave Hansen / Ben LaHaise
	Prep work to reduce kernel stacks to 4K
	
interrupt_stacks    (4K stacks pt 2)		Dave Hansen / Ben LaHaise
	Create a per-cpu interrupt stack.

stack_usage_check   (4K stacks pt 3)		Dave Hansen / Ben LaHaise
	Check for kernel stack overflows.

4k_stack            (4K stacks pt 4)		Dave Hansen
	Config option to reduce kernel stacks to 4K

notsc						Martin Bligh
	Enable notsc option for NUMA-Q (new version for new config system)

numameminfo					Martin Bligh / Keith Mannthey
	Expose NUMA meminfo information under /proc/meminfo.numa

kallsyms					Andi Kleen / Daniel Ritz
	Fix some bug.

-mjb						Martin Bligh
	Add a tag to the makefile

