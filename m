Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267130AbTBHXTA>; Sat, 8 Feb 2003 18:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267129AbTBHXTA>; Sat, 8 Feb 2003 18:19:00 -0500
Received: from mail.mplayerhq.hu ([192.190.173.45]:64746 "EHLO
	mail.mplayerhq.hu") by vger.kernel.org with ESMTP
	id <S267130AbTBHXS7>; Sat, 8 Feb 2003 18:18:59 -0500
Date: Sun, 9 Feb 2003 00:37:41 +0100 (CET)
From: Szabolcs Berecz <szabi@mplayerhq.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] radix_tree_extend()
Message-ID: <Pine.LNX.4.33.0302090033300.8676-100000@mail.mplayerhq.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No need to check root->rnode in the loop. In the loop it remains nonzero.

Where should I send this patch?

Bye,
Szabi


--- linux-2.5.59/lib/radix-tree.c.orig	Sat Jan 25 19:28:22 2003
+++ linux-2.5.59/lib/radix-tree.c	Sat Feb  8 22:24:16 2003
@@ -154,8 +154,7 @@

 			/* Increase the height.  */
 			node->slots[0] = root->rnode;
-			if (root->rnode)
-				node->count = 1;
+			node->count = 1;
 			root->rnode = node;
 			root->height++;
 		} while (height > root->height);

