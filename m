Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317221AbSFBWtM>; Sun, 2 Jun 2002 18:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317223AbSFBWtL>; Sun, 2 Jun 2002 18:49:11 -0400
Received: from holomorphy.com ([66.224.33.161]:40610 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317221AbSFBWtK>;
	Sun, 2 Jun 2002 18:49:10 -0400
Date: Sun, 2 Jun 2002 15:48:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: complete comment regarding inner workings of buddy system
Message-ID: <20020602224848.GQ14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The comment about buddy system allocators has a TODO item for
explanation of buddy system allocators in general. The following patch
removes the TODO item in favor of an actual explanation.

Against 2.5.19.


Cheers,
Bill



===== mm/page_alloc.c 1.71 vs edited =====
--- 1.71/mm/page_alloc.c	Sun Jun  2 15:41:24 2002
+++ edited/mm/page_alloc.c	Sun Jun  2 15:45:27 2002
@@ -69,10 +69,22 @@
  * at the bottom level available, and propagating the changes upward
  * as necessary, plus some accounting needed to play nicely with other
  * parts of the VM system.
- *
- * TODO: give references to descriptions of buddy system allocators,
- * describe precisely the silly trick buddy allocators use to avoid
- * storing an extra bit, utilizing entry point information.
+ * More precisely, a buddy system for a given level maintains one bit
+ * for each pair of blocks, which is the xor of the "virtual bits"
+ * describing whether or not the individual blocks are available.
+ * While freeing, the block of pages being examined is known to be
+ * already allocated, so its "virtual bit" is 0 and its buddy's bit
+ * may be recovered by xor'ing with 0 (or just checking it). While
+ * allocating, the block of pages to be handed back is chosen from
+ * lists of free pages, and so the page's "virtual bit" is 1 and its
+ * buddy's bit may be recovered by xor'ing with 1 (or just inverting it).
+ * These virtual bits, when recovered, are used only to determine when
+ * to split or coalesce blocks of free pages and do the corresponding
+ * list manipulations. That is, if both were free and a smaller block
+ * is allocated from a free region then the remainder of the region
+ * must be split into blocks, or if a free block's buddy is freed then
+ * this triggers coalescing of blocks on the queues into a block of
+ * larger size.
  *
  * -- wli
  */
