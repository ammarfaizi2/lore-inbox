Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932775AbVITRXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775AbVITRXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbVITRXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:23:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:58272 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932769AbVITRXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:23:13 -0400
Subject: [RFC][PATCH 3/4] build_zonelists() unification: don't re-zero zonelist
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 20 Sep 2005 10:23:11 -0700
References: <20050920172303.8CD9190C@kernel.beaverton.ibm.com>
In-Reply-To: <20050920172303.8CD9190C@kernel.beaverton.ibm.com>
Message-Id: <20050920172311.12E6FE03@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The pgdats, and thus the zonelists are either statically
allocated in BSS, cleared by the bootmem allocator, or
cleared by arch code such as remapped_pgdat_init(). There
is no need to re-zero them here

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/mm/page_alloc.c |    6 ------
 1 files changed, 6 deletions(-)

diff -puN mm/page_alloc.c~B1.2-build_zonelists_unification mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~B1.2-build_zonelists_unification	2005-09-14 09:32:38.000000000 -0700
+++ memhotplug-dave/mm/page_alloc.c	2005-09-14 09:32:38.000000000 -0700
@@ -1549,12 +1549,6 @@ static void __init build_zonelists(pg_da
 	struct zonelist *zonelist;
 	nodemask_t used_mask;
 
-	/* initialize zonelists */
-	for (i = 0; i < GFP_ZONETYPES; i++) {
-		zonelist = pgdat->node_zonelists + i;
-		zonelist->zones[0] = NULL;
-	}
-
 	/* NUMA-aware ordering of nodes */
 	local_node = pgdat->node_id;
 	load = num_online_nodes();
_
