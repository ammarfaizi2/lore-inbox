Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUIAQHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUIAQHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUIAP56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:57:58 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:58802 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267285AbUIAPvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:43 -0400
Date: Wed, 1 Sep 2004 16:51:20 +0100
Message-Id: <200409011551.i81FpKhF000600@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix leak in atmel wireless driver.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/wireless/atmel.c linux-2.6/drivers/net/wireless/atmel.c
--- bk-linus/drivers/net/wireless/atmel.c	2004-08-11 00:00:37.000000000 +0100
+++ linux-2.6/drivers/net/wireless/atmel.c	2004-08-23 14:08:15.000000000 +0100
@@ -2430,12 +2430,13 @@ static int atmel_ioctl(struct net_device
 			rc = -ENOMEM;
 			break;
 		}
-		
+
 		if (copy_from_user(new_firmware, com.data, com.len)) {
+			kfree(new_firmware);
 			rc = -EFAULT;
 			break;
 		}
-		
+
 		if (priv->firmware)
 			kfree(priv->firmware);
 		
