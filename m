Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263396AbRFEWpe>; Tue, 5 Jun 2001 18:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263398AbRFEWpZ>; Tue, 5 Jun 2001 18:45:25 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:55670 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263396AbRFEWpJ>; Tue, 5 Jun 2001 18:45:09 -0400
Date: Wed, 6 Jun 2001 00:44:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: kswapd and MM overload fix
Message-ID: <20010606004450.C27651@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anybody running on a machine with some zone empty (<16Mbyte boxes (PDAs),
<1G x86 with highmem enabled kernel or an arch with an iommu like alpha)
probably noticed that the MM was unusable on those hardware
configurations (as I also incidentally mentioned a few times on l-k in
the last months).

Yesterday I checked and here it is the fix (included in 2.4.5aa3).

--- 2.4.5aa3/mm/vmscan.c.~1~	Sat May 26 04:03:50 2001
+++ 2.4.5aa3/mm/vmscan.c	Tue Jun  5 03:41:06 2001
@@ -791,6 +788,8 @@
 		for(i = 0; i < MAX_NR_ZONES; i++) {
 			int zone_shortage;
 			zone_t *zone = pgdat->node_zones+ i;
+			if (!zone->size)
+				continue;
 
 			zone_shortage = zone->pages_high;
 			zone_shortage -= zone->inactive_dirty_pages;

Andrea
