Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261241AbVCEXom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVCEXom (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 5 Mar 2005 18:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVCEXmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:42:20 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:55706 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261245AbVCEXh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:37:58 -0500
Date: Sat, 05 Mar 2005 17:37:56 -0600 (CST)
Date-warning: Date header was inserted by vms044.mailsrvcs.net
From: James Nelson <james4765@cwazy.co.uk>
Subject: [PATCH 8/13] powermate: Clean up printk()'s in
 drivers/usb/input/powermate.c
In-reply-to: <20050305233712.7648.24364.93822@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-id: <20050305233755.7648.2198.68429@localhost.localdomain>
References: <20050305233712.7648.24364.93822@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add newlines and KERN_ constants to printk()s neeeding them in
drivers/usb/input/powermate.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -Nurp -x dontdiff-osdl --exclude='*~' linux-2.6.11-mm1-original/drivers/usb/input/powermate.c linux-2.6.11-mm1/drivers/usb/input/powermate.c
--- linux-2.6.11-mm1-original/drivers/usb/input/powermate.c	2005-03-05 13:29:48.000000000 -0500
+++ linux-2.6.11-mm1/drivers/usb/input/powermate.c	2005-03-05 15:46:40.000000000 -0500
@@ -170,7 +170,7 @@ static void powermate_sync_state(struct 
 		pm->configcr->wIndex = cpu_to_le16( pm->static_brightness );
 		pm->requires_update &= ~UPDATE_STATIC_BRIGHTNESS;
 	}else{
-		printk(KERN_ERR "powermate: unknown update required");
+		printk(KERN_ERR "powermate: unknown update required\n");
 		pm->requires_update = 0; /* fudge the bug */
 		return;
 	}
@@ -188,7 +188,7 @@ static void powermate_sync_state(struct 
 	pm->config->transfer_flags |= URB_NO_SETUP_DMA_MAP;
 
 	if (usb_submit_urb(pm->config, GFP_ATOMIC))
-		printk(KERN_ERR "powermate: usb_submit_urb(config) failed");
+		printk(KERN_ERR "powermate: usb_submit_urb(config) failed\n");
 }
 
 /* Called when our asynchronous control message completes. We may need to issue another immediately */
@@ -357,7 +357,7 @@ static int powermate_probe(struct usb_in
 	maxp = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
 
 	if(maxp < POWERMATE_PAYLOAD_SIZE_MIN || maxp > POWERMATE_PAYLOAD_SIZE_MAX){
-		printk("powermate: Expected payload of %d--%d bytes, found %d bytes!\n",
+		printk(KERN_WARNING "powermate: Expected payload of %d--%d bytes, found %d bytes!\n",
 			POWERMATE_PAYLOAD_SIZE_MIN, POWERMATE_PAYLOAD_SIZE_MAX, maxp);
 		maxp = POWERMATE_PAYLOAD_SIZE_MAX;
 	}
