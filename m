Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266744AbTGKUHc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTGKRwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:52:11 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2180
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264701AbTGKRv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:51:59 -0400
Date: Fri, 11 Jul 2003 19:05:46 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111805.h6BI5kxD017236@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: axnet can unload with timers live
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/drivers/net/pcmcia/axnet_cs.c linux-2.5.75-ac1/drivers/net/pcmcia/axnet_cs.c
--- linux-2.5.75/drivers/net/pcmcia/axnet_cs.c	2003-07-10 21:10:53.000000000 +0100
+++ linux-2.5.75-ac1/drivers/net/pcmcia/axnet_cs.c	2003-07-11 15:21:39.000000000 +0100
@@ -258,7 +258,7 @@
     if (*linkp == NULL)
 	return;
 
-    del_timer(&link->release);
+    del_timer_sync(&link->release);
     if (link->state & DEV_CONFIG) {
 	axnet_release((u_long)link);
 	if (link->state & DEV_STALE_CONFIG) {
@@ -706,7 +706,7 @@
     
     link->open--;
     netif_stop_queue(dev);
-    del_timer(&info->watchdog);
+    del_timer_sync(&info->watchdog);
     if (link->state & DEV_STALE_CONFIG)
 	mod_timer(&link->release, jiffies + HZ/20);
 
