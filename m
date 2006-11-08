Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965889AbWKHOp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965889AbWKHOp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965825AbWKHOfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:35:44 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:51206 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965819AbWKHOfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:35:22 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 6/33] usb: ttusb_dec free urb cleanup
Date: Wed, 8 Nov 2006 15:34:27 +0100
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
Message-Id: <200611081534.28503.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2006-11-06 17:07:39.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2006-11-06 19:55:08.000000000 +0100
@@ -1135,8 +1135,7 @@ static void ttusb_dec_free_iso_urbs(stru
 	dprintk("%s\n", __FUNCTION__);
 
 	for (i = 0; i < ISO_BUF_COUNT; i++)
-		if (dec->iso_urb[i])
-			usb_free_urb(dec->iso_urb[i]);
+		usb_free_urb(dec->iso_urb[i]);
 
 	pci_free_consistent(NULL,
 			    ISO_FRAME_SIZE * (FRAMES_PER_ISO_BUF *
