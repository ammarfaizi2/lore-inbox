Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbTIAKfG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 06:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbTIAKfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 06:35:06 -0400
Received: from [63.205.85.133] ([63.205.85.133]:30912 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262804AbTIAKfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 06:35:01 -0400
Date: Mon, 1 Sep 2003 03:42:21 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] simple const-ification for list.h
Message-ID: <20030901104221.GA15886@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixed up some warnings I was getting compiling some (unmerged)
code I'm working on.  Basically a few trivial list.h functions can operate
safely on "const" pointers, so their prototypes should reflect that.

-Mitch

--- linux-2.6.0-test4-VIRGIN/include/linux/list.h	2003-07-13 20:34:41.000000000 -0700
+++ linux-2.6.0-test4mnb1/include/linux/list.h	2003-08-31 16:43:40.057169288 -0700
@@ -203,7 +203,7 @@
  * list_empty - tests whether a list is empty
  * @head: the list to test.
  */
-static inline int list_empty(struct list_head *head)
+static inline int list_empty(const struct list_head *head)
 {
 	return head->next == head;
 }
@@ -408,12 +408,12 @@
 #define INIT_HLIST_HEAD(ptr) ((ptr)->first = NULL) 
 #define INIT_HLIST_NODE(ptr) ((ptr)->next = NULL, (ptr)->pprev = NULL)
 
-static __inline__ int hlist_unhashed(struct hlist_node *h) 
+static __inline__ int hlist_unhashed(const struct hlist_node *h) 
 { 
 	return !h->pprev;
 } 
 
-static __inline__ int hlist_empty(struct hlist_head *h) 
+static __inline__ int hlist_empty(const struct hlist_head *h) 
 { 
 	return !h->first;
 } 
