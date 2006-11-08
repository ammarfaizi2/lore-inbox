Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965823AbWKHOft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965823AbWKHOft (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965819AbWKHOfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:35:46 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:50182 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965816AbWKHOfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:35:17 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/33] usb: cinergyT2 free kill urb cleanup
Date: Wed, 8 Nov 2006 15:34:22 +0100
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
Message-Id: <200611081534.23484.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup
- usb_kill_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/media/dvb/cinergyT2/cinergyT2.c	2006-11-06 17:07:38.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/dvb/cinergyT2/cinergyT2.c	2006-11-07 16:52:07.000000000 +0100
@@ -275,8 +275,7 @@ static void cinergyt2_free_stream_urbs (
 	int i;
 
 	for (i=0; i<STREAM_URB_COUNT; i++)
-		if (cinergyt2->stream_urb[i])
-			usb_free_urb(cinergyt2->stream_urb[i]);
+		usb_free_urb(cinergyt2->stream_urb[i]);
 
 	usb_buffer_free(cinergyt2->udev, STREAM_URB_COUNT*STREAM_BUF_SIZE,
 			    cinergyt2->streambuf, cinergyt2->streambuf_dmahandle);
@@ -320,8 +319,7 @@ static void cinergyt2_stop_stream_xfer (
 	cinergyt2_control_stream_transfer(cinergyt2, 0);
 
 	for (i=0; i<STREAM_URB_COUNT; i++)
-		if (cinergyt2->stream_urb[i])
-			usb_kill_urb(cinergyt2->stream_urb[i]);
+		usb_kill_urb(cinergyt2->stream_urb[i]);
 }
 
 static int cinergyt2_start_stream_xfer (struct cinergyt2 *cinergyt2)
