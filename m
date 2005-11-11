Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVKKIir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVKKIir (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVKKIgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:36:09 -0500
Received: from i121.durables.org ([64.81.244.121]:6862 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932239AbVKKIgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:04 -0500
Date: Fri, 11 Nov 2005 02:35:50 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <4.282480653@selenic.com>
Message-Id: <5.282480653@selenic.com>
Subject: [PATCH 4/15] misc: Uninline some inode.c functions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uninline a couple inode.c functions

add/remove: 2/0 grow/shrink: 0/5 up/down: 256/-428 (-172)
function                                     old     new   delta
ifind                                          -     136    +136
ifind_fast                                     -     120    +120
ilookup5_nowait                              131      80     -51
ilookup                                      158      71     -87
ilookup5                                     171      80     -91
iget_locked                                  190      95     -95
iget5_locked                                 240     136    -104

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny/fs/inode.c
===================================================================
--- tiny.orig/fs/inode.c	2005-09-12 12:02:25.000000000 -0700
+++ tiny/fs/inode.c	2005-09-19 14:26:09.000000000 -0700
@@ -770,7 +770,7 @@ EXPORT_SYMBOL(igrab);
  *
  * Note, @test is called with the inode_lock held, so can't sleep.
  */
-static inline struct inode *ifind(struct super_block *sb,
+static struct inode *ifind(struct super_block *sb,
 		struct hlist_head *head, int (*test)(struct inode *, void *),
 		void *data, const int wait)
 {
@@ -804,7 +804,7 @@ static inline struct inode *ifind(struct
  *
  * Otherwise NULL is returned.
  */
-static inline struct inode *ifind_fast(struct super_block *sb,
+static struct inode *ifind_fast(struct super_block *sb,
 		struct hlist_head *head, unsigned long ino)
 {
 	struct inode *inode;
