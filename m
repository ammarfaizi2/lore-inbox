Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965834AbWKHOnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965834AbWKHOnc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965822AbWKHOgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:36:52 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:60422 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965835AbWKHOgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:36:49 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 15/33] usb: ati_remote free urb cleanup
Date: Wed, 8 Nov 2006 15:35:46 +0100
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
Message-Id: <200611081535.47630.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/input/ati_remote.c	2006-11-06 17:08:20.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/input/ati_remote.c	2006-11-06 19:23:09.000000000 +0100
@@ -630,11 +630,8 @@ static int ati_remote_alloc_buffers(stru
  */
 static void ati_remote_free_buffers(struct ati_remote *ati_remote)
 {
-	if (ati_remote->irq_urb)
-		usb_free_urb(ati_remote->irq_urb);
-
-	if (ati_remote->out_urb)
-		usb_free_urb(ati_remote->out_urb);
+	usb_free_urb(ati_remote->irq_urb);
+	usb_free_urb(ati_remote->out_urb);
 
 	if (ati_remote->inbuf)
 		usb_buffer_free(ati_remote->udev, DATA_BUFSIZE,
