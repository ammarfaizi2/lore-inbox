Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWEQSu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWEQSu6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWEQSu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:50:58 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:23937 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750929AbWEQSu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:50:57 -0400
Subject: [RFC] [Patch 1/6] statistics infrastructure - prerequisite: list
	operation
From: Martin Peschke <mp3@de.ibm.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Chase Venters <chase.venters@clientec.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Keith Owens <kaos@ocs.com.au>,
       Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>,
       "hch@infradead.org" <hch@infradead.org>,
       "arjan@infradead.org" <arjan@infradead.org>, "ak@suse.de" <ak@suse.de>
Content-Type: text/plain
Date: Wed, 17 May 2006 20:50:44 +0200
Message-Id: <1147891845.3076.11.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
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
--- a/include/linux/list.h	2006-05-17 19:02:03.000000000 +0200
+++ b/include/linux/list.h	2006-05-17 19:05:41.000000000 +0200
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


