Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbTDHAag (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbTDGXLC (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:11:02 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50816
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263729AbTDGW5P (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:57:15 -0400
Date: Tue, 8 Apr 2003 01:16:05 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080016.h380G5hS009024@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix our handling of BIOS forced PIO serverworks OSB4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Robert Hentosh & me)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/ide/pci/serverworks.c linux-2.5.67-ac1/drivers/ide/pci/serverworks.c
--- linux-2.5.67/drivers/ide/pci/serverworks.c	2003-03-26 19:59:51.000000000 +0000
+++ linux-2.5.67-ac1/drivers/ide/pci/serverworks.c	2003-04-06 18:44:38.000000000 +0100
@@ -419,7 +419,13 @@
 
 static void svwks_tune_drive (ide_drive_t *drive, u8 pio)
 {
-	(void) svwks_tune_chipset(drive, (XFER_PIO_0 + pio));
+	/* Tune to desired value or to "best". We must not adjust
+	   "best" when we adjust from pio numbers to rate values! */
+	   
+	if(pio != 255)
+		(void) svwks_tune_chipset(drive, (XFER_PIO_0 + pio));
+	else
+		(void) svwks_tune_chipset(drive, 255);
 }
 
 static int config_chipset_for_dma (ide_drive_t *drive)
