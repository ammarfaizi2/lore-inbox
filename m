Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUJGVHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUJGVHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267700AbUJGS1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:27:18 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:62136 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S267705AbUJGSYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:24:04 -0400
Subject: [patch 1/1] use offsetof for rb_entry
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 07 Oct 2004 19:53:42 +0200
Message-Id: <20041007175343.AE28944CD@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use, in the rb_entry definition, the offsetof macro instead of reinventing the
wheel.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/include/linux/rbtree.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/rbtree.h~use-offsetof-rb_entry include/linux/rbtree.h
--- linux-2.6.9-current/include/linux/rbtree.h~use-offsetof-rb_entry	2004-10-07 16:11:27.590555976 +0200
+++ linux-2.6.9-current-paolo/include/linux/rbtree.h	2004-10-07 16:11:27.592555672 +0200
@@ -114,7 +114,7 @@ struct rb_root
 
 #define RB_ROOT	(struct rb_root) { NULL, }
 #define	rb_entry(ptr, type, member)					\
-	((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
+	((type *)((char *)(ptr) - offsetof(type, member)))
 
 extern void rb_insert_color(struct rb_node *, struct rb_root *);
 extern void rb_erase(struct rb_node *, struct rb_root *);
_
