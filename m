Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVARG0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVARG0Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 01:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVARG0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 01:26:25 -0500
Received: from ozlabs.org ([203.10.76.45]:29394 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261241AbVARG0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 01:26:18 -0500
Subject: [PATCH] Remove nonsensical list function list_for_each_safe_rcu
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul McKenney <Paul.McKenney@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 17:26:05 +1100
Message-Id: <1106029565.30801.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Remove nonsensical list function
Status: Trivial
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

The correct use of list_for_each_safe_rcu is a coding puzzle which
minor minds such mine are not capable of solving.  Please remove this
obstacle on my path to enlightenment.

Index: linux-2.6.11-rc1-bk5-Misc/Documentation/RCU/checklist.txt
===================================================================
--- linux-2.6.11-rc1-bk5-Misc.orig/Documentation/RCU/checklist.txt	2005-01-18 17:20:56.484344256 +1100
+++ linux-2.6.11-rc1-bk5-Misc/Documentation/RCU/checklist.txt	2005-01-18 17:21:12.846856776 +1100
@@ -132,11 +132,11 @@
 
 9.	All RCU list-traversal primitives, which include
 	list_for_each_rcu(), list_for_each_entry_rcu(),
-	list_for_each_continue_rcu(), and list_for_each_safe_rcu(),
-	must be within an RCU read-side critical section.  RCU
-	read-side critical sections are delimited by rcu_read_lock()
-	and rcu_read_unlock(), or by similar primitives such as
-	rcu_read_lock_bh() and rcu_read_unlock_bh().
+	and list_for_each_continue_rcu(), must be within an RCU
+	read-side critical section.  RCU read-side critical sections
+	are delimited by rcu_read_lock() and rcu_read_unlock(), or by
+	similar primitives such as rcu_read_lock_bh()
+	and rcu_read_unlock_bh().
 
 	Use of the _rcu() list-traversal primitives outside of an
 	RCU read-side critical section causes no harm other than
Index: linux-2.6.11-rc1-bk5-Misc/include/linux/list.h
===================================================================
--- linux-2.6.11-rc1-bk5-Misc.orig/include/linux/list.h	2005-01-18 17:18:39.394185128 +1100
+++ linux-2.6.11-rc1-bk5-Misc/include/linux/list.h	2005-01-18 17:19:47.098892448 +1100
@@ -436,21 +436,6 @@
         	pos = rcu_dereference(pos->next))
 
 /**
- * list_for_each_safe_rcu	-	iterate over an rcu-protected list safe
- *					against removal of list entry
- * @pos:	the &struct list_head to use as a loop counter.
- * @n:		another &struct list_head to use as temporary storage
- * @head:	the head for your list.
- *
- * This list-traversal primitive may safely run concurrently with
- * the _rcu list-mutation primitives such as list_add_rcu()
- * as long as the traversal is guarded by rcu_read_lock().
- */
-#define list_for_each_safe_rcu(pos, n, head) \
-	for (pos = (head)->next, n = pos->next; pos != (head); \
-		pos = rcu_dereference(n), n = pos->next)
-
-/**
  * list_for_each_entry_rcu	-	iterate over rcu list of given type
  * @pos:	the type * to use as a loop counter.
  * @head:	the head for your list.

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

