Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSE3BBN>; Wed, 29 May 2002 21:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315993AbSE3BBM>; Wed, 29 May 2002 21:01:12 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:65110 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315988AbSE3BBK>; Wed, 29 May 2002 21:01:10 -0400
Date: Thu, 30 May 2002 03:01:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre9aa1
Message-ID: <20020530010125.GA1383@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: this release is highly experimental, while it worked solid so far
it's not well tested yet, so please don't use in production
environments! (yet :)

The o1 scheduler integration will take a few weeks to settle and to
compile on all archs. I would suggest the big-iron folks to give this
kernel a spin, in particular for o1, shm-rmid fix, p4/pmd fix,
inode-leak fix. The only rejected feature is been the node-affine
allocations of per-cpu data structures in the numa-sched (matters only
for numa, but o1 is more sensible optimization for numa anyways).
Currently only x86 and alpha compiles and runs as expected. x86-64,
ia64, ppc, s390*, sparc64 doesn't compile yet. uml worst of all compiles
but it doesn't run correctly :), however it runs pretty well too, simply
it hangs sometime and you've to press a key in the terminal and then it
resumes as if nothing has happened.

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre9aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre9aa1/

Diff between 2.4.19pre8aa3 and 2.4.19pre9aa1 besides migrating to pre9.

Only in 2.4.19pre8aa3: 00_block-highmem-all-18b-11.gz
Only in 2.4.19pre9aa1: 00_block-highmem-all-18b-12.gz
Only in 2.4.19pre8aa3: 00_x86-fast-pte-1
Only in 2.4.19pre9aa1: 10_x86-fast-pte-2
Only in 2.4.19pre8aa3: 20_pte-highmem-24
Only in 2.4.19pre9aa1: 20_pte-highmem-25
Only in 2.4.19pre8aa3: 30_x86_setup-boot-cleanup-3
Only in 2.4.19pre9aa1: 30_x86_setup-boot-cleanup-4
Only in 2.4.19pre8aa3: 90_init-survive-threaded-race-2
Only in 2.4.19pre9aa1: 90_init-survive-threaded-race-3
Only in 2.4.19pre8aa3: 91_zone_start_pfn-3
Only in 2.4.19pre9aa1: 91_zone_start_pfn-5
Only in 2.4.19pre8aa3: 93_NUMAQ-1
Only in 2.4.19pre9aa1: 93_NUMAQ-2

	Rediffed.

Only in 2.4.19pre8aa3: 00_compile-nfsroot-1
Only in 2.4.19pre8aa3: 00_initrd-free-2
Only in 2.4.19pre8aa3: 00_ufs-compile-1

	Merged in mainline.

