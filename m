Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271768AbRHREGZ>; Sat, 18 Aug 2001 00:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271769AbRHREGP>; Sat, 18 Aug 2001 00:06:15 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:28444 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271768AbRHREGI>; Sat, 18 Aug 2001 00:06:08 -0400
Date: Sat, 18 Aug 2001 06:06:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9aa2 and please test mmap-rb-4
Message-ID: <20010818060615.A1719@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diff between 2.4.9aa1 and 2.4.9aa2:

Only in 2.4.9aa2: 00_megaraid-paranoid-1

	Possibly it's a bug in the anti-bounce buffer patch but make sure the
	megaraid gets not confused by the fact I'm really allowing it to get
	the 512k large requests with the sd-max_sectors patch (in mainline the
	line I #ifdeffed out are meaningless so it never got tested).

Only in 2.4.9aa1: 00_o_direct-13
Only in 2.4.9aa2: 00_o_direct-14

	Janet Morgan promptly noticed I needed to s/>=/</ (it was an editing
	error while preparing the -13 patch).

Only in 2.4.9aa1: 00_poll-nfds-1
Only in 2.4.9aa2: 00_poll-nfds-2

	Fixed off by one check.

Only in 2.4.9aa1: 40_blkdev-pagecache-13
Only in 2.4.9aa2: 40_blkdev-pagecache-14

	Rediffed against o_direct-14.

Only in 2.4.9aa1: 70_mmap-rb-3
Only in 2.4.9aa2: 70_mmap-rb-4

	Fixed severe bug that caused mm corruption and crashes. (splitted a
	__vma_link_file off __vma_link_rb, build_mmap_rb must not mess with
	anything but the rb itself) Improved other bits to cover all the
	merging cases and some minor optimization.

	Since I couldn't find other issues in my workloads I'd now ask
	everybody who complained about the lack of vma merging in 2.4 to test
	this patch on their systems and to report the performance difference
	while running their vma intensive applications. Thanks!

	You don't need to use the -aa tree to test this patch, I ported it
	on top of 2.4.9 vanilla too, you can find it here:

		ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.9/mmap-rb-4

Andrea
