Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSFCWdF>; Mon, 3 Jun 2002 18:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSFCWdE>; Mon, 3 Jun 2002 18:33:04 -0400
Received: from pD9E23450.dip.t-dialin.net ([217.226.52.80]:8330 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315630AbSFCWdD>; Mon, 3 Jun 2002 18:33:03 -0400
Date: Mon, 3 Jun 2002 16:32:58 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] Port opl3sa2 changes from 2.4
Message-ID: <Pine.LNX.4.44.0206031628050.11309-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

opl3sa2 didn't accept dma=0 in 2.4 due to isapnp

In a recent thread [1], someone described problems with opl3sa2 on 
Linux-2.4 when dma 0 was used, since isapnp didn't support dma 0. If it's 
necessary to patch this in Linux-2.5 either, please apply this one. 

[1] <URL:http://marc.theaimsgroup.com/?l=linux-kernel&m=102310599324992&w=2>

--- linus-2.5/sound/oss/opl3sa2.c	Mon Jun  3 06:32:51 2002
+++ thunder-2.5.20/sound/oss/opl3sa2.c	Mon Jun  3 16:26:38 2002
@@ -874,8 +874,18 @@
 		opl3sa2_activated[card] = 1;
 	}
 	else {
+		/*
+		 * isapnp.c disallows dma=0, but the opl3sa2 card itself
+		 * accepts this value perfectly.
+		 */
+		if (dev->ro) {
+			isapnp_resource_change(&dev->dma_resource[0], 0, 1);
+			isapnp_resource_change(&dev->dma_resource[1], 1, 1);
+		}
+		opl3sa2_state[card].activated = 1;
+
 		if(dev->activate(dev) < 0) {
-			printk(KERN_WARNING "opl3sa2: ISA PnP activate failed\n");
+			printk(KERN_WARNING "opl3sa2: ISA PnP activate failed!\n");
 			opl3sa2_activated[card] = 0;
 			return -ENODEV;
 		}
-- 
Lightweight patch manager using pine. If you have any objections, tell me.

