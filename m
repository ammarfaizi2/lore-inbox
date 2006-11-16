Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162279AbWKPCxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162279AbWKPCxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162272AbWKPCw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:52:57 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53647 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162234AbWKPCp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:45:27 -0500
Message-Id: <20061116024613.613119000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:44 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, maks@sternwelten.at
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Ritz <daniel.ritz-ml@swissonline.ch>,
       Daniel Ritz <daniel.ritz@gmx.ch>, Ralf Lehmann <ralf@lehmann.cc>,
       "J.P. Delport" <jpdelport@csir.co.za>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 12/30] usbtouchscreen: use endpoint address from endpoint descriptor
Content-Disposition: inline; filename=usbtouchscreen-use-endpoint-address-from-endpoint-descriptor.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>

use the endpoint address from the endpoint descriptor instead of the hardcoding
it to 0x81. at least some ITM based screen use a different address and don't work
without this.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Ralf Lehmann <ralf@lehmann.cc>
Cc: J.P. Delport <jpdelport@csir.co.za>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/usb/input/usbtouchscreen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.2.orig/drivers/usb/input/usbtouchscreen.c
+++ linux-2.6.18.2/drivers/usb/input/usbtouchscreen.c
@@ -522,7 +522,7 @@ static int usbtouch_probe(struct usb_int
 		                     type->max_press, 0, 0);
 
 	usb_fill_int_urb(usbtouch->irq, usbtouch->udev,
-			 usb_rcvintpipe(usbtouch->udev, 0x81),
+			 usb_rcvintpipe(usbtouch->udev, endpoint->bEndpointAddress),
 			 usbtouch->data, type->rept_size,
 			 usbtouch_irq, usbtouch, endpoint->bInterval);
 

--
