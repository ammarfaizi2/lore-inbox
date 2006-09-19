Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWISBo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWISBo3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 21:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbWISBo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 21:44:29 -0400
Received: from twin.jikos.cz ([213.151.79.26]:43154 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751325AbWISBo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 21:44:28 -0400
Date: Tue, 19 Sep 2006 03:44:15 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       dbrownell@users.sourceforge.net, weissg@vienna.at
Subject: [PATCH] USB: consolidate error values from EHCI,UHCI and OHCI
 _suspend()
Message-ID: <Pine.LNX.4.64.0609190340310.9787@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

EHCI, UHCI and OHCI USB host drivers are not consistent when returining 
error values from their _suspend() functions, in case that the device is 
not in suspended state. This could confuse users, so let all three of them 
return -EBUSY.

Patch against 2.6.18-rc6-mm2.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

--- linux-2.6.18-rc6-mm2.orig/drivers/usb/host/ehci-pci.c	2006-09-14 16:20:48.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/usb/host/ehci-pci.c	2006-09-19 03:20:22.000000000 +0200
@@ -232,7 +232,7 @@ static int ehci_pci_suspend(struct usb_h
 	 */
 	spin_lock_irqsave (&ehci->lock, flags);
 	if (hcd->state != HC_STATE_SUSPENDED) {
-		rc = -EINVAL;
+		rc = -EBUSY;
 		goto bail;
 	}
 	writel (0, &ehci->regs->intr_enable);
--- linux-2.6.18-rc6-mm2.orig/drivers/usb/host/ohci-pci.c	2006-09-14 16:20:48.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/usb/host/ohci-pci.c	2006-09-19 03:36:35.000000000 +0200
@@ -130,7 +130,7 @@ static int ohci_pci_suspend (struct usb_
 	 */
 	spin_lock_irqsave (&ohci->lock, flags);
 	if (hcd->state != HC_STATE_SUSPENDED) {
-		rc = -EINVAL;
+		rc = -EBUSY;
 		goto bail;
 	}
 	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);

-- 
Jiri Kosina
