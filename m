Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWH0X7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWH0X7z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 19:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWH0X73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 19:59:29 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:46791 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932313AbWH0X6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:58:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Hollis <dhollis@davehollis.com>
Subject: [PATCH] mcs7830: fix reception of 1514 byte frames
Date: Sun, 27 Aug 2006 22:41:53 +0200
User-Agent: KMail/1.9.1
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, support@moschip.com,
       Michael Helmling <supermihi@web.de>
References: <200608071500.55903.arnd.bergmann@de.ibm.com> <200608202207.39709.arnd@arndb.de> <200608272241.05026.arnd@arndb.de>
In-Reply-To: <200608272241.05026.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608272241.54161.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mcs7830 chip always appends a byte with status information
to an rx frame, so the URB needs to reserve an extra byte.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Index: linux-cg/drivers/usb/net/mcs7830.c
===================================================================
--- linux-cg.orig/drivers/usb/net/mcs7830.c	2006-08-25 21:23:35.000000000 +0200
+++ linux-cg/drivers/usb/net/mcs7830.c	2006-08-25 21:26:02.000000000 +0200
@@ -405,6 +405,9 @@
 	net->set_multicast_list = mcs7830_set_multicast;
 	mcs7830_set_multicast(net);
 
+	/* reserve space for the status byte on rx */
+	dev->rx_urb_size = ETH_FRAME_LEN + 1;
+
 	dev->mii.mdio_read = mcs7830_mdio_read;
 	dev->mii.mdio_write = mcs7830_mdio_write;
 	dev->mii.dev = net;

