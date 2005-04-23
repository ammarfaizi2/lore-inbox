Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVDWXbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVDWXbU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 19:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVDWXbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 19:31:20 -0400
Received: from mail.dif.dk ([193.138.115.101]:43924 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262175AbVDWXbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 19:31:12 -0400
Date: Sun, 24 Apr 2005 01:34:25 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] trivial type correction in fs/mpage.c::__mpage_writepages
Message-ID: <Pine.LNX.4.62.0504240130240.2474@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the variable 'i' in
fs/mpage.c::__mpage_writepages from 'unsigned int' to int.
The only use of 'i' is in the for loop, and the array being indexed is
PAGEVEC_SIZE in size (and with PAGEVEC_SIZE being 14, an int is fully
sufficient) and in the loop itself 'i' is being compared to 'nr_pages'
which is defined as 'int' at the top of the function. So, as far as I can
see changing 'i' to int makes sense - it is more than large enough for
what it's used for, it then matches the type it is compared against
exactely and it avoids a signed vs unsigned comparison.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc2-mm3-orig/fs/mpage.c	2005-04-11 21:20:50.000000000 +0200
+++ linux-2.6.12-rc2-mm3/fs/mpage.c	2005-04-24 01:28:53.000000000 +0200
@@ -676,7 +676,7 @@ retry:
 			(nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
 			PAGECACHE_TAG_DIRTY,
 			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1))) {
-		unsigned i;
+		int i;
 
 		scanned = 1;
 		for (i = 0; i < nr_pages; i++) {


