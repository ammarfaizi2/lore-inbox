Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWESQJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWESQJO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 12:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWESQJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 12:09:14 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:52756 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932426AbWESQJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 12:09:13 -0400
Subject: [Patch 1/6] statistics infrastructure - prerequisite: list
	operation
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 19 May 2006 18:09:10 +0200
Message-Id: <1148054950.2974.12.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds another list_for_each_* derivate. I can't work around it
because there is a list that I need to search both ways.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 list.h |   13 +++++++++++++
 1 files changed, 13 insertions(+)

diff -Nurp a/include/linux/list.h b/include/linux/list.h
--- a/include/linux/list.h	2006-05-19 15:44:27.000000000 +0200
+++ b/include/linux/list.h	2006-05-19 16:28:14.000000000 +0200
@@ -411,6 +411,19 @@ static inline void list_splice_init(stru
 	     pos = list_entry(pos->member.next, typeof(*pos), member))
 
 /**
+ * list_for_each_entry_continue_reverse - list iterator variant
+ * @pos:	the type * to use as a loop counter.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ *
+ * Iterates backwards over list of given type continuing before given point.
+ */
+#define list_for_each_entry_continue_reverse(pos, head, member) 	\
+	for (pos = list_entry(pos->member.prev, typeof(*pos), member);	\
+	     prefetch(pos->member.prev), &pos->member != (head);	\
+	     pos = list_entry(pos->member.prev, typeof(*pos), member))
+
+/**
  * list_for_each_entry_from -	iterate over list of given type
  *			continuing from existing point
  * @pos:	the type * to use as a loop counter.