Only in 2.4.19pre8aa3: 00_cpu-affinity-rml-3

	Dropped (collided with o1 and it's not needed).

Only in 2.4.19pre8aa3: 00_cpu-affinity-syscall-rml-2.4.19-pre7-1
Only in 2.4.19pre9aa1: 00_cpu-affinity-syscall-rml-2.4.19-pre9-1

	Ported to the o1 sched with the -ac patch in rml/sched.

Only in 2.4.19pre8aa3: 00_dnotify-cleanup-1
Only in 2.4.19pre9aa1: 00_dnotify-cleanup-2

	Just keep the leftover out deletion in -ac.

Only in 2.4.19pre9aa1: 00_ext2-ext3-warning-1

	Warning when mounting an ext3 as an ext2 from Andrew Morton.

Only in 2.4.19pre9aa1: 00_free_pgtable-and-p4-tlb-race-fixes-1

	Fix the pagetable freeing races introduced by the speculative
	random userspace tlb fills of the p4, patch discussed on l-k.
	Also fix a definitive kernel smp race condition in free_pgtables.

Only in 2.4.19pre8aa3: 00_get_pid-no-deadlock-and-boosted-3
Only in 2.4.19pre9aa1: 10_get_pid-no-deadlock-and-boosted-4

	Discard the inferior attempt in pre9 and rediff (as Ihno noticed in
	practice the complexity dominates, if you fill the pid space the fix in
	mainline is useless anyways). Wonder why this much better fix isn't
	been merged instead (it is been submitted for both 2.2 and 2.4).
	This also fix a longstanding fork race present even in 2.2 that can
	lead to two tasks getting the same pid.

Only in 2.4.19pre9aa1: 00_negative-dentry-waste-ram-1

	Collect negative dentries after unlink or creat-failure
	(discussed on l-k, for 2.5 a very-low-prio lru list can
	be implemented instead).

Only in 2.4.19pre8aa3: 00_rcu-poll-5
Only in 2.4.19pre9aa1: 10_rcu-poll-6

	Ported to the o1 scheduler, this has a fix in force_cpu_reschedule
	compared to the rcu-poll patch in 2.5, and also it saves cachelines
	by colaescing the per-cpu quiescent sequence number in the runqueue
	structure, the quiescent will be increased at every schedule() call
	(i.e. every time we reach the quiescent point), so it is optimal
	to coalesce it in the same cacheline with the other fields later used
	by schedule(). the per-cpu quiescent++ is the _only_ fixed cost of
	rcu-poll, this is been a design choice to keep the fast-path overhead
	as low as possible.

Only in 2.4.19pre9aa1: 00_sched-O1-rml-2.4.19-pre9-1.gz

	2.5 O1 scheduler from Ingo Molnar backported to 2.4 from Robert Love.

Only in 2.4.19pre9aa1: 00_shm_destroy-deadlock-1

	Fix SMP deadlock due scheduling with spinlock held in IPC_RMID
	(fput is a blocking operation).

Only in 2.4.19pre9aa1: 00_vm86-pagetablelock-1

	Add pagetable lock to the vm86 pagetable walking,
	from Benjamin LaHaise.

Only in 2.4.19pre9aa1: 02_sched-19pre8ac5-1

	Use the wq locks so it stays generic and the switch in wait.h
	doesn't break. From -ac o1 sched comparison.

Only in 2.4.19pre9aa1: 02_sched-alpha-1

	alpha updates to make o1 working. This is also a good tutorial
	to port all the other archs.

Only in 2.4.19pre9aa1: 02_sched-sparc64-1

	Little attempt, only takes care of two bits, still lots of stuff
	missing for sparc64 and x86-64, they won't compile at the moment.

Only in 2.4.19pre9aa1: 02_sched-x86-1

	Additional fix for x86 (needed because of the rcu-poll changes
	to make the runqueue structure visible to the common code).

Only in 2.4.19pre8aa3: 05_vm_03_vm_tunables-1
Only in 2.4.19pre9aa1: 05_vm_03_vm_tunables-2
Only in 2.4.19pre8aa3: 05_vm_06_swap_out-1
Only in 2.4.19pre9aa1: 05_vm_06_swap_out-2
Only in 2.4.19pre8aa3: 05_vm_07_local_pages-1
Only in 2.4.19pre9aa1: 05_vm_07_local_pages-2
Only in 2.4.19pre8aa3: 05_vm_08_try_to_free_pages_nozone-1
Only in 2.4.19pre9aa1: 05_vm_08_try_to_free_pages_nozone-2
Only in 2.4.19pre8aa3: 05_vm_09_misc_junk-1
Only in 2.4.19pre9aa1: 05_vm_09_misc_junk-2
Only in 2.4.19pre8aa3: 05_vm_17_rest-4
Only in 2.4.19pre9aa1: 05_vm_17_rest-7

	Various random rediffing to sync with the o1 scheduler
	introduction.

Only in 2.4.19pre9aa1: 05_vm_18_buffer-page-uptodate-1

	Optimization to avoid losing the page-uptodate information
	while dropping the bh, from Andrew Morton.

Only in 2.4.19pre9aa1: 10_inode-highmem-1

	Avoid highmem pagecache to pin inodes in memory undefinitely,
	if we detect the "pinned inode" condition we shrink the cache.
	This should fix the last (known :) highmem vm unbalance problem.

Only in 2.4.19pre8aa3: 10_numa-sched-18

	Dropped in favour of the o1 scheduler, but it's not obsoleted
	by the o1 scheduler, for istance all the runqueue should go into
	the zone local memory so even the spinlocks are local etc...

Only in 2.4.19pre9aa1: 10_o1-sched-64-cpu-1

	Fix 64bit bug in o1 scheduler.

Only in 2.4.19pre9aa1: 10_o1-sched-fixes-1

	Other o1 sched fixes.

Only in 2.4.19pre9aa1: 10_o1-sched-nfs-1

	Fix nfs to compile with the o1 scheduler.

Only in 2.4.19pre9aa1: 10_parent-timeslice-10
Only in 2.4.19pre8aa3: 10_parent-timeslice-9

	Port this longstanding scheduler fix in the "share" timeslice
	algorithm on top of the o1 scheduler (with o1 the coding of the
	algorithm changed but the bug was stll there). This bug
	is been noticed in real life workloads that rendered the machine
	not interactive during intensive bash/exec/wait workloads.

Only in 2.4.19pre8aa3: 10_tlb-state-2
Only in 2.4.19pre9aa1: 10_tlb-state-3

	Mainline patch is inferior, backedout and resurrected this one.

Only in 2.4.19pre8aa3: 20_share-timeslice-2

	Obsoleted by the o1 scheduler, I missed the code in
	wake_up_forked_process, I didn't verified that it really works as
	expected in practice with gdb but the code looked ok. We'll see
	with the next round of benchmarks from Randy (the fact 2.5 wasn't
	forking as fast as previous -aa make me to think it might be
	related to an difference here).

Only in 2.4.19pre8aa3: 30_dyn-sched-6

	Obsoleted in favour of o1 that also provides similar
	dynamic priority.

Only in 2.4.19pre8aa3: 50_uml-patch-2.4.18-25.gz
Only in 2.4.19pre9aa1: 50_uml-patch-2.4.18-30.gz

	New patch from Jeff. NOTE: this compiles with o1 but
	it hangs sometime until you press a character on the
	konsole and then it restarts like if it didn't hanged,
	I checked schedule_ticks keeps running and that rq->nr_running
	is zero, so I'm not sure what's wrong at the moment. Could
	even be a bug between -29 and -30, I tested only -30 with
	o1, OTOH -29 was working fine w/o o1. Jeff could you
	give a spin to 2.4.19pre9aa1 and see what's wrong with uml?
	(sounds like a problem with the uml internals that you certainly
	know better than anyone else :)

Only in 2.4.19pre8aa3: 51_uml-ac-to-aa-8
Only in 2.4.19pre9aa1: 51_uml-ac-to-aa-9
Only in 2.4.19pre9aa1: 51_uml-o1-1
Only in 2.4.19pre8aa3: 57_uml-dyn_sched-1
Only in 2.4.19pre8aa3: 59_uml-yield-1
Only in 2.4.19pre9aa1: 59_uml-yield-2

	Various updates to compile with o1.

Only in 2.4.19pre8aa3: 60_show-stack-1
Only in 2.4.19pre9aa1: 62_tux-dump-stack-1

	Use dump_stack instead.

Only in 2.4.19pre8aa3: 60_tux-exports-3
Only in 2.4.19pre9aa1: 60_tux-exports-4
Only in 2.4.19pre8aa3: 60_tux-kstat-3
Only in 2.4.19pre9aa1: 60_tux-kstat-4
Only in 2.4.19pre9aa1: 60_tux-o1-1

	Further o1 scheduler updates this time for tux.

Only in 2.4.19pre8aa3: 70_xfs-1.1-1.gz
Only in 2.4.19pre9aa1: 70_xfs-1.1-2.gz
Only in 2.4.19pre9aa1: 75_compile-dmapi-1

	Rediffed.

Only in 2.4.19pre8aa3: 80_x86_64-common-code-3
Only in 2.4.19pre9aa1: 80_x86_64-common-code-4
Only in 2.4.19pre8aa3: 82_x86-64-compile-aa-5
Only in 2.4.19pre9aa1: 82_x86-64-compile-aa-6

	Some fixup for rejects and first o1 bits, but not complete yet.

Andrea
