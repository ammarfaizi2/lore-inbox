Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTJPSav (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 14:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTJPSav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 14:30:51 -0400
Received: from [193.138.115.2] ([193.138.115.2]:50958 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263055AbTJPSat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 14:30:49 -0400
Date: Thu, 16 Oct 2003 20:29:35 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Minor fix for wrong format in drivers/mtd/inftlcore.c
 (2.6.0-test7)
Message-ID: <Pine.LNX.4.56.0310162023001.3021@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's a small patch for a very minor issue :

drivers/mtd/inftlcore.c: In function `inftl_writeblock':
drivers/mtd/inftlcore.c:761: warning: int format, long unsigned int arg (arg 3)
drivers/mtd/inftlcore.c:761: warning: int format, long unsigned int arg (arg 3)
drivers/mtd/inftlcore.c: In function `inftl_readblock':
drivers/mtd/inftlcore.c:807: warning: int format, long unsigned int arg (arg 3)
drivers/mtd/inftlcore.c:807: warning: int format, long unsigned int arg (arg 3)

This patch should fix that (against 2.6.0-test7):

--- linux-2.6.0-test7-orig/drivers/mtd/inftlcore.c	2003-10-08 21:24:01.000000000 +0200
+++ linux-2.6.0-test7/drivers/mtd/inftlcore.c	2003-10-16 20:15:29.000000000 +0200
@@ -757,7 +757,7 @@ static int inftl_writeblock(struct mtd_b
 	u8 eccbuf[6];
 	char *p, *pend;

-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: inftl_writeblock(inftl=0x%x,block=%d,"
+	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: inftl_writeblock(inftl=0x%x,block=%ld,"
 		"buffer=0x%x)\n", (int)inftl, block, (int)buffer);

 	/* Is block all zero? */
@@ -803,7 +803,7 @@ static int inftl_readblock(struct mtd_bl
         struct inftl_bci bci;
 	size_t retlen;

-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: inftl_readblock(inftl=0x%x,block=%d,"
+	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: inftl_readblock(inftl=0x%x,block=%ld,"
 		"buffer=0x%x)\n", (int)inftl, block, (int)buffer);

 	while (thisEUN < inftl->nb_blocks) {



Hopefully this is useful.


Kind regards,

Jesper Juhl <juhl-lkml@dif.dk>
