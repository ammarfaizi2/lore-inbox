Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270234AbUJTBz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270234AbUJTBz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUJTAvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:51:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:3508 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266768AbUJTAT3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:29 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315052474@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:25 -0700
Message-Id: <1098231505320@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1939.9.4, 2004/09/29 11:03:48-07:00, greg@kroah.com

I2C: convert scx200_acb driver to not use pci_find_device

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/scx200_acb.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- a/drivers/i2c/busses/scx200_acb.c	2004-10-19 16:54:40 -07:00
+++ b/drivers/i2c/busses/scx200_acb.c	2004-10-19 16:54:40 -07:00
@@ -503,6 +503,12 @@
 	return rc;
 }
 
+static struct pci_device_id scx200[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_BRIDGE) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SC1100_BRIDGE) },
+	{ },
+};
+
 static int __init scx200_acb_init(void)
 {
 	int i;
@@ -511,12 +517,7 @@
 	pr_debug(NAME ": NatSemi SCx200 ACCESS.bus Driver\n");
 
 	/* Verify that this really is a SCx200 processor */
-	if (pci_find_device(PCI_VENDOR_ID_NS,
-			    PCI_DEVICE_ID_NS_SCx200_BRIDGE,
-			    NULL) == NULL
-	    && pci_find_device(PCI_VENDOR_ID_NS,
-			       PCI_DEVICE_ID_NS_SC1100_BRIDGE,
-			       NULL) == NULL)
+	if (pci_dev_present(scx200) == 0)
 		return -ENODEV;
 
 	rc = -ENXIO;

