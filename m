Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264751AbUEETqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264751AbUEETqb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 15:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264755AbUEETqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 15:46:31 -0400
Received: from mailout.zma.compaq.com ([161.114.64.104]:64517 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S264751AbUEETqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 15:46:23 -0400
Date: Wed, 5 May 2004 13:59:50 -0500
From: mikem@beardog.cca.cpqcorp.net
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update for 2.6.6
Message-ID: <20040505185950.GA29293@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for 2 new controllers. The first is a PCI-Express version of the 6400. The second is actually a SATA controller using the cciss interface. Please consider this for inclusion.

mikem
-------------------------------------------------------------------------------
 Documentation/cciss.txt |    2 ++
 drivers/block/cciss.c   |   12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff -burpN lx266-rc3.orig/Documentation/cciss.txt lx266-rc3/Documentation/cciss.txt
--- lx266-rc3.orig/Documentation/cciss.txt	2004-04-03 21:36:24.000000000 -0600
+++ lx266-rc3/Documentation/cciss.txt	2004-05-05 13:37:33.000000000 -0500
@@ -14,6 +14,8 @@ This driver is known to work with the fo
 	* SA 6400
 	* SA 6400 U320 Expansion Module
 	* SA 6i
+	* SA 6422
+	* SA V100
 
 If nodes are not already created in the /dev/cciss directory
 
diff -burpN lx266-rc3.orig/drivers/block/cciss.c lx266-rc3/drivers/block/cciss.c
--- lx266-rc3.orig/drivers/block/cciss.c	2004-05-05 13:27:25.000000000 -0500
+++ lx266-rc3/drivers/block/cciss.c	2004-05-05 13:32:33.000000000 -0500
@@ -45,12 +45,12 @@
 #include <linux/completion.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "Compaq CISS Driver (v 2.6.0)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,6,0)
+#define DRIVER_NAME "Compaq CISS Driver (v 2.6.2)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,6,2)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Hewlett-Packard Company");
-MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.0");
+MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.2");
 MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"
 			" SA6i");
 MODULE_LICENSE("GPL");
@@ -79,6 +79,10 @@ const struct pci_device_id cciss_pci_dev
 		0x0E11, 0x409D, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
 		0x0E11, 0x4091, 0, 0, 0},
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
+		0x0E11, 0x409E, 0, 0, 0},
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
+		0x103C, 0x3211, 0, 0, 0},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
@@ -99,6 +103,8 @@ static struct board_type products[] = {
 	{ 0x409C0E11, "Smart Array 6400", &SA5_access},
 	{ 0x409D0E11, "Smart Array 6400 EM", &SA5_access},
 	{ 0x40910E11, "Smart Array 6i", &SA5_access},
+	{ 0x409E0E11, "Smart Array 6422", &SA5_access},
+	{ 0x3211103C, "Smart Array V100", &SA5_access},
 };
 
 /* How long to wait (in millesconds) for board to go into simple mode */
