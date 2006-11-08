Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965873AbWKHOho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965873AbWKHOho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965869AbWKHOhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:37:43 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:4103 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965868AbWKHOhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:37:24 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 25/33] usb: io_edgeport kill urb cleanup
Date: Wed, 8 Nov 2006 15:36:29 +0100
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
Message-Id: <200611081536.31231.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_kill_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/serial/io_edgeport.c	2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/serial/io_edgeport.c	2006-11-07 17:03:34.000000000 +0100
@@ -1038,9 +1038,7 @@ static void edge_close (struct usb_seria
 	edge_port->open = FALSE;
 	edge_port->openPending = FALSE;
 
-	if (edge_port->write_urb) {
-		usb_kill_urb(edge_port->write_urb);
-	}
+	usb_kill_urb(edge_port->write_urb);
 
 	if (edge_port->write_urb) {
 		/* if this urb had a transfer buffer already (old transfer) free it */
