Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262802AbTCVPww>; Sat, 22 Mar 2003 10:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbTCVPvy>; Sat, 22 Mar 2003 10:51:54 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:28084 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262800AbTCVPvc>; Sat, 22 Mar 2003 10:51:32 -0500
Date: Sat, 22 Mar 2003 17:01:19 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] pcmcia (5/5): convert pccard_cs driver to new registration interface
Message-ID: <20030322160119.GE12342@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the pcnet_cs driver to use the new registration call.

diff -ruN linux-original/drivers/net/pcmcia/pcnet_cs.c linux/drivers/net/pcmcia/pcnet_cs.c
--- linux-original/drivers/net/pcmcia/pcnet_cs.c	2003-03-19 11:08:30.000000000 +0100
+++ linux/drivers/net/pcmcia/pcnet_cs.c	2003-03-19 11:23:25.000000000 +0100
@@ -1617,6 +1617,15 @@
 
 /*====================================================================*/
 
+static struct pcmcia_driver pcnet_driver = {
+	.drv		= {
+		.name	= "pcnet_cs",
+	},
+	.attach		= pcnet_attach,
+	.detach		= pcnet_detach,
+	.owner		= THIS_MODULE,
+};
+
 static int __init init_pcnet_cs(void)
 {
     servinfo_t serv;
@@ -1627,14 +1636,14 @@
 	       "does not match!\n");
 	return -EINVAL;
     }
-    register_pccard_driver(&dev_info, &pcnet_attach, &pcnet_detach);
+    pcmcia_register_driver(&pcnet_driver);
     return 0;
 }
 
 static void __exit exit_pcnet_cs(void)
 {
     DEBUG(0, "pcnet_cs: unloading\n");
-    unregister_pccard_driver(&dev_info);
+    pcmcia_unregister_driver(&pcnet_driver);
     while (dev_list != NULL)
 	pcnet_detach(dev_list);
 }
