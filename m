Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267916AbTBLXG4>; Wed, 12 Feb 2003 18:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267922AbTBLXG4>; Wed, 12 Feb 2003 18:06:56 -0500
Received: from air-2.osdl.org ([65.172.181.6]:43663 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267916AbTBLXGz>;
	Wed, 12 Feb 2003 18:06:55 -0500
Subject: [PATCH] Eliminate compile warnings from min() in mm
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1045091800.22238.58.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 12 Feb 2003 15:16:40 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following gets rid of the warnings:

mm/vmscan.c: In function `shrink_caches':
mm/vmscan.c:768: warning: duplicate `const'
mm/swap_state.c: In function `free_pages_and_swap_cache':
mm/swap_state.c:302: warning: duplicate `const'



diff -Nru a/mm/swap_state.c b/mm/swap_state.c
--- a/mm/swap_state.c	Wed Feb 12 14:20:26 2003
+++ b/mm/swap_state.c	Wed Feb 12 14:20:26 2003
@@ -294,7 +294,7 @@
  */
 void free_pages_and_swap_cache(struct page **pages, int nr)
 {
-	const int chunk = 16;
+	int chunk = 16;
 	struct page **pagep = pages;
 
 	lru_add_drain();
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Wed Feb 12 14:20:26 2003
+++ b/mm/vmscan.c	Wed Feb 12 14:20:26 2003
@@ -765,7 +765,7 @@
 
 	first_classzone = classzone->zone_pgdat->node_zones;
 	for (zone = classzone; zone >= first_classzone; zone--) {
-		int to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX);
+		int to_reclaim = max_t(int, nr_pages, SWAP_CLUSTER_MAX);
 		int nr_mapped = 0;
 		int max_scan;
 


