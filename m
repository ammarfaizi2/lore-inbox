Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269121AbUJTS7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269121AbUJTS7n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269102AbUJTS4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:56:21 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:16366 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268989AbUJTSzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:55:17 -0400
Date: Wed, 20 Oct 2004 11:55:14 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: Hanna Linder <hannal@us.ibm.com>, greg@kroah.com, davej@codemonkey.org.uk
Subject: [RFT 2.6] sis-agp.c: replace pci_find_device with pci_get_device
Message-ID: <18870000.1098298514@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away soon I have converted this file to use
pci_get_device instead. for_each_pci_dev is a macro wrapper around
pci_get_device.  I have compile tested it. If anyone has this hardware
and could test it that would be great.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
---

diff -Nrup linux-2.6.9cln/drivers/char/agp/sis-agp.c linux-2.6.9patch2/drivers/char/agp/sis-agp.c
--- linux-2.6.9cln/drivers/char/agp/sis-agp.c	2004-10-18 16:35:52.000000000 -0700
+++ linux-2.6.9patch2/drivers/char/agp/sis-agp.c	2004-10-19 15:52:32.000000000 -0700
@@ -85,7 +85,7 @@ static void sis_delayed_enable(u32 mode)
 	command |= AGPSTAT_AGP_ENABLE;
 	rate = (command & 0x7) << 2;
 
-	while ((device = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL) {
+	for_each_pci_dev(device) {
 		u8 agp = pci_find_capability(device, PCI_CAP_ID_AGP);
 		if (!agp)
 			continue;

