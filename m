Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272212AbRI0JXG>; Thu, 27 Sep 2001 05:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272247AbRI0JW4>; Thu, 27 Sep 2001 05:22:56 -0400
Received: from chiara.elte.hu ([157.181.150.200]:19725 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S272212AbRI0JWm>;
	Thu, 27 Sep 2001 05:22:42 -0400
Date: Thu, 27 Sep 2001 11:20:45 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Bernd Harries <mlbha@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: __get_free_pages(): is the MEM really mine?
In-Reply-To: <356.1001580994@www46.gmx.net>
Message-ID: <Pine.LNX.4.33.0109271117490.4082-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


another method is to apply the attached patch to 2.4.10, and watch the
stack traces whether it all happens in the order and places you intended
it to. Your driver should be the only thing doing order-9 allocations on
your system.

	Ingo

--- linux/mm/page_alloc.c.orig	Thu Sep 27 11:04:02 2001
+++ linux/mm/page_alloc.c	Thu Sep 27 11:05:27 2001
@@ -70,6 +70,10 @@
 	struct page *base;
 	zone_t *zone;

+	if (order == 9) {
+		printk("free_pages order 9 called.\n");
+		show_stack(NULL);
+	}
 	if (page->buffers)
 		BUG();
 	if (page->mapping)
@@ -319,6 +323,10 @@
 	struct page * page;
 	int freed;

+	if (order == 9) {
+		printk("alloc_pages order 9 called.\n");
+		show_stack(NULL);
+	}
 	zone = zonelist->zones;
 	classzone = *zone;
 	for (;;) {

