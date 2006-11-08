Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965868AbWKHOhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965868AbWKHOhn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965861AbWKHOg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:36:59 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:63238 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965838AbWKHOgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:36:53 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 18/33] usb: usbkbd free urb cleanup
Date: Wed, 8 Nov 2006 15:35:58 +0100
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
Message-Id: <200611081536.00087.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/input/usbkbd.c	2006-11-06 17:08:20.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/input/usbkbd.c	2006-11-06 19:26:18.000000000 +0100
@@ -208,10 +208,8 @@ static int usb_kbd_alloc_mem(struct usb_
 
 static void usb_kbd_free_mem(struct usb_device *dev, struct usb_kbd *kbd)
 {
-	if (kbd->irq)
-		usb_free_urb(kbd->irq);
-	if (kbd->led)
-		usb_free_urb(kbd->led);
+	usb_free_urb(kbd->irq);
+	usb_free_urb(kbd->led);
 	if (kbd->new)
 		usb_buffer_free(dev, 8, kbd->new, kbd->new_dma);
 	if (kbd->cr)
