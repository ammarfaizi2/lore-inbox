Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWIKVba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWIKVba (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWIKVba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:31:30 -0400
Received: from palrel13.hp.com ([156.153.255.238]:5842 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1750803AbWIKVb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:31:29 -0400
Date: Mon, 11 Sep 2006 16:31:26 -0500
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: axboe@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-scsi@vgter.kernel.org
Subject: [PATCH 1/2] cciss: version update, new hw
Message-ID: <20060911213126.GA6867@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 1 of 2

This patch adds support for new hardware and bumps the version to 3.6.10. It
seems there were several changes introduced including soft_irq. I decided
to bump the major number to reflect these changes. Since we're still 
supporting older vendor kernels I need some way differenciate between kernel
versions <=2.6.10 and newer kernels >=2.6.16. 
I hate to send this in -rc6 but it seems like 2.6.18 is having a tough time
getting out the gate. Please consider this for inclusion.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 Documentation/cciss.txt |    1 +
 drivers/block/cciss.c   |   10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)
--------------------------------------------------------------------------------
diff -urNp linux-2.6.18-rc6.orig/Documentation/cciss.txt linux-2.6.18-rc6-p0001/Documentation/cciss.txt
--- linux-2.6.18-rc6.orig/Documentation/cciss.txt	2006-06-17 20:49:35.000000000 -0500
+++ linux-2.6.18-rc6-p0001/Documentation/cciss.txt	2006-09-11 14:29:43.000000000 -0500
@@ -20,6 +20,7 @@ This driver is known to work with the fo
 	* SA P400i
 	* SA E200
 	* SA E200i
+	* SA E500
 
 If nodes are not already created in the /dev/cciss directory, run as root:
 
diff -urNp linux-2.6.18-rc6.orig/drivers/block/cciss.c linux-2.6.18-rc6-p0001/drivers/block/cciss.c
--- linux-2.6.18-rc6.orig/drivers/block/cciss.c	2006-09-11 11:19:34.000000000 -0500
+++ linux-2.6.18-rc6-p0001/drivers/block/cciss.c	2006-09-11 14:35:35.000000000 -0500
@@ -48,14 +48,14 @@
 #include <linux/completion.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "HP CISS Driver (v 2.6.10)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,6,10)
+#define DRIVER_NAME "HP CISS Driver (v 3.6.10)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(3,6,10)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Hewlett-Packard Company");
-MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.10");
+MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 3.6.10");
 MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"
-			" SA6i P600 P800 P400 P400i E200 E200i");
+			" SA6i P600 P800 P400 P400i E200 E200i E500");
 MODULE_LICENSE("GPL");
 
 #include "cciss_cmd.h"
@@ -82,6 +82,7 @@ static const struct pci_device_id cciss_
 	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSD,     0x103C, 0x3213},
 	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSD,     0x103C, 0x3214},
 	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSD,     0x103C, 0x3215},
+	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSC,     0x103C, 0x3233},
 	{0,}
 };
 
@@ -110,6 +111,7 @@ static struct board_type products[] = {
 	{0x3213103C, "Smart Array E200i", &SA5_access},
 	{0x3214103C, "Smart Array E200i", &SA5_access},
 	{0x3215103C, "Smart Array E200i", &SA5_access},
+	{0x3233103C, "Smart Array E500", &SA5_access},
 };
 
 /* How long to wait (in milliseconds) for board to go into simple mode */
