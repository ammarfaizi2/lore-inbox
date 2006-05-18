Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWERP4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWERP4B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWERP4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:56:01 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:45464
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751343AbWERPz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:55:59 -0400
Date: Thu, 18 May 2006 16:55:27 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, nickpiggin@yahoo.com.au,
       haveblue@us.ibm.com, bob.picco@hp.com, mingo@elte.hu, mbligh@mbligh.org,
       ak@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/2] zone allow unaligned zone boundaries spelling fix
Message-ID: <20060518155527.GA10920@shadowen.org>
References: <exportbomb.1147967697@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1147967697@pinky>
User-Agent: Mutt/1.5.11+cvs20060403
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zone allow unaligned zone boundaries spelling fix

When the spelling of boundary was sorted out the config options
got missed.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 include/linux/mmzone.h |    2 +-
 mm/page_alloc.c        |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
diff -upN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h
+++ current/include/linux/mmzone.h
@@ -393,7 +393,7 @@ static inline int is_dma(struct zone *zo
 
 static inline unsigned long zone_boundary_align_pfn(unsigned long pfn)
 {
-#ifdef CONFIG_UNALIGNED_ZONE_BOUNDRIES
+#ifdef CONFIG_UNALIGNED_ZONE_BOUNDARIES
 	return pfn;
 #else
 	return pfn & ~((1 << MAX_ORDER) - 1);
diff -upN reference/mm/page_alloc.c current/mm/page_alloc.c
--- reference/mm/page_alloc.c
+++ current/mm/page_alloc.c
@@ -315,7 +315,7 @@ static inline int page_is_buddy(struct p
 	if (!pfn_valid(page_to_pfn(buddy)))
 		return 0;
 #endif
-#ifdef CONFIG_UNALIGNED_ZONE_BOUNDRIES
+#ifdef CONFIG_UNALIGNED_ZONE_BOUNDARIES
 	if (page_zone_id(page) != page_zone_id(buddy))
 		return 0;
 #endif
@@ -2232,7 +2232,7 @@ static void __meminit free_area_init_cor
 		if (zone_boundary_align_pfn(zone_start_pfn) !=
 					zone_start_pfn && j != 0 && size != 0)
 			printk(KERN_CRIT "node %d zone %s missaligned "
-				"start pfn, enable UNALIGNED_ZONE_BOUNDRIES\n",
+				"start pfn, enable UNALIGNED_ZONE_BOUNDARIES\n",
 							nid, zone_names[j]);
 
 		realsize = size = zones_size[j];
