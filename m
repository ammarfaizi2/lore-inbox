Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVFTVTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVFTVTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVFTVQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:16:41 -0400
Received: from mail.dif.dk ([193.138.115.101]:28298 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261597AbVFTVLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:11:47 -0400
Date: Mon, 20 Jun 2005 23:17:12 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Luc Saillard <luc@saillard.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][3/3] pwc-uncompress cleanup - remove redundant casts.
Message-ID: <Pine.LNX.4.62.0506202315130.2369@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a few redundant casts from 
drivers/usb/media/pwc/pwc-uncompress.c

The patch is incremental on top of the previous [PATCH][2/3]


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/usb/media/pwc/pwc-uncompress.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.12/drivers/usb/media/pwc/pwc-uncompress.c.with_patch_2	2005-06-20 22:58:38.000000000 +0200
+++ linux-2.6.12/drivers/usb/media/pwc/pwc-uncompress.c	2005-06-20 22:57:42.000000000 +0200
@@ -73,17 +73,17 @@ int pwc_decompress(struct pwc_device *pd
 		 * We do some byte shuffling here to go from the
 		 * native format to YUV420P.
 		 */
-		src = (u16 *)yuv;
+		src = yuv;
 		n = pdev->view.x * pdev->view.y;
 
 		/* offset in Y plane */
 		stride = pdev->view.x * pdev->offset.y + pdev->offset.x;
-		dsty = (u16 *)(image + stride);
+		dsty = image + stride;
 
 		/* offsets in U/V planes */
 		stride = pdev->view.x * pdev->offset.y / 4 + pdev->offset.x / 2;
-		dstu = (u16 *)(image + n +         stride);
-		dstv = (u16 *)(image + n + n / 4 + stride);
+		dstu = image + n + stride;
+		dstv = image + n + n / 4 + stride;
 
 		/* increment after each line */
 		stride = (pdev->view.x - pdev->image.x) / 2; /* u16 = 2 bytes */




