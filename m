Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263921AbTCVWlj>; Sat, 22 Mar 2003 17:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263970AbTCVWlH>; Sat, 22 Mar 2003 17:41:07 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11653
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263954AbTCVWjw>; Sat, 22 Mar 2003 17:39:52 -0500
Date: Sat, 22 Mar 2003 23:55:34 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303222355.h2MNtYPv020703@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: add checks to pc9800 ide reserve
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/ide/legacy/pc9800.c linux-2.5.65-ac3/drivers/ide/legacy/pc9800.c
--- linux-2.5.65-bk3/drivers/ide/legacy/pc9800.c	2003-03-22 19:35:11.000000000 +0000
+++ linux-2.5.65-ac3/drivers/ide/legacy/pc9800.c	2003-03-22 20:36:26.000000000 +0000
@@ -64,9 +64,13 @@
 	/* Restore original value, just in case. */
 	outb(saved_bank, PC9800_IDE_BANKSELECT);
 
-	/* These ports are probably used by IDE I/F.  */
-	request_region(0x430, 1, "ide");
-	request_region(0x435, 1, "ide");
+	/* These ports are reseved by IDE I/F.  */
+	if (!request_region(0x430, 1, "ide") ||
+	    !request_region(0x435, 1, "ide")) {
+		printk(KERN_WARNING
+			"ide: IO port 0x430 and 0x435 are reserved for IDE"
+			" the card using these ports may not work\n");
+	}
 
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET] == HD_DATA &&
 	    ide_hwifs[1].io_ports[IDE_DATA_OFFSET] == HD_DATA) {
