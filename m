Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313896AbSDZL3a>; Fri, 26 Apr 2002 07:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313862AbSDZL33>; Fri, 26 Apr 2002 07:29:29 -0400
Received: from [195.223.140.120] ([195.223.140.120]:28700 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313827AbSDZL3Y>; Fri, 26 Apr 2002 07:29:24 -0400
Date: Fri, 26 Apr 2002 13:29:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre7aa2
Message-ID: <20020426132936.B19278@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre7aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre7aa2/

Changelog diff between 2.4.19pre7aa1 and 2.4.19pre7aa2:

Only in 2.4.19pre7aa2: 00_bh-IPI-1

	Drop the pointless _bh from the IPI-send locking,
	sending any IPI from a softirq would deadlock
	regardless of the _bh. Cleanup from Dipankar Sarma.

Only in 2.4.19pre7aa1: 00_get_pid-no-deadlock-and-boosted-1
Only in 2.4.19pre7aa2: 00_get_pid-no-deadlock-and-boosted-2

	Ihno Krumreich fixed two bugs in the previous implementation
	(incorrect calculation of next_unsafe from pid_bitmap and now check
	retval of get_pid).

	While merging the two fixes, I found a longstanding SMP race that can
	trigger in 2.2 too, it will lead to a PID collision. So fixed it
	as well, too bad the semaphore will add some more serialization, but it's
	the less intrusive fix. Another possibility is to link the task within
	the ex lastpid_lock, but then some tons of stuff would break for example
	because we assume a task visible in the tasklist is just set up to
	receive signals, etc... so this is the obviously safe fix even if
	it has some scalability drawbacks with simultaneous fork flood from
	multiple cpus (hopefully not a common case :). The boost remains in
	the common case thanks to the linear complexity and always using asm
	bitops to scan the array.

Only in 2.4.19pre7aa1: 00_mmx_xmm-init-1
Only in 2.4.19pre7aa2: 00_mmx_xmm-init-2
Only in 2.4.19pre7aa1: 85_x86_64-mmx-xmm-init-1
Only in 2.4.19pre7aa2: 85_x86_64-mmx-xmm-init-2

	Initialize the fpu with fxrestor when fxsr is enabled and avoid memset
	in the fast path, should be faster than 2.5.10.
	While implementing it found another problem with ptrace that is cleanly
	fixed too.

Only in 2.4.19pre7aa1: 05_vm_17_rest-2
Only in 2.4.19pre7aa2: 05_vm_17_rest-3

	Two marginal cleanups (no difference in practice).

Only in 2.4.19pre7aa1: 10_numa-sched-17
Only in 2.4.19pre7aa2: 10_numa-sched-18
Only in 2.4.19pre7aa1: 90_init-survive-threaded-race-1
Only in 2.4.19pre7aa2: 90_init-survive-threaded-race-2
Only in 2.4.19pre7aa1: 82_x86-64-compile-aa-4
Only in 2.4.19pre7aa2: 82_x86-64-compile-aa-5
Only in 2.4.19pre7aa1: 87_x86_64-dec_and_lock-1
Only in 2.4.19pre7aa2: 87_x86_64-dec_and_lock-2

	Rediffed.

Only in 2.4.19pre7aa1: 20_pte-highmem-22
Only in 2.4.19pre7aa2: 20_pte-highmem-23

	Merged some missing #include. From Hubert.

Only in 2.4.19pre7aa1: 80_x86_64-common-code-2
Only in 2.4.19pre7aa2: 80_x86_64-common-code-3
Only in 2.4.19pre7aa1: 81_x86_64-arch-3.gz
Only in 2.4.19pre7aa2: 81_x86_64-arch-4.gz

	Go in sync with the latest updates in CVS HEAD at cvs.x86-64.org from
	Andi/SuSE Labs.

Only in 2.4.19pre7aa2: 91_zone_start_pfn-1

	s/paddr/pfn/ original patch from Martin J. Bligh, needed by
	NUMA-Q to start nodes and in turn zones above 4G. I found
	a few compilation glitches in some non-x86 arch code this
	version of the patch should be corrected.

Only in 2.4.19pre7aa2: 92_core-dump-seek-unmapped-1

	Skip over unmapped nonfilebacked pages during core dumping,
	the caller of get_user_pages is just smart enough to seek when
	it gets the zero page so that it makes holes as well on disk.
	All readers should be unaffected by this change: a page in a vma that
	can be read (VM_MAYREAD|VM_READ depending on force) and that isn't
	filebacked must always read zero, so passing the zeropage instead of
	filling the pagetables seems a fine optimization. In particular
	it avoids some huge I/O load and oom true condition (triggered by
	pagetable allocations) during core dumping with some stack usage.

Andrea
