Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUGQWvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUGQWvV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUGQWsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:48:08 -0400
Received: from digitalimplant.org ([64.62.235.95]:65257 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262322AbUGQWgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:36:24 -0400
Date: Sat, 17 Jul 2004 15:36:20 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [25/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171532580.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1867, 2004/07/17 14:50:11-07:00, mochel@digitalimplant.org

[swsusp] Fix nasty typo.


 kernel/power/swsusp.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:50:21 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:50:21 -07:00
@@ -578,7 +578,7 @@
 		return 0;
 	}
 	if ((chunk_size = is_head_of_free_region(page))) {
-		zone_pfn += chunk_size - 1;
+		*zone_pfn += chunk_size - 1;
 		return 0;
 	}

@@ -601,11 +601,11 @@
 }


-static void copy_data_pages(struct pbe * pbe)
+static void copy_data_pages(void)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
-
+	struct pbe * pbe = pagedir_nosave;

 	for_each_zone(zone) {
 		if (!is_highmem(zone))
@@ -807,9 +807,9 @@
 	printk(", ");
 #endif

-	printk("counting pages to copy" );
 	drain_local_pages();
 	count_data_pages();
+	printk("swsusp: Need to copy %u pages\n",nr_copy_pages);
 	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;

 	swsusp_alloc();
@@ -818,7 +818,7 @@
 	 * Kill them.
 	 */
 	drain_local_pages();
-	copy_data_pages(pagedir_nosave);
+	copy_data_pages();

 	/*
 	 * End of critical section. From now on, we can write to memory,
