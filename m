Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSLOR0i>; Sun, 15 Dec 2002 12:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSLOR0i>; Sun, 15 Dec 2002 12:26:38 -0500
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:12114 "EHLO
	brian.localnet") by vger.kernel.org with ESMTP id <S262210AbSLOR0h>;
	Sun, 15 Dec 2002 12:26:37 -0500
To: rmk@arm.linux.org.uk
Subject: [PATCH 2.5] Titan pci serial card recognition fix
Cc: linux-kernel@vger.kernel.org
Message-Id: <E18Nceo-00014o-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Sun, 15 Dec 2002 18:34:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an error in the pci recognition table which
means that otherwise supportes Titan pci serial cards fail to
work.

/Brian

--- linux-2.5.44/drivers/serial/8250_pci.c	2002-12-15 18:21:15.000000000 +0100
+++ linux-2.5.44-mine/drivers/serial/8250_pci.c	2002-12-15 17:00:41.000000000 +0100
@@ -473,6 +473,7 @@
 	pbn_b1_4_115200,
 	pbn_b1_8_115200,
 
+	pbn_b1_1_921600,
 	pbn_b1_2_921600,
 	pbn_b1_4_921600,
 	pbn_b1_8_921600,
@@ -481,6 +482,8 @@
 	pbn_b1_4_1382400,
 	pbn_b1_8_1382400,
 
+	pbn_b1_bt_2_921600,
+
 	pbn_b2_1_115200,
 	pbn_b2_8_115200,
 	pbn_b2_4_460800,
@@ -494,6 +497,9 @@
 	pbn_b2_bt_4_115200,
 	pbn_b2_bt_2_921600,
 
+	pbn_bt_4_921600,
+	pbn_bt_8_921600,
+
 	pbn_panacom,
 	pbn_panacom2,
 	pbn_panacom4,
@@ -553,6 +559,7 @@
 	{ SPCI_FL_BASE1, 4, 115200 },		/* pbn_b1_4_115200 */
 	{ SPCI_FL_BASE1, 8, 115200 },		/* pbn_b1_8_115200 */
 
+	{ SPCI_FL_BASE1, 1, 921600 },		/* pbn_b1_1_921600 */
 	{ SPCI_FL_BASE1, 2, 921600 },		/* pbn_b1_2_921600 */
 	{ SPCI_FL_BASE1, 4, 921600 },		/* pbn_b1_4_921600 */
 	{ SPCI_FL_BASE1, 8, 921600 },		/* pbn_b1_8_921600 */
@@ -561,6 +568,7 @@
 	{ SPCI_FL_BASE1, 4, 1382400 },		/* pbn_b1_4_1382400 */
 	{ SPCI_FL_BASE1, 8, 1382400 },		/* pbn_b1_8_1382400 */
 
+	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 }, /* pbn_b1_bt_2_921600 */
 	{ SPCI_FL_BASE2, 1, 115200 },		/* pbn_b2_1_115200 */
 	{ SPCI_FL_BASE2, 8, 115200 },		/* pbn_b2_8_115200 */
 	{ SPCI_FL_BASE2, 4, 460800 },		/* pbn_b2_4_460800 */
@@ -574,6 +582,9 @@
 	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 115200 }, /* pbn_b2_bt_4_115200 */
 	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600 }, /* pbn_b2_bt_2_921600 */
 
+	{ SPCI_FL_BASE_TABLE, 4, 921600 },		/* pbn_bt_4_921600 */
+	{ SPCI_FL_BASE_TABLE, 8, 921600 },		/* pbn_bt_8_921600 */
+
 	{ SPCI_FL_BASE2, 2, 921600, /* IOMEM */		   /* pbn_panacom */
 		0x400, 7, pci_plx9050_fn },
 	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,   /* pbn_panacom2 */
@@ -1000,17 +1011,17 @@
 		pbn_b0_4_921600 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100L,
 		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE1, 1, 921600 },
+		pbn_b1_1_921600 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200L,
 		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
+		pbn_b1_bt_2_921600 },
 	/* The 400L and 800L have a custom hack in get_pci_port */
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400L,
 		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE_TABLE, 4, 921600 },
+		pbn_bt_4_921600 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800L,
 		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE_TABLE, 8, 921600 },
+		pbn_bt_8_921600 },
 
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_550,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
