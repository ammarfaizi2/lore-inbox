Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265333AbUAJT3a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbUAJT3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:29:30 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:27532 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265333AbUAJT3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:29:03 -0500
Date: Sat, 10 Jan 2004 11:28:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.1-mjb1
Message-ID: <78850000.1073762932@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset is meant to be pretty stable, not so much a testing ground.
Main differences from mainline are:

1. Better performance & resource consumption, particularly on larger machines.
2. Diagnosis tools (kgdb, early_printk, etc).
3. Updated arch support for AMD64 + PPC64.
4. Better support for sound, especially OSS emulation over ALSA.
5. Better support for video (v4l2, bttv, ivtv).
6. Kexec support.

I'd be very interested in feedback from anyone willing to test on any 
platform, however large or small.

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.1/patch-2.6.1-mjb1.bz2

Since 2.6.1-rc3-mjb1 (~ = changed, + = added, - = dropped)

Notes:  

-----------------------------------------------------------------------

Now in Linus' tree:

Dropped:

New:

+ kgdboe_build_fix				Andrew Morton
	Fix kgdboe stuff so non-ia32 platforms build

+ kgdb_x86_64					Jim Houston
	Support kgdb on x86_64

+ kgdb_gdb6_patches				Jim Houston
	Patches for gdb to support kgdb on x86_64, under scripts/kgdb/

+ build_options_on_oops				Andrew Morton
	Print out the build options when we oops.

+ use_minus_p					Martin J Bligh
	Fix docs to make people use -p. It's good for your soul.

+ kcg_gcc_detect				Adam Litke
	Detect older gcc versions that don't work with mcount, and crap out

Pending:
config_numasched
list_of_lists
Hyperthreaded scheduler (Ingo Molnar)
Child runs first (akpm)
pidmaps_nodepages (Dave Hansen)
Netdump
Netconsole

Present in this patch:

-mjb						Martin J. Bligh
	Add a tag to the makefile

netdrvr_2.6.1_rc1_exp1				Jeff Garzik
	Net driver kit, including the netpoll infrastructure.

kgdb						Various
	Stolen from akpm's 2.6.0-mm1, includes fixes

kgdboe_netpoll					Matt Mackall et al.
	Kgdb over ethernet support that works with the netpoll infrastructure

kgdboe_build_fix				Andrew Morton
	Fix kgdboe stuff so non-ia32 platforms build

kgdb_x86_64					Jim Houston
	Support kgdb on x86_64

kgdb_gdb6_patches				Jim Houston
	Patches for gdb to support kgdb on x86_64, under scripts/kgdb/

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


oops_dump_preceding_code			Andrew Morton
	dump opcodes preceding and after the offending EIP.

4g4g						Ingo Molnar
	Provide a 4G/4G user/kernel split for 32 bit memory lushes.

lotsa_sds					Badari
	Enable lots of scsi disks

x86-64						Andi Kleen et al.
	x86_64 patch kit, 2.6.0-1

build_options_on_oops				Andrew Morton
	Print out the build options when we oops.

use_minus_p					Martin J Bligh
	Fix docs to make people use -p. It's good for your soul.

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

kcg_gcc_detect					Adam Litke
	Detect older gcc versions that don't work with mcount, and crap out

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

fasync_lock_rcu					Manfred Spraul
	Use RCU for fasync_lock

lockmeter_ia64					Ray Bryant
	Add a config option for lockmeter on ia64

4g4g_sep_fix					Ingo Molnar
	Fix SEP on 4g/4g split

4g4g_sysenter_test_fix				Arjan
	Fix sysenter detection

4g4g_locked_copy				Dave McCracken
	Locked copy to userspace

kexec						Eric Biederman et al.
	Exec a kernel for breakfast today.

alsa_100rc2					ALSA project
	New code drop of sound infrastructure - fixes various bugs.

force_wholefrag					Martin J. Bligh et al.
	OSS emulation sounds like crap without wholefrag. Revert that change.

lockmeter_notsc					Martin J. Bligh
	Lockmeter does not require CONFIG_X86_TSC.

smp_boot_id					Martin J. Bligh
	Fix panic if boot cpu's phys apicid doesn't match expected.

sysfs_backing_store1				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

sysfs_backing_store2				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

sysfs_backing_store3				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

sysfs_backing_store4				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

sysfs_backing_store5				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

scsi_changer					Gerd Knorr

videodev					Gerd Knorr

v4l2						Gerd Knorr
	Video 4 Linux 2

video_buf					Gerd Knorr

bt832						Gerd Knorr

i2c						Gerd Knorr

ir_input					Gerd Knorr

tuner						Gerd Knorr

bttv						Gerd Knorr

bttv_input					Gerd Knorr

saa7134						Gerd Knorr

bttv_documentation				Gerd Knorr

tiocgdev					Gerd Knorr

ivtv						Kevin Thayer / Steven Fuerst
	Driver for ivtv (includes Hauppauge PVR 250 / 350)
	Written by Kevin Thayer, ported to 2.6 by Steven Fuerst




