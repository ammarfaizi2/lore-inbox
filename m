Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTIAMWV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 08:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbTIAMWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 08:22:21 -0400
Received: from johanna5.ux.his.no ([152.94.1.25]:5565 "EHLO johanna5.ux.his.no")
	by vger.kernel.org with ESMTP id S262827AbTIAMWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 08:22:17 -0400
Date: Mon, 1 Sep 2003 14:22:13 +0200
From: Erlend Aasland <erlend-a@ux.his.no>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] __inline__ to inline in list.h
Message-ID: <20030901122213.GA462@johanna5.ux.his.no>
Reply-To: Erlend Aasland <erlend-a@ux.his.no>
References: <20030901104221.GA15886@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901104221.GA15886@gaz.sfgoth.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/01/03 03:42, Mitchell Blank Jr wrote:
> -static __inline__ int hlist_unhashed(struct hlist_node *h) 
> +static __inline__ int hlist_unhashed(const struct hlist_node *h) 

Is there any reason for not converting __inline__ to inline?
If there's not, then just convert them:

diff -urN linux-2.6.0-test4/include/linux/list.h linux-2.6.0-test4-dirty/include/linux/list.h
--- linux-2.6.0-test4/include/linux/list.h	2003-08-23 01:56:34.000000000 +0200
+++ linux-2.6.0-test4-dirty/include/linux/list.h	2003-09-01 12:51:38.000000000 +0200
@@ -86,7 +86,7 @@
  * This is only for internal list manipulation where we know
  * the prev/next entries already!
  */
-static __inline__ void __list_add_rcu(struct list_head * new,
+static inline void __list_add_rcu(struct list_head * new,
 	struct list_head * prev,
 	struct list_head * next)
 {
@@ -105,7 +105,7 @@
  * Insert a new entry after the specified head.
  * This is good for implementing stacks.
  */
-static __inline__ void list_add_rcu(struct list_head *new, struct list_head *head)
+static inline void list_add_rcu(struct list_head *new, struct list_head *head)
 {
 	__list_add_rcu(new, head, head->next);
 }
@@ -118,7 +118,7 @@
  * Insert a new entry before the specified head.
  * This is useful for implementing queues.
  */
-static __inline__ void list_add_tail_rcu(struct list_head *new, struct list_head *head)
+static inline void list_add_tail_rcu(struct list_head *new, struct list_head *head)
 {
 	__list_add_rcu(new, head->prev, head);
 }
@@ -408,17 +408,17 @@
 #define INIT_HLIST_HEAD(ptr) ((ptr)->first = NULL) 
 #define INIT_HLIST_NODE(ptr) ((ptr)->next = NULL, (ptr)->pprev = NULL)
 
-static __inline__ int hlist_unhashed(struct hlist_node *h) 
+static inline int hlist_unhashed(struct hlist_node *h) 
 { 
 	return !h->pprev;
 } 
 
-static __inline__ int hlist_empty(struct hlist_head *h) 
+static inline int hlist_empty(struct hlist_head *h) 
 { 
 	return !h->first;
 } 
 
-static __inline__ void __hlist_del(struct hlist_node *n) 
+static inline void __hlist_del(struct hlist_node *n) 
 {
 	struct hlist_node *next = n->next;
 	struct hlist_node **pprev = n->pprev;
@@ -427,7 +427,7 @@
 		next->pprev = pprev;
 }  
 
-static __inline__ void hlist_del(struct hlist_node *n)
+static inline void hlist_del(struct hlist_node *n)
 {
 	__hlist_del(n);
 	n->next = LIST_POISON1;
@@ -451,7 +451,7 @@
 	n->pprev = LIST_POISON2;
 }
 
-static __inline__ void hlist_del_init(struct hlist_node *n) 
+static inline void hlist_del_init(struct hlist_node *n) 
 {
 	if (n->pprev)  {
 		__hlist_del(n);
@@ -461,7 +461,7 @@
 
 #define hlist_del_rcu_init hlist_del_init
 
-static __inline__ void hlist_add_head(struct hlist_node *n, struct hlist_head *h) 
+static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h) 
 { 
 	struct hlist_node *first = h->first;
 	n->next = first; 
@@ -471,7 +471,7 @@
 	n->pprev = &h->first; 
 } 
 
-static __inline__ void hlist_add_head_rcu(struct hlist_node *n, struct hlist_head *h) 
+static inline void hlist_add_head_rcu(struct hlist_node *n, struct hlist_head *h) 
 { 
 	struct hlist_node *first = h->first;
 	n->next = first;
@@ -483,7 +483,7 @@
 } 
 
 /* next must be != NULL */
-static __inline__ void hlist_add_before(struct hlist_node *n, struct hlist_node *next)
+static inline void hlist_add_before(struct hlist_node *n, struct hlist_node *next)
 {
 	n->pprev = next->pprev;
 	n->next = next; 
@@ -491,7 +491,7 @@
 	*(n->pprev) = n;
 }
 
-static __inline__ void hlist_add_after(struct hlist_node *n,
+static inline void hlist_add_after(struct hlist_node *n,
 				       struct hlist_node *next)
 {
 	next->next	= n->next;
