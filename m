Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030498AbVKIBJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbVKIBJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 20:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbVKIBJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 20:09:32 -0500
Received: from outmx014.isp.belgacom.be ([195.238.2.69]:52369 "EHLO
	outmx014.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030498AbVKIBJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 20:09:31 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: Replace kcalloc(1, with kzalloc.
Cc: davidm@hpl.hp.com, eranian@hpl.hp.com
Message-Id: <20051109010842.5FCE220A1A@localhost.localdomain>
Date: Wed,  9 Nov 2005 02:08:42 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Conversion from kcalloc(1, to kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 arch/ia64/kernel/efi.c            |    2 +-
 arch/ia64/sn/kernel/io_init.c     |    2 +-
 arch/ia64/sn/pci/tioce_provider.c |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

applies-to: 9bdf86f4869b687a234501a47b32621ddaa19154
3388b4701a81a40bc2d567ffe0d005e3a153dbc9
diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index f72ea6a..a3aa45c 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -987,7 +987,7 @@ efi_initialize_iomem_resources(struct re
 				break;
 		}
 
-		if ((res = kcalloc(1, sizeof(struct resource), GFP_KERNEL)) == NULL) {
+		if ((res = kzalloc(sizeof(struct resource), GFP_KERNEL)) == NULL) {
 			printk(KERN_ERR "failed to alocate resource for iomem\n");
 			return;
 		}
diff --git a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
index b4f5053..05e4ea8 100644
--- a/arch/ia64/sn/kernel/io_init.c
+++ b/arch/ia64/sn/kernel/io_init.c
@@ -349,7 +349,7 @@ void sn_pci_controller_fixup(int segment
 		return;		/*bus # does not exist */
 	prom_bussoft_ptr = __va(prom_bussoft_ptr);
 
- 	controller = kcalloc(1,sizeof(struct pci_controller), GFP_KERNEL);
+ 	controller = kzalloc(sizeof(struct pci_controller), GFP_KERNEL);
 	controller->segment = segment;
  	if (!controller)
  		BUG();
diff --git a/arch/ia64/sn/pci/tioce_provider.c b/arch/ia64/sn/pci/tioce_provider.c
index 9f03d4e..dda196c 100644
--- a/arch/ia64/sn/pci/tioce_provider.c
+++ b/arch/ia64/sn/pci/tioce_provider.c
@@ -218,7 +218,7 @@ tioce_alloc_map(struct tioce_kernel *ce_
 	if (i > last)
 		return 0;
 
-	map = kcalloc(1, sizeof(struct tioce_dmamap), GFP_ATOMIC);
+	map = kzalloc(sizeof(struct tioce_dmamap), GFP_ATOMIC);
 	if (!map)
 		return 0;
 
@@ -555,7 +555,7 @@ tioce_kern_init(struct tioce_common *tio
 	struct tioce *tioce_mmr;
 	struct tioce_kernel *tioce_kern;
 
-	tioce_kern = kcalloc(1, sizeof(struct tioce_kernel), GFP_KERNEL);
+	tioce_kern = kzalloc(sizeof(struct tioce_kernel), GFP_KERNEL);
 	if (!tioce_kern) {
 		return NULL;
 	}
@@ -727,7 +727,7 @@ tioce_bus_fixup(struct pcibus_bussoft *p
 	 * Allocate kernel bus soft and copy from prom.
 	 */
 
-	tioce_common = kcalloc(1, sizeof(struct tioce_common), GFP_KERNEL);
+	tioce_common = kzalloc(sizeof(struct tioce_common), GFP_KERNEL);
 	if (!tioce_common)
 		return NULL;
 
---
0.99.9.GIT
