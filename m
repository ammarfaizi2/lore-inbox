Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263841AbTCUTas>; Fri, 21 Mar 2003 14:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263840AbTCUT34>; Fri, 21 Mar 2003 14:29:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55684
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263838AbTCUT2v>; Fri, 21 Mar 2003 14:28:51 -0500
Date: Fri, 21 Mar 2003 20:44:07 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212044.h2LKi7jG026461@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: ide should check dma_on
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide.c linux-2.5.65-ac2/drivers/ide/ide.c
--- linux-2.5.65/drivers/ide/ide.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide.c	2003-03-20 18:23:19.000000000 +0000
@@ -1255,13 +1284,14 @@
 
 static int set_using_dma (ide_drive_t *drive, int arg)
 {
-	if (!drive->driver || !DRIVER(drive)->supports_dma)
+	if (!DRIVER(drive)->supports_dma)
 		return -EPERM;
 	if (!drive->id || !(drive->id->capability & 1))
 		return -EPERM;
 	if (HWIF(drive)->ide_dma_check == NULL)
 		return -EPERM;
 	if (arg) {
+		if (HWIF(drive)->ide_dma_check(drive)) return -EIO;
 		if (HWIF(drive)->ide_dma_on(drive)) return -EIO;
 	} else {
 		if (HWIF(drive)->ide_dma_off(drive)) return -EIO;
