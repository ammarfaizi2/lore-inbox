Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264864AbTGKR5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264722AbTGKRxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:53:51 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4484
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264593AbTGKRx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:53:28 -0400
Date: Fri, 11 Jul 2003 19:07:15 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111807.h6BI7FfR017254@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix further timer in pcmcia stuff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#ra1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/drivers/net/pcmcia/pcnet_cs.c linux-2.5.75-ac1/drivers/net/pcmcia/pcnet_cs.c
--- linux-2.5.75/drivers/net/pcmcia/pcnet_cs.c	2003-07-10 21:13:34.000000000 +0100
+++ linux-2.5.75-ac1/drivers/net/pcmcia/pcnet_cs.c	2003-07-11 15:22:26.000000000 +0100
@@ -357,7 +357,7 @@
     if (*linkp == NULL)
 	return;
 
-    del_timer(&link->release);
+    del_timer_sync(&link->release);
     if (link->state & DEV_CONFIG) {
 	pcnet_release((u_long)link);
 	if (link->state & DEV_STALE_CONFIG) {
@@ -1052,7 +1052,7 @@
     
     link->open--;
     netif_stop_queue(dev);
-    del_timer(&info->watchdog);
+    del_timer_sync(&info->watchdog);
     if (link->state & DEV_STALE_CONFIG)
 	mod_timer(&link->release, jiffies + HZ/20);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/drivers/net/pcmcia/smc91c92_cs.c linux-2.5.75-ac1/drivers/net/pcmcia/smc91c92_cs.c
--- linux-2.5.75/drivers/net/pcmcia/smc91c92_cs.c	2003-07-10 21:12:18.000000000 +0100
+++ linux-2.5.75-ac1/drivers/net/pcmcia/smc91c92_cs.c	2003-07-11 15:22:40.000000000 +0100
@@ -433,7 +433,7 @@
     if (*linkp == NULL)
 	return;
 
-    del_timer(&link->release);
+    del_timer_sync(&link->release);
     if (link->state & DEV_CONFIG) {
 	smc91c92_release((u_long)link);
 	if (link->state & DEV_STALE_CONFIG) {
@@ -1330,7 +1330,7 @@
     outw(CTL_POWERDOWN, ioaddr + CONTROL );
 
     link->open--;
-    del_timer(&smc->media);
+    del_timer_sync(&smc->media);
     if (link->state & DEV_STALE_CONFIG)
 	mod_timer(&link->release, jiffies + HZ/20);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/drivers/net/pcmcia/xirc2ps_cs.c linux-2.5.75-ac1/drivers/net/pcmcia/xirc2ps_cs.c
--- linux-2.5.75/drivers/net/pcmcia/xirc2ps_cs.c	2003-07-10 21:08:16.000000000 +0100
+++ linux-2.5.75-ac1/drivers/net/pcmcia/xirc2ps_cs.c	2003-07-11 15:22:49.000000000 +0100
@@ -689,7 +689,7 @@
      * the release() function is called, that will trigger a proper
      * detach().
      */
-    del_timer(&link->release);
+    del_timer_sync(&link->release);
     if (link->state & DEV_CONFIG) {
 	xirc2ps_release((unsigned long)link);
 	if (link->state & DEV_STALE_CONFIG) {
