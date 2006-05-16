Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWEPRpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWEPRpT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWEPRpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:45:13 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:30214 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932323AbWEPRot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:44:49 -0400
Message-ID: <446A0F86.9070806@de.ibm.com>
Date: Tue, 16 May 2006 19:44:38 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, ak@suse.de, hch@infradead.org, arjan@infradead.org,
       James.Smart@Emulex.Com, James.Bottomley@SteelEye.com
Subject: [RFC] [Patch 1/8] statistics infrastructure - prerequisite: list
 operation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds another list_for_each_* derivate. I can't work around it
because there is a list that I need to search both ways.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

  list.h |   12 ++++++++++++
  1 files changed, 12 insertions(+)

diff -Nurp a/include/linux/list.h b/include/linux/list.h
--- a/include/linux/list.h	2006-05-15 12:42:12.000000000 +0200
+++ b/include/linux/list.h	2006-05-15 17:26:16.000000000 +0200
@@ -411,6 +411,18 @@ static inline void list_splice_init(stru
  	     pos = list_entry(pos->member.next, typeof(*pos), member))

  /**
+ * list_for_each_entry_continue_reverse -	iterate backwards over list
+ *			of given type continuing before existing point
+ * @pos:	the type * to use as a loop counter.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
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


