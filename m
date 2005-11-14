Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVKNUTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVKNUTS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVKNUTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:19:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:42694 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932085AbVKNUTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:19:17 -0500
Date: Mon, 14 Nov 2005 12:05:09 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch 01/12] USB: fix build breakage in dummy_hcd.c
Message-ID: <20051114200509.GB2319@kroah.com>
References: <20051114200100.984523000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-fix-dummy_hcd-breakage.patch"
In-Reply-To: <20051114200456.GA2319@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/gadget/dummy_hcd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/usb/gadget/dummy_hcd.c
+++ gregkh-2.6/drivers/usb/gadget/dummy_hcd.c
@@ -944,7 +944,7 @@ static int dummy_udc_suspend (struct pla
 	set_link_state (dum);
 	spin_unlock_irq (&dum->lock);
 
-	dev->power.power_state = state;
+	dev->dev.power.power_state = state;
 	usb_hcd_poll_rh_status (dummy_to_hcd (dum));
 	return 0;
 }
@@ -1904,7 +1904,7 @@ static int dummy_hcd_probe (struct platf
 	struct usb_hcd		*hcd;
 	int			retval;
 
-	dev_info (dev, "%s, driver " DRIVER_VERSION "\n", driver_desc);
+	dev_info(&dev->dev, "%s, driver " DRIVER_VERSION "\n", driver_desc);
 
 	hcd = usb_create_hcd (&dummy_hcd, &dev->dev, dev->dev.bus_id);
 	if (!hcd)

--
