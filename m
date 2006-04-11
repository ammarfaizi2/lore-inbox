Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWDKLa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWDKLa3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWDKLa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:30:29 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:12725 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750761AbWDKLa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:30:28 -0400
Date: Tue, 11 Apr 2006 20:30:09 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:001/005] wait_table and zonelist initializing for memory hotadd (change name of wait_table_size())
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060411202031.5643.Y-GOTO@jp.fujitsu.com>
References: <20060411202031.5643.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060411202534.5645.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is just to rename from wait_table_size() to wait_table_hash_nr_entries().

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 include/linux/mmzone.h |    4 ++--
 mm/page_alloc.c        |   12 +++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

Index: pgdat10/mm/page_alloc.c
===================================================================
--- pgdat10.orig/mm/page_alloc.c	2006-04-10 18:30:42.000000000 +0900
+++ pgdat10/mm/page_alloc.c	2006-04-10 20:20:09.000000000 +0900
@@ -1786,7 +1786,7 @@ void __init build_all_zonelists(void)
  */
 #define PAGES_PER_WAITQUEUE	256
 
-static inline unsigned long wait_table_size(unsigned long pages)
+static inline unsigned long wait_table_hash_nr_entries(unsigned long pages)
 {
 	unsigned long size = 1;
 
@@ -2081,13 +2081,15 @@ void zone_wait_table_init(struct zone *z
 	 * The per-page waitqueue mechanism uses hashed waitqueues
 	 * per zone.
 	 */
-	zone->wait_table_size = wait_table_size(zone_size_pages);
-	zone->wait_table_bits =	wait_table_bits(zone->wait_table_size);
+	zone->wait_table_hash_nr_entries =
+		 wait_table_hash_nr_entries(zone_size_pages);
+	zone->wait_table_bits =
+		wait_table_bits(zone->wait_table_hash_nr_entries);
 	zone->wait_table = (wait_queue_head_t *)
-		alloc_bootmem_node(pgdat, zone->wait_table_size
+		alloc_bootmem_node(pgdat, zone->wait_table_hash_nr_entries
 					* sizeof(wait_queue_head_t));
 
-	for(i = 0; i < zone->wait_table_size; ++i)
+	for(i = 0; i < zone->wait_table_hash_nr_entries; ++i)
 		init_waitqueue_head(zone->wait_table + i);
 }
 
Index: pgdat10/include/linux/mmzone.h
===================================================================
--- pgdat10.orig/include/linux/mmzone.h	2006-04-10 18:30:40.000000000 +0900
+++ pgdat10/include/linux/mmzone.h	2006-04-10 20:19:33.000000000 +0900
@@ -196,7 +196,7 @@ struct zone {
 
 	/*
 	 * wait_table		-- the array holding the hash table
-	 * wait_table_size	-- the size of the hash table array
+	 * wait_table_hash_nr_entries	-- the size of the hash table array
 	 * wait_table_bits	-- wait_table_size == (1 << wait_table_bits)
 	 *
 	 * The purpose of all these is to keep track of the people
@@ -219,7 +219,7 @@ struct zone {
 	 * free_area_init_core() performs the initialization of them.
 	 */
 	wait_queue_head_t	* wait_table;
-	unsigned long		wait_table_size;
+	unsigned long		wait_table_hash_nr_entries;
 	unsigned long		wait_table_bits;
 
 	/*

-- 
Yasunori Goto 


