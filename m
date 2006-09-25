Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWIYByE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWIYByE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWIYByE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:54:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47848 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932218AbWIYByB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:54:01 -0400
Date: Mon, 25 Sep 2006 02:53:53 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] qla3xxx iomem annotations
Message-ID: <20060925015353.GC29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the driver is still shite, though...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/qla3xxx.c |   49 ++++++++++++++++++++++++-------------------------
 drivers/net/qla3xxx.h |    2 +-
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/net/qla3xxx.c b/drivers/net/qla3xxx.c
index 09a481a..c184cd8 100644
--- a/drivers/net/qla3xxx.c
+++ b/drivers/net/qla3xxx.c
@@ -189,31 +189,31 @@ static u32 ql_read_page0_reg(struct ql3_
 }
 
 static void ql_write_common_reg_l(struct ql3_adapter *qdev,
-				u32 * reg, u32 value)
+				u32 __iomem *reg, u32 value)
 {
 	unsigned long hw_flags;
 
 	spin_lock_irqsave(&qdev->hw_lock, hw_flags);
-	writel(value, (u32 *) reg);
+	writel(value, reg);
 	readl(reg);
 	spin_unlock_irqrestore(&qdev->hw_lock, hw_flags);
 	return;
 }
 
 static void ql_write_common_reg(struct ql3_adapter *qdev,
-				u32 * reg, u32 value)
+				u32 __iomem *reg, u32 value)
 {
-	writel(value, (u32 *) reg);
+	writel(value, reg);
 	readl(reg);
 	return;
 }
 
 static void ql_write_page0_reg(struct ql3_adapter *qdev,
-			       u32 * reg, u32 value)
+			       u32 __iomem *reg, u32 value)
 {
 	if (qdev->current_page != 0)
 		ql_set_register_page(qdev,0);
-	writel(value, (u32 *) reg);
+	writel(value, reg);
 	readl(reg);
 	return;
 }
@@ -222,11 +222,11 @@ static void ql_write_page0_reg(struct ql
  * Caller holds hw_lock. Only called during init.
  */
 static void ql_write_page1_reg(struct ql3_adapter *qdev,
-			       u32 * reg, u32 value)
+			       u32 __iomem *reg, u32 value)
 {
 	if (qdev->current_page != 1)
 		ql_set_register_page(qdev,1);
-	writel(value, (u32 *) reg);
+	writel(value, reg);
 	readl(reg);
 	return;
 }
@@ -235,11 +235,11 @@ static void ql_write_page1_reg(struct ql
  * Caller holds hw_lock. Only called during init.
  */
 static void ql_write_page2_reg(struct ql3_adapter *qdev,
-			       u32 * reg, u32 value)
+			       u32 __iomem *reg, u32 value)
 {
 	if (qdev->current_page != 2)
 		ql_set_register_page(qdev,2);
-	writel(value, (u32 *) reg);
+	writel(value, reg);
 	readl(reg);
 	return;
 }
@@ -1687,7 +1687,7 @@ static void ql_update_lrg_bufq_prod_inde
 		qdev->lrg_buf_next_free = lrg_buf_q_ele;
 
 		ql_write_common_reg(qdev,
-				    (u32 *) & port_regs->CommonRegs.
+				    &port_regs->CommonRegs.
 				    rxLargeQProducerIndex,
 				    qdev->lrg_buf_q_producer_index);
 	}
@@ -1924,13 +1924,13 @@ static int ql_tx_rx_clean(struct ql3_ada
 		}
 
 		ql_write_common_reg(qdev,
-				    (u32 *) & port_regs->CommonRegs.
+				    &port_regs->CommonRegs.
 				    rxSmallQProducerIndex,
 				    qdev->small_buf_q_producer_index);
 	}
 
 	ql_write_common_reg(qdev,
-			    (u32 *) & port_regs->CommonRegs.rspQConsumerIndex,
+			    &port_regs->CommonRegs.rspQConsumerIndex,
 			    qdev->rsp_consumer_index);
 	spin_unlock_irqrestore(&qdev->hw_lock, hw_flags);
 
