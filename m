Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUGNORP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUGNORP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267430AbUGNOPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:15:49 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:12220 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267417AbUGNOGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:06:14 -0400
Date: Wed, 14 Jul 2004 23:05:59 +0900 (JST)
Message-Id: <20040714.230559.94845836.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: [BUG][PATCH] memory hotremoval for linux-2.6.7 [12/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.6.7/mm/hugetlb.c.save	Wed Jul  7 18:34:06 2032
+++ linux-2.6.7/mm/hugetlb.c	Wed Jul  7 18:35:10 2032
@@ -149,8 +149,8 @@ static int try_to_free_low(unsigned long
 {
 	int i;
 	for (i = 0; i < MAX_NUMNODES; ++i) {
-		struct page *page;
-		list_for_each_entry(page, &hugepage_freelists[i], lru) {
+		struct page *page, *page1;
+		list_for_each_entry_safe(page, page1, &hugepage_freelists[i], lru) {
 			if (PageHighMem(page))
 				continue;
 			list_del(&page->lru);
