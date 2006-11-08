Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965835AbWKHOg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965835AbWKHOg6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965819AbWKHOg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:36:57 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:58374 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965832AbWKHOgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:36:33 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 13/33] usb: irda-usb free urb cleanup
Date: Wed, 8 Nov 2006 15:35:38 +0100
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
Message-Id: <200611081535.40265.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/net/irda/irda-usb.c	2006-11-06 17:07:55.000000000 +0100
+++ linux-2.6.19-rc4/drivers/net/irda/irda-usb.c	2006-11-06 19:59:15.000000000 +0100
@@ -1793,10 +1793,8 @@ err_out_3:
 err_out_2:
 	usb_free_urb(self->tx_urb);
 err_out_1:
-	for (i = 0; i < self->max_rx_urb; i++) {
-		if (self->rx_urb[i])
-			usb_free_urb(self->rx_urb[i]);
-	}
+	for (i = 0; i < self->max_rx_urb; i++)
+		usb_free_urb(self->rx_urb[i]);
 	free_netdev(net);
 err_out:
 	return ret;
