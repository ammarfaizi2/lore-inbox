Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266198AbRGESfu>; Thu, 5 Jul 2001 14:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266207AbRGESfk>; Thu, 5 Jul 2001 14:35:40 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:19770 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266198AbRGESfc>; Thu, 5 Jul 2001 14:35:32 -0400
Date: Thu, 5 Jul 2001 20:35:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7pre2aa1
Message-ID: <20010705203547.C2425@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The main new thing is the blkdev in pagecache by default (not in the
experimental dir anymore). Ramdisk and initrd should work fine now
(initrd is untested though). It also fixes a vm deadlock and merges uml
from -ac.

----------------------------------------------------------------
Diff between 2.4.6pre5aa1 and 2.4.7pre2aa1:

Only in 2.4.6pre5aa1: 00_irda-2.4.5ac13-1.bz2
Only in 2.4.6pre5aa1: 00_swapinfo-1
Only in 2.4.6pre5aa1: 00_numa-compile-1
Only in 2.4.6pre5aa1: 00_alpha-irq_err_count-1
Only in 2.4.6pre5aa1: 00_bootmem-header-1

	Merged in in mainline.

Only in 2.4.7pre2aa1/: 00_3c59x-zerocopy-1

	Fix from Andi to allow zerocopy networking on
	HIGHMEM enabled kernel running on non highmem
	hardware.

Only in 2.4.6pre5aa1: 00_double-buffer-pass-1
Only in 2.4.7pre2aa1/: 00_double-buffer-pass-2

	Rediffed on top of the new sync logic.

Only in 2.4.7pre2aa1/: 00_increase-logbuffer-1

	Increase dmesg buffer for long bootup logs.

Only in 2.4.6pre5aa1: 00_ksoftirqd-6_ia64-1
Only in 2.4.7pre2aa1/: 00_ksoftirqd-7_ia64-2

	Fix from Andreas S.

Only in 2.4.6pre5aa1: 00_nanosleep-4
Only in 2.4.7pre2aa1/: 00_nanosleep-5

	Fixed a stupid merging bug. (spotted by Andi)

Only in 2.4.6pre5aa1: 00_rwsem-13
Only in 2.4.7pre2aa1/: 00_rwsem-14

	Rediffed to fix minor reject.

Only in 2.4.7pre2aa1/: 00_swapfiles-1

	Increase the max number of swapfiles (should
	be dynamic oh well).

Only in 2.4.7pre2aa1/: 00_vm-deadlock-fix-1

	Fix VM deadlock with GFP_NOFS.

Only in 2.4.7pre2aa1/: 10_blkdev-pagecache-4

	Move blkdev in pagecache. Ramdisk should be rock solid,
	even better than before, the rd_blocksize is meaningless
	these days so it won't break regardless of the blocksize
	used by the fs like it could happen before.

	Only last pending points are:

	1) blkdev with a size not multiple of PAGE_CACHE_SIZE, need
	   to check nothing fatal happens in that case with some
	   simulation.

	2) about performance, Chel van Gennip raised a point about granularity
	   of the I/O to avoid read-modify-write (which is easily selectable at
	   compile time like in 2.2, by default it is 4k for streming I/O
	   performance reason, order of magnitude faster)
	   The question is if we should change the granularity dynamically, and
	   if we should also handle partial reads similarly to what we do with
	   the partial writes. (this way a partial write followed by a partial read
	   would generate no I/O besides the async flush of the dirty block)
	   However this is a performance point, not really a functional/stability point.

Only in 2.4.6pre5aa1/30_tux: 30_atomic-alloc-1
Only in 2.4.7pre2aa1/30_tux: 30_atomic-alloc-2

	Rediffered to fix trivial reject.

Only in 2.4.6pre5aa1: 40_experimental

	Gone away as blkdev in pagecache is included by default.

Only in 2.4.7pre2aa1/: 50_uml-arch-2.4.5ac17.bz2
Only in 2.4.7pre2aa1/: 50_uml-common-1.bz2
Only in 2.4.7pre2aa1/: 51_uml-ac-to-aa-1.bz2

	Merged in uml from -ac.
----------------------------------------------------------------

Andrea
