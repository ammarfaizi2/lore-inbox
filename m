Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266419AbUGOWYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266419AbUGOWYL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 18:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266425AbUGOWYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 18:24:10 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:6963 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266419AbUGOWYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 18:24:06 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] quiet down per-zone memory stats
Date: Thu, 15 Jul 2004 18:23:33 -0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lPw9AvuTQf+8WUh"
Message-Id: <200407151823.33854.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_lPw9AvuTQf+8WUh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On a system with a lot of nodes, 4 lines of output per node is a lot to have 
to sit through as the system comes up, especially if you're on the other end 
of a slow serial link.  The information is valuable though, so keep it around 
for the system logger.  This patch makes the printks for the memory stats use 
KERN_DEBUG instead of the default loglevel.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Jesse

--Boundary-00=_lPw9AvuTQf+8WUh
Content-Type: text/x-diff;
  charset="us-ascii";
  name="per-node-quiet.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="per-node-quiet.patch"

===== mm/page_alloc.c 1.220 vs edited =====
--- 1.220/mm/page_alloc.c	2004-07-11 01:52:11 -07:00
+++ edited/mm/page_alloc.c	2004-07-15 14:51:07 -07:00
@@ -1381,7 +1381,7 @@
 		for (i = 0; i < MAX_NR_ZONES; i++)
 			realtotalpages -= zholes_size[i];
 	pgdat->node_present_pages = realtotalpages;
-	printk("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
+	printk(KERN_DEBUG "On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
 }
 
 
@@ -1487,7 +1487,7 @@
 			pcp->batch = 1 * batch;
 			INIT_LIST_HEAD(&pcp->list);
 		}
-		printk("  %s zone: %lu pages, LIFO batch:%lu\n",
+		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",
 				zone_names[j], realsize, batch);
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_list);

--Boundary-00=_lPw9AvuTQf+8WUh--
