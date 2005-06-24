Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263120AbVFXEIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbVFXEIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVFXEEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:04:43 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263084AbVFXEEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:21 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 02/14] IB/mthca: Clean up error messages
In-Reply-To: <2005623214.8M2FOQ4JBL5cpK2n@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:20 -0700
Message-Id: <2005623214.mXu9RTJT2MIk7KOo@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:20.0605 (UTC) FILETIME=[CC69CAD0:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernhard Fischer <berny.f@aon.at>

- Fix incorrect cut-n-paste in error messages.
- Add missing newlines in error messages.
- Use DRV_NAME instead of "ib_mthca" in a couple of places.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 linux.git/drivers/infiniband/hw/mthca/mthca_eq.c   |    9 +++------
 linux.git/drivers/infiniband/hw/mthca/mthca_main.c |    6 +++---
 2 files changed, 6 insertions(+), 9 deletions(-)



--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_eq.c	2005-06-23 13:03:02.247630576 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_eq.c	2005-06-23 13:03:03.703315530 -0700
@@ -615,8 +615,7 @@ static void mthca_free_eq(struct mthca_d
 	if (err)
 		mthca_warn(dev, "HW2SW_EQ failed (%d)\n", err);
 	if (status)
-		mthca_warn(dev, "HW2SW_EQ returned status 0x%02x\n",
-			   status);
+		mthca_warn(dev, "HW2SW_EQ returned status 0x%02x\n", status);
 
 	dev->eq_table.arm_mask &= ~eq->eqn_mask;
 
@@ -709,8 +708,7 @@ static int __devinit mthca_map_eq_regs(s
 		if (mthca_map_reg(dev, ((pci_resource_len(dev->pdev, 0) - 1) &
 					dev->fw.arbel.eq_arm_base) + 4, 4,
 				  &dev->eq_regs.arbel.eq_arm)) {
-			mthca_err(dev, "Couldn't map interrupt clear register, "
-				  "aborting.\n");
+			mthca_err(dev, "Couldn't map EQ arm register, aborting.\n");
 			mthca_unmap_reg(dev, (pci_resource_len(dev->pdev, 0) - 1) &
 					dev->fw.arbel.clr_int_base, MTHCA_CLR_INT_SIZE,
 					dev->clr_base);
@@ -721,8 +719,7 @@ static int __devinit mthca_map_eq_regs(s
 				  dev->fw.arbel.eq_set_ci_base,
 				  MTHCA_EQ_SET_CI_SIZE,
 				  &dev->eq_regs.arbel.eq_set_ci_base)) {
-			mthca_err(dev, "Couldn't map interrupt clear register, "
-				  "aborting.\n");
+			mthca_err(dev, "Couldn't map EQ CI register, aborting.\n");
 			mthca_unmap_reg(dev, ((pci_resource_len(dev->pdev, 0) - 1) &
 					      dev->fw.arbel.eq_arm_base) + 4, 4,
 					dev->eq_regs.arbel.eq_arm);
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-06-23 13:03:02.630547703 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_main.c	2005-06-23 13:03:03.703315530 -0700
@@ -70,7 +70,7 @@ MODULE_PARM_DESC(msi, "attempt to use MS
 #endif /* CONFIG_PCI_MSI */
 
 static const char mthca_version[] __devinitdata =
-	"ib_mthca: Mellanox InfiniBand HCA driver v"
+	DRV_NAME ": Mellanox InfiniBand HCA driver v"
 	DRV_VERSION " (" DRV_RELDATE ")\n";
 
 static struct mthca_profile default_profile = {
@@ -928,13 +928,13 @@ static int __devinit mthca_init_one(stru
 	 */
 	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
 	    pci_resource_len(pdev, 0) != 1 << 20) {
-		dev_err(&pdev->dev, "Missing DCS, aborting.");
+		dev_err(&pdev->dev, "Missing DCS, aborting.\n");
 		err = -ENODEV;
 		goto err_disable_pdev;
 	}
 	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM) ||
 	    pci_resource_len(pdev, 2) != 1 << 23) {
-		dev_err(&pdev->dev, "Missing UAR, aborting.");
+		dev_err(&pdev->dev, "Missing UAR, aborting.\n");
 		err = -ENODEV;
 		goto err_disable_pdev;
 	}
@@ -1164,7 +1164,7 @@ static struct pci_device_id mthca_pci_ta
 MODULE_DEVICE_TABLE(pci, mthca_pci_table);
 
 static struct pci_driver mthca_driver = {
-	.name		= "ib_mthca",
+	.name		= DRV_NAME,
 	.id_table	= mthca_pci_table,
 	.probe		= mthca_init_one,
 	.remove		= __devexit_p(mthca_remove_one)

