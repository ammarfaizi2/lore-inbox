Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965875AbWKHOkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965875AbWKHOkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965886AbWKHOkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:40:05 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:9735 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965875AbWKHOhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:37:50 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 31/33] usb: visor kill urb cleanup
Date: Wed, 8 Nov 2006 15:36:55 +0100
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
Message-Id: <200611081536.57366.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_kill_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/serial/visor.c	2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/serial/visor.c	2006-11-07 17:07:07.000000000 +0100
@@ -348,8 +348,7 @@ static void visor_close (struct usb_seri
 			 
 	/* shutdown our urbs */
 	usb_kill_urb(port->read_urb);
-	if (port->interrupt_in_urb)
-		usb_kill_urb(port->interrupt_in_urb);
+	usb_kill_urb(port->interrupt_in_urb);
 
 	/* Try to send shutdown message, if the device is gone, this will just fail. */
 	transfer_buffer =  kmalloc (0x12, GFP_KERNEL);
