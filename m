Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268021AbUIGNCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268021AbUIGNCs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 09:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUIGNCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 09:02:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14285 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268021AbUIGNCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 09:02:32 -0400
Date: Tue, 7 Sep 2004 14:02:21 +0100
Message-Id: <200409071302.i87D2LSQ030902@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Mingming Cao <cmm@us.ibm.com>, pbadari@us.ibm.com,
       Ram Pai <linuxram@us.ibm.com>
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 1/6]: ext3 reservations: Spelling fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6.9-rc1-mm4/fs/ext3/balloc.c.=K0000=.orig
+++ linux-2.6.9-rc1-mm4/fs/ext3/balloc.c
@@ -571,19 +571,19 @@ fail_access:
 
 /**
  * 	find_next_reservable_window():
- *		find a reservable space within the given range
- *		It does not allocate the reservation window for now
+ *		find a reservable space within the given range.
+ *		It does not allocate the reservation window for now:
  *		alloc_new_reservation() will do the work later.
  *
  * 	@search_head: the head of the searching list;
- *		This is not necessary the list head of the whole filesystem
+ *		This is not necessarily the list head of the whole filesystem
  *
- *		we have both head and start_block to assist the search
- *		for the reservable space. The list start from head,
+ *		We have both head and start_block to assist the search
+ *		for the reservable space. The list starts from head,
  *		but we will shift to the place where start_block is,
- *		then start from there, we looking for a resevable space.
+ *		then start from there, when looking for a reservable space.
  *
- *	@fs_rsv_head: per-filesystem reervation list head.
+ *	@fs_rsv_head: per-filesystem reservation list head.
  *
  * 	@size: the target new reservation window size
  * 	@group_first_block: the first block we consider to start
@@ -598,10 +598,10 @@ fail_access:
  *
  * 	basically we search from the given range, rather than the whole
  * 	reservation double linked list, (start_block, last_block)
- * 	to find a free region that of of my size and has not
+ * 	to find a free region that is of my size and has not
  * 	been reserved.
  *
- *	on succeed, it returns the reservation window to be append to.
+ *	on succeed, it returns the reservation window to be appended to.
  *	failed, return NULL.
  */
 static inline
@@ -614,8 +614,8 @@ struct reserve_window *find_next_reserva
 	struct reserve_window *rsv;
 	int cur;
 
-	/* TODO:make the start of the reservation window byte alligned */
-	/*cur = *start_block & 8;*/
+	/* TODO:make the start of the reservation window byte-aligned */
+	/* cur = *start_block & ~7;*/
 	cur = *start_block;
 	rsv = list_entry(search_head->rsv_list.next,
 				struct reserve_window, rsv_list);
@@ -667,32 +667,32 @@ struct reserve_window *find_next_reserva
  *		is not given.
  *
  *		To make a new reservation, we search part of the filesystem
- *		reservation list(the list that inside the group).
+ *		reservation list (the list that inside the group).
  *
  *		If we have a old reservation, the search goal is the end of
- *		last reservation. If we do not have a old reservatio, then we
+ *		last reservation. If we do not have a old reservation, then we
  *		start from a given goal, or the first block of the group, if
  *		the goal is not given.
  *
  *		We first find a reservable space after the goal, then from
- *		there,we check the bitmap for the first free block after
+ *		there, we check the bitmap for the first free block after
  *		it. If there is no free block until the end of group, then the
  *		whole group is full, we failed. Otherwise, check if the free
  *		block is inside the expected reservable space, if so, we
  *		succeed.
- *		If the first free block is outside the reseravle space, then
- *		start from the first free block, we search for next avalibale
+ *		If the first free block is outside the reservable space, then
+ *		start from the first free block, we search for next available
  *		space, and go on.
  *
  *	on succeed, a new reservation will be found and inserted into the list
- *	It contains at least one free block, and it is not overlap with other
- *	reservation window.
+ *	It contains at least one free block, and it does not overlap with other
+ *	reservation windows.
  *
- *	failed: we failed to found a reservation window in this group
+ *	failed: we failed to find a reservation window in this group
  *
  *	@rsv: the reservation
  *
- *	@goal: The goal.  It is where the search for a
+ *	@goal: The goal (group-relative).  It is where the search for a
  *		free reservable space should start from.
  *		if we have a old reservation, start_block is the end of
  *		old reservation. Otherwise,
@@ -701,7 +701,7 @@ struct reserve_window *find_next_reserva
  *		of the group.
  *
  *	@sb: the super block
- *	@group: the group we are trying to do allocate in
+ *	@group: the group we are trying to allocate in
  *	@bitmap_bh: the block group block bitmap
  */
 static int alloc_new_reservation(struct reserve_window *my_rsv,
@@ -771,7 +771,7 @@ static int alloc_new_reservation(struct 
 	}
 
 	/*
-	 * find_next_reservable_window() simply find a reservable window
+	 * find_next_reservable_window() simply finds a reservable window
 	 * inside the given range(start_block, group_end_block).
 	 *
 	 * To make sure the reservation window has a free bit inside it, we
@@ -851,12 +851,13 @@ failed:
  * its own reservation.  If it does not have a reservation window, instead of
  * looking for a free bit on bitmap first, then look up the reservation list to
  * see if it is inside somebody else's reservation window, we try to allocate a
- * reservation window for it start from the goal first. Then do the block
+ * reservation window for it starting from the goal first. Then do the block
  * allocation within the reservation window.
  *
- * This will aviod keep searching the reservation list again and again when
- * someboday is looking for a free block(without reservation), and there are
- * lots of free blocks, but they are all being reserved
+ * This will avoid keeping on searching the reservation list again and
+ * again when someboday is looking for a free block (without
+ * reservation), and there are lots of free blocks, but they are all
+ * being reserved.
  *
  * We use a sorted double linked list for the per-filesystem reservation list.
  * The insert, remove and find a free space(non-reserved) operations for the
@@ -893,7 +894,7 @@ ext3_try_to_allocate_with_rsv(struct sup
 	 * we don't deal with reservation when
 	 * filesystem is mounted without reservation
 	 * or the file is not a regular file
-	 * of last attemp of allocating a block with reservation turn on failed
+	 * or last attempt to allocate a block with reservation turned on failed
 	 */
 	if (my_rsv == NULL ) {
 		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal, NULL);
@@ -915,13 +916,13 @@ ext3_try_to_allocate_with_rsv(struct sup
 	 *
 	 * We need to allocate a new reservation window, if:
 	 * a) inode does not have a reservation window; or
-	 * b) last attemp of allocating a block from existing reservation
+	 * b) last attempt to allocate a block from existing reservation
 	 *    failed; or
 	 * c) we come here with a goal and with a reservation window
 	 *
 	 * We do not need to allocate a new reservation window if we come here
 	 * at the beginning with a goal and the goal is inside the window, or
-	 * or we don't have a goal but already have a reservation window.
+	 * we don't have a goal but already have a reservation window.
 	 * then we could go to allocate from the reservation window directly.
 	 */
 	while (1) {
