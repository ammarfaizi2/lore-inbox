Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbVLNQN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbVLNQN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVLNQN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:13:57 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:4566 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932629AbVLNQNz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:13:55 -0500
Message-ID: <43A044C9.2050204@de.ibm.com>
Date: Wed, 14 Dec 2005 17:14:01 +0100
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: [patch 3/6] statistics infrastructure - prerequisite: list operation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/6] statistics infrastructure - prerequisite: list operation

This patch adds another list_for_each_* derivate. I can't work around it
because there is a list that I need to search both ways.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

  list.h |   12 ++++++++++++
  1 files changed, 12 insertions(+)

diff -Nurp c/include/linux/list.h d/include/linux/list.h
--- c/include/linux/list.h	2005-12-14 12:51:52.000000000 +0100
+++ d/include/linux/list.h	2005-12-14 13:56:08.000000000 +0100
@@ -409,6 +409,18 @@ static inline void list_splice_init(stru
  	     pos = list_entry(pos->member.next, typeof(*pos), member))

  /**
+ * list_for_each_entry_continue_reverse -       iterate backwards over list
+ *                      of given type continuing before existing point
+ * @pos:        the type * to use as a loop counter.
+ * @head:       the head for your list.
+ * @member:     the name of the list_struct within the struct.
+ */
+#define list_for_each_entry_continue_reverse(pos, head, member)                 \
+        for (pos = list_entry(pos->member.prev, typeof(*pos), member);  \
+             prefetch(pos->member.prev), &pos->member != (head);        \
+             pos = list_entry(pos->member.prev, typeof(*pos), member))
+
+/**
   * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
   * @pos:	the type * to use as a loop counter.
   * @n:		another type * to use as temporary storage