@@ -2057,7 +2057,7 @@ static int ql3xxx_send(struct sk_buff *s
 		qdev->req_producer_index = 0;
 	wmb();
 	ql_write_common_reg_l(qdev,
-			    (u32 *) & port_regs->CommonRegs.reqQProducerIndex,
+			    &port_regs->CommonRegs.reqQProducerIndex,
 			    qdev->req_producer_index);
 
 	ndev->trans_start = jiffies;
@@ -2474,8 +2474,8 @@ static void ql_free_mem_resources(struct
 
 static int ql_init_misc_registers(struct ql3_adapter *qdev)
 {
-	struct ql3xxx_local_ram_registers *local_ram =
-	    (struct ql3xxx_local_ram_registers *)qdev->mem_map_registers;
+	struct ql3xxx_local_ram_registers __iomem *local_ram =
+	    (void __iomem *)qdev->mem_map_registers;
 
 	if(ql_sem_spinlock(qdev, QL_DDR_RAM_SEM_MASK,
 			(QL_RESOURCE_BITS_BASE_CODE | (qdev->mac_index) *
@@ -2535,7 +2535,7 @@ static int ql_adapter_initialize(struct 
 	u32 value;
 	struct ql3xxx_port_registers __iomem *port_regs = qdev->mem_map_registers;
 	struct ql3xxx_host_memory_registers __iomem *hmem_regs =
-	    (struct ql3xxx_host_memory_registers *)port_regs;
+						(void __iomem *)port_regs;
 	u32 delay = 10;
 	int status = 0;
 
@@ -2640,11 +2640,11 @@ static int ql_adapter_initialize(struct 
 	qdev->lrg_buf_free_tail = NULL;
 
 	ql_write_common_reg(qdev,
-			    (u32 *) & port_regs->CommonRegs.
+			    &port_regs->CommonRegs.
 			    rxSmallQProducerIndex,
 			    qdev->small_buf_q_producer_index);
 	ql_write_common_reg(qdev,
-			    (u32 *) & port_regs->CommonRegs.
+			    &port_regs->CommonRegs.
 			    rxLargeQProducerIndex,
 			    qdev->lrg_buf_q_producer_index);
 
@@ -2787,7 +2787,7 @@ static int ql_adapter_reset(struct ql3_a
 	       "%s: Issue soft reset to chip.\n",
 	       qdev->ndev->name);
 	ql_write_common_reg(qdev,
-			    (u32 *) & port_regs->CommonRegs.ispControlStatus,
+			    &port_regs->CommonRegs.ispControlStatus,
 			    ((ISP_CONTROL_SR << 16) | ISP_CONTROL_SR));
 
 	/* Wait 3 seconds for reset to complete. */
@@ -2817,7 +2817,7 @@ static int ql_adapter_reset(struct ql3_a
 		printk(KERN_DEBUG PFX
 		       "ql_adapter_reset: clearing RI after reset.\n");
 		ql_write_common_reg(qdev,
-				    (u32 *) & port_regs->CommonRegs.
+				    &port_regs->CommonRegs.
 				    ispControlStatus,
 				    ((ISP_CONTROL_RI << 16) | ISP_CONTROL_RI));
 	}
@@ -2825,7 +2825,7 @@ static int ql_adapter_reset(struct ql3_a
 	if (max_wait_time == 0) {
 		/* Issue Force Soft Reset */
 		ql_write_common_reg(qdev,
-				    (u32 *) & port_regs->CommonRegs.
+				    &port_regs->CommonRegs.
 				    ispControlStatus,
 				    ((ISP_CONTROL_FSR << 16) |
 				     ISP_CONTROL_FSR));
@@ -3243,8 +3243,7 @@ static void ql_reset_work(struct ql3_ada
 				       "%s: clearing NRI after reset.\n",
 				       qdev->ndev->name);
 				ql_write_common_reg(qdev,
-						    (u32 *) &
-						    port_regs->
+						    &port_regs->
 						    CommonRegs.
 						    ispControlStatus,
 						    ((ISP_CONTROL_RI <<
@@ -3509,7 +3508,7 @@ static void __devexit ql3xxx_remove(stru
 		qdev->workqueue = NULL;
 	}
 
-	iounmap((void *)qdev->mmap_virt_base);
+	iounmap(qdev->mmap_virt_base);
 	pci_release_regions(pdev);
 	pci_set_drvdata(pdev, NULL);
 	free_netdev(ndev);
diff --git a/drivers/net/qla3xxx.h b/drivers/net/qla3xxx.h
index 9492cee..65da2c0 100644
--- a/drivers/net/qla3xxx.h
+++ b/drivers/net/qla3xxx.h
@@ -1093,7 +1093,7 @@ struct ql3_adapter {
 	spinlock_t hw_lock;
 
 	/* PCI Bus Relative Register Addresses */
-	u8 *mmap_virt_base;	/* stores return value from ioremap() */
+	u8 __iomem *mmap_virt_base;	/* stores return value from ioremap() */
 	struct ql3xxx_port_registers __iomem *mem_map_registers;
 	u32 current_page;	/* tracks current register page */
 
-- 
1.4.2.GIT

