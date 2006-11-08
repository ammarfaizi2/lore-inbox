Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965864AbWKHOiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965864AbWKHOiX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965819AbWKHOhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:37:55 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:65030 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965864AbWKHOhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:37:01 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 21/33] usb: phidgetkit free urb cleanup
Date: Wed, 8 Nov 2006 15:36:07 +0100
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
Message-Id: <200611081536.08682.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/misc/phidgetkit.c	2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/misc/phidgetkit.c	2006-11-06 19:27:48.000000000 +0100
@@ -650,8 +650,7 @@ out2:
 		device_remove_file(kit->dev, &dev_output_attrs[i]);
 out:
 	if (kit) {
-		if (kit->irq)
-			usb_free_urb(kit->irq);
+		usb_free_urb(kit->irq);
 		if (kit->data)
 			usb_buffer_free(dev, URB_INT_SIZE, kit->data, kit->data_dma);
 		if (kit->dev)
