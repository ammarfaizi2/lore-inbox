Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290752AbSBFTEh>; Wed, 6 Feb 2002 14:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290751AbSBFTES>; Wed, 6 Feb 2002 14:04:18 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:10039 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S290741AbSBFTEQ>; Wed, 6 Feb 2002 14:04:16 -0500
Date: Wed, 6 Feb 2002 19:06:01 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Andrew Morton <akpm@zip.com.au>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] __free_pages_ok oops
Message-ID: <Pine.LNX.4.21.0202061844450.1856-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, no solution, but maybe another oops in __free_pages_ok might help?

Hugh

--- 2.4.18-pre8/mm/page_alloc.c	Tue Feb  5 12:55:36 2002
+++ linux/mm/page_alloc.c	Wed Feb  6 18:31:07 2002
@@ -73,9 +73,11 @@
 	/* Yes, think what happens when other parts of the kernel take 
 	 * a reference to a page in order to pin it for io. -ben
 	 */
-	if (PageLRU(page))
+	if (PageLRU(page)) {
+		if (in_interrupt())
+			BUG();
 		lru_cache_del(page);
-
+	}
 	if (page->buffers)
 		BUG();
 	if (page->mapping)

