Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWG3Ql5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWG3Ql5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWG3Ql5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:41:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:54835 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932366AbWG3Ql4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:41:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=P18iNvga8bxl5Uf/QqP1pEJz9YTDGuF6b77WNL7BzpH42+T3HeYMi6zYPkPn4zckibZlKdKzl0W5aRP+IAci+TqGJuSa0FfB5RpMswAaoDKWR2pD6GK1RxCM3+2XgnxGIsD0W9iP+KUNFShCWFaz+ueajyoNsIBy7mWvuAu1zuQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] making the kernel -Wshadow clean - mm/truncate.c
Date: Sun, 30 Jul 2006 18:42:56 +0200
User-Agent: KMail/1.9.3
References: <200607301830.01659.jesper.juhl@gmail.com>
In-Reply-To: <200607301830.01659.jesper.juhl@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301842.56405.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix -Wshadow warnings in mm/truncate.c


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 mm/truncate.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

--- linux-2.6.18-rc2-git7-orig/mm/truncate.c	2006-07-29 14:57:27.000000000 +0200
+++ linux-2.6.18-rc2-git7/mm/truncate.c	2006-07-30 06:48:27.000000000 +0200
@@ -127,15 +127,15 @@ void truncate_inode_pages_range(struct a
 	       pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
-			pgoff_t page_index = page->index;
+			pgoff_t page_idx = page->index;
 
-			if (page_index > end) {
-				next = page_index;
+			if (page_idx > end) {
+				next = page_idx;
 				break;
 			}
 
-			if (page_index > next)
-				next = page_index;
+			if (page_idx > next)
+				next = page_idx;
 			next++;
 			if (TestSetPageLocked(page))
 				continue;
@@ -298,7 +298,7 @@ int invalidate_inode_pages2_range(struct
 			min(end - next, (pgoff_t)PAGEVEC_SIZE - 1) + 1)) {
 		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
-			pgoff_t page_index;
+			pgoff_t page_idx;
 			int was_dirty;
 
 			lock_page(page);
@@ -306,11 +306,11 @@ int invalidate_inode_pages2_range(struct
 				unlock_page(page);
 				continue;
 			}
-			page_index = page->index;
-			next = page_index + 1;
+			page_idx = page->index;
+			next = page_idx + 1;
 			if (next == 0)
 				wrapped = 1;
-			if (page_index > end) {
+			if (page_idx > end) {
 				unlock_page(page);
 				break;
 			}
@@ -321,8 +321,8 @@ int invalidate_inode_pages2_range(struct
 					 * Zap the rest of the file in one hit.
 					 */
 					unmap_mapping_range(mapping,
-					   (loff_t)page_index<<PAGE_CACHE_SHIFT,
-					   (loff_t)(end - page_index + 1)
+					   (loff_t)page_idx<<PAGE_CACHE_SHIFT,
+					   (loff_t)(end - page_idx + 1)
 							<< PAGE_CACHE_SHIFT,
 					    0);
 					did_range_unmap = 1;
@@ -331,7 +331,7 @@ int invalidate_inode_pages2_range(struct
 					 * Just zap this page
 					 */
 					unmap_mapping_range(mapping,
-					  (loff_t)page_index<<PAGE_CACHE_SHIFT,
+					  (loff_t)page_idx<<PAGE_CACHE_SHIFT,
 					  PAGE_CACHE_SIZE, 0);
 				}
 			}



