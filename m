Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbTGKUId (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266751AbTGKUHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:07:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2948
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264701AbTGKRwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:52:13 -0400
Date: Fri, 11 Jul 2003 19:06:00 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111806.h6BI60rr017242@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: ibmtr can unload with timers live
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/drivers/net/pcmcia/ibmtr_cs.c linux-2.5.75-ac1/drivers/net/pcmcia/ibmtr_cs.c
--- linux-2.5.75/drivers/net/pcmcia/ibmtr_cs.c	2003-07-10 21:10:16.000000000 +0100
+++ linux-2.5.75-ac1/drivers/net/pcmcia/ibmtr_cs.c	2003-07-11 15:22:01.000000000 +0100
@@ -293,9 +293,9 @@
     dev = info->dev;
     {
 	struct tok_info *ti = (struct tok_info *)dev->priv;
-	del_timer(&(ti->tr_timer));
+	del_timer_sync(&(ti->tr_timer));
     }
-    del_timer(&link->release);
+    del_timer_sync(&link->release);
     if (link->state & DEV_CONFIG) {
         ibmtr_release((u_long)link);
         if (link->state & DEV_STALE_CONFIG) {
