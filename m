Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTEPIjT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 04:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbTEPIjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 04:39:18 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:30356 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264377AbTEPIjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 04:39:13 -0400
Date: Fri, 16 May 2003 10:51:36 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: [patch] Support for VIA vt8237 IDE 
Message-ID: <20030516105136.A6964@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

These two, rather trivial, patches for 2.4 and 2.5 add support for the
IDE controller found on the new VIA vt8237 southbridge.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vt8237-2.4.diff"

ChangeSet@1.1210, 2003-05-16 10:46:58+02:00, vojtech@suse.cz
  Support for VIA vt8237 IDE.


 drivers/ide/pci/via82cxxx.c |   10 ++++------
 include/linux/pci_ids.h     |    7 ++++---
 2 files changed, 8 insertions(+), 9 deletions(-)


diff -Nru a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c	Fri May 16 10:47:10 2003
+++ b/drivers/ide/pci/via82cxxx.c	Fri May 16 10:47:10 2003
@@ -1,12 +1,12 @@
 /*
  *
- * Version 3.36
+ * Version 3.37
  *
  * VIA IDE driver for Linux. Supported southbridges:
  *
  *   vt82c576, vt82c586, vt82c586a, vt82c586b, vt82c596a, vt82c596b,
  *   vt82c686, vt82c686a, vt82c686b, vt8231, vt8233, vt8233c, vt8233a,
- *   vt8235
+ *   vt8235, vt8237
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -74,9 +74,7 @@
 	u8 rev_max;
 	u16 flags;
 } via_isa_bridges[] = {
-#ifdef FUTURE_BRIDGES
-	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 },
-#endif
+	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
@@ -148,7 +146,7 @@
 	via_print("----------VIA BusMastering IDE Configuration"
 		"----------------");
 
-	via_print("Driver Version:                     3.36");
+	via_print("Driver Version:                     3.37");
 	via_print("South Bridge:                       VIA %s",
 		via_config->name);
 
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Fri May 16 10:47:10 2003
+++ b/include/linux/pci_ids.h	Fri May 16 10:47:10 2003
@@ -1026,10 +1026,11 @@
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109
 #define PCI_DEVICE_ID_VIA_8361		0x3112
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
-#define PCI_DEVICE_ID_VIA_P4X333   0x3168
-#define PCI_DEVICE_ID_VIA_8235        0x3177
-#define PCI_DEVICE_ID_VIA_8377_0  0x3189
+#define PCI_DEVICE_ID_VIA_8237_SATA	0x3149
+#define PCI_DEVICE_ID_VIA_P4X333	0x3168
+#define PCI_DEVICE_ID_VIA_8235		0x3177
 #define PCI_DEVICE_ID_VIA_8377_0	0x3189
+#define PCI_DEVICE_ID_VIA_8237		0x3227
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vt8237-2.5.diff"

ChangeSet@1.1148, 2003-05-16 10:27:50+02:00, vojtech@suse.cz
  Add support for the vt8237 southbridge.


 drivers/ide/pci/via82cxxx.c |   10 ++++------
 include/linux/pci_ids.h     |    2 ++
 2 files changed, 6 insertions(+), 6 deletions(-)


diff -Nru a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c	Fri May 16 10:28:27 2003
+++ b/drivers/ide/pci/via82cxxx.c	Fri May 16 10:28:27 2003
@@ -1,12 +1,12 @@
 /*
  *
- * Version 3.36
+ * Version 3.37
  *
  * VIA IDE driver for Linux. Supported southbridges:
  *
  *   vt82c576, vt82c586, vt82c586a, vt82c586b, vt82c596a, vt82c596b,
  *   vt82c686, vt82c686a, vt82c686b, vt8231, vt8233, vt8233c, vt8233a,
- *   vt8235
+ *   vt8235, vt8237
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -74,9 +74,7 @@
 	u8 rev_max;
 	u16 flags;
 } via_isa_bridges[] = {
-#ifdef FUTURE_BRIDGES
-	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 },
-#endif
+	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
@@ -148,7 +146,7 @@
 	via_print("----------VIA BusMastering IDE Configuration"
 		"----------------");
 
-	via_print("Driver Version:                     3.36");
+	via_print("Driver Version:                     3.37");
 	via_print("South Bridge:                       VIA %s",
 		via_config->name);
 
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Fri May 16 10:28:27 2003
+++ b/include/linux/pci_ids.h	Fri May 16 10:28:27 2003
@@ -1124,6 +1124,7 @@
 #define PCI_DEVICE_ID_VIA_8753_0	0x3128
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
 #define PCI_DEVICE_ID_VIA_8752		0x3148
+#define PCI_DEVICE_ID_VIA_8237_SATA	0x3149
 #define PCI_DEVICE_ID_VIA_KN266		0x3156
 #define PCI_DEVICE_ID_VIA_8754		0x3168
 #define PCI_DEVICE_ID_VIA_8235		0x3177
@@ -1131,6 +1132,7 @@
 #define PCI_DEVICE_ID_VIA_8377_0	0x3189
 #define PCI_DEVICE_ID_VIA_KM400		0x3205
 #define PCI_DEVICE_ID_VIA_P4M400	0x3209
+#define PCI_DEVICE_ID_VIA_8237		0x3227
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235

--fdj2RfSjLxBAspz7--
