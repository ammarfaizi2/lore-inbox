Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268955AbUHZM2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268955AbUHZM2H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268701AbUHZMTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:19:24 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:12173 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268783AbUHZMKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:10:12 -0400
Date: Thu, 26 Aug 2004 21:15:14 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC] buddy allocator without bitmap [4/4]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: LHMS <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>
Message-id: <412DD452.1090703@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch 5th inserts prefetch().
I think These prefetch are reasonable and helpful.

-- Kame
====================================================================



---

  linux-2.6.8.1-mm4-kame-kamezawa/mm/page_alloc.c |    2 ++
  1 files changed, 2 insertions(+)

diff -puN mm/page_alloc.c~eliminate-bitmap-prefetch mm/page_alloc.c
--- linux-2.6.8.1-mm4-kame/mm/page_alloc.c~eliminate-bitmap-prefetch	2004-08-26 19:32:01.598461736 +0900
+++ linux-2.6.8.1-mm4-kame-kamezawa/mm/page_alloc.c	2004-08-26 19:32:01.602461128 +0900
@@ -257,6 +257,7 @@ static inline void __free_pages_bulk (st
  		order++;
  		mask <<= 1;
  		page_idx &= mask;
+		prefetch(base + (page_idx ^ (1 << order)));
  		list_del(&buddy->lru);
  		/* for propriety of PG_private bit, we clear it */
  		buddy->flags &= ~(1 << PG_private);
@@ -360,6 +361,7 @@ expand(struct zone *zone, struct page *p
  		area--;
  		high--;
  		size >>= 1;
+		prefetch(&page[size >> 1]);
  		BUG_ON(bad_range(zone, &page[size]));
  		list_add(&page[size].lru, &area->free_list);
  		page[size].flags |= (1 << PG_private);

_

