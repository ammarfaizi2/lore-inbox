Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbVLOJVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbVLOJVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422655AbVLOJS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:18:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:17578 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422653AbVLOJSk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:18:40 -0500
To: torvalds@osdl.org
Subject: [PATCH] ia64 sn __iomem annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpG4-00080O-3D@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:18:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 arch/ia64/sn/pci/pcibr/pcibr_reg.c |   48 ++++++++++++++++++------------------
 arch/ia64/sn/pci/tioca_provider.c  |   12 +++++----
 2 files changed, 30 insertions(+), 30 deletions(-)

947497f8f98ce10ff2ce4b81d4ad311dfd57f7ef
diff --git a/arch/ia64/sn/pci/pcibr/pcibr_reg.c b/arch/ia64/sn/pci/pcibr/pcibr_reg.c
index 5d53409..79fdb91 100644
--- a/arch/ia64/sn/pci/pcibr/pcibr_reg.c
+++ b/arch/ia64/sn/pci/pcibr/pcibr_reg.c
@@ -25,7 +25,7 @@ union br_ptr {
  */
 void pcireg_control_bit_clr(struct pcibus_info *pcibus_info, uint64_t bits)
 {
-	union br_ptr *ptr = (union br_ptr *)pcibus_info->pbi_buscommon.bs_base;
+	union br_ptr __iomem *ptr = (union br_ptr __iomem *)pcibus_info->pbi_buscommon.bs_base;
 
 	if (pcibus_info) {
 		switch (pcibus_info->pbi_bridge_type) {
@@ -38,14 +38,14 @@ void pcireg_control_bit_clr(struct pcibu
 		default:
 			panic
 			    ("pcireg_control_bit_clr: unknown bridgetype bridge 0x%p",
-			     (void *)ptr);
+			     ptr);
 		}
 	}
 }
 
 void pcireg_control_bit_set(struct pcibus_info *pcibus_info, uint64_t bits)
 {
-	union br_ptr *ptr = (union br_ptr *)pcibus_info->pbi_buscommon.bs_base;
+	union br_ptr __iomem *ptr = (union br_ptr __iomem *)pcibus_info->pbi_buscommon.bs_base;
 
 	if (pcibus_info) {
 		switch (pcibus_info->pbi_bridge_type) {
@@ -58,7 +58,7 @@ void pcireg_control_bit_set(struct pcibu
 		default:
 			panic
 			    ("pcireg_control_bit_set: unknown bridgetype bridge 0x%p",
-			     (void *)ptr);
+			     ptr);
 		}
 	}
 }
@@ -68,7 +68,7 @@ void pcireg_control_bit_set(struct pcibu
  */
 uint64_t pcireg_tflush_get(struct pcibus_info *pcibus_info)
 {
-	union br_ptr *ptr = (union br_ptr *)pcibus_info->pbi_buscommon.bs_base;
+	union br_ptr __iomem *ptr = (union br_ptr __iomem *)pcibus_info->pbi_buscommon.bs_base;
 	uint64_t ret = 0;
 
 	if (pcibus_info) {
@@ -82,7 +82,7 @@ uint64_t pcireg_tflush_get(struct pcibus
 		default:
 			panic
 			    ("pcireg_tflush_get: unknown bridgetype bridge 0x%p",
-			     (void *)ptr);
+			     ptr);
 		}
 	}
 
@@ -98,7 +98,7 @@ uint64_t pcireg_tflush_get(struct pcibus
  */
 uint64_t pcireg_intr_status_get(struct pcibus_info * pcibus_info)
 {
-	union br_ptr *ptr = (union br_ptr *)pcibus_info->pbi_buscommon.bs_base;
+	union br_ptr __iomem *ptr = (union br_ptr __iomem *)pcibus_info->pbi_buscommon.bs_base;
 	uint64_t ret = 0;
 
 	if (pcibus_info) {
@@ -112,7 +112,7 @@ uint64_t pcireg_intr_status_get(struct p
 		default:
 			panic
 			    ("pcireg_intr_status_get: unknown bridgetype bridge 0x%p",
-			     (void *)ptr);
+			     ptr);
 		}
 	}
 	return ret;
@@ -123,7 +123,7 @@ uint64_t pcireg_intr_status_get(struct p
  */
 void pcireg_intr_enable_bit_clr(struct pcibus_info *pcibus_info, uint64_t bits)
 {
-	union br_ptr *ptr = (union br_ptr *)pcibus_info->pbi_buscommon.bs_base;
+	union br_ptr __iomem *ptr = (union br_ptr __iomem *)pcibus_info->pbi_buscommon.bs_base;
 
 	if (pcibus_info) {
 		switch (pcibus_info->pbi_bridge_type) {
@@ -136,14 +136,14 @@ void pcireg_intr_enable_bit_clr(struct p
 		default:
 			panic
 			    ("pcireg_intr_enable_bit_clr: unknown bridgetype bridge 0x%p",
-			     (void *)ptr);
+			     ptr);
 		}
 	}
 }
 
 void pcireg_intr_enable_bit_set(struct pcibus_info *pcibus_info, uint64_t bits)
 {
-	union br_ptr *ptr = (union br_ptr *)pcibus_info->pbi_buscommon.bs_base;
+	union br_ptr __iomem *ptr = (union br_ptr __iomem *)pcibus_info->pbi_buscommon.bs_base;
 
 	if (pcibus_info) {
 		switch (pcibus_info->pbi_bridge_type) {
@@ -156,7 +156,7 @@ void pcireg_intr_enable_bit_set(struct p
 		default:
 			panic
 			    ("pcireg_intr_enable_bit_set: unknown bridgetype bridge 0x%p",
-			     (void *)ptr);
+			     ptr);
 		}
 	}
 }
@@ -167,7 +167,7 @@ void pcireg_intr_enable_bit_set(struct p
 void pcireg_intr_addr_addr_set(struct pcibus_info *pcibus_info, int int_n,
 			       uint64_t addr)
 {
-	union br_ptr *ptr = (union br_ptr *)pcibus_info->pbi_buscommon.bs_base;
+	union br_ptr __iomem *ptr = (union br_ptr __iomem *)pcibus_info->pbi_buscommon.bs_base;
 
 	if (pcibus_info) {
 		switch (pcibus_info->pbi_bridge_type) {
@@ -186,7 +186,7 @@ void pcireg_intr_addr_addr_set(struct pc
 		default:
 			panic
 			    ("pcireg_intr_addr_addr_get: unknown bridgetype bridge 0x%p",
-			     (void *)ptr);
+			     ptr);
 		}
 	}
 }
@@ -196,7 +196,7 @@ void pcireg_intr_addr_addr_set(struct pc
  */
 void pcireg_force_intr_set(struct pcibus_info *pcibus_info, int int_n)
 {
-	union br_ptr *ptr = (union br_ptr *)pcibus_info->pbi_buscommon.bs_base;
+	union br_ptr __iomem *ptr = (union br_ptr __iomem *)pcibus_info->pbi_buscommon.bs_base;
 
 	if (pcibus_info) {
 		switch (pcibus_info->pbi_bridge_type) {
@@ -209,7 +209,7 @@ void pcireg_force_intr_set(struct pcibus
 		default:
 			panic
 			    ("pcireg_force_intr_set: unknown bridgetype bridge 0x%p",
-			     (void *)ptr);
+			     ptr);
 		}
 	}
 }
@@ -219,7 +219,7 @@ void pcireg_force_intr_set(struct pcibus
  */
 uint64_t pcireg_wrb_flush_get(struct pcibus_info *pcibus_info, int device)
 {
-	union br_ptr *ptr = (union br_ptr *)pcibus_info->pbi_buscommon.bs_base;
+	union br_ptr __iomem *ptr = (union br_ptr __iomem *)pcibus_info->pbi_buscommon.bs_base;
 	uint64_t ret = 0;
 
 	if (pcibus_info) {
@@ -233,7 +233,7 @@ uint64_t pcireg_wrb_flush_get(struct pci
 			    __sn_readq_relaxed(&ptr->pic.p_wr_req_buf[device]);
 			break;
 		default:
-		      panic("pcireg_wrb_flush_get: unknown bridgetype bridge 0x%p", (void *)ptr);
+		      panic("pcireg_wrb_flush_get: unknown bridgetype bridge 0x%p", ptr);
 		}
 
 	}
@@ -244,7 +244,7 @@ uint64_t pcireg_wrb_flush_get(struct pci
 void pcireg_int_ate_set(struct pcibus_info *pcibus_info, int ate_index,
 			uint64_t val)
 {
-	union br_ptr *ptr = (union br_ptr *)pcibus_info->pbi_buscommon.bs_base;
+	union br_ptr __iomem *ptr = (union br_ptr __iomem *)pcibus_info->pbi_buscommon.bs_base;
 
 	if (pcibus_info) {
 		switch (pcibus_info->pbi_bridge_type) {
@@ -257,15 +257,15 @@ void pcireg_int_ate_set(struct pcibus_in
 		default:
 			panic
 			    ("pcireg_int_ate_set: unknown bridgetype bridge 0x%p",
-			     (void *)ptr);
+			     ptr);
 		}
 	}
 }
 
-uint64_t *pcireg_int_ate_addr(struct pcibus_info *pcibus_info, int ate_index)
+uint64_t __iomem *pcireg_int_ate_addr(struct pcibus_info *pcibus_info, int ate_index)
 {
-	union br_ptr *ptr = (union br_ptr *)pcibus_info->pbi_buscommon.bs_base;
-	uint64_t *ret = (uint64_t *) 0;
+	union br_ptr __iomem *ptr = (union br_ptr __iomem *)pcibus_info->pbi_buscommon.bs_base;
+	uint64_t __iomem *ret = NULL;
 
 	if (pcibus_info) {
 		switch (pcibus_info->pbi_bridge_type) {
@@ -278,7 +278,7 @@ uint64_t *pcireg_int_ate_addr(struct pci
 		default:
 			panic
 			    ("pcireg_int_ate_addr: unknown bridgetype bridge 0x%p",
-			     (void *)ptr);
+			     ptr);
 		}
 	}
 	return ret;
diff --git a/arch/ia64/sn/pci/tioca_provider.c b/arch/ia64/sn/pci/tioca_provider.c
index 46b646a..27aa184 100644
--- a/arch/ia64/sn/pci/tioca_provider.c
+++ b/arch/ia64/sn/pci/tioca_provider.c
@@ -38,10 +38,10 @@ tioca_gart_init(struct tioca_kernel *tio
 	uint64_t offset;
 	struct page *tmp;
 	struct tioca_common *tioca_common;
-	struct tioca *ca_base;
+	struct tioca __iomem *ca_base;
 
 	tioca_common = tioca_kern->ca_common;
-	ca_base = (struct tioca *)tioca_common->ca_common.bs_base;
+	ca_base = (struct tioca __iomem *)tioca_common->ca_common.bs_base;
 
 	if (list_empty(tioca_kern->ca_devices))
 		return 0;
@@ -215,7 +215,7 @@ tioca_fastwrite_enable(struct tioca_kern
 {
 	int cap_ptr;
 	uint32_t reg;
-	struct tioca *tioca_base;
+	struct tioca __iomem *tioca_base;
 	struct pci_dev *pdev;
 	struct tioca_common *common;
 
@@ -257,7 +257,7 @@ tioca_fastwrite_enable(struct tioca_kern
 	 * Set ca's fw to match
 	 */
 
-	tioca_base = (struct tioca *)common->ca_common.bs_base;
+	tioca_base = (struct tioca __iomem*)common->ca_common.bs_base;
 	__sn_setq_relaxed(&tioca_base->ca_control1, CA_AGP_FW_ENABLE);
 }
 
@@ -322,7 +322,7 @@ static uint64_t
 tioca_dma_d48(struct pci_dev *pdev, uint64_t paddr)
 {
 	struct tioca_common *tioca_common;
-	struct tioca *ca_base;
+	struct tioca __iomem *ca_base;
 	uint64_t ct_addr;
 	dma_addr_t bus_addr;
 	uint32_t node_upper;
@@ -330,7 +330,7 @@ tioca_dma_d48(struct pci_dev *pdev, uint
 	struct pcidev_info *pcidev_info = SN_PCIDEV_INFO(pdev);
 
 	tioca_common = (struct tioca_common *)pcidev_info->pdi_pcibus_info;
-	ca_base = (struct tioca *)tioca_common->ca_common.bs_base;
+	ca_base = (struct tioca __iomem *)tioca_common->ca_common.bs_base;
 
 	ct_addr = PHYS_TO_TIODMA(paddr);
 	if (!ct_addr)
-- 
0.99.9.GIT

