Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267418AbUGNOTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267418AbUGNOTC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267430AbUGNORg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:17:36 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:15036 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267420AbUGNOGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:06:51 -0400
Date: Wed, 14 Jul 2004 23:06:36 +0900 (JST)
Message-Id: <20040714.230636.11986115.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: [BUG] [PATCH] memory hotremoval for linux-2.6.7 [15/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- linux-2.6.7/fs/direct-io.c.ORG	Fri Jun 18 13:52:47 2032
+++ linux-2.6.7/fs/direct-io.c	Fri Jun 18 13:53:49 2032
@@ -411,7 +411,7 @@ static int dio_bio_complete(struct dio *
 		for (page_no = 0; page_no < bio->bi_vcnt; page_no++) {
 			struct page *page = bvec[page_no].bv_page;
 
-			if (dio->rw == READ)
+			if (dio->rw == READ && !PageCompound(page))
 				set_page_dirty_lock(page);
 			page_cache_release(page);
 		}
