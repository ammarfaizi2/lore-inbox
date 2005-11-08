Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbVKHUFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbVKHUFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 15:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVKHUFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 15:05:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15364 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030212AbVKHUFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 15:05:43 -0500
Date: Tue, 8 Nov 2005 21:05:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/core/message.c: make usb_get_string() static
Message-ID: <20051108200543.GF3847@stusta.de>
References: <20051108181239.GB3847@stusta.de> <20051108184638.GA15939@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108184638.GA15939@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the removal of usb-midi.c, there's no longer any external user of 
usb_get_string().


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/core/message.c |    5 ++---
 include/linux/usb.h        |    2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

--- linux-2.6.14-mm1-full/include/linux/usb.h.old	2005-11-08 18:42:15.000000000 +0100
+++ linux-2.6.14-mm1-full/include/linux/usb.h	2005-11-08 18:42:23.000000000 +0100
@@ -1004,8 +1004,6 @@
 	unsigned char descindex, void *buf, int size);
 extern int usb_get_status(struct usb_device *dev,
 	int type, int target, void *data);
-extern int usb_get_string(struct usb_device *dev,
-	unsigned short langid, unsigned char index, void *buf, int size);
 extern int usb_string(struct usb_device *dev, int index,
 	char *buf, size_t size);
 
--- linux-2.6.14-mm1-full/drivers/usb/core/message.c.old	2005-11-08 18:42:32.000000000 +0100
+++ linux-2.6.14-mm1-full/drivers/usb/core/message.c	2005-11-08 18:42:58.000000000 +0100
@@ -637,8 +637,8 @@
  * Returns the number of bytes received on success, or else the status code
  * returned by the underlying usb_control_msg() call.
  */
-int usb_get_string(struct usb_device *dev, unsigned short langid,
-		unsigned char index, void *buf, int size)
+static int usb_get_string(struct usb_device *dev, unsigned short langid,
+			  unsigned char index, void *buf, int size)
 {
 	int i;
 	int result;
@@ -1488,7 +1488,6 @@
 // synchronous control message convenience routines
 EXPORT_SYMBOL(usb_get_descriptor);
 EXPORT_SYMBOL(usb_get_status);
-EXPORT_SYMBOL(usb_get_string);
 EXPORT_SYMBOL(usb_string);
 
 // synchronous calls that also maintain usbcore state

