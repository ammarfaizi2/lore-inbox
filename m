Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267928AbUJNWOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267928AbUJNWOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUJNWMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:12:50 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:15852 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267767AbUJNVoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:44:14 -0400
Date: Thu, 14 Oct 2004 23:44:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] move struct list_head to linux/types.h
Message-ID: <Pine.LNX.4.61.0410142343410.29939@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This moves the definition and the initializer of struct list_head from
linux/list.h to linux/types.h.
I exented the protection via __KERNEL__ to include sector_t and pgoff_t,
I don't think they are relevant for user space.

 list.h  |    6 ------
 types.h |    9 +++++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

Index: linux-2.6-inc/include/linux/types.h
===================================================================
--- linux-2.6-inc.orig/include/linux/types.h	2004-05-10 19:17:33.000000000 +0200
+++ linux-2.6-inc/include/linux/types.h	2004-10-14 02:06:33.646151715 +0200
@@ -123,6 +123,7 @@ typedef		__u64		u_int64_t;
 typedef		__s64		int64_t;
 #endif
 
+#ifdef __KERNEL__
 /*
  * The type used for indexing onto a disc or disc partition.
  * If required, asm/types.h can override it and define
@@ -140,6 +141,14 @@ typedef unsigned long sector_t;
 #define pgoff_t unsigned long
 #endif
 
+struct list_head {
+	struct list_head *next, *prev;
+};
+
+#define LIST_HEAD_INIT(name) { .next = &(name), .prev = &(name) }
+
+#endif /* __KERNEL__ */
+
 #endif /* __KERNEL_STRICT_NAMES */
 
 /*
Index: linux-2.6-inc/include/linux/list.h
===================================================================
--- linux-2.6-inc.orig/include/linux/list.h	2004-08-14 13:01:14.000000000 +0200
+++ linux-2.6-inc/include/linux/list.h	2004-10-14 02:05:30.053176848 +0200
@@ -25,12 +25,6 @@
  * using the generic single-entry routines.
  */
 
-struct list_head {
-	struct list_head *next, *prev;
-};
-
-#define LIST_HEAD_INIT(name) { &(name), &(name) }
-
 #define LIST_HEAD(name) \
 	struct list_head name = LIST_HEAD_INIT(name)
 
