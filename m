Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTKZRDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTKZRDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:03:40 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:36009 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264272AbTKZRDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:03:34 -0500
Date: Wed, 26 Nov 2003 09:03:26 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.0-test10-mjb1
Message-ID: <16090000.1069866206@[10.10.2.4]>
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

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.0-test10/patch-2.6.0-test10-mjb1.bz2

Since 2.6.0-test9-mjb3 (~ = changed, + = added, - = dropped)

Notes:  Mostly a merge forwards.

Now in Linus' tree:

Dropped:

- imcplicit_large_page				Adam Litke
	Breaks PPC64 build. New patch soon.

New:

+ scsi_fix					Mike Anderson
	Fix kobject oops.

+ pci_topology					Matt Dobson
	Expose PCI NUMA topology to userspace

Pending:
lotsa_sds
config_numasched
4/4 split
list_of_lists
Hyperthreaded scheduler (Ingo Molnar)
scheduler callers profiling (Anton or Bill Hartner)
Child runs first (akpm)
Kexec
e1000 fixes
pidmaps_nodepages (Dave Hansen)

Present in this patch:

kgdb						Various
	Stolen from akpm's 2.6.0-test9-mm2

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

ext2_fix					Andrew Morton
	Fix a race in ext2

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

scsi_fix					Mike Anderson
	Fix kobject oops.

pci_topology					Matt Dobson
	Expose PCI NUMA topology to userspace


-mjb						Martin J. Bligh
	Add a tag to the makefile


