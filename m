Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbWBNPiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWBNPiD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWBNPiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:38:03 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:6116 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1161071AbWBNPiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:38:01 -0500
Date: Tue, 14 Feb 2006 16:33:12 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: trivial@kernel.org
Subject: [trivial PATCH] "drivers/usb/media/stv680.h": fix jiffies timeout
Message-ID: <20060214163312.22960006@localhost>
X-Mailer: Sylpheed-Claws 2.0.0-rc4 (GTK+ 2.8.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Ornati <ornati@fastwebnet.it>

stv680.c driver calls "usb_control_msg" passing PENCAM_TIMEOUT as
jiffies timout. However PENCAM_TIMEOUT is defined to the fixed value of
1000, this leads to different timeouts with different HZ settings.

Since stv680.c is there since 2.4.18 I don't know if 1000 means 10s or
1s... I've picked the bigger.

---

diff --git a/drivers/usb/media/stv680.h b/drivers/usb/media/stv680.h
index b0551cd..b1a4bf5 100644
--- a/drivers/usb/media/stv680.h
+++ b/drivers/usb/media/stv680.h
@@ -45,7 +45,7 @@
 #define USB_CREATIVEGOMINI_VENDOR_ID	0x041e
 #define USB_CREATIVEGOMINI_PRODUCT_ID	0x4007
 
-#define PENCAM_TIMEOUT          1000
+#define PENCAM_TIMEOUT		(10*HZ)
 /* fmt 4 */
 #define STV_VIDEO_PALETTE       VIDEO_PALETTE_RGB24
 

-- 
	Paolo Ornati
	Linux 2.6.15.4-suspend2 on x86_64
