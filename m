Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287909AbSAHF2E>; Tue, 8 Jan 2002 00:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287908AbSAHF1y>; Tue, 8 Jan 2002 00:27:54 -0500
Received: from [202.54.26.202] ([202.54.26.202]:18595 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S287907AbSAHF1o>;
	Tue, 8 Jan 2002 00:27:44 -0500
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256B3B.001DEEA2.00@sandesh.hss.hns.com>
Date: Tue, 8 Jan 2002 10:51:24 +0530
Subject: [PATCH] locked page handling in shrink_cache() : revised
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Whenever the shrink_cache wakes up after a laundered page in unlocked, it should
move that page to the end of inactive list so that
the page can be freed immediately and shrink_cache dosen't have to wait for
complete list scan before freeing this page.

The patch is created against standard redhat 7.1 distribution 2.4.16 kernel.
Let me know if I need to create it for a different kernel release.

regards
Amol


--- vmscan_orig.c   Mon Jan  7 11:47:43 2002
+++ vmscan.c   Mon Jan  7 11:49:07 2002
@@ -387,6 +387,8 @@
                    wait_on_page(page);
                    page_cache_release(page);
                    spin_lock(&pagemap_lru_lock);
+                   list_del(&page->lru);
+                   list_add(&page->lru,inactive_list.prev);
               }
               continue;
          }




