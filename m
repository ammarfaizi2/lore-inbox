Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTCVPvf>; Sat, 22 Mar 2003 10:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbTCVPvf>; Sat, 22 Mar 2003 10:51:35 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:25524 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262789AbTCVPvc>; Sat, 22 Mar 2003 10:51:32 -0500
Date: Sat, 22 Mar 2003 16:59:51 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] pcmcia (1/6): check return values of driver_register
Message-ID: <20030322155951.GA12342@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN linux-original/drivers/pcmcia/i82365.c linux/drivers/pcmcia/i82365.c
--- linux-original/drivers/pcmcia/i82365.c	2003-03-22 15:22:39.000000000 +0100
+++ linux/drivers/pcmcia/i82365.c	2003-03-22 15:24:36.000000000 +0100
@@ -1608,9 +1608,11 @@
 	return -1;
     }
     DEBUG(0, "%s\n", version);
+    if (driver_register(&i82365_driver))
+	return -1;
+
     printk(KERN_INFO "Intel PCIC probe: ");
     sockets = 0;
-    driver_register(&i82365_driver);
 
 #ifdef CONFIG_ISA
     isa_probe();
diff -ruN linux-original/drivers/pcmcia/tcic.c linux/drivers/pcmcia/tcic.c
--- linux-original/drivers/pcmcia/tcic.c	2003-03-22 15:22:39.000000000 +0100
+++ linux/drivers/pcmcia/tcic.c	2003-03-22 15:26:14.000000000 +0100
@@ -408,7 +408,8 @@
 	return -1;
     }
 
-    driver_register(&tcic_driver);
+    if (driver_register(&tcic_driver))
+	return -1;
     
     printk(KERN_INFO "Databook TCIC-2 PCMCIA probe: ");
     sock = 0;
