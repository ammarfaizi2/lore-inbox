Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbTAUDzg>; Mon, 20 Jan 2003 22:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbTAUDzf>; Mon, 20 Jan 2003 22:55:35 -0500
Received: from [195.223.140.107] ([195.223.140.107]:2944 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265409AbTAUDzd>;
	Mon, 20 Jan 2003 22:55:33 -0500
Date: Tue, 21 Jan 2003 05:06:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21pre3aa1
Message-ID: <20030121040628.GD1257@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre3aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre3aa1/

diff between 2.4.21pre2aa2 and 2.4.21pre3aa1:

Only in 2.4.21pre2aa2: 00_apm-do_read-1
Only in 2.4.21pre2aa2: 20_apm-o1-sched-1
Only in 2.4.21pre2aa2: 9970_corename-2.gz

	Merged in mainline.

Only in 2.4.21pre2aa2: 00_extraversion-15
Only in 2.4.21pre3aa1: 00_extraversion-16
Only in 2.4.21pre2aa2: 00_sched-O1-aa-2.4.19rc3-7.gz
Only in 2.4.21pre3aa1: 00_sched-O1-aa-2.4.19rc3-8.gz
Only in 2.4.21pre2aa2: 10_o_direct-open-check-2
Only in 2.4.21pre3aa1: 10_o_direct-open-check-3
Only in 2.4.21pre2aa2: 30_09_o_direct-1
Only in 2.4.21pre3aa1: 30_09_o_direct-2
Only in 2.4.21pre2aa2: 70_xfs-sysctl-1
Only in 2.4.21pre3aa1: 70_xfs-sysctl-2
Only in 2.4.21pre3aa1: 9910_shm-largepage-10.gz
Only in 2.4.21pre2aa2: 9910_shm-largepage-9.gz

	Rediffed.

Only in 2.4.21pre3aa1: 00_o_direct-align-1

	Fix alignment check.

Only in 2.4.21pre3aa1: 00_one_highpage_init-cleanup-1

	Cleanup from J.A. Magallon backported from 2.5.

Only in 2.4.21pre2aa2: 00_semop-timeout-1
Only in 2.4.21pre3aa1: 00_semop-timeout-2

	Add ia32 emulation of the syscall to ia64 (forwarded by Andrew).

Only in 2.4.21pre3aa1: 00_vmalloc-ltp-crash-1

	Fix oops with ltp (still log, doesn't need to be rate limited
	since it's a privilegied call and printing it is useful
	for debugging but it doesn't crash).

Only in 2.4.21pre3aa1: 05_vm_22_vm-anon-lru-1

	SMP scalability feature that increase performance of 20% on some
	16-way. VM will be less aware when it's time to start swapping, this
	may be even better for some DB workload, but it could be a little worse
	for very small boxes. The first seconds of swap could be less smooth.
	If you want the VM to always have visibility of anon pages just set
	this sysctl to 1: /proc/sys/vm/vm_anon_lru. Default is set to zero.
	After the first swapouts the anon pages will be left into the lru and
	the behaviour will be equivalent to vm_anon_lru set to 1.

Only in 2.4.21pre3aa1: 05_vm_23_per-cpu-pages-1

	Add per-cpu-pages in front of the allocator, this brings several dozen
	points percent to some 16-way too, this along with the vm-anon-lru
	drops all the global locks in the anonymous memory allocation page fault
	fast path, and if applied together they nearly doubles performance of
	very parallel SMP workloads.

	This patch is based on the original code from Ingo Molnar but the
	refill/allocation decisions are quite different, and this as well is
	made to work fine with the per-point-of-view watermarks.

Only in 2.4.21pre2aa2: 10_rawio-vary-io-16
Only in 2.4.21pre3aa1: 10_rawio-vary-io-17

	Add some exports for modules needing these functionalities.

Only in 2.4.21pre2aa2: 93_NUMAQ-8
Only in 2.4.21pre3aa1: 93_NUMAQ-9

	Should fix compilation (reported by William Lee Irwin III)

Only in 2.4.21pre2aa2: 9985_blk-atomic-aa4
Only in 2.4.21pre3aa1: 9985_blk-atomic-aa5

	Remeber to start with blk_elv_seq set to 0 by default (or it can
	hang with synchronous-rawio followed by async-io-rawio).

Only in 2.4.21pre3aa1: 9995_frlock-gettimeofday-1

	Added patch from Stephen Hemminger that uses the two sequence
	numbers to bring total SMP scalability to gettimeofday and
	implements a frlock framework that can replace read/write locks.
	This way the fr_write_lock is also fair, and it cannot get starved
	by the readers (unlike the plain read_lock where we depend on the
	unfariness to avoid clearing irq in the readers if the writes will
	never run from irqs). Avoiding starvation of writes make sure not to
	lose timer ticks (and in turn system time), in particular on numa or
	big smp.  The locking design is the same of the one implemented in the
	x86-64 vsyscalls, except here the reader is still in kernel so it's
	still some order of magnitude slower than x86-64, but at least the smp
	scalability is total and the starvation is gone. This also includes a
	critical race fix from me to make the code stable, and some porting
	work from Andreas Schwab.

Andrea
