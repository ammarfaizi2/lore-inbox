Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267508AbUJTDgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUJTDgT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 23:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270103AbUJTAcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:32:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:8884 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267313AbUJTATb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:31 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315053127@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:25 -0700
Message-Id: <10982315052474@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1939.9.3, 2004/09/29 11:01:14-07:00, greg@kroah.com

I2C: change i2c-elektor.c driver from using pci_find_device()

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-elektor.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	2004-10-19 16:54:45 -07:00
+++ b/drivers/i2c/busses/i2c-elektor.c	2004-10-19 16:54:45 -07:00
@@ -180,11 +180,10 @@
 	/* check to see we have memory mapped PCF8584 connected to the 
 	Cypress cy82c693 PCI-ISA bridge as on UP2000 board */
 	if (base == 0) {
+		struct pci_dev *cy693_dev;
 		
-		struct pci_dev *cy693_dev =
-                    pci_find_device(PCI_VENDOR_ID_CONTAQ, 
-		                    PCI_DEVICE_ID_CONTAQ_82C693, NULL);
-
+		cy693_dev = pci_get_device(PCI_VENDOR_ID_CONTAQ, 
+					   PCI_DEVICE_ID_CONTAQ_82C693, NULL);
 		if (cy693_dev) {
 			char config;
 			/* yeap, we've found cypress, let's check config */
@@ -215,6 +214,7 @@
 					printk(KERN_INFO "i2c-elektor: found API UP2000 like board, will probe PCF8584 later.\n");
 				}
 			}
+			pci_dev_put(cy693_dev);
 		}
 	}
 #endif

