Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbTDYASr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTDXXf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:35:28 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:20392 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264494AbTDXXeG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280511591@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <1051228051504@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:31 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.3, 2003/04/23 12:05:10-07:00, david-b@pacbell.net

[PATCH] USB: hcd-pci.c catch up to dev_printk changes

The preceding patch to fix this was incomplete, since
it didn't work for the pure debug messages.  And that
was because the DEBUG-vs-CONFIG_USB_DEBUG stuff changed
somewhere.


 drivers/usb/core/hcd-pci.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


diff -Nru a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
--- a/drivers/usb/core/hcd-pci.c	Thu Apr 24 16:28:14 2003
+++ b/drivers/usb/core/hcd-pci.c	Thu Apr 24 16:28:14 2003
@@ -17,11 +17,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <asm/io.h>
-#include <asm/irq.h>
 
 #ifdef CONFIG_USB_DEBUG
 	#define DEBUG
@@ -29,6 +24,11 @@
 	#undef DEBUG
 #endif
 
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <asm/irq.h>
 #include <linux/usb.h>
 #include "hcd.h"
 
@@ -214,7 +214,7 @@
 	hub = hcd->self.root_hub;
 	hcd->state = USB_STATE_QUIESCING;
 
-	dev_dbg (*hcd->controller, "roothub graceful disconnect\n");
+	dev_dbg (hcd->controller, "roothub graceful disconnect\n");
 	usb_disconnect (&hub);
 
 	hcd->driver->stop (hcd);
@@ -326,7 +326,7 @@
 
 	retval = -EBUSY;
 	if (hcd->state != USB_STATE_SUSPENDED) {
-		dev_dbg (*hcd->controller, "can't resume, not suspended!\n");
+		dev_dbg (hcd->controller, "can't resume, not suspended!\n");
 		goto done;
 	}
 	hcd->state = USB_STATE_RESUMING;
@@ -336,7 +336,7 @@
 
 	retval = hcd->driver->resume (hcd);
 	if (!HCD_IS_RUNNING (hcd->state)) {
-		dev_dbg (*hcd->controller, "resume fail, retval %d\n", retval);
+		dev_dbg (hcd->controller, "resume fail, retval %d\n", retval);
 		usb_hc_died (hcd);
 // FIXME:  recover, reset etc.
 	} else {

