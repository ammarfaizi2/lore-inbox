Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965871AbWKHOhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965871AbWKHOhn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965873AbWKHOhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:37:41 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:5127 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965869AbWKHOh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:37:29 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 26/33] usb: keyspan free urb cleanup
Date: Wed, 8 Nov 2006 15:36:34 +0100
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
Message-Id: <200611081536.35884.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/serial/keyspan.c	2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/serial/keyspan.c	2006-11-06 19:32:46.000000000 +0100
@@ -2306,22 +2306,16 @@ static void keyspan_shutdown (struct usb
 	}
 
 	/* Now free them */
-	if (s_priv->instat_urb)
-		usb_free_urb(s_priv->instat_urb);
-	if (s_priv->glocont_urb)
-		usb_free_urb(s_priv->glocont_urb);
+	usb_free_urb(s_priv->instat_urb);
+	usb_free_urb(s_priv->glocont_urb);
 	for (i = 0; i < serial->num_ports; ++i) {
 		port = serial->port[i];
 		p_priv = usb_get_serial_port_data(port);
-		if (p_priv->inack_urb)
-			usb_free_urb(p_priv->inack_urb);
-		if (p_priv->outcont_urb)
-			usb_free_urb(p_priv->outcont_urb);
+		usb_free_urb(p_priv->inack_urb);
+		usb_free_urb(p_priv->outcont_urb);
 		for (j = 0; j < 2; j++) {
-			if (p_priv->in_urbs[j])
-				usb_free_urb(p_priv->in_urbs[j]);
-			if (p_priv->out_urbs[j])
-				usb_free_urb(p_priv->out_urbs[j]);
+			usb_free_urb(p_priv->in_urbs[j]);
+			usb_free_urb(p_priv->out_urbs[j]);
 		}
 	}
 
