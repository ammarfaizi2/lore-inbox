Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965828AbWKHOft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965828AbWKHOft (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965823AbWKHOfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:35:47 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:49158 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965804AbWKHOfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:35:12 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/33] usb: usb-gigaset free kill urb cleanup
Date: Wed, 8 Nov 2006 15:34:17 +0100
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
Message-Id: <200611081534.18562.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup
- usb_kill_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/isdn/gigaset/usb-gigaset.c	2006-11-06 17:07:30.000000000 +0100
+++ linux-2.6.19-rc4/drivers/isdn/gigaset/usb-gigaset.c	2006-11-07 16:51:17.000000000 +0100
@@ -815,14 +815,11 @@ static int gigaset_probe(struct usb_inte
 	return 0;
 
 error:
-	if (ucs->read_urb)
-		usb_kill_urb(ucs->read_urb);
+	usb_kill_urb(ucs->read_urb);
 	kfree(ucs->bulk_out_buffer);
-	if (ucs->bulk_out_urb != NULL)
-		usb_free_urb(ucs->bulk_out_urb);
+	usb_free_urb(ucs->bulk_out_urb);
 	kfree(cs->inbuf[0].rcvbuf);
-	if (ucs->read_urb != NULL)
-		usb_free_urb(ucs->read_urb);
+	usb_free_urb(ucs->read_urb);
 	usb_set_intfdata(interface, NULL);
 	ucs->read_urb = ucs->bulk_out_urb = NULL;
 	cs->inbuf[0].rcvbuf = ucs->bulk_out_buffer = NULL;
@@ -850,11 +847,9 @@ static void gigaset_disconnect(struct us
 	usb_kill_urb(ucs->bulk_out_urb);	/* FIXME: only if active? */
 
 	kfree(ucs->bulk_out_buffer);
-	if (ucs->bulk_out_urb != NULL)
-		usb_free_urb(ucs->bulk_out_urb);
+	usb_free_urb(ucs->bulk_out_urb);
 	kfree(cs->inbuf[0].rcvbuf);
-	if (ucs->read_urb != NULL)
-		usb_free_urb(ucs->read_urb);
+	usb_free_urb(ucs->read_urb);
 	ucs->read_urb = ucs->bulk_out_urb = NULL;
 	cs->inbuf[0].rcvbuf = ucs->bulk_out_buffer = NULL;
 
