Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265101AbRFUSql>; Thu, 21 Jun 2001 14:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbRFUSqa>; Thu, 21 Jun 2001 14:46:30 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24098 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265101AbRFUSqT>; Thu, 21 Jun 2001 14:46:19 -0400
Date: Thu, 21 Jun 2001 20:46:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.6pre5aa1
Message-ID: <20010621204618.C707@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diff between 2.4.6pre3aa2 and 2.4.6pre5aa1:

-------------------------------------------------------------
	Moved on top of 2.4.6pre5.

Only in 2.4.6pre3aa2: 00_alpha-warnings-1
Only in 2.4.6pre3aa2: 00_backout-udelay-1
Only in 2.4.6pre3aa2: 00_locks-1
Only in 2.4.6pre3aa2: 00_xircom-tulip-cb-2.4.5ac13-1
Only in 2.4.6pre3aa2: 10_alpha-udelay-1

	Merged in pre5.

Only in 2.4.6pre5aa1: 00_alpha-irq_err_count-1

	Fix alpha compile from Jeff.

	(recommended)

Only in 2.4.6pre5aa1: 00_bh-async-1

	Patch to Stefan.Bader@de.ibm.com to allow lowlevel layer
	to override bh->b_end_io callback without breaking the
	async I/O.

	(nice to have)

Only in 2.4.6pre3aa2: 00_ksoftirqd-6
Only in 2.4.6pre5aa1: 00_ksoftirqd-7

	%c1 do_softirq merged in mainline, fix reject.

Only in 2.4.6pre3aa2: 00_ksoftirqd-6_ppc-1
Only in 2.4.6pre5aa1: 00_ksoftirqd-7_ppc-2

	Dropped a comment (no code change). ('and' is really needed
	because lwz doesn't update the equal bit state of the cpu)

Only in 2.4.6pre3aa2: 10_no-virtual-1
Only in 2.4.6pre5aa1: 10_no-virtual-2

	Comments generated rejects, fixup.

Only in 2.4.6pre3aa2/30_tux: 30_tux-2
Only in 2.4.6pre5aa1/30_tux: 30_tux-3

	Include init.h to fix some compilation trouble and drop the
	__KERNEL_SYSCALLS__ #defines from the .c files.
-------------------------------------------------------------

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre5aa1/
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre5aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre5aa1/30_tux/
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre5aa1/40_experimental/

In the 40_experimental there's the latest blkdev in pagecache and it has
to be applied after all the other patches. Issue to solve in the
blkdev-pagecache-3 patch are:

-	fix ramdisk: lookup on pagecache and pin blkdev address space
	while the ramdisk stays allocated
-	I/O granularity is fixed to 4k, this can be easily decreased with
	a recompile, but I'm wondering if we should make the granularity
	dynamic somehow to avoid the partial write to do too many
	read-modify-write cycles
-	Currently the pagecache assumes the end of the device is aligned
	for excess on the next 4k (in genereal BUFFERED_BLOCKSIZE)
	boundary to be sure we can read and write all bytes of the disk.
	(see buffered_blk_size) I don't expect problems but blkdev layer
	must be able to cope with it.

I'm running this patch on all my systems and I didn't had problems yet
(though you cannot expect to get ramdisk and in turn initrd working
[ramfs works fine of course]). As said in a earlier email you can do
rawio now by simply openeing the blkdev with O_DIRECT (however you get
the BUFFERED_BLOCKSIZE granularity for it too, instead of the
hardblocksize granularity of the /dev/raw rawio, but this also means you
pay less cycles for bulding a flood of 512 bytes large bh) and mmap
private and shared on the blkdev works like with files in the fs.

Andrea
