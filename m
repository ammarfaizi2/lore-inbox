Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268836AbUJUJRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268836AbUJUJRe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268900AbUJUJNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:13:20 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:10425 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269092AbUJTSyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:54:23 -0400
Date: Wed, 20 Oct 2004 11:54:04 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: Hanna Linder <hannal@us.ibm.com>, greg@kroah.com, davej@codemonkey.org.uk
Subject: [RFT 2.6] isoch.c: replace pci_find_device with pci_get_device
Message-ID: <18340000.1098298444@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away soon I have converted this file to use
pci_get_device instead. for_each_pci_dev is just a macro wrapper around
pci_get_device.  I have compile tested it. If anyone has this hardware
and could test it that would be great.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
---
diff -Nrup linux-2.6.9cln/drivers/char/agp/isoch.c linux-2.6.9patch/drivers/char/agp/isoch.c
--- linux-2.6.9cln/drivers/char/agp/isoch.c	2004-10-18 16:35:52.000000000 -0700
+++ linux-2.6.9patch/drivers/char/agp/isoch.c	2004-10-19 16:02:16.634192424 -0700
@@ -347,7 +347,7 @@ int agp_3_5_enable(struct agp_bridge_dat
 	INIT_LIST_HEAD(head);
 
 	/* Find all AGP devices, and add them to dev_list. */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		mcapndx = pci_find_capability(dev, PCI_CAP_ID_AGP);
 		if (mcapndx == 0)
 			continue;

