Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbVIVHuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbVIVHuG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVIVHuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:50:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:19635 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932206AbVIVHtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:49:47 -0400
Date: Thu, 22 Sep 2005 00:48:58 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       rpurdie@rpsys.net, dbrownell@users.sourceforge.net
Subject: [patch 12/18] USB: fix pxa2xx_udc compile warnings
Message-ID: <20050922074856.GM15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-pxa2xx_udc-build-fix.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Purdie <rpurdie@rpsys.net>

This patch fixes several types in the PXA25x udc driver and hence fixes
several compiler warnings.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/gadget/pxa2xx_udc.c |    4 ++--
 drivers/usb/gadget/pxa2xx_udc.h |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

--- scsi-2.6.orig/drivers/usb/gadget/pxa2xx_udc.c	2005-09-20 06:00:03.000000000 -0700
+++ scsi-2.6/drivers/usb/gadget/pxa2xx_udc.c	2005-09-21 17:29:43.000000000 -0700
@@ -422,7 +422,7 @@
 }
 
 static int
-write_packet(volatile u32 *uddr, struct pxa2xx_request *req, unsigned max)
+write_packet(volatile unsigned long *uddr, struct pxa2xx_request *req, unsigned max)
 {
 	u8		*buf;
 	unsigned	length, count;
@@ -2602,7 +2602,7 @@
  * VBUS IRQs should probably be ignored so that the PXA device just acts
  * "dead" to USB hosts until system resume.
  */
-static int pxa2xx_udc_suspend(struct device *dev, u32 state, u32 level)
+static int pxa2xx_udc_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct pxa2xx_udc	*udc = dev_get_drvdata(dev);
 
--- scsi-2.6.orig/drivers/usb/gadget/pxa2xx_udc.h	2005-09-20 06:00:03.000000000 -0700
+++ scsi-2.6/drivers/usb/gadget/pxa2xx_udc.h	2005-09-21 17:29:43.000000000 -0700
@@ -69,11 +69,11 @@
 	 * UDDR = UDC Endpoint Data Register (the fifo)
 	 * DRCM = DMA Request Channel Map
 	 */
-	volatile u32				*reg_udccs;
-	volatile u32				*reg_ubcr;
-	volatile u32				*reg_uddr;
+	volatile unsigned long			*reg_udccs;
+	volatile unsigned long			*reg_ubcr;
+	volatile unsigned long			*reg_uddr;
 #ifdef USE_DMA
-	volatile u32				*reg_drcmr;
+	volatile unsigned long			*reg_drcmr;
 #define	drcmr(n)  .reg_drcmr = & DRCMR ## n ,
 #else
 #define	drcmr(n)  

--
