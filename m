Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965862AbWKHOg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965862AbWKHOg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965844AbWKHOg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:36:56 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:61446 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965819AbWKHOgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:36:48 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 16/33] usb: ati_remote2 free urb cleanup
Date: Wed, 8 Nov 2006 15:35:50 +0100
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
Message-Id: <200611081535.51421.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/input/ati_remote2.c	2006-11-06 17:08:20.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/input/ati_remote2.c	2006-11-06 19:24:20.000000000 +0100
@@ -372,8 +372,7 @@ static void ati_remote2_urb_cleanup(stru
 	int i;
 
 	for (i = 0; i < 2; i++) {
-		if (ar2->urb[i])
-			usb_free_urb(ar2->urb[i]);
+		usb_free_urb(ar2->urb[i]);
 
 		if (ar2->buf[i])
 			usb_buffer_free(ar2->udev, 4, ar2->buf[i], ar2->buf_dma[i]);
