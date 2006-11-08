Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965865AbWKHOkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965865AbWKHOkF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965861AbWKHOhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:37:47 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:2567 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965865AbWKHOhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:37:16 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 23/33] usb: catc free urb cleanup
Date: Wed, 8 Nov 2006 15:36:22 +0100
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
Message-Id: <200611081536.23489.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/net/catc.c	2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/net/catc.c	2006-11-06 19:29:53.000000000 +0100
@@ -786,14 +786,10 @@ static int catc_probe(struct usb_interfa
 	if ((!catc->ctrl_urb) || (!catc->tx_urb) || 
 	    (!catc->rx_urb) || (!catc->irq_urb)) {
 		err("No free urbs available.");
-		if (catc->ctrl_urb)
-			usb_free_urb(catc->ctrl_urb);
-		if (catc->tx_urb)
-			usb_free_urb(catc->tx_urb);
-		if (catc->rx_urb)
-			usb_free_urb(catc->rx_urb);
-		if (catc->irq_urb)
-			usb_free_urb(catc->irq_urb);
+		usb_free_urb(catc->ctrl_urb);
+		usb_free_urb(catc->tx_urb);
+		usb_free_urb(catc->rx_urb);
+		usb_free_urb(catc->irq_urb);
 		free_netdev(netdev);
 		return -ENOMEM;
 	}
