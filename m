Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbTIVPvq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 11:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTIVPvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 11:51:46 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:17073 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263200AbTIVPvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 11:51:43 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: torvalds@osdl.org, akpm@zip.com.au, thornber@sistina.com
Subject: [PATCH] DM 1/6: Use new format_dev_t macro
Date: Mon, 22 Sep 2003 10:51:27 -0500
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200309221044.21694.kevcorry@us.ibm.com>
In-Reply-To: <200309221044.21694.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309221051.27714.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the format_dev_t function for target status functions.

--- diff/drivers/md/dm-linear.c	2003-06-30 10:07:21.000000000 +0100
+++ source/drivers/md/dm-linear.c	2003-09-17 13:08:44.000000000 +0100
@@ -79,7 +79,7 @@
 			 char *result, unsigned int maxlen)
 {
 	struct linear_c *lc = (struct linear_c *) ti->private;
-	char b[BDEVNAME_SIZE];
+	char buffer[32];
 
 	switch (type) {
 	case STATUSTYPE_INFO:
@@ -87,8 +87,8 @@
 		break;
 
 	case STATUSTYPE_TABLE:
-		snprintf(result, maxlen, "%s " SECTOR_FORMAT,
-			 bdevname(lc->dev->bdev, b), lc->start);
+		format_dev_t(buffer, lc->dev->bdev->bd_dev);
+		snprintf(result, maxlen, "%s " SECTOR_FORMAT, buffer, lc->start);
 		break;
 	}
 	return 0;
--- diff/drivers/md/dm-stripe.c	2003-08-20 14:16:28.000000000 +0100
+++ source/drivers/md/dm-stripe.c	2003-09-17 13:08:44.000000000 +0100
@@ -187,7 +187,7 @@
 	struct stripe_c *sc = (struct stripe_c *) ti->private;
 	int offset;
 	unsigned int i;
-	char b[BDEVNAME_SIZE];
+	char buffer[32];
 
 	switch (type) {
 	case STATUSTYPE_INFO:
@@ -198,10 +198,10 @@
 		offset = snprintf(result, maxlen, "%d " SECTOR_FORMAT,
 				  sc->stripes, sc->chunk_mask + 1);
 		for (i = 0; i < sc->stripes; i++) {
+			format_dev_t(buffer, sc->stripe[i].dev->bdev->bd_dev);
 			offset +=
 			    snprintf(result + offset, maxlen - offset,
-				     " %s " SECTOR_FORMAT,
-		       bdevname(sc->stripe[i].dev->bdev, b),
+				     " %s " SECTOR_FORMAT, buffer,
 				     sc->stripe[i].physical_start);
 		}
 		break;

