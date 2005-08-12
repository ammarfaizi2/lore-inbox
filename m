Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVHLSVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVHLSVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVHLSVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:21:51 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:7302 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S1750818AbVHLSPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:15:18 -0400
Subject: [patch 05/39] remove stale comment from swapfile.c
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:21:07 +0200
Message-Id: <20050812182108.3C7C624E7CC@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Seems like on 2.4.9.4 this comment got out of sync ;-)

I'm not completely sure on which basis we don't need any more to do as the
comment suggests, but it seems that when faulting in a second time the same
swap page,  can_share_swap_page() returns false, and we do an early COW break,
so there's no need to write-protect the page.

No idea why we don't defer the COW break.

Reference commit from GIT version of BKCVS history:
5ee46c7964de4b1969fc5be036167eb2da0de4e2, BKRev 3c603c81PtWl2I1NnVuphvsItrD1hg
(v2.4.9.3 -> v2.4.9.4).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/swapfile.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

diff -puN mm/swapfile.c~remove-stale-comment-swap-file mm/swapfile.c
--- linux-2.6.git/mm/swapfile.c~remove-stale-comment-swap-file	2005-08-11 11:13:18.000000000 +0200
+++ linux-2.6.git-paolo/mm/swapfile.c	2005-08-11 11:13:18.000000000 +0200
@@ -388,10 +388,7 @@ void free_swap_and_cache(swp_entry_t ent
 }
 
 /*
- * Always set the resulting pte to be nowrite (the same as COW pages
- * after one process has exited).  We don't know just how many PTEs will
- * share this swap entry, so be cautious and let do_wp_page work out
- * what to do if a write is requested later.
+ * Since we're swapping it in, we mark it as old.
  *
  * vma->vm_mm->page_table_lock is held.
  */
_
