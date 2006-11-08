Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965884AbWKHOjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965884AbWKHOjj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965880AbWKHOhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:37:51 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:1799 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965819AbWKHOhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:37:13 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 22/33] usb: phidgetmotorcontrol free urb cleanup
Date: Wed, 8 Nov 2006 15:36:18 +0100
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
Message-Id: <200611081536.20239.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/misc/phidgetmotorcontrol.c	2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/misc/phidgetmotorcontrol.c	2006-11-06 19:28:17.000000000 +0100
@@ -392,8 +392,7 @@ out2:
 		device_remove_file(mc->dev, &dev_attrs[i]);
 out:
 	if (mc) {
-		if (mc->irq)
-			usb_free_urb(mc->irq);
+		usb_free_urb(mc->irq);
 		if (mc->data)
 			usb_buffer_free(dev, URB_INT_SIZE, mc->data, mc->data_dma);
 		if (mc->dev)
