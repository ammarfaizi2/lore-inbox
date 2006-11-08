Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965844AbWKHOg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965844AbWKHOg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965835AbWKHOgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:36:54 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:62214 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965804AbWKHOgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:36:49 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 17/33] usb: hid-core free urb cleanup
Date: Wed, 8 Nov 2006 15:35:54 +0100
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
Message-Id: <200611081535.55651.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/input/hid-core.c	2006-11-06 17:08:20.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/input/hid-core.c	2006-11-06 19:25:20.000000000 +0100
@@ -2037,13 +2037,9 @@ static struct hid_device *usb_hid_config
 	return hid;
 
 fail:
-
-	if (hid->urbin)
-		usb_free_urb(hid->urbin);
-	if (hid->urbout)
-		usb_free_urb(hid->urbout);
-	if (hid->urbctrl)
-		usb_free_urb(hid->urbctrl);
+	usb_free_urb(hid->urbin);
+	usb_free_urb(hid->urbout);
+	usb_free_urb(hid->urbctrl);
 	hid_free_buffers(dev, hid);
 	hid_free_device(hid);
 
@@ -2074,8 +2070,7 @@ static void hid_disconnect(struct usb_in
 
 	usb_free_urb(hid->urbin);
 	usb_free_urb(hid->urbctrl);
-	if (hid->urbout)
-		usb_free_urb(hid->urbout);
+	usb_free_urb(hid->urbout);
 
 	hid_free_buffers(hid->dev, hid);
 	hid_free_device(hid);
