Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313722AbSDHU2B>; Mon, 8 Apr 2002 16:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313723AbSDHU2A>; Mon, 8 Apr 2002 16:28:00 -0400
Received: from barrichello.cs.ucr.edu ([138.23.169.5]:31935 "HELO
	barrichello.cs.ucr.edu") by vger.kernel.org with SMTP
	id <S313722AbSDHU17>; Mon, 8 Apr 2002 16:27:59 -0400
Date: Mon, 8 Apr 2002 13:27:49 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] list_del_all
Message-ID: <Pine.LNX.4.30.0204081327150.26582-100000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS perl-6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- include/linux/list.h.orig	Mon Apr  8 13:10:55 2002
+++ include/linux/list.h	Mon Apr  8 13:22:48 2002
@@ -170,7 +170,23 @@
 #define list_for_each_prev(pos, head) \
 	for (pos = (head)->prev, prefetch(pos->prev); pos != (head); \
         	pos = pos->prev, prefetch(pos->prev))
-
+
+/**
+ * list_del_all -               delete all entries in list and call func for each entry
+ * @head:       the head for your list
+ * @func:       callback that should be called for each entry
+ * @type:       the type of the struct this is embedded in
+ * @member:     the name of the list_struct within the struct
+ */
+#define list_del_all( head, func, type, member )                        \
+        do {                                                            \
+                struct list_head *curr, *next;                          \
+                list_for_each_safe( curr, next, head ) {                \
+                        type *var = list_entry( curr, type, member );   \
+                        list_del( curr );                               \
+                        func( var );                                    \
+                }                                                       \
+        } while ( 0 )

 #endif /* __KERNEL__ || _LVM_H_INCLUDE */


