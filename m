Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269989AbTGLIKU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 04:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269990AbTGLIKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 04:10:20 -0400
Received: from mail.tbdnetworks.com ([63.209.25.99]:47878 "EHLO stargazer")
	by vger.kernel.org with ESMTP id S269989AbTGLIKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 04:10:16 -0400
Date: Sat, 12 Jul 2003 01:24:59 -0700
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix to debug code in arch/i386/pci/legacy.c
Message-ID: <20030712082459.GA10941@defiant>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch fixes a leftover from a patch which went in around 2.5.72
(emailed to the author of the patch which forgot to fix the debug code,
but no reply).

--nk

--- linux-2.5/arch/i386/pci/legacy.c-orig	2003-07-04 13:42:36.000000000 -0700
+++ linux-2.5/arch/i386/pci/legacy.c	2003-07-04 13:42:48.000000000 -0700
@@ -24,7 +24,7 @@
 		for (devfn = 0; devfn < 256; devfn += 8) {
 			if (!raw_pci_ops->read(0, n, devfn, PCI_VENDOR_ID, 2, &l) &&
 			    l != 0x0000 && l != 0xffff) {
-				DBG("Found device at %02x:%02x [%04x]\n", n, dev->devfn, l);
+				DBG("Found device at %02x:%02x [%04x]\n", n, devfn, l);
 				printk(KERN_INFO "PCI: Discovered peer bus %02x\n", n);
 				pci_scan_bus(n, &pci_root_ops, NULL);
 				break;
