Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263674AbTEJH6E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 03:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263675AbTEJH6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 03:58:03 -0400
Received: from zeus.kernel.org ([204.152.189.113]:62455 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263674AbTEJH6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 03:58:02 -0400
Date: Sat, 10 May 2003 03:59:31 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][2.5] small cleanup for __rmqueue
Message-ID: <Pine.LNX.4.50.0305100227120.11047-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes an extra initialisation and general nitpicking.

Index: linux-2.5.69/mm/page_alloc.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.69/mm/page_alloc.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 page_alloc.c
--- linux-2.5.69/mm/page_alloc.c	6 May 2003 12:21:35 -0000	1.1.1.1
+++ linux-2.5.69/mm/page_alloc.c	10 May 2003 04:48:46 -0000
@@ -336,21 +336,17 @@ static void prep_new_page(struct page *p
 static struct page *__rmqueue(struct zone *zone, unsigned int order)
 {
 	struct free_area * area;
-	unsigned int current_order = order;
-	struct list_head *head, *curr;
+	unsigned int current_order;
 	struct page *page;
 	unsigned int index;
 
-	for (current_order=order; current_order < MAX_ORDER; ++current_order) {
+	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
 		area = zone->free_area + current_order;
-		head = &area->free_list;
-		curr = head->next;
-
 		if (list_empty(&area->free_list))
 			continue;
 
-		page = list_entry(curr, struct page, list);
-		list_del(curr);
+		page = list_entry(area->free_list.next, struct page, list);
+		list_del(&page->list);
 		index = page - zone->zone_mem_map;
 		if (current_order != MAX_ORDER-1)
 			MARK_USED(index, current_order, area);

-- 
function.linuxpower.ca
