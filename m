Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWGHFYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWGHFYY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 01:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWGHFYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 01:24:24 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:319 "EHLO
	asav05.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1750742AbWGHFYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 01:24:24 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FADLcrkSBTA
From: Dmitry Torokhov <dtor@insightbb.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Introduce list_get() and list_get_tail()
Date: Sat, 8 Jul 2006 01:24:21 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607080124.21856.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dtor@mail.ru>

Add primitives to access first and last elements of a list instead
of accessng pointers directly.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

We have primitives to iterate over lists and to add/delete elements,
why not for accessing head/tail?

 include/linux/list.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+)

Index: work/include/linux/list.h
===================================================================
--- work.orig/include/linux/list.h
+++ work/include/linux/list.h
@@ -571,6 +571,24 @@ static inline void list_splice_init(stru
 		prefetch(rcu_dereference((pos))->next), (pos) != (head); \
         	(pos) = (pos)->next)
 
+/**
+ * list_get - get first element in a list
+ * @head: the head of your list
+ */
+static inline struct list_head *list_get(struct list_head *head)
+{
+	return head->next;
+}
+
+/**
+ * list_get_tail - get last element in a list
+ * @head: the head of your list
+ */
+static inline struct list_head *list_get_tail(struct list_head *head)
+{
+	return head->prev;
+}
+
 /*
  * Double linked lists with a single pointer list head.
  * Mostly useful for hash tables where the two pointer list head is
