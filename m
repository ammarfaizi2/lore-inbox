Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264309AbTLKBqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTLKBar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:30:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:55503 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264326AbTLKBaK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:30:10 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1071106147533@kroah.com>
Subject: Re: [PATCH] USB Fixes for 2.6.0-test11
In-Reply-To: <10711061473166@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 10 Dec 2003 17:29:07 -0800
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1523, 2003/12/09 15:41:57-08:00, stern@rowland.harvard.edu

[PATCH] USB: fix bug not setting device state following usb_device_reset()


 drivers/usb/core/hub.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	Wed Dec 10 16:47:09 2003
+++ b/drivers/usb/core/hub.c	Wed Dec 10 16:47:09 2003
@@ -1345,6 +1345,7 @@
 			dev->devpath, ret);
 		return ret;
 	}
+	dev->state = USB_STATE_CONFIGURED;
 
 	for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++) {
 		struct usb_interface *intf = dev->actconfig->interface[i];

