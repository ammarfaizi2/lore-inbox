Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVA3Q0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVA3Q0N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 11:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVA3Q0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 11:26:13 -0500
Received: from mail.dif.dk ([193.138.115.101]:35770 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261719AbVA3QZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 11:25:44 -0500
Date: Sun, 30 Jan 2005 17:29:03 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Paul Mundt <lethal@chaoticdreams.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] copy_*_user return value checks added to kyro fb... 
Message-ID: <Pine.LNX.4.62.0501301720560.2731@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's a patch that makes sure the return value of copy_from/to_user gets 
checked and handled in drivers/video/kyro/fbdev.c
It also updates a comment at the top of the file that lists the files name 
and location.
Please review and consider applying.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-rc2-bk7-orig/drivers/video/kyro/fbdev.c linux-2.6.11-rc2-bk7/drivers/video/kyro/fbdev.c
--- linux-2.6.11-rc2-bk7-orig/drivers/video/kyro/fbdev.c	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.11-rc2-bk7/drivers/video/kyro/fbdev.c	2005-01-30 17:25:18.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/video/kyro/kyrofb.c
+ *  linux/drivers/video/kyro/fbdev.c
  *
  *  Copyright (C) 2002 STMicroelectronics
  *  Copyright (C) 2003, 2004 Paul Mundt
@@ -594,7 +594,8 @@ static int kyrofb_ioctl(struct inode *in
 
 	switch (cmd) {
 	case KYRO_IOCTL_OVERLAY_CREATE:
-		copy_from_user(&ol_create, argp, sizeof(overlay_create));
+		if (copy_from_user(&ol_create, argp, sizeof(overlay_create)))
+			return -EFAULT;
 
 		if (kyro_dev_overlay_create(ol_create.ulWidth,
 					    ol_create.ulHeight, 0) < 0) {
@@ -604,8 +605,9 @@ static int kyrofb_ioctl(struct inode *in
 		}
 		break;
 	case KYRO_IOCTL_OVERLAY_VIEWPORT_SET:
-		copy_from_user(&ol_viewport_set, argp,
-			       sizeof(overlay_viewport_set));
+		if (copy_from_user(&ol_viewport_set, argp,
+			       sizeof(overlay_viewport_set)))
+			return -EFAULT;
 
 		if (kyro_dev_overlay_viewport_set(ol_viewport_set.xOrgin,
 						  ol_viewport_set.yOrgin,
@@ -625,13 +627,16 @@ static int kyrofb_ioctl(struct inode *in
 		}
 		break;
 	case KYRO_IOCTL_UVSTRIDE:
-		copy_to_user(argp, &deviceInfo.ulOverlayUVStride, sizeof(unsigned long));
+		if (copy_to_user(argp, &deviceInfo.ulOverlayUVStride, sizeof(unsigned long)))
+			return -EFAULT;
 		break;
 	case KYRO_IOCTL_STRIDE:
-		copy_to_user(argp, &deviceInfo.ulOverlayStride, sizeof(unsigned long));
+		if (copy_to_user(argp, &deviceInfo.ulOverlayStride, sizeof(unsigned long)))
+			return -EFAULT;
 		break;
 	case KYRO_IOCTL_OVERLAY_OFFSET:
-		copy_to_user(argp, &deviceInfo.ulOverlayOffset, sizeof(unsigned long));
+		if (copy_to_user(argp, &deviceInfo.ulOverlayOffset, sizeof(unsigned long)))
+			return -EFAULT;
 		break;
 	}
 



-- 
Jesper Juhl

PS. Please CC: me on replies.

