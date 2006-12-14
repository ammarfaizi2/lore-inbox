Return-Path: <linux-kernel-owner+w=401wt.eu-S932732AbWLNN4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbWLNN4m (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbWLNN4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:56:42 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:4745 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932732AbWLNN4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:56:41 -0500
Date: Thu, 14 Dec 2006 13:56:36 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
cc: linux-fbdev-devel@lists.sourceforge.net, axp-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19 7/6] tgafb: Fix the PCI ID table
Message-ID: <Pine.LNX.4.64N.0612141349590.12201@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 The end marker is missing from the driver's PCI ID table.  This set of 
changes adds the marker, switches to using PCI_DEVICE() and records the 
table for the use in a module.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Here's one more. ;-)

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tgafb-pci_tbl-0
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c linux-mips-2.6.18-20060920/drivers/video/tgafb.c
--- linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c	2006-09-20 20:50:52.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/tgafb.c	2006-12-14 00:55:35.000000000 +0000
@@ -69,9 +69,10 @@ static struct fb_ops tgafb_ops = {
  */
 
 static struct pci_device_id const tgafb_pci_table[] = {
-	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TGA, PCI_ANY_ID, PCI_ANY_ID,
-	  0, 0, 0 }
+	{ PCI_DEVICE(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TGA) },
+	{ }
 };
+MODULE_DEVICE_TABLE(pci, tgafb_pci_table);
 
 static struct pci_driver tgafb_driver = {
 	.name			= "tgafb",
