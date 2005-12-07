Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVLGK1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVLGK1R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVLGK1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:27:14 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:10684 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750797AbVLGK0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:26:45 -0500
Message-Id: <20051207105256.874507000@localhost.localdomain>
References: <20051207104755.177435000@localhost.localdomain>
Date: Wed, 07 Dec 2005 18:48:11 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 16/16] mm: kswapd reclaim debug trace
Content-Disposition: inline; filename=mm-kswapd-reclaim-debug-trace.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Debug trace for kswapd reclaim.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/vmscan.c |   11 +++++++++++
 1 files changed, 11 insertions(+)

--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -1450,6 +1450,17 @@ loop_again:
 			if (nr_pages) 	/* software suspend */
 				goto scan_swspd;
 
+			if (debug_page_reclaim)
+			printk(KERN_DEBUG "zone %d%d watermark %d%d age %lu prio %d\n",
+					zone_idx(prev_zone),
+					zone_idx(zone),
+					zone_watermark_ok(zone, order,
+						zone->pages_high, 0, 0),
+					zone_watermark_ok(zone, order,
+						zone->pages_high,
+						pgdat->nr_zones - 1, 0),
+					zone->page_age, priority);
+
 			if (zone_watermark_ok(zone, order,
 						zone->pages_high,
 						pgdat->nr_zones - 1, 0)) {

--
