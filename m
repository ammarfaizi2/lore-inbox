Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269824AbUJHLQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269824AbUJHLQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269837AbUJHLQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:16:39 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:7812
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269838AbUJHLOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:14:35 -0400
Subject: [patch 1/1] use container_of for rb_entry
To: akpm@osdl.org
Cc: hch@infradead.org, linux-kernel@vger.kernel.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Fri, 08 Oct 2004 13:14:12 +0200
Message-Id: <20041008111413.A6C0C523A@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use, in the rb_entry definition, the container_of macro instead of reinventing
the wheel; compared to using offset_of() as I did in the prev. version, it has
type safety checking.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/include/linux/rbtree.h |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN include/linux/rbtree.h~use-offsetof-rb_entry include/linux/rbtree.h
--- linux-2.6.9-current/include/linux/rbtree.h~use-offsetof-rb_entry	2004-10-08 11:57:18.523435712 +0200
+++ linux-2.6.9-current-paolo/include/linux/rbtree.h	2004-10-08 13:12:27.602951432 +0200
@@ -113,8 +113,7 @@ struct rb_root
 };
 
 #define RB_ROOT	(struct rb_root) { NULL, }
-#define	rb_entry(ptr, type, member)					\
-	((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
+#define	rb_entry(ptr, type, member) container_of(ptr, type, member)
 
 extern void rb_insert_color(struct rb_node *, struct rb_root *);
 extern void rb_erase(struct rb_node *, struct rb_root *);
_
