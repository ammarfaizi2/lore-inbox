Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbTJEHUz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 03:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbTJEHUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 03:20:55 -0400
Received: from dp.samba.org ([66.70.73.150]:57027 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262991AbTJEHUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 03:20:52 -0400
From: Rusty Trivial Russell <trivial@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] [2.6 PATCH] hlist constification
Date: Sun, 05 Oct 2003 16:55:19 +1000
Message-Id: <20031005072052.3102C2CC42@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Mitchell Blank Jr <mitch@sfgoth.com>

  I posted a patch to consify 3 inline functions in <linux/list.h> to lkml
  on 9/1 but it looks like it slipped through the cracks.  Looking at your
  trivial tree it seems that Inaky Perez-Gonzalez already submitted a patch
  to constify list_empty().  Here is a patch to do the other two.  Should
  be non-controversial.
  
  Patch is versus your current 2.6.0-test5-bk2 trivial tree.
  
  -Mitch
  

--- trivial-2.6.0-test6-bk6/include/linux/list.h.orig	2003-10-05 16:50:48.000000000 +1000
+++ trivial-2.6.0-test6-bk6/include/linux/list.h	2003-10-05 16:50:48.000000000 +1000
@@ -421,12 +421,12 @@
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
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Mitchell Blank Jr <mitch@sfgoth.com>: [2.6 PATCH] hlist constification
