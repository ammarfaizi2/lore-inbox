Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbUKXAJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbUKXAJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUKXAHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 19:07:37 -0500
Received: from mail.dif.dk ([193.138.115.101]:60642 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261667AbUKXAGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 19:06:33 -0500
Date: Wed, 24 Nov 2004 01:16:05 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: netdev@oss.sgi.com, linux-net@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] move inline keywords nearer beginning of declaration in
 skbuff.c to elliminate warning with gcc -W 
Message-ID: <Pine.LNX.4.61.0411240106580.3389@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In order to get rid of 
net/core/skbuff.c:1353: warning: `inline' is not at beginning of declaration
net/core/skbuff.c:1374: warning: `inline' is not at beginning of declaration
when building with gcc -W, I submit the patch below.
There's no impact on the way the code works, so it is perfectly safe. It 
just brings the count of warnings that I have to sift through down by two 
(yes, I know the kernel is not normally build with -W, but I do it to 
look for stuff that potentially needs review, and the less warnings I 
have to sift through the better). I see no good reason not to apply this.
Please apply.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk6-orig/net/core/skbuff.c linux-2.6.10-rc2-bk6/net/core/skbuff.c
--- linux-2.6.10-rc2-bk6-orig/net/core/skbuff.c	2004-11-17 01:20:32.000000000 +0100
+++ linux-2.6.10-rc2-bk6/net/core/skbuff.c	2004-11-24 01:05:32.000000000 +0100
@@ -1350,7 +1350,7 @@ void skb_add_mtu(int mtu)
 }
 #endif
 
-static void inline skb_split_inside_header(struct sk_buff *skb,
+static inline void skb_split_inside_header(struct sk_buff *skb,
 					   struct sk_buff* skb1,
 					   const u32 len, const int pos)
 {
@@ -1371,7 +1371,7 @@ static void inline skb_split_inside_head
 	skb->tail		   = skb->data + len;
 }
 
-static void inline skb_split_no_header(struct sk_buff *skb,
+static inline void skb_split_no_header(struct sk_buff *skb,
 				       struct sk_buff* skb1,
 				       const u32 len, int pos)
 {



