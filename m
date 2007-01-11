Return-Path: <linux-kernel-owner+w=401wt.eu-S1750734AbXAKQE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbXAKQE3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbXAKQE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:04:29 -0500
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:40250 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750734AbXAKQE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:04:28 -0500
X-Greylist: delayed 4175 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 11:04:28 EST
Message-Id: <20070111145422.080260045@delta.onse.fi>
References: <20070111145115.405679742@delta.onse.fi>
User-Agent: quilt/0.45-1
Date: Thu, 11 Jan 2007 16:51:16 +0200
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch 1/3] hid: allow force feedback for multi-input devices
Content-Disposition: inline; filename=input-hid-allow-multi-input-ff.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow hid devices with HID_QUIRK_MULTI_INPUT to have force feedback.
This was previously disabled because there were not any force
feedback drivers for such devices. This will change with my upcoming
patch.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/usb/input/hid-core.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: linux-2.6.20-rc3-ptr/drivers/usb/input/hid-core.c
===================================================================
--- linux-2.6.20-rc3-ptr.orig/drivers/usb/input/hid-core.c	2007-01-06 00:38:41.000000000 +0200
+++ linux-2.6.20-rc3-ptr/drivers/usb/input/hid-core.c	2007-01-07 20:53:21.000000000 +0200
@@ -1315,11 +1315,7 @@ static int hid_probe(struct usb_interfac
 		return -ENODEV;
 	}
 
-	/* This only gets called when we are a single-input (most of the
-	 * time). IOW, not a HID_QUIRK_MULTI_INPUT. The hid_ff_init() is
-	 * only useful in this case, and not for multi-input quirks. */
-	if ((hid->claimed & HID_CLAIMED_INPUT) &&
-			!(hid->quirks & HID_QUIRK_MULTI_INPUT))
+	if ((hid->claimed & HID_CLAIMED_INPUT))
 		hid_ff_init(hid);
 
 	printk(KERN_INFO);

--
Anssi Hannula
