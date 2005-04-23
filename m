Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVDWWjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVDWWjg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 18:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVDWWha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 18:37:30 -0400
Received: from mail.dif.dk ([193.138.115.101]:42386 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262154AbVDWWg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 18:36:59 -0400
Date: Sun, 24 Apr 2005 00:40:10 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] trivial little type correction in mm/filemap.c::wait_on_page_writeback_range
Message-ID: <Pine.LNX.4.62.0504240030260.2474@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the variable 'i' in 
mm/filemap.c::wait_on_page_writeback_range from 'unsigned int' to int.
The only use of 'i' is in the for loop, and the array being indexed is 
PAGEVEC_SIZE in size (and with PAGEVEC_SIZE being 14, an int is fully 
sufficient) and in the loop itself 'i' is being compared to 'nr_pages' 
which is defined as 'int' at the top of the function. So, as far as I can 
see changing 'i' to int makes sense - it is more than large enough for 
what it's used for, it then matches the type it is compared against 
exactely and it avoids a signed vs unsigned comparison.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 mm/filemap.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12-rc2-mm3-orig/mm/filemap.c	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/mm/filemap.c	2005-04-24 00:36:18.000000000 +0200
@@ -234,7 +234,7 @@ static int wait_on_page_writeback_range(
 			(nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
 			PAGECACHE_TAG_WRITEBACK,
 			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1)) != 0) {
-		unsigned i;
+		int i;
 
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];



