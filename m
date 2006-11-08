Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965886AbWKHOnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965886AbWKHOnc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965834AbWKHOm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:42:57 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:59398 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965832AbWKHOg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:36:57 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 14/33] usb: zd1201 free urb cleanup
Date: Wed, 8 Nov 2006 15:35:42 +0100
User-Agent: KMail/1.9.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200611062228.38937.m.kozlowski@tuxland.pl> <200611071030.57152.m.kozlowski@tuxland.pl> <20061107013702.46b5710f.akpm@osdl.org>
In-Reply-To: <20061107013702.46b5710f.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611081535.43818.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/net/wireless/zd1201.c	2006-11-06 17:07:59.000000000 +0100
+++ linux-2.6.19-rc4/drivers/net/wireless/zd1201.c	2006-11-06 19:59:49.000000000 +0100
@@ -1828,10 +1828,8 @@ err_start:
 	/* Leave the device in reset state */
 	zd1201_docmd(zd, ZD1201_CMDCODE_INIT, 0, 0, 0);
 err_zd:
-	if (zd->tx_urb)
-		usb_free_urb(zd->tx_urb);
-	if (zd->rx_urb)
-		usb_free_urb(zd->rx_urb);
+	usb_free_urb(zd->tx_urb);
+	usb_free_urb(zd->rx_urb);
 	kfree(zd);
 	return err;
 }
