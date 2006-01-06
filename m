Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWAFMMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWAFMMF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWAFMMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:12:05 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:25833 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751211AbWAFMMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:12:01 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       mingo@elte.hu
Subject: [PATCH] pktcdvd: Un-inline some functions
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
	<1136544226.2940.23.camel@laptopd505.fenrus.org>
From: Peter Osterlund <petero2@telia.com>
Date: 06 Jan 2006 13:11:00 +0100
In-Reply-To: <1136544226.2940.23.camel@laptopd505.fenrus.org>
Message-ID: <m3mzi9wo8b.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to un-inline two functions in the pktcdvd driver.
This makes the compiled code 172 bytes smaller on my system.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index b5f67b1..7eb2931 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -247,7 +247,7 @@ static inline struct pkt_rb_node *pkt_rb
 	return rb_entry(n, struct pkt_rb_node, rb_node);
 }
 
-static inline void pkt_rbtree_erase(struct pktcdvd_device *pd, struct pkt_rb_node *node)
+static void pkt_rbtree_erase(struct pktcdvd_device *pd, struct pkt_rb_node *node)
 {
 	rb_erase(&node->rb_node, &pd->bio_queue);
 	mempool_free(node, pd->rb_pool);
@@ -315,7 +315,7 @@ static void pkt_rbtree_insert(struct pkt
 /*
  * Add a bio to a single linked list defined by its head and tail pointers.
  */
-static inline void pkt_add_list_last(struct bio *bio, struct bio **list_head, struct bio **list_tail)
+static void pkt_add_list_last(struct bio *bio, struct bio **list_head, struct bio **list_tail)
 {
 	bio->bi_next = NULL;
 	if (*list_tail) {

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
