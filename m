Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbUKJTWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbUKJTWV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbUKJTWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:22:21 -0500
Received: from fmr12.intel.com ([134.134.136.15]:25568 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S262105AbUKJTWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:22:10 -0500
Date: Wed, 10 Nov 2004 11:38:58 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200411101938.iAAJcwNU030100@snoqualmie.dp.intel.com>
To: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] pci-mmconfig fix for 2.6.9
Cc: akpm@osdl.org, sundarapandian.durairaj@intel.com, tom.l.nguyen@intel.com,
       willy@debian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 9:36 Greg KH wrote:
> Your patch is line wrapped, and mime encoded.

On behalf of Sundar, I redo it.
Signed-off-by: Sundarapandian Durairaj

Thanks,
Long
---------------------------------------------------------------
diff -Naur linux-2.6.9/arch/i386/pci/mmconfig.c pcie-fix-linux-2.6.9/arch/i386/pci/mmconfig.c
--- linux-2.6.9/arch/i386/pci/mmconfig.c	2004-10-19 03:24:38.000000000 +0530
+++ pcie-fix-linux-2.6.9/arch/i386/pci/mmconfig.c	2004-11-04 11:35:36.029054848 +0530
@@ -30,7 +30,7 @@
 	u32 dev_base = pci_mmcfg_base_addr | (bus << 20) | (devfn << 12);
 	if (dev_base != mmcfg_last_accessed_device) {
 		mmcfg_last_accessed_device = dev_base;
-		set_fixmap(FIX_PCIE_MCFG, dev_base);
+		set_fixmap_nocache(FIX_PCIE_MCFG, dev_base);
 	}
 }
 
@@ -85,9 +85,6 @@
 		break;
 	}
 
-	/* Dummy read to flush PCI write */
-	readl(mmcfg_virt_addr);
-
 	spin_unlock_irqrestore(&pci_config_lock, flags);
 
 	return 0;
diff -Naur linux-2.6.9/arch/x86_64/pci/mmconfig.c pcie-fix-linux-2.6.9/arch/x86_64/pci/mmconfig.c
--- linux-2.6.9/arch/x86_64/pci/mmconfig.c	2004-10-19 03:23:41.000000000 +0530
+++ pcie-fix-linux-2.6.9/arch/x86_64/pci/mmconfig.c	2004-11-04 11:39:21.989703608 +0530
@@ -63,9 +63,6 @@
 		break;
 	}
 
-	/* Dummy read to flush PCI write */
-	readl(addr);
-
 	return 0;
 }
 
