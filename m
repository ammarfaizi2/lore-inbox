Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbSKYCxw>; Sun, 24 Nov 2002 21:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSKYCxv>; Sun, 24 Nov 2002 21:53:51 -0500
Received: from viefep15-int.chello.at ([213.46.255.19]:299 "EHLO
	viefep15-int.chello.at") by vger.kernel.org with ESMTP
	id <S262387AbSKYCxu>; Sun, 24 Nov 2002 21:53:50 -0500
Date: Sun, 24 Nov 2002 23:41:06 +0100 (CET)
From: =?ISO-8859-2?Q?=C9rsek_L=E1szl=F3?= <erseklaszlo@chello.hu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] rbtree
In-Reply-To: <200211241225.gAOCP3p05987@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0211242332310.90-100000@lacos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this patch tries to remove those checks for 0 from
linux-2.4.19/lib/rbtree.c which are (I think) superfluous.

Laszlo Ersek


--- linux-2.4.19/lib/rbtree.c	Sat Aug  3 02:39:46 2002
+++ linux/lib/rbtree.c	Sun Nov 24 22:59:38 2002
@@ -159,17 +159,16 @@
 				if (!other->rb_right ||
 				    other->rb_right->rb_color == RB_BLACK)
 				{
-					register rb_node_t * o_left;
-					if ((o_left = other->rb_left))
-						o_left->rb_color = RB_BLACK;
+					/* unneeded check-for-0 removed */
+					other->rb_left->rb_color = RB_BLACK;
 					other->rb_color = RB_RED;
 					__rb_rotate_right(other, root);
 					other = parent->rb_right;
 				}
 				other->rb_color = parent->rb_color;
 				parent->rb_color = RB_BLACK;
-				if (other->rb_right)
-					other->rb_right->rb_color = RB_BLACK;
+				/* unneeded check-for-0 removed */
+				other->rb_right->rb_color = RB_BLACK;
 				__rb_rotate_left(parent, root);
 				node = root->rb_node;
 				break;
@@ -199,17 +198,16 @@
 				if (!other->rb_left ||
 				    other->rb_left->rb_color == RB_BLACK)
 				{
-					register rb_node_t * o_right;
-					if ((o_right = other->rb_right))
-						o_right->rb_color = RB_BLACK;
+					/* unneeded check-for-0 removed */
+					other->rb_right->rb_color = RB_BLACK;
 					other->rb_color = RB_RED;
 					__rb_rotate_left(other, root);
 					other = parent->rb_left;
 				}
 				other->rb_color = parent->rb_color;
 				parent->rb_color = RB_BLACK;
-				if (other->rb_left)
-					other->rb_left->rb_color = RB_BLACK;
+				/* unneeded check-for-0 removed */
+				other->rb_left->rb_color = RB_BLACK;
 				__rb_rotate_right(parent, root);
 				node = root->rb_node;
 				break;


