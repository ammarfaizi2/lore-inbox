Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSGYMkv>; Thu, 25 Jul 2002 08:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSGYMkv>; Thu, 25 Jul 2002 08:40:51 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:42122 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S312254AbSGYMku>; Thu, 25 Jul 2002 08:40:50 -0400
Date: Thu, 25 Jul 2002 05:40:58 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix complile warnings in suspend.c, 2.5.28
Message-ID: <Pine.LNX.4.44.0207250536451.17973-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This fixes some compile time warnings in suspend.c.  Look sensible? 
It's tested, even with full rmap and slab-on-LRU patches.  Even worked 
when suspending from X!

--- linux-2.5.28-rmap-slablru/kernel/suspend.c~	Wed Jul 24 20:56:59 2002
+++ linux-2.5.28-rmap-slablru/kernel/suspend.c	Wed Jul 24 21:05:21 2002
@@ -66,6 +66,7 @@
 #include <linux/swapops.h>
 
 extern void signal_wake_up(struct task_struct *t);
+asmlinkage void sys_sync(void);	/* it's really int */
 
 unsigned char software_suspend_enabled = 0;
 
@@ -1004,8 +1005,9 @@
 
 static int bdev_write_page(struct block_device *bdev, long pos, void *buf)
 {
-	struct buffer_head *bh;
 #if 0
+	struct buffer_head *bh;
+
 	BUG_ON (pos%PAGE_SIZE);
 	bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
 	if (!bh || (!bh->b_data)) {


Craig Kulesa
Steward Obs.
Univ. of Arizona

