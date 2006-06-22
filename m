Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWFVVDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWFVVDf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWFVVDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:03:35 -0400
Received: from havoc.gtf.org ([69.61.125.42]:33664 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964909AbWFVVDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:03:34 -0400
Date: Thu, 22 Jun 2006 16:59:28 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86-64 build fix
Message-ID: <20060622205928.GA23801@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As of last night, I still needed the Kconfig patch below to
successfully build allmodconfig on x86-64.  I believe Andrew has the
patch with a proper description and attribution, so I would prefer
that he send it...

	Jeff




diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 408d44a..7d3bc5a 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -389,6 +389,7 @@ config GART_IOMMU
 	bool "K8 GART IOMMU support"
 	default y
 	select SWIOTLB
+	select AGP
 	depends on PCI
 	help
 	  Support for hardware IOMMU in AMD's Opteron/Athlon64 Processors
@@ -401,11 +402,9 @@ config GART_IOMMU
   	  northbridge and a software emulation used on other systems without
 	  hardware IOMMU.  If unsure, say Y.
 
-# need this always enabled with GART_IOMMU for the VIA workaround
+# need this always selected by GART_IOMMU for the VIA workaround
 config SWIOTLB
 	bool
-	default y
-	depends on GART_IOMMU
 
 config X86_MCE
 	bool "Machine check support" if EMBEDDED
diff --git a/drivers/char/agp/Kconfig b/drivers/char/agp/Kconfig
index 7c88c06..46685a5 100644
--- a/drivers/char/agp/Kconfig
+++ b/drivers/char/agp/Kconfig
@@ -1,7 +1,6 @@
 config AGP
-	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU
+	tristate "/dev/agpgart (AGP Support)"
 	depends on ALPHA || IA64 || PPC || X86
-	default y if GART_IOMMU
 	---help---
 	  AGP (Accelerated Graphics Port) is a bus system mainly used to
 	  connect graphics cards to the rest of the system.
