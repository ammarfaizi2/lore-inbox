Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVC0UvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVC0UvA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 15:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVC0Uta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 15:49:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34064 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261161AbVC0Usy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 15:48:54 -0500
Date: Sun, 27 Mar 2005 22:48:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/media/usbvideo.c: fix a check after use
Message-ID: <20050327204852.GC4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/usb/media/usbvideo.c.old	2005-03-23 04:59:11.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/usb/media/usbvideo.c	2005-03-23 04:59:46.000000000 +0100
@@ -1814,12 +1814,12 @@
 {
 	int i, j;
 
-	if (uvd->debug > 1)
-		info("%s($%p)", __FUNCTION__, uvd);
-
 	if ((uvd == NULL) || (!uvd->streaming) || (uvd->dev == NULL))
 		return;
 
+	if (uvd->debug > 1)
+		info("%s($%p)", __FUNCTION__, uvd);
+
 	/* Unschedule all of the iso td's */
 	for (i=0; i < USBVIDEO_NUMSBUF; i++) {
 		usb_kill_urb(uvd->sbuf[i].urb);

