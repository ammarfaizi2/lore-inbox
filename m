Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWFUOfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWFUOfq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWFUOfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:35:46 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:59113
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750745AbWFUOfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:35:45 -0400
Subject: [PATCH] synclink_gt add GT2 adapter support
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 09:35:37 -0500
Message-Id: <1150900537.3708.11.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SyncLink GT2 adapter to driver.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- a/drivers/char/synclink_gt.c	2006-06-21 09:04:11.000000000 -0500
+++ b/drivers/char/synclink_gt.c	2006-06-21 09:02:01.000000000 -0500
@@ -101,6 +101,7 @@ MODULE_LICENSE("GPL");
 
 static struct pci_device_id pci_table[] = {
 	{PCI_VENDOR_ID_MICROGATE, SYNCLINK_GT_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PCI_VENDOR_ID_MICROGATE, SYNCLINK_GT2_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{PCI_VENDOR_ID_MICROGATE, SYNCLINK_GT4_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{PCI_VENDOR_ID_MICROGATE, SYNCLINK_AC_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{0,}, /* terminate list */
@@ -3276,6 +3277,9 @@ static void add_device(struct slgt_info 
 	case SYNCLINK_GT_DEVICE_ID:
 		devstr = "GT";
 		break;
+	case SYNCLINK_GT2_DEVICE_ID:
+		devstr = "GT2";
+		break;
 	case SYNCLINK_GT4_DEVICE_ID:
 		devstr = "GT4";
 		break;
@@ -3353,7 +3357,9 @@ static void device_init(int adapter_num,
 	int i;
 	int port_count = 1;
 
-	if (pdev->device == SYNCLINK_GT4_DEVICE_ID)
+	if (pdev->device == SYNCLINK_GT2_DEVICE_ID)
+		port_count = 2;
+	else if (pdev->device == SYNCLINK_GT4_DEVICE_ID)
 		port_count = 4;
 
 	/* allocate device instances for all ports */
--- a/include/linux/synclink.h	2006-06-21 09:04:26.000000000 -0500
+++ b/include/linux/synclink.h	2006-06-21 09:01:51.000000000 -0500
@@ -170,6 +170,7 @@ typedef struct _MGSL_PARAMS
 #define SYNCLINK_GT_DEVICE_ID 0x0070
 #define SYNCLINK_GT4_DEVICE_ID 0x0080
 #define SYNCLINK_AC_DEVICE_ID  0x0090
+#define SYNCLINK_GT2_DEVICE_ID 0x00A0
 #define MGSL_MAX_SERIAL_NUMBER 30
 
 /*


