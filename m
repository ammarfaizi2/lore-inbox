Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbSKNM3i>; Thu, 14 Nov 2002 07:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbSKNM3i>; Thu, 14 Nov 2002 07:29:38 -0500
Received: from [212.130.55.83] ([212.130.55.83]:20243 "EHLO smtp.tt.dk")
	by vger.kernel.org with ESMTP id <S264883AbSKNM3g>;
	Thu, 14 Nov 2002 07:29:36 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5 (2.4)] wrong information for detection of serial pci devices
Cc: linus@transmeta.com, rmk@arm.linux.org.uk
Message-Id: <E18CJEO-0006YZ-00@brmlinux.tt.dk>
From: brm@tt.dk
Date: Thu, 14 Nov 2002 13:36:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some outdated structure members for Titan Serial Boards.
With a simple substitution of serial.c for 8250_pci.c (and a directory
change) it also applies to 2.4 where the identical error can be found.

/Brian

--- linux-2.5.46/drivers/serial/8250_pci.c	2002-11-04 23:30:46.000000000 +0100
+++ linux-2.5.46-mine/drivers/serial/8250_pci.c	2002-11-14 11:05:59.000000000 +0100
@@ -474,6 +474,9 @@
 	pbn_b1_4_1382400,
 	pbn_b1_8_1382400,
 
+	pbn_b1_bt_1_921600,
+	pbn_b1_bt_2_921600,
+
 	pbn_b2_1_115200,
 	pbn_b2_8_115200,
 	pbn_b2_4_460800,
@@ -487,6 +490,9 @@
 	pbn_b2_bt_4_115200,
 	pbn_b2_bt_2_921600,
 
+	pbn_bt_4_921600,
+	pbn_bt_8_921600,
+
 	pbn_panacom,
 	pbn_panacom2,
 	pbn_panacom4,
@@ -554,6 +563,8 @@
 	{ SPCI_FL_BASE1, 4, 1382400 },		/* pbn_b1_4_1382400 */
 	{ SPCI_FL_BASE1, 8, 1382400 },		/* pbn_b1_8_1382400 */
 
+	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 1, 921600 }, /* pbn_b1_bt_1_921600 */
+	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 }, /* pbn_b1_bt_2_921600 */
 	{ SPCI_FL_BASE2, 1, 115200 },		/* pbn_b2_1_115200 */
 	{ SPCI_FL_BASE2, 8, 115200 },		/* pbn_b2_8_115200 */
 	{ SPCI_FL_BASE2, 4, 460800 },		/* pbn_b2_4_460800 */
@@ -567,6 +578,8 @@
 	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 115200 }, /* pbn_b2_bt_4_115200 */
 	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600 }, /* pbn_b2_bt_2_921600 */
 
+	{ SPCI_FL_BASE_TABLE, 4, 921600 }, 		/* pbn_bt_4_921600 */
+	{ SPCI_FL_BASE_TABLE, 8, 921600 }, 		/* pbn_bt_8_921600 */
 	{ SPCI_FL_BASE2, 2, 921600, /* IOMEM */		   /* pbn_panacom */
 		0x400, 7, pci_plx9050_fn },
 	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,   /* pbn_panacom2 */
@@ -992,19 +1005,18 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
 		pbn_b0_4_921600 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100L,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE1, 1, 921600 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b1_bt_1_921600 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200L,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b1_bt_2_921600 },
 	/* The 400L and 800L have a custom hack in get_pci_port */
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400L,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE_TABLE, 4, 921600 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_bt_4_921600 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800L,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE_TABLE, 8, 921600 },
-
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_bt_8_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_550,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_siig10x_0 },
