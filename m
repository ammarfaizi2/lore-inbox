Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVAHJaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVAHJaC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVAHJVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:21:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:33669 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261836AbVAHFsJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:09 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632662317@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:46 -0800
Message-Id: <11051632662253@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.27, 2004/12/15 16:38:01-08:00, david-b@pacbell.net

[PATCH] USB: better messages for "no-IRQ" cases (15/15)

This changes the usbcore message about HCD IRQ problems so it makes
sense on systems without ACPI or an APIC.  It also updates the comments;
the issue doesn't appiear only with PCI, and with the recent enumeration
changes it doesn't happen just with set_address either.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/core/hcd.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)


diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	2005-01-07 15:47:52 -08:00
+++ b/drivers/usb/core/hcd.c	2005-01-07 15:47:52 -08:00
@@ -1251,13 +1251,14 @@
 		goto done;
 	}
 
-	/* PCI IRQ setup can easily be broken so that USB controllers
+	/* IRQ setup can easily be broken so that USB controllers
 	 * never get completion IRQs ... maybe even the ones we need to
-	 * finish unlinking the initial failed usb_set_address().
+	 * finish unlinking the initial failed usb_set_address()
+	 * or device descriptor fetch.
 	 */
 	if (!hcd->saw_irq && hcd->self.root_hub != urb->dev) {
 		dev_warn (hcd->self.controller, "Unlink after no-IRQ?  "
-			"Different ACPI or APIC settings may help."
+			"Controller is probably using the wrong IRQ."
 			"\n");
 		hcd->saw_irq = 1;
 	}

