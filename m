Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVKNVzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVKNVzU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVKNVzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:55:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3221 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751274AbVKNVyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:54:51 -0500
Date: Mon, 14 Nov 2005 21:54:38 GMT
Message-Id: <200511142154.jAELscCP007519@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Fcc: outgoing
Subject: [PATCH 3/12] FS-Cache: Add list_for_each_entry_safe_reverse()
In-Reply-To: <dhowells1132005277@warthog.cambridge.redhat.com>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds list_for_each_entry_safe_reverse() to linux/list.h

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 list-foreach-saferev-2614mm2.diff
 include/linux/list.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

diff -uNrp linux-2.6.14-mm2/include/linux/list.h linux-2.6.14-mm2-cachefs/include/linux/list.h
--- linux-2.6.14-mm2/include/linux/list.h	2005-11-14 16:17:58.000000000 +0000
+++ linux-2.6.14-mm2-cachefs/include/linux/list.h	2005-11-14 16:23:38.000000000 +0000
@@ -450,6 +450,20 @@ static inline void list_splice_init(stru
 	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
 
 /**
+ * list_for_each_entry_safe_reverse - iterate backwards over list of given type safe against
+ *				      removal of list entry
+ * @pos:	the type * to use as a loop counter.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry_safe_reverse(pos, n, head, member)		\
+	for (pos = list_entry((head)->prev, typeof(*pos), member),	\
+		n = list_entry(pos->member.prev, typeof(*pos), member);	\
+	     &pos->member != (head); 					\
+	     pos = n, n = list_entry(n->member.prev, typeof(*n), member))
+
+/**
  * list_for_each_rcu	-	iterate over an rcu-protected list
  * @pos:	the &struct list_head to use as a loop counter.
  * @head:	the head for your list.
