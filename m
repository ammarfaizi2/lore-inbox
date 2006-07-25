Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWGYMnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWGYMnf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 08:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWGYMnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 08:43:35 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:445 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751333AbWGYMne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 08:43:34 -0400
Date: Tue, 25 Jul 2006 15:43:33 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: aia21@cantab.net
cc: akpm@osdl.irg, linux-kernel@vger.kernel.org
Subject: ntfs: remove unnecessary PG_uptodate check from ntfs_readpage
Message-ID: <Pine.LNX.4.58.0607251542570.2665@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

The check is not needed because SetPageUptodate is called for locked pages
and callers of ->readpage either explicitly check for PageUptodate or pass
newly allocated pages (see read_cache_pages and page_cache_read).

Cc: Andrew Morton <akpm@osdl.org>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/ntfs/aops.c |    8 --------
 1 file changed, 8 deletions(-)

Index: 2.6/fs/ntfs/aops.c
===================================================================
--- 2.6.orig/fs/ntfs/aops.c
+++ 2.6/fs/ntfs/aops.c
@@ -410,14 +410,6 @@ static int ntfs_readpage(struct file *fi
 
 retry_readpage:
 	BUG_ON(!PageLocked(page));
-	/*
-	 * This can potentially happen because we clear PageUptodate() during
-	 * ntfs_writepage() of MstProtected() attributes.
-	 */
-	if (PageUptodate(page)) {
-		unlock_page(page);
-		return 0;
-	}
 	vi = page->mapping->host;
 	ni = NTFS_I(vi);
 	/*
