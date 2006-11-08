Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965810AbWKHOg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965810AbWKHOg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965835AbWKHOgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:36:17 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:54278 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965810AbWKHOft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:35:49 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 9/33] usb: pwc-if free urb cleanup
Date: Wed, 8 Nov 2006 15:34:55 +0100
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
Message-Id: <200611081534.56743.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/media/video/pwc/pwc-if.c	2006-11-06 17:07:44.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/video/pwc/pwc-if.c	2006-11-06 19:57:00.000000000 +0100
@@ -867,8 +867,7 @@ int pwc_isoc_init(struct pwc_device *pde
 	if (ret) {
 		/* De-allocate in reverse order */
 		while (i >= 0) {
-			if (pdev->sbuf[i].urb != NULL)
-				usb_free_urb(pdev->sbuf[i].urb);
+			usb_free_urb(pdev->sbuf[i].urb);
 			pdev->sbuf[i].urb = NULL;
 			i--;
 		}
