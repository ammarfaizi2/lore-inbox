Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130004AbRB1A1C>; Tue, 27 Feb 2001 19:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130016AbRB1A0v>; Tue, 27 Feb 2001 19:26:51 -0500
Received: from [199.183.24.200] ([199.183.24.200]:55921 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130004AbRB1A0j>; Tue, 27 Feb 2001 19:26:39 -0500
Date: Tue, 27 Feb 2001 19:26:32 -0500
From: Peter Zaitcev <zaitcev@redhat.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Patchlet for drivers/usb/hub.c
Message-ID: <20010227192632.A2143@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4.2-ac5/drivers/usb/hub.c	Tue Feb 27 15:52:05 2001
+++ linux-2.4.2-ac5-p3/drivers/usb/hub.c	Tue Feb 27 16:21:32 2001
@@ -150,14 +150,14 @@
 	unsigned int pipe;
 	int i, maxp, ret;
 
-	hub->descriptor = kmalloc(sizeof(hub->descriptor), GFP_KERNEL);
+	hub->descriptor = kmalloc(sizeof(*hub->descriptor), GFP_KERNEL);
 	if (!hub->descriptor) {
-		err("Unable to kmalloc %d bytes for hub descriptor", sizeof(hub->descriptor));
+		err("Unable to kmalloc %d bytes for hub descriptor", sizeof(*hub->descriptor));
 		return -1;
 	}
 
 	/* Request the entire hub descriptor. */
-	ret = usb_get_hub_descriptor(dev, hub->descriptor, sizeof(hub->descriptor));
+	ret = usb_get_hub_descriptor(dev, hub->descriptor, sizeof(*hub->descriptor));
 		/* <hub->descriptor> is large enough for a hub with 127 ports;
 		 * the hub can/will return fewer bytes here. */
 	if (ret < 0) {
