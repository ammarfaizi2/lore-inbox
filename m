Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965887AbWKHOkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965887AbWKHOkE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965865AbWKHOht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:37:49 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:6919 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965875AbWKHOhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:37:37 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 28/33] usb: mct_u232 free urb cleanup
Date: Wed, 8 Nov 2006 15:36:42 +0100
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
Message-Id: <200611081536.44075.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/serial/mct_u232.c	2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/serial/mct_u232.c	2006-11-07 17:40:34.000000000 +0100
@@ -358,10 +358,8 @@ static int mct_u232_startup (struct usb_
 	/* Puh, that's dirty */
 	port = serial->port[0];
 	rport = serial->port[1];
-	if (port->read_urb) {
-		/* No unlinking, it wasn't submitted yet. */
-		usb_free_urb(port->read_urb);
-	}
+	/* No unlinking, it wasn't submitted yet. */
+	usb_free_urb(port->read_urb);
 	port->read_urb = rport->interrupt_in_urb;
 	rport->interrupt_in_urb = NULL;
 	port->read_urb->context = port;
