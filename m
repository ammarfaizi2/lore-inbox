Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284072AbRLAL1S>; Sat, 1 Dec 2001 06:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281562AbRLAL06>; Sat, 1 Dec 2001 06:26:58 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:25231 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S281561AbRLAL0r>; Sat, 1 Dec 2001 06:26:47 -0500
Date: Sat, 1 Dec 2001 13:31:29 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] if (foo) brelse(foo) in /drivers cleanup
Message-ID: <Pine.LNX.4.33.0112011330380.11026-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to remove the extra check before calling brelse in /drivers

-Zwane Mwaikambo

diffed against 2.5.1-pre4

diff -urN linux-2.5.1-pre4.orig/drivers/ide/pdcraid.c linux-2.5.1-pre4.brelse/drivers/ide/pdcraid.c
--- linux-2.5.1-pre4.orig/drivers/ide/pdcraid.c	Tue Nov 13 19:19:41 2001
+++ linux-2.5.1-pre4.brelse/drivers/ide/pdcraid.c	Sat Dec  1 07:47:23 2001
@@ -445,8 +445,7 @@
 	}
 	ret = 0;
 abort:
-	if (bh)
-		brelse (bh);
+	brelse (bh);
 	return ret;
 }

diff -urN linux-2.5.1-pre4.orig/drivers/md/md.c linux-2.5.1-pre4.brelse/drivers/md/md.c
--- linux-2.5.1-pre4.orig/drivers/md/md.c	Thu Oct 25 22:58:34 2001
+++ linux-2.5.1-pre4.brelse/drivers/md/md.c	Sat Dec  1 07:46:39 2001
@@ -501,8 +501,7 @@
 	printk(KERN_INFO " [events: %08lx]\n", (unsigned long)rdev->sb->events_lo);
 	ret = 0;
 abort:
-	if (bh)
-		brelse (bh);
+	brelse (bh);
 	return ret;
 }


