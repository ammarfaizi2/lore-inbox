Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262965AbVCDRG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbVCDRG1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbVCDRGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:06:19 -0500
Received: from adsl-69-149-197-17.dsl.austtx.swbell.net ([69.149.197.17]:46737
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S262989AbVCDRDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 12:03:13 -0500
Subject: [PATCH 2.6] fix register access typo in synclinkmp
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1109955994.7160.2.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 04 Mar 2005 11:06:34 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix register access typo in synclinkmp.c
that caused value to be written to wrong register.

-- 
Paul Fulghum
paulkf@microgate.com

--- linux-2.6.11/drivers/char/synclinkmp.c	2005-03-02 01:37:50.000000000 -0600
+++ linux-2.6.11-mg/drivers/char/synclinkmp.c	2005-03-04 11:02:29.000000000 -0600
@@ -1,5 +1,5 @@
 /*
- * $Id: synclinkmp.c,v 4.29 2004/08/27 20:06:41 paulkf Exp $
+ * $Id: synclinkmp.c,v 4.34 2005/03/04 15:07:10 paulkf Exp $
  *
  * Device driver for Microgate SyncLink Multiport
  * high speed multiprotocol serial adapter.
@@ -487,7 +487,7 @@ module_param_array(maxframe, int, NULL, 
 module_param_array(dosyncppp, int, NULL, 0);
 
 static char *driver_name = "SyncLink MultiPort driver";
-static char *driver_version = "$Revision: 4.29 $";
+static char *driver_version = "$Revision: 4.34 $";
 
 static int synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void synclinkmp_remove_one(struct pci_dev *dev);
@@ -4528,7 +4528,7 @@ void async_mode(SLMP_INFO *info)
 	 * 07..05  Reserved, must be 0
 	 * 04..00  RRC<4..0> Rx FIFO trigger active 0x00 = 1 byte
 	 */
-	write_reg(info, TRC0, 0x00);
+	write_reg(info, RRC, 0x00);
 
 	/* TRC0 Transmit Ready Control 0
 	 *


