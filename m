Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVAHIGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVAHIGu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVAHIFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:05:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:21381 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261811AbVAHFr6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:47:58 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163265199@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:46 -0800
Message-Id: <11051632663455@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.20, 2004/12/15 16:34:41-08:00, david-b@pacbell.net

[PATCH] USB: usbtest and usb_dev->epmaxpacket (8/15)

Makes usbtest stop referencing the udev->epmaxpacket[] arrays.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/misc/usbtest.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
--- a/drivers/usb/misc/usbtest.c	2005-01-07 15:48:59 -08:00
+++ b/drivers/usb/misc/usbtest.c	2005-01-07 15:48:59 -08:00
@@ -954,13 +954,13 @@
 		case 13:	// short read, resembling case 10
 			req.wValue = cpu_to_le16 ((USB_DT_CONFIG << 8) | 0);
 			// last data packet "should" be DATA1, not DATA0
-			len = 1024 - udev->epmaxpacketin [0];
+			len = 1024 - udev->descriptor.bMaxPacketSize0;
 			expected = -EREMOTEIO;
 			break;
 		case 14:	// short read; try to fill the last packet
 			req.wValue = cpu_to_le16 ((USB_DT_DEVICE << 8) | 0);
 			// device descriptor size == 18 bytes 
-			len = udev->epmaxpacketin [0];
+			len = udev->descriptor.bMaxPacketSize0;
 			switch (len) {
 			case 8:		len = 24; break;
 			case 16:	len = 32; break;

