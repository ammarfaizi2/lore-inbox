Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277132AbRJDUUU>; Thu, 4 Oct 2001 16:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277129AbRJDUUK>; Thu, 4 Oct 2001 16:20:10 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:57350 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S276984AbRJDUT6>; Thu, 4 Oct 2001 16:19:58 -0400
Date: Thu, 4 Oct 2001 15:58:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>
Subject: [PATCH] Add information to SysRq+M output  
Message-ID: <Pine.LNX.4.21.0110041556270.2744-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes a patch, against 2.4.10pre3, which adds very useful information
to Alt+SysRq+M: it prints per-zone free information (freepages,
freepages.min, freepages.low, freepages.high).

Linus, pleasy apply.

--- linux/mm/page_alloc.c.orig	Thu Oct  4 17:18:00 2001
+++ linux/mm/page_alloc.c	Thu Oct  4 17:18:12 2001
@@ -515,6 +515,30 @@
 {
  	unsigned int order;
 	unsigned type;
+	pg_data_t *tmpdat = pgdat;
+
+	printk("Free pages:      %6dkB (%6dkB HighMem)\n",
+		nr_free_pages() << (PAGE_SHIFT-10),
+		nr_free_highpages() << (PAGE_SHIFT-10));
+
+	while (tmpdat) {
+		zone_t *zone;
+		for (zone = tmpdat->node_zones;
+			       	zone < tmpdat->node_zones + MAX_NR_ZONES; zone++)
+			printk("Zone:%s freepages:%6dkB min:%6dKB low:%6dkB " 
+				       "high:%6dkB\n", 
+					zone->name,
+					(zone->free_pages)
+					<< ((PAGE_SHIFT-10)),
+					zone->pages_min
+					<< ((PAGE_SHIFT-10)),
+					zone->pages_low
+					<< ((PAGE_SHIFT-10)),
+					zone->pages_high
+					<< ((PAGE_SHIFT-10)));
+			
+		tmpdat = tmpdat->node_next;
+	}
 
 	printk("Free pages:      %6dkB (%6dkB HighMem)\n",
 		nr_free_pages() << (PAGE_SHIFT-10),

