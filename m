Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTJGNuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTJGNuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:50:15 -0400
Received: from mailout.zma.compaq.com ([161.114.64.105]:51204 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S262344AbTJGNuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:50:05 -0400
Date: Tue, 7 Oct 2003 09:04:49 -0500
From: mike.miller@hp.com
To: axboe@suse.de
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, fred.harris@hp.com
Subject: cciss update for 2.4.23-pre6
Message-ID: <20031007140449.GA11102@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds support for a new intregrated cciss based controller. It also bumps the version to 2.4.50. It was built and tested against the 2.4.23-pre6 kernel tree.
Please consider this patch for inclusion.

Thanks,
mikem
-------------------------------------------------------------------------------

diff -burN lx2423-pre6.orig/Documentation/cciss.txt lx2423-pre6/Documentation/cciss.txt
--- lx2423-pre6.orig/Documentation/cciss.txt	2003-10-07 08:29:59.000000000 -0500
+++ lx2423-pre6/Documentation/cciss.txt	2003-10-07 08:40:05.000000000 -0500
@@ -13,6 +13,7 @@
 	* SA 642
 	* SA 6400
 	* SA 6400 U320 Expansion Module
+	* SA 6i
 
 If nodes are not already created in the /dev/cciss directory
 
diff -burN lx2423-pre6.orig/drivers/block/cciss.c lx2423-pre6/drivers/block/cciss.c
--- lx2423-pre6.orig/drivers/block/cciss.c	2003-10-07 08:29:59.000000000 -0500
+++ lx2423-pre6/drivers/block/cciss.c	2003-10-07 08:39:39.000000000 -0500
@@ -45,13 +45,13 @@
 #include <linux/genhd.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "HP CISS Driver (v 2.4.47)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,4,47)
+#define DRIVER_NAME "HP CISS Driver (v 2.4.50)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,4,50)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Hewlett-Packard Company");
-MODULE_DESCRIPTION("Driver for HP SA5xxx SA6xxx Controllers version 2.4.47");
-MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"); 
+MODULE_DESCRIPTION("Driver for HP SA5xxx SA6xxx Controllers version 2.4.50");
+MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400 6i"); 
 MODULE_LICENSE("GPL");
 
 #include "cciss_cmd.h"
@@ -76,6 +76,8 @@
                         0x0E11, 0x409C, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
                         0x0E11, 0x409D, 0, 0, 0},
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
+                        0x0E11, 0x4091, 0, 0, 0},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
@@ -95,6 +97,7 @@
 	{ 0x409B0E11, "Smart Array 642", &SA5_access},
 	{ 0x409C0E11, "Smart Array 6400", &SA5_access},
 	{ 0x409D0E11, "Smart Array 6400 EM", &SA5_access},
+	{ 0x40910E11, "Smart Array 6i", &SA5_access},
 };
 
 /* How long to wait (in millesconds) for board to go into simple mode */
