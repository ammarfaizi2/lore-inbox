Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVCOWWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVCOWWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVCOWUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:20:24 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:30368 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261925AbVCOWT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:19:58 -0500
Subject: [PATCH] Add freezer call in
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1110925280.6454.143.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 16 Mar 2005 09:21:20 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a freezer call to the slow path in __alloc_pages. It
thus avoids freezing failures in low memory situations. Like the other
patches, it has been in Suspend2 for longer than I can remember.

Signed-of-by: Nigel Cunningham <ncunningham@cyclades.com>

diff -ruNp 213-missing-refrigerator-calls-old/mm/page_alloc.c 213-missing-refrigerator-calls-new/mm/page_alloc.c
--- 213-missing-refrigerator-calls-old/mm/page_alloc.c	2005-02-03 22:33:50.000000000 +1100
+++ 213-missing-refrigerator-calls-new/mm/page_alloc.c	2005-03-16 09:01:28.000000000 +1100
@@ -838,6 +838,7 @@ rebalance:
 			do_retry = 1;
 	}
 	if (do_retry) {
+		try_to_freeze(0);
 		blk_congestion_wait(WRITE, HZ/50);
 		goto rebalance;
 	}
 

-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

