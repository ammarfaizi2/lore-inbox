Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161099AbWBAPrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbWBAPrN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWBAPrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:47:13 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:36487 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161099AbWBAPrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:47:12 -0500
Date: Wed, 1 Feb 2006 10:47:11 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: [PATCH] usbcore: fix compile error with CONFIG_USB_SUSPEND=n
In-Reply-To: <20060131214432.566abcff.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0602011044270.5635-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as647) fixes a small error introduced by a recent change to 
the USB core suspend/resume code.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---


On Tue, 31 Jan 2006, Andrew Morton wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> >
> > drivers/usb/core/hub.c: In function `usb_resume_device':
> > drivers/usb/core/hub.c:1879: warning: `status' might be used uninitialized in this function
> > 
> > And yes, with CONFIG_USB_SUSPEND=n it is indeed buggy.
> > 
> > Can we please tighten things up a bit over there?
> 
> This bug is still present in Greg's tree.

This should fix it.

Alan Stern


Index: usb-2.6/drivers/usb/core/hub.c
===================================================================
--- usb-2.6.orig/drivers/usb/core/hub.c
+++ usb-2.6/drivers/usb/core/hub.c
@@ -1890,8 +1890,8 @@ int usb_resume_device(struct usb_device 
 			status = hub_port_resume(hdev_to_hub(udev->parent),
 					udev->portnum, udev);
 		} else
-			status = 0;
 #endif
+			status = 0;
 	} else
 		status = finish_device_resume(udev);
 	if (status < 0)

