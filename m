Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269166AbTCBIyE>; Sun, 2 Mar 2003 03:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269167AbTCBIyE>; Sun, 2 Mar 2003 03:54:04 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:32525 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id <S269166AbTCBIyD>; Sun, 2 Mar 2003 03:54:03 -0500
Date: Sun, 2 Mar 2003 20:03:34 +1100
To: Stephen Cameron <steve.cameron@hp.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix cciss init error handling
Message-ID: <20030302090334.GA987@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following patches against 2.4 and 2.5 makes cciss unregister properly
if initialisation fails.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4"

Index: drivers/block/cciss.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/block/cciss.c,v
retrieving revision 1.1.1.14
diff -u -r1.1.1.14 cciss.c
--- drivers/block/cciss.c	28 Nov 2002 23:53:12 -0000	1.1.1.14
+++ drivers/block/cciss.c	2 Mar 2003 08:53:02 -0000
@@ -2164,12 +2164,8 @@
 
 	printk(KERN_INFO DRIVER_NAME "\n");
 	/* Register for out PCI devices */
-	if (pci_register_driver(&cciss_pci_driver) > 0 )
-		return 0;
-	else 
-		return -ENODEV;
-
- }
+	return pci_module_init(&cciss_pci_driver);
+}
 
 EXPORT_NO_SYMBOLS;
 static int __init init_cciss_module(void)

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.5"

Index: drivers/block/cciss.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/block/cciss.c,v
retrieving revision 1.1.1.3
retrieving revision 1.2
diff -u -r1.1.1.3 -r1.2
--- drivers/block/cciss.c	24 Feb 2003 19:05:47 -0000	1.1.1.3
+++ drivers/block/cciss.c	2 Mar 2003 08:55:40 -0000	1.2
@@ -2435,11 +2435,7 @@
 	printk(KERN_INFO DRIVER_NAME "\n");
 
 	/* Register for out PCI devices */
-	if (pci_register_driver(&cciss_pci_driver) > 0 )
-		return 0;
-	else 
-		return -ENODEV;
-
+	return pci_module_init(&cciss_pci_driver);
 }
 
 static int __init init_cciss_module(void)

--oyUTqETQ0mS9luUI--
