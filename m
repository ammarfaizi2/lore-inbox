Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269673AbRHQEvW>; Fri, 17 Aug 2001 00:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269674AbRHQEvC>; Fri, 17 Aug 2001 00:51:02 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:5168 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269673AbRHQEuv>; Fri, 17 Aug 2001 00:50:51 -0400
Date: Fri, 17 Aug 2001 06:51:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: vma rbtree and vma merging
Message-ID: <20010817065114.A830@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I rewrote the vma lookup engine with a rbtree, it drops many browse of
the tree in many places this way and it drops the complexity of
rebalancing the tree as well. There is still some room for improvements
(get_unmapped_area walks the tree one more time in the non MAP_FIXED
case and we could checkpoint there but it would pollute some other code
and I thought it was a lower prio).

It also hopefully does the right merging for the anon mappings for mmap,
mremap and mprotect in all the cases (I got some mremap bit from Ben's
patch).  It's still very early work so don't apply it in any production
box but it works for me so far (running kde pre-2.9 over it, konqueror,
mutt, emacs, and some test programs and found no problems yet). I also
included it under the name of 70_mmap-rb-3 in the 2.4.9aa1 patchkit but
please make sure to back it out from the patchkit before doing any
production work. It needs to be tested better and it also needs to be
benchmarked carefully (should be a speed improvement).

against 2.4.9 vanilla:

	ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.9/mmap-rb-1

Andrea
