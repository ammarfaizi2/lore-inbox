Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbVKJCKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbVKJCKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 21:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVKJCKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 21:10:35 -0500
Received: from gold.veritas.com ([143.127.12.110]:58934 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751431AbVKJCKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 21:10:34 -0500
Date: Thu, 10 Nov 2005 02:09:22 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] mm: remove install_page limit
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100208230.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 02:10:33.0834 (UTC) FILETIME=[EEC274A0:01C5E59B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the INT_MAX/2 limit on remap_file_pages mapcount, which we added
in late 2.6.14: both 32-bit and 64-bit can now handle more, and are now
limited by their page tables.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/fremap.c |    3 ---
 1 files changed, 3 deletions(-)

--- mm14/mm/fremap.c	2005-11-07 07:39:59.000000000 +0000
+++ mm15/mm/fremap.c	2005-11-09 14:40:44.000000000 +0000
@@ -87,9 +87,6 @@ int install_page(struct mm_struct *mm, s
 	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	if (!page->mapping || page->index >= size)
 		goto unlock;
-	err = -ENOMEM;
-	if (page_mapcount(page) > INT_MAX/2)
-		goto unlock;
 
 	if (pte_none(*pte) || !zap_pte(mm, vma, addr, pte))
 		inc_mm_counter(mm, file_rss);
