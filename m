Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267414AbUGNOM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267414AbUGNOM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267427AbUGNOLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:11:30 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:7612 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267414AbUGNOEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:04:52 -0400
Date: Wed, 14 Jul 2004 23:04:37 +0900 (JST)
Message-Id: <20040714.230437.128870242.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: [PATCH] memory hotremoval for linux-2.6.7 [7/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


$Id: va-shmem.patch,v 1.5 2004/04/14 06:36:05 iwamoto Exp $

--- linux-2.6.5.ORG/mm/shmem.c	Fri Apr  2 14:05:11 2032
+++ linux-2.6.5/mm/shmem.c	Fri Apr  2 14:43:37 2032
@@ -80,7 +80,13 @@ static inline struct page *shmem_dir_all
 	 * BLOCKS_PER_PAGE on indirect pages, assume PAGE_CACHE_SIZE:
 	 * might be reconsidered if it ever diverges from PAGE_SIZE.
 	 */
+#ifdef CONFIG_MEMHOTPLUG
+	return alloc_pages((gfp_mask & GFP_ZONEMASK) == __GFP_HOTREMOVABLE ? 
+	 	(gfp_mask & ~GFP_ZONEMASK) | __GFP_HIGHMEM : gfp_mask, 
+		    PAGE_CACHE_SHIFT-PAGE_SHIFT);
+#else
 	return alloc_pages(gfp_mask, PAGE_CACHE_SHIFT-PAGE_SHIFT);
+#endif
 }
 
 static inline void shmem_dir_free(struct page *page)
