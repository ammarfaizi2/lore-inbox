Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289179AbSAVGrW>; Tue, 22 Jan 2002 01:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288114AbSAVGrN>; Tue, 22 Jan 2002 01:47:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:22042 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287874AbSAVGrA>; Tue, 22 Jan 2002 01:47:00 -0500
Date: Tue, 22 Jan 2002 07:48:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18pre4aa1
Message-ID: <20020122074806.A1547@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first release moving the pagetables in highmem. It only
compiles on x86 and it is still a bit experimental. I couldn't reproduce
problems yet though. the new pte-highmem patch can be downloaded from
here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre4aa1/20_pte-highmem-6

Next relevant things to do are the non-x86 archs compilation, and I'd
like to sort out the vary-IO for rawio and the hardblocksize-O_DIRECT
patch.

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre4aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre4aa1/

Diff between 2.4.18pre2aa2 and 2.4.18pre4aa1 follows:

Only in 2.4.18pre2aa2: 00_3.5G-address-space-2
Only in 2.4.18pre4aa1/: 00_3.5G-address-space-3

	Merge 1-2-3 GB option.

Only in 2.4.18pre4aa1/: 00_access_process_vm-1

	Fix oops in access_process_vm (get_area_pages will
	set the page pointer to NULL on non-ram maps).

Only in 2.4.18pre4aa1/: 00_allow_mixed_b_size-1

	This is the groundwork for the O_DIRECT-hardblocksize
	patch, and for the IOvary patch for rawio.

	In short this prevents the merging of different b_size
	in the same request at the blkdev layer. After I mentioned
	this Jens immediatly sent me a patch and here it is.

	So now I'd suggest to drop the varyIO thing which shouldn't
	be necessary any longer, and to port the rawio-large-bsize
	patch, and the O_DIRECT hardblocksize patches on top of
	my current tree. I'd like to include both. Of course the
	O_DIRECT-hardblocksize patch can also take advantage of
	the large-b_size improvement to brw_kiovec during large
	requests hardblocksize aligned. At least unless we want
	to change the alignment requirements, in such a case
	the varyIO info would be still valuable.

	About the O_DIRECT-hardblocksize patch there's also another problem
	though, if the get_block says that the buffer is new(), then
	the whole "soft" block must be cleared out, if not written
	to completly implicitly by the write. I just fixed similar bugs in
	presence of I/O errors or ENOSPC with O_DIRECT, and I don't want to
	reintroduce the very same problem while adding a new feature. The
	buffer_new() path is a very slow path for the DB usage point of view,
	so it's perfectly fine there to just writeout the zero page (or
	something like that) on the blocks around in a synchronous manner etc..

Only in 2.4.18pre4aa1/: 00_icmp-offset-1

	Remote security fix from Andi (see bugtraq).

Only in 2.4.18pre4aa1/: 00_init-blk-freelist-1

	Requests cmd wasn't initialized when first queued into the blkdev,
	so if dequeued and then re-enqueued without being used, they could get
	unbalanced. Now always initialize it during get_request, so it certainly
	works right.

Only in 2.4.18pre2aa2: 00_msync-ret-1
Only in 2.4.18pre2aa2: 00_page-cache-release-1
Only in 2.4.18pre2aa2: 00_ramdisk-buffercache-2
Only in 2.4.18pre2aa2: 00_truncate-garbage-1

	Merged in mainline.

Only in 2.4.18pre2aa2: 00_vmalloc-tlb-flush-1

	Merged into mainline (modulo Jeff having implemented pagetable
	walking/tlb misses into uml that doesn't assume the tlb
	flush [ouch, right Andrew, tlb invalidate :) ] cames first).

Only in 2.4.18pre2aa2: 00_nfs-2.4.17-cto-1
Only in 2.4.18pre4aa1/: 00_nfs-2.4.17-cto-2
Only in 2.4.18pre2aa2: 00_nfs-bkl-1
Only in 2.4.18pre4aa1/: 00_nfs-bkl-2
Only in 2.4.18pre2aa2: 00_nfs-rdplus-1
Only in 2.4.18pre4aa1/: 00_nfs-rdplus-2
Only in 2.4.18pre2aa2: 00_nfs-svc_tcp-1
Only in 2.4.18pre4aa1/: 00_nfs-svc_tcp-2
Only in 2.4.18pre2aa2: 00_nfs-tcp-tweaks-1
Only in 2.4.18pre4aa1/: 00_nfs-tcp-tweaks-2
Only in 2.4.18pre4aa1/: 10_nfs-o_direct-1

	New NFS updates from Trond.

Only in 2.4.18pre2aa2: 00_rwsem-fair-25
Only in 2.4.18pre2aa2: 00_rwsem-fair-25-recursive-7
Only in 2.4.18pre4aa1/: 00_rwsem-fair-26
Only in 2.4.18pre4aa1/: 00_rwsem-fair-26-recursive-7

	Rediffed.

Only in 2.4.18pre4aa1/: 00_waitfor-one-page-1

	Export complaining symbol.

Only in 2.4.18pre2aa2: 10_vm-22
Only in 2.4.18pre4aa1/: 10_vm-23

	Minor changes (try to always do some relevant work during the
	refiling).

Only in 2.4.18pre4aa1/: 20_pte-highmem-6

	First "working" version of the pte-highmem patch, this fixes (or at
	least "should fix" :) lots of bugs. pte_offset_lowmem is still there
	because kmap doesn't yet work by the time pte_offset_lowmem is
	recalled. Lots of fixes, special thanks to Hugh, Linus and others for
	the review and the feedback! All drivers should be updated. Works
	for me so far.

Only in 2.4.18pre2aa2: 30_dyn-sched-2
Only in 2.4.18pre4aa1/: 30_dyn-sched-3

	Minor changes, volatile would be needed only to avoid confusing
	gcc, but nobody cares about variables changing under gcc anyways so
	let's remove it so it will be a little faster.

Only in 2.4.18pre2aa2: 50_uml-patch-2.4.17-4.bz2
Only in 2.4.18pre4aa1/: 50_uml-patch-2.4.17-7.bz2

	Latest update from Jeff (hopefully vmalloc works despite it doesn't
	start with the tlb invalidate).

Only in 2.4.18pre4aa1/: 60_show-stack-1

	Export symbol, so CONFIG_TUX_DEBUG has a chance to generate a loadable
	kernel module. 

Only in 2.4.18pre2aa2: 60_tux-vfs-4
Only in 2.4.18pre4aa1/: 60_tux-vfs-5

	Rediffed.

Andrea
