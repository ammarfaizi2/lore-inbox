Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267495AbUHDXQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267495AbUHDXQZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUHDXQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:16:25 -0400
Received: from ozlabs.org ([203.10.76.45]:20121 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267495AbUHDXQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:16:23 -0400
Date: Thu, 5 Aug 2004 09:15:01 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH] [ppc64] Fix PCI allocation warning
Message-ID: <20040804231500.GZ30253@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Print the correct domain when a PCI resource allocation fails.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/pSeries_pci.c~pci-allocation-warning arch/ppc64/kernel/pSeries_pci.c
--- linux-2.6.8-rc2-mm2/arch/ppc64/kernel/pSeries_pci.c~pci-allocation-warning	2004-08-04 17:46:40.875894803 -0500
+++ linux-2.6.8-rc2-mm2-anton/arch/ppc64/kernel/pSeries_pci.c	2004-08-04 17:46:40.886893055 -0500
@@ -600,8 +600,9 @@ void __devinit pcibios_fixup_bus(struct 
 			BUG();	/* No I/O resource for this PHB? */
 
 		if (request_resource(&ioport_resource, res))
-			printk(KERN_ERR "Failed to request IO"
-					"on hose %d\n", 0 /* FIXME */);
+			printk(KERN_ERR "Failed to request IO on "
+					"PCI domain %d\n", pci_domain_nr(bus));
+
 
 		for (i = 0; i < 3; ++i) {
 			res = &hose->mem_resources[i];
@@ -609,8 +610,9 @@ void __devinit pcibios_fixup_bus(struct 
 				BUG();	/* No memory resource for this PHB? */
 			bus->resource[i+1] = res;
 			if (res->flags && request_resource(&iomem_resource, res))
-				printk(KERN_ERR "Failed to request MEM"
-						"on hose %d\n", 0 /* FIXME */);
+				printk(KERN_ERR "Failed to request MEM on "
+						"PCI domain %d\n",
+						pci_domain_nr(bus));
 		}
 	} else if (pci_probe_only &&
 		   (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {

_
