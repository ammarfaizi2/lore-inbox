Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVIGRCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVIGRCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVIGRCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:02:31 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:37323
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750705AbVIGRCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:02:31 -0400
Subject: [patch] synclink.c compiler optimiation fix
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1126112543.3984.17.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Sep 2005 12:02:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] synclink.c compiler optimization fix

From: Paul Fulghum <paulkf@microgate.com>

Make some fields of DMA descriptor volatile to
prevent compiler optimizations.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.13/drivers/char/synclink.c	2005-09-07 11:43:56.000000000 -0500
+++ linux-2.6.13-mg/drivers/char/synclink.c	2005-09-07 11:52:08.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 4.28 2004/08/11 19:30:01 paulkf Exp $
+ * $Id: synclink.c,v 4.37 2005/09/07 13:13:19 paulkf Exp $
  *
  * Device driver for Microgate SyncLink ISA and PCI
  * high speed multiprotocol serial adapters.
@@ -141,9 +141,9 @@ static MGSL_PARAMS default_params = {
 typedef struct _DMABUFFERENTRY
 {
 	u32 phys_addr;	/* 32-bit flat physical address of data buffer */
-	u16 count;	/* buffer size/data count */
-	u16 status;	/* Control/status field */
-	u16 rcc;	/* character count field */
+	volatile u16 count;	/* buffer size/data count */
+	volatile u16 status;	/* Control/status field */
+	volatile u16 rcc;	/* character count field */
 	u16 reserved;	/* padding required by 16C32 */
 	u32 link;	/* 32-bit flat link to next buffer entry */
 	char *virt_addr;	/* virtual address of data buffer */
@@ -896,7 +896,7 @@ module_param_array(txdmabufs, int, NULL,
 module_param_array(txholdbufs, int, NULL, 0);
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 4.28 $";
+static char *driver_version = "$Revision: 4.37 $";
 
 static int synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);


