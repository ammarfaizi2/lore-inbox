Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317601AbSFIMm1>; Sun, 9 Jun 2002 08:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSFIMm0>; Sun, 9 Jun 2002 08:42:26 -0400
Received: from p50887457.dip.t-dialin.net ([80.136.116.87]:54458 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317601AbSFIMm0>; Sun, 9 Jun 2002 08:42:26 -0400
Date: Sun, 9 Jun 2002 06:42:17 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] introduce list_move macros (revisited)
In-Reply-To: <Pine.LNX.4.44.0206090508330.22407-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0206090641330.24893-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only _global_ patch about the list_move macros, which means 
introducing them. Here they are, revisited:

--- linus-2.5/include/linux/list.h	Sun Jun  9 04:17:14 2002
+++ thunder-2.5/include/linux/list.h	Sun Jun  9 06:40:14 2002
@@ -174,6 +174,26 @@
 	for (pos = (head)->next, n = pos->next; pos != (head); \
 		pos = n, n = pos->next)
 
+/**
+ * list_move           - move a list entry from a right after b
+ * @list       the entry to move
+ * @head       the entry to move after
+ */
+#define list_move(list,head) \
+        do { __list_del(list->prev, list->next); \
+             list_add(list,head); } \
+        while(0)
+
+/**
+ * list_move_tail      - move a list entry from a right before b
+ * @list       the entry to move
+ * @head       the entry that will come after ours
+ */
+#define list_move_tail(list,head) \
+        do { __list_del(list->prev, list->next); \
+             list_add_tail(list,head); } \
+        while(0)
+
 #endif /* __KERNEL__ || _LVM_H_INCLUDE */
 
 #endif

-- 
Lightweight patch manager using pine. If you have any objections, tell me.

