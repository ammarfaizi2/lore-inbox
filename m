Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWERRvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWERRvO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 13:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWERRvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 13:51:14 -0400
Received: from xenotime.net ([66.160.160.81]:45784 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932104AbWERRvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 13:51:13 -0400
Date: Thu, 18 May 2006 10:53:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH 1/2] fix list.h kernel-doc
Message-Id: <20060518105342.12f4cc72.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

kernel-doc:

Put all short function descriptions on one line or if they are too
long, omit the short description & add a Description: section for them.

Change some list iterator descriptions to use "current" point
instead of "existing" point.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/linux/list.h |   82 ++++++++++++++++++++++++++++++++-------------------
 1 files changed, 52 insertions(+), 30 deletions(-)

--- linux-2617-rc4g6.orig/include/linux/list.h
+++ linux-2617-rc4g6/include/linux/list.h
@@ -258,16 +258,17 @@ static inline int list_empty(const struc
 }
 
 /**
- * list_empty_careful - tests whether a list is
- * empty _and_ checks that no other CPU might be
- * in the process of still modifying either member
+ * list_empty_careful - tests whether a list is empty and not being modified
+ * @head: the list to test
+ *
+ * Description:
+ * tests whether a list is empty _and_ checks that no other CPU might be
+ * in the process of modifying either member (next or prev)
  *
  * NOTE: using list_empty_careful() without synchronization
  * can only be safe if the only activity that can happen
  * to the list entry is list_del_init(). Eg. it cannot be used
  * if another CPU could re-list_add() it.
- *
- * @head: the list to test.
  */
 static inline int list_empty_careful(const struct list_head *head)
 {
@@ -357,7 +358,7 @@ static inline void list_splice_init(stru
         	pos = pos->prev)
 
 /**
- * list_for_each_safe	-	iterate over a list safe against removal of list entry
+ * list_for_each_safe - iterate over a list safe against removal of list entry
  * @pos:	the &struct list_head to use as a loop counter.
  * @n:		another &struct list_head to use as temporary storage
  * @head:	the head for your list.
@@ -389,21 +390,24 @@ static inline void list_splice_init(stru
 	     pos = list_entry(pos->member.prev, typeof(*pos), member))
 
 /**
- * list_prepare_entry - prepare a pos entry for use as a start point in
- *			list_for_each_entry_continue
+ * list_prepare_entry - prepare a pos entry for use in list_for_each_entry_continue
  * @pos:	the type * to use as a start point
  * @head:	the head of the list
  * @member:	the name of the list_struct within the struct.
+ *
+ * Prepares a pos entry for use as a start point in list_for_each_entry_continue.
  */
 #define list_prepare_entry(pos, head, member) \
 	((pos) ? : list_entry(head, typeof(*pos), member))
 
 /**
- * list_for_each_entry_continue -	iterate over list of given type
- *			continuing after existing point
+ * list_for_each_entry_continue - continue iteration over list of given type
  * @pos:	the type * to use as a loop counter.
  * @head:	the head for your list.
  * @member:	the name of the list_struct within the struct.
+ *
+ * Continue to iterate over list of given type, continuing after
+ * the current position.
  */
 #define list_for_each_entry_continue(pos, head, member) 		\
 	for (pos = list_entry(pos->member.next, typeof(*pos), member);	\
@@ -411,11 +415,12 @@ static inline void list_splice_init(stru
 	     pos = list_entry(pos->member.next, typeof(*pos), member))
 
 /**
- * list_for_each_entry_from -	iterate over list of given type
- *			continuing from existing point
+ * list_for_each_entry_from - iterate over list of given type from the current point
  * @pos:	the type * to use as a loop counter.
  * @head:	the head for your list.
  * @member:	the name of the list_struct within the struct.
+ *
+ * Iterate over list of given type, continuing from current position.
  */
 #define list_for_each_entry_from(pos, head, member) 			\
 	for (; prefetch(pos->member.next), &pos->member != (head);	\
@@ -435,12 +440,14 @@ static inline void list_splice_init(stru
 	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
 
 /**
- * list_for_each_entry_safe_continue -	iterate over list of given type
- *			continuing after existing point safe against removal of list entry
+ * list_for_each_entry_safe_continue
  * @pos:	the type * to use as a loop counter.
  * @n:		another type * to use as temporary storage
  * @head:	the head for your list.
  * @member:	the name of the list_struct within the struct.
+ *
+ * Iterate over list of given type, continuing after current point,
+ * safe against removal of list entry.
  */
 #define list_for_each_entry_safe_continue(pos, n, head, member) 		\
 	for (pos = list_entry(pos->member.next, typeof(*pos), member), 		\
@@ -449,12 +456,14 @@ static inline void list_splice_init(stru
 	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
 
 /**
- * list_for_each_entry_safe_from - iterate over list of given type
- *			from existing point safe against removal of list entry
+ * list_for_each_entry_safe_from
  * @pos:	the type * to use as a loop counter.
  * @n:		another type * to use as temporary storage
  * @head:	the head for your list.
  * @member:	the name of the list_struct within the struct.
+ *
+ * Iterate over list of given type from current point, safe against
+ * removal of list entry.
  */
 #define list_for_each_entry_safe_from(pos, n, head, member) 			\
 	for (n = list_entry(pos->member.next, typeof(*pos), member);		\
@@ -462,12 +471,14 @@ static inline void list_splice_init(stru
 	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
 
 /**
- * list_for_each_entry_safe_reverse - iterate backwards over list of given type safe against
- *				      removal of list entry
+ * list_for_each_entry_safe_reverse
  * @pos:	the type * to use as a loop counter.
  * @n:		another type * to use as temporary storage
  * @head:	the head for your list.
  * @member:	the name of the list_struct within the struct.
+ *
+ * Iterate backwards over list of given type, safe against removal
+ * of list entry.
  */
 #define list_for_each_entry_safe_reverse(pos, n, head, member)		\
 	for (pos = list_entry((head)->prev, typeof(*pos), member),	\
@@ -495,12 +506,13 @@ static inline void list_splice_init(stru
         	pos = pos->next)
 
 /**
- * list_for_each_safe_rcu	-	iterate over an rcu-protected list safe
- *					against removal of list entry
+ * list_for_each_safe_rcu
  * @pos:	the &struct list_head to use as a loop counter.
  * @n:		another &struct list_head to use as temporary storage
  * @head:	the head for your list.
  *
+ * Iterate over an rcu-protected list, safe against removal of list entry.
+ *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as list_add_rcu()
  * as long as the traversal is guarded by rcu_read_lock().
@@ -528,11 +540,12 @@ static inline void list_splice_init(stru
 
 
 /**
- * list_for_each_continue_rcu	-	iterate over an rcu-protected list
- *			continuing after existing point.
+ * list_for_each_continue_rcu
  * @pos:	the &struct list_head to use as a loop counter.
  * @head:	the head for your list.
  *
+ * Iterate over an rcu-protected list, continuing after current point.
+ *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as list_add_rcu()
  * as long as the traversal is guarded by rcu_read_lock().
@@ -658,11 +671,14 @@ static inline void hlist_add_head(struct
 
 
 /**
- * hlist_add_head_rcu - adds the specified element to the specified hlist,
- * while permitting racing traversals.
+ * hlist_add_head_rcu
  * @n: the element to add to the hash list.
  * @h: the list to add to.
  *
+ * Description:
+ * Adds the specified element to the specified hlist,
+ * while permitting racing traversals.
+ *
  * The caller must take whatever precautions are necessary
  * (such as holding appropriate locks) to avoid racing
  * with another list-mutation primitive, such as hlist_add_head_rcu()
@@ -707,11 +723,14 @@ static inline void hlist_add_after(struc
 }
 
 /**
- * hlist_add_before_rcu - adds the specified element to the specified hlist
- * before the specified node while permitting racing traversals.
+ * hlist_add_before_rcu
  * @n: the new element to add to the hash list.
  * @next: the existing element to add the new element before.
  *
+ * Description:
+ * Adds the specified element to the specified hlist
+ * before the specified node while permitting racing traversals.
+ *
  * The caller must take whatever precautions are necessary
  * (such as holding appropriate locks) to avoid racing
  * with another list-mutation primitive, such as hlist_add_head_rcu()
@@ -732,11 +751,14 @@ static inline void hlist_add_before_rcu(
 }
 
 /**
- * hlist_add_after_rcu - adds the specified element to the specified hlist
- * after the specified node while permitting racing traversals.
+ * hlist_add_after_rcu
  * @prev: the existing element to add the new element after.
  * @n: the new element to add to the hash list.
  *
+ * Description:
+ * Adds the specified element to the specified hlist
+ * after the specified node while permitting racing traversals.
+ *
  * The caller must take whatever precautions are necessary
  * (such as holding appropriate locks) to avoid racing
  * with another list-mutation primitive, such as hlist_add_head_rcu()
@@ -781,7 +803,7 @@ static inline void hlist_add_after_rcu(s
 	     pos = pos->next)
 
 /**
- * hlist_for_each_entry_continue - iterate over a hlist continuing after existing point
+ * hlist_for_each_entry_continue - iterate over a hlist continuing after current point
  * @tpos:	the type * to use as a loop counter.
  * @pos:	the &struct hlist_node to use as a loop counter.
  * @member:	the name of the hlist_node within the struct.
@@ -793,7 +815,7 @@ static inline void hlist_add_after_rcu(s
 	     pos = pos->next)
 
 /**
- * hlist_for_each_entry_from - iterate over a hlist continuing from existing point
+ * hlist_for_each_entry_from - iterate over a hlist continuing from current point
  * @tpos:	the type * to use as a loop counter.
  * @pos:	the &struct hlist_node to use as a loop counter.
  * @member:	the name of the hlist_node within the struct.


---
