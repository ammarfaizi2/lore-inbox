Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWCYGqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWCYGqN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 01:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWCYGqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 01:46:13 -0500
Received: from ozlabs.org ([203.10.76.45]:59280 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750779AbWCYGqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 01:46:12 -0500
Date: Sat, 25 Mar 2006 17:41:42 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] quieten zone_pcp_init
Message-ID: <20060325064142.GW30422@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In zone_pcp_init we print out all zones even if they are empty:

On node 0 totalpages: 245760
  DMA zone: 245760 pages, LIFO batch:31
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0

To conserve dmesg space why not print only the non zero zones.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/mm/page_alloc.c
===================================================================
--- build.orig/mm/page_alloc.c	2006-03-25 16:26:58.000000000 +1100
+++ build/mm/page_alloc.c	2006-03-25 16:27:06.000000000 +1100
@@ -2029,8 +2029,9 @@ static __meminit void zone_pcp_init(stru
 		setup_pageset(zone_pcp(zone,cpu), batch);
 #endif
 	}
-	printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",
-		zone->name, zone->present_pages, batch);
+	if (zone->present_pages)
+		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",
+			zone->name, zone->present_pages, batch);
 }
 
 static __meminit void init_currently_empty_zone(struct zone *zone,
