Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbUCXAqC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 19:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbUCXAqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 19:46:01 -0500
Received: from gate.crashing.org ([63.228.1.57]:25216 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262943AbUCXAp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 19:45:58 -0500
Subject: [PATCH] Cosmetic fix of BMAC boot messages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Content-Type: text/plain
Message-Id: <1080088212.23716.169.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Mar 2004 11:30:15 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes display of the boot messages on the BMAC
driver (pmac only). It used to be messed up in 2.6

Please, apply,


===== drivers/net/bmac.c 1.31 vs edited =====
--- 1.31/drivers/net/bmac.c	Tue Mar 23 12:47:11 2004
+++ edited/drivers/net/bmac.c	Wed Mar 24 10:05:20 2004
@@ -1312,10 +1312,8 @@
 	bmwrite(dev, INTDISABLE, DisableAll);
 
 	rev = addr[0] == 0 && addr[1] == 0xA0;
-	for (j = 0; j < 6; ++j) {
+	for (j = 0; j < 6; ++j)
 		dev->dev_addr[j] = rev? bitrev(addr[j]): addr[j];
-		printk("%c%.2x", (j? ':': ' '), dev->dev_addr[j]);
-	}
 
 	/* Enable chip without interrupts for now */
 	bmac_enable_and_reset_chip(dev);
@@ -1380,6 +1378,8 @@
 	}
 
 	printk(KERN_INFO "%s: BMAC%s at", dev->name, (is_bmac_plus? "+": ""));
+	for (j = 0; j < 6; ++j)
+		printk("%c%.2x", (j? ':': ' '), dev->dev_addr[j]);
 	XXDEBUG((", base_addr=%#0lx", dev->base_addr));
 	printk("\n");
 	


