Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWCGBlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWCGBlL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWCGBks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:40:48 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:16339 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932594AbWCGBkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:40:46 -0500
Date: Tue, 7 Mar 2006 09:45:35 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: isolate_lru_pages() scan count fix
Message-ID: <20060307014535.GA5560@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, Nick Piggin <npiggin@suse.de>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In isolate_lru_pages(), *scanned reports one more scan because the scan
counter is increased one more time on exit of the while-loop.

Change the while-loop to for-loop to fix it.

Signed-off-by: Nick Piggin <npiggin@suse.de>
Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

--- linux-2.6.16-rc5-mm2.orig/mm/vmscan.c
+++ linux-2.6.16-rc5-mm2/mm/vmscan.c
@@ -1074,9 +1074,9 @@ static unsigned long isolate_lru_pages(u
 {
 	unsigned long nr_taken = 0;
 	struct page *page;
-	unsigned long scan = 0;
+	unsigned long scan;
 
-	while (scan++ < nr_to_scan && !list_empty(src)) {
+	for (scan = 0; scan < nr_to_scan && !list_empty(src); scan++) {
 		struct list_head *target;
 		page = lru_to_page(src);
 		prefetchw_prev_lru_page(page, src, flags);
