Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268306AbUIKUs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268306AbUIKUs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 16:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268310AbUIKUs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 16:48:29 -0400
Received: from hcc022004.bai.ne.jp ([210.171.22.4]:40073 "HELO
	tigger.internet.email.ne.jp") by vger.kernel.org with SMTP
	id S268306AbUIKUs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 16:48:26 -0400
Date: Sun, 12 Sep 2004 05:48:26 +0900 (JST)
Message-Id: <20040912.054826.607956537.takata@linux-m32r.org>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm4 2/6] [m32r] Update zone_sizes_init()
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
In-Reply-To: <20040912.052403.730551818.takata@linux-m32r.org>
References: <20040912.052403.730551818.takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.9-rc1-mm4 2/6] [m32r] Update zone_sizes_init()
  This patch upgrades zone_sizes_init() function.
  This patch is required because free_area_init_node()'s interface 
  has been changed.

	* arch/m32r/mm/discontig.c (zone_sizes_init): 
	Change free_area_init_node() interface.

	* arch/m32r/mm/init.c: ditto.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/mm/discontig.c |    2 +-
 arch/m32r/mm/init.c      |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)


diff -ruNp linux-2.6.9-rc1-mm4.orig/arch/m32r/mm/discontig.c linux-2.6.9-rc1-mm4/arch/m32r/mm/discontig.c
--- linux-2.6.9-rc1-mm4.orig/arch/m32r/mm/discontig.c	2004-09-08 08:14:03.000000000 +0900
+++ linux-2.6.9-rc1-mm4/arch/m32r/mm/discontig.c	2004-09-09 01:47:12.000000000 +0900
@@ -152,7 +152,7 @@ unsigned long __init zone_sizes_init(voi
 		zholes_size[ZONE_DMA] = mp->holes;
 		holes += zholes_size[ZONE_DMA];
 
-		free_area_init_node(nid, NODE_DATA(nid), NULL, zones_size,
+		free_area_init_node(nid, NODE_DATA(nid), zones_size,
 			start_pfn, zholes_size);
 	}
 
diff -ruNp linux-2.6.9-rc1-mm4.orig/arch/m32r/mm/init.c linux-2.6.9-rc1-mm4/arch/m32r/mm/init.c
--- linux-2.6.9-rc1-mm4.orig/arch/m32r/mm/init.c	2004-09-08 08:14:03.000000000 +0900
+++ linux-2.6.9-rc1-mm4/arch/m32r/mm/init.c	2004-09-09 01:39:58.000000000 +0900
@@ -120,8 +120,7 @@ unsigned long __init zone_sizes_init(voi
 	start_pfn = __MEMORY_START >> PAGE_SHIFT;
 #endif /* CONFIG_MMU */
 
-	free_area_init_node(0, NODE_DATA(0), 0, zones_size,
-		start_pfn, 0);
+	free_area_init_node(0, NODE_DATA(0), zones_size, start_pfn, 0);
 
 	mem_map = contig_page_data.node_mem_map;
 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
