Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbSKYUyb>; Mon, 25 Nov 2002 15:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbSKYUyb>; Mon, 25 Nov 2002 15:54:31 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:128 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S265661AbSKYUya>; Mon, 25 Nov 2002 15:54:30 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "=?us-ascii?B?J0Vyc2VrIExhc3psbyc=?=" <erseklaszlo@chello.hu>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rbtree
Date: Mon, 25 Nov 2002 22:01:37 +0100
Message-ID: <005501c294c5$d8b1e300$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.44.0211242332310.90-100000@lacos>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not trying to be negative and also really wondering this: won't
the compiler produce the same code for:
if (!variable)
and
if (variable == 0)
?

-----Oorspronkelijk bericht-----
Van: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]Namens Ersek Laszlo
Verzonden: zondag 24 november 2002 23:41
Aan: linux-kernel@vger.kernel.org
Onderwerp: [PATCH] rbtree


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
...
