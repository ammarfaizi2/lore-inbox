Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269640AbUJAAiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269640AbUJAAiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 20:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269639AbUJAAiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 20:38:15 -0400
Received: from 10.69-93-172.reverse.theplanet.com ([69.93.172.10]:6101 "EHLO
	gsf.ironcreek.net") by vger.kernel.org with ESMTP id S269640AbUJAAiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 20:38:04 -0400
Date: Thu, 30 Sep 2004 19:39:47 -0500
From: Andre Eisenbach <andre@eisenbach.com>
To: akpm@osdl.org, bjorn.helgaas@hp.com
Cc: Andre Eisenbach <andre@eisenbach.com>, linux-kernel@vger.kernel.org
Message-Id: <20041001003638.11038.64652.40892@localhost>
Subject: [PATCH] ohci_hcd: ALi USB M5237 host controller init quirk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an error (init error -75) when initializing the ALi M5237 host controller which otherwise renders the USB bus inoperable.

Patch has been tested successfully on a Compaq Presario 2100z notebook.

Signed-off-by: Andre Eisenbach <andre@eisenbach.com>

--- previous/drivers/usb/host/ohci-pci.c	2004-09-23 09:29:02.000000000 -0700
+++ current/drivers/usb/host/ohci-pci.c	2004-09-30 17:02:24.000000000 -0700
@@ -94,6 +94,13 @@
 			ohci->flags = OHCI_QUIRK_INITRESET;
 			ohci_info(ohci, "SiS init quirk\n");
 		}
+
+		/* ALi USB 1.1 controller fails init without this */
+		else if (pdev->vendor == PCI_VENDOR_ID_AL
+				&& pdev->device == PCI_DEVICE_ID_AL_M5237) {
+			ohci->flags = OHCI_QUIRK_INITRESET;
+			ohci_info(ohci, "ALi M5237 init quirk\n");
+		}
 	
 	}
 
