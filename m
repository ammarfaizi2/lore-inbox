Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUDMVcb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 17:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263774AbUDMVcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 17:32:31 -0400
Received: from aun.it.uu.se ([130.238.12.36]:29139 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263770AbUDMVca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 17:32:30 -0400
Date: Tue, 13 Apr 2004 23:32:15 +0200 (MEST)
Message-Id: <200404132132.i3DLWFml005032@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: [PATCH] 2.6.5-bk1 on x86-64 linkage error
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

2.6.5-bk1 on x86-64 with CONFIG_GART_IOMMU=n fails to
link due to undefined references to iommu_aperture_allowed
and iommu_aperture_disabled. Fixed by the patch below.

/Mikael

--- linux-2.6.5-bk1/arch/x86_64/kernel/io_apic.c.~1~	2004-04-13 21:18:26.000000000 +0200
+++ linux-2.6.5-bk1/arch/x86_64/kernel/io_apic.c	2004-04-13 23:01:32.000000000 +0200
@@ -250,12 +250,14 @@
 				vendor &= 0xffff;
 				switch (vendor) { 
 				case PCI_VENDOR_ID_VIA:
+#ifdef CONFIG_GART_IOMMU
 					if (end_pfn >= (0xffffffff>>PAGE_SHIFT) &&
 					    !iommu_aperture_allowed) {
 						printk(KERN_INFO
     "Looks like a VIA chipset. Disabling IOMMU. Overwrite with \"iommu=allowed\"\n");
 						iommu_aperture_disabled = 1;
 					}
+#endif
 					/* FALL THROUGH */
 				case PCI_VENDOR_ID_NVIDIA:
 #ifndef CONFIG_SMP
