Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318572AbSH1B6F>; Tue, 27 Aug 2002 21:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318591AbSH1B6E>; Tue, 27 Aug 2002 21:58:04 -0400
Received: from dp.samba.org ([66.70.73.150]:1242 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318572AbSH1B6D>;
	Tue, 27 Aug 2002 21:58:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] list_for_each_entry
Date: Wed, 28 Aug 2002 11:52:00 +1000
Message-Id: <20020827210245.608912C069@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

List iteration pain removal patch.

Marcelo, Linus, please apply.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: list_for_each_entry patch
Author: Rusty Russell
Status: Trivial

D: This adds list_for_each_entry, which is the equivalent of
D: list_for_each and list_entry, except only one variable is needed.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5652-linux-2.5.31/include/linux/list.h .5652-linux-2.5.31.updated/include/linux/list.h
--- .5652-linux-2.5.31/include/linux/list.h	2002-08-02 11:15:10.000000000 +1000
+++ .5652-linux-2.5.31.updated/include/linux/list.h	2002-08-22 10:38:52.000000000 +1000
@@ -211,6 +211,19 @@ static inline void list_splice_init(list
 	for (pos = (head)->next, n = pos->next; pos != (head); \
 		pos = n, n = pos->next)
 
+/**
+ * list_for_each_entry	-	iterate over list of given type
+ * @pos:	the type * to use as a loop counter.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry(pos, head, member)				\
+	for (pos = list_entry((head)->next, typeof(*pos), member),	\
+		     prefetch(pos->member.next);			\
+	     &pos->member != (head); 					\
+	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
+		     prefetch(pos->member.next))
+
 #endif /* __KERNEL__ || _LVM_H_INCLUDE */
 
 #endif
