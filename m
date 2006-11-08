Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965811AbWKHOe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965811AbWKHOe6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754590AbWKHOe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:34:58 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:34053 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1754589AbWKHOe5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:34:57 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/33] usb: pcwd_usb free urb cleanup
Date: Wed, 8 Nov 2006 15:34:02 +0100
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
Message-Id: <200611081534.03942.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/char/watchdog/pcwd_usb.c	2006-11-06 17:07:20.000000000 +0100
+++ linux-2.6.19-rc4/drivers/char/watchdog/pcwd_usb.c	2006-11-06 19:51:32.000000000 +0100
@@ -561,8 +561,7 @@ static struct notifier_block usb_pcwd_no
  */
 static inline void usb_pcwd_delete (struct usb_pcwd_private *usb_pcwd)
 {
-	if (usb_pcwd->intr_urb != NULL)
-		usb_free_urb (usb_pcwd->intr_urb);
+	usb_free_urb (usb_pcwd->intr_urb);
 	if (usb_pcwd->intr_buffer != NULL)
 		usb_buffer_free(usb_pcwd->udev, usb_pcwd->intr_size,
 				usb_pcwd->intr_buffer, usb_pcwd->intr_dma);
