Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316383AbSEWPJY>; Thu, 23 May 2002 11:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316421AbSEWPJX>; Thu, 23 May 2002 11:09:23 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:27065 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S316383AbSEWPJX>; Thu, 23 May 2002 11:09:23 -0400
Date: Thu, 23 May 2002 16:12:16 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: linux-kernel@vger.kernel.org
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>
Subject: Q: PREFETCH_STRIDE/16
Message-ID: <Pine.LNX.4.21.0205231554090.1304-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could anyone please shed light on PREFETCH_STRIDE,
and in particular its sole use:
		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
in mm/memory.c: free_one_pgd().

That looks to me suspiciously like something inserted to suit
one particular architecture - ia64? is it really suitable for
others? is 4*L1_CACHE_SIZE really right for PREFETCH_STRIDE
on anything that prefetches except ia64? what's the "/ 16"?
shouldn't there be a "/ sizeof(pmd_t)" somewhere (PAE or not)?
is it right to prefetch each time around that loop? isn't it
appropriate only to the exit_mm (0 to TASK_SIZE) clearance?

All in all, I'm thinking that line shouldn't be there,
or not without a substantial comment...

Thanks,
Hugh

