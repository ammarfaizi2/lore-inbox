Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965838AbWKHOld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965838AbWKHOld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965834AbWKHOlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:41:05 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:8967 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965838AbWKHOhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:37:46 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 30/33] usb: usb-serial free urb cleanup
Date: Wed, 8 Nov 2006 15:36:51 +0100
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
Message-Id: <200611081536.52739.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/serial/usb-serial.c	2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/serial/usb-serial.c	2006-11-06 19:36:24.000000000 +0100
@@ -952,32 +952,28 @@ probe_error:
 		port = serial->port[i];
 		if (!port)
 			continue;
-		if (port->read_urb)
-			usb_free_urb (port->read_urb);
+		usb_free_urb (port->read_urb);
 		kfree(port->bulk_in_buffer);
 	}
 	for (i = 0; i < num_bulk_out; ++i) {
 		port = serial->port[i];
 		if (!port)
 			continue;
-		if (port->write_urb)
-			usb_free_urb (port->write_urb);
+		usb_free_urb (port->write_urb);
 		kfree(port->bulk_out_buffer);
 	}
 	for (i = 0; i < num_interrupt_in; ++i) {
 		port = serial->port[i];
 		if (!port)
 			continue;
-		if (port->interrupt_in_urb)
-			usb_free_urb (port->interrupt_in_urb);
+		usb_free_urb (port->interrupt_in_urb);
 		kfree(port->interrupt_in_buffer);
 	}
 	for (i = 0; i < num_interrupt_out; ++i) {
 		port = serial->port[i];
 		if (!port)
 			continue;
-		if (port->interrupt_out_urb)
-			usb_free_urb (port->interrupt_out_urb);
+		usb_free_urb (port->interrupt_out_urb);
 		kfree(port->interrupt_out_buffer);
 	}
 
