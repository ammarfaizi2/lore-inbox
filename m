Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271218AbUJVL2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271218AbUJVL2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271217AbUJVL2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:28:35 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:18835 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S271240AbUJVLZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:25:22 -0400
From: margitsw@t-online.de (Margit Schubert-While)
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 linux-2.4.28-pre4] Add prism54 to MAINTAINERS
Date: Fri, 22 Oct 2004 11:39:46 +0200
User-Agent: KMail/1.5.4
Cc: prism54-devel@prism54.org, marcelo.tosatti@cyclades.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iVNeBfZV2dBuz+6"
Message-Id: <200410221139.46780.margitsw@t-online.de>
X-ID: GurYDkZdYeifVw1hGv5hrodP56wZCu85WuQVV3wN5-AYxfL-ERSzQN
X-TOI-MSGID: 09efc295-8964-464a-995a-6a899ce804e9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_iVNeBfZV2dBuz+6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2004-10-22 Margit Schubert-While <margitsw@t-online.de>

* Add prism54 to MAINTAINERS

Margit




















--Boundary-00=_iVNeBfZV2dBuz+6
Content-Type: text/x-diff;
  charset="us-ascii";
  name="01_26compat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="01_26compat.patch"

diff -Naur linux-2.4.28-pre3/drivers/net/wireless/prism54/isl_38xx.c linux-2.4.28-pre3msw/drivers/net/wireless/prism54/isl_38xx.c
--- linux-2.4.28-pre3/drivers/net/wireless/prism54/isl_38xx.c	2004-10-09 14:07:05.000000000 +0200
+++ linux-2.4.28-pre3msw/drivers/net/wireless/prism54/isl_38xx.c	2004-10-09 14:11:59.000000000 +0200
@@ -44,7 +44,7 @@
  *  register located at offset %ISL38XX_INT_IDENT_REG.
  */
 void
-isl38xx_disable_interrupts(void *device)
+isl38xx_disable_interrupts(void __iomem *device)
 {
 	isl38xx_w32_flush(device, 0x00000000, ISL38XX_INT_EN_REG);
 	udelay(ISL38XX_WRITEIO_DELAY);
@@ -52,7 +52,7 @@
 
 void
 isl38xx_handle_sleep_request(isl38xx_control_block *control_block,
-			     int *powerstate, void *device_base)
+			     int *powerstate, void __iomem *device_base)
 {
 	/* device requests to go into sleep mode
 	 * check whether the transmit queues for data and management are empty */
@@ -88,7 +88,7 @@
 
 void
 isl38xx_handle_wakeup(isl38xx_control_block *control_block,
-		      int *powerstate, void *device_base)
+		      int *powerstate, void __iomem *device_base)
 {
 	/* device is in active state, update the powerstate flag */
 	*powerstate = ISL38XX_PSM_ACTIVE_STATE;
@@ -110,7 +110,7 @@
 }
 
 void
-isl38xx_trigger_device(int asleep, void *device_base)
+isl38xx_trigger_device(int asleep, void __iomem *device_base)
 {
 	struct timeval current_time;
 	u32 reg, counter = 0;
@@ -190,7 +190,7 @@
 }
 
 void
-isl38xx_interface_reset(void *device_base, dma_addr_t host_address)
+isl38xx_interface_reset(void __iomem *device_base, dma_addr_t host_address)
 {
 #if VERBOSE > SHOW_ERROR_MESSAGES
 	DEBUG(SHOW_FUNCTION_CALLS, "isl38xx_interface_reset\n");
@@ -214,7 +214,7 @@
 }
 
 void
-isl38xx_enable_common_interrupts(void *device_base) {
+isl38xx_enable_common_interrupts(void __iomem *device_base) {
 	u32 reg;
 	reg = ( ISL38XX_INT_IDENT_UPDATE | 
 			ISL38XX_INT_IDENT_SLEEP | ISL38XX_INT_IDENT_WAKEUP);
diff -Naur linux-2.4.28-pre3/drivers/net/wireless/prism54/isl_38xx.h linux-2.4.28-pre3msw/drivers/net/wireless/prism54/isl_38xx.h
--- linux-2.4.28-pre3/drivers/net/wireless/prism54/isl_38xx.h	2004-10-09 14:07:05.000000000 +0200
+++ linux-2.4.28-pre3msw/drivers/net/wireless/prism54/isl_38xx.h	2004-10-09 14:11:59.000000000 +0200
@@ -75,7 +75,7 @@
  *  from the %ISL38XX_PCI_POSTING_FLUSH offset.
  */
 static inline void
-isl38xx_w32_flush(void *base, u32 val, unsigned long offset)
+isl38xx_w32_flush(void __iomem *base, u32 val, unsigned long offset)
 {
 	writel(val, base + offset);
 	(void) readl(base + ISL38XX_PCI_POSTING_FLUSH);
@@ -161,13 +161,13 @@
 /* determine number of entries currently in queue */
 int isl38xx_in_queue(isl38xx_control_block *cb, int queue);
 
-void isl38xx_disable_interrupts(void *);
-void isl38xx_enable_common_interrupts(void *);
+void isl38xx_disable_interrupts(void __iomem *);
+void isl38xx_enable_common_interrupts(void __iomem *);
 
 void isl38xx_handle_sleep_request(isl38xx_control_block *, int *,
-				  void *);
-void isl38xx_handle_wakeup(isl38xx_control_block *, int *, void *);
-void isl38xx_trigger_device(int, void *);
-void isl38xx_interface_reset(void *, dma_addr_t);
+				  void __iomem *);
+void isl38xx_handle_wakeup(isl38xx_control_block *, int *, void __iomem *);
+void isl38xx_trigger_device(int, void __iomem *);
+void isl38xx_interface_reset(void __iomem *, dma_addr_t);
 
 #endif				/* _ISL_38XX_H */
diff -Naur linux-2.4.28-pre3/drivers/net/wireless/prism54/islpci_dev.c linux-2.4.28-pre3msw/drivers/net/wireless/prism54/islpci_dev.c
--- linux-2.4.28-pre3/drivers/net/wireless/prism54/islpci_dev.c	2004-10-09 14:07:05.000000000 +0200
+++ linux-2.4.28-pre3msw/drivers/net/wireless/prism54/islpci_dev.c	2004-10-09 14:11:59.000000000 +0200
@@ -58,7 +58,7 @@
 isl_upload_firmware(islpci_private *priv)
 {
 	u32 reg, rc;
-	void *device_base = priv->device_base;
+	void __iomem *device_base = priv->device_base;
 
 	/* clear the RAMBoot and the Reset bit */
 	reg = readl(device_base + ISL38XX_CTRL_STAT_REG);
@@ -113,7 +113,7 @@
 			    (fw_len >
 			     ISL38XX_MEMORY_WINDOW_SIZE) ?
 			    ISL38XX_MEMORY_WINDOW_SIZE : fw_len;
-			u32 *dev_fw_ptr = device_base + ISL38XX_DIRECT_MEM_WIN;
+			u32 __iomem *dev_fw_ptr = device_base + ISL38XX_DIRECT_MEM_WIN;
 
 			/* set the cards base address for writting the data */
 			isl38xx_w32_flush(device_base, reg,
@@ -187,7 +187,7 @@
 	u32 reg;
 	islpci_private *priv = config;
 	struct net_device *ndev = priv->ndev;
-	void *device = priv->device_base;
+	void __iomem *device = priv->device_base;
 	int powerstate = ISL38XX_PSM_POWERSAVE_STATE;
 
 	/* lock the interrupt handler */
@@ -407,7 +407,7 @@
 static int
 prism54_bring_down(islpci_private *priv)
 {
-	void *device_base = priv->device_base;
+	void __iomem *device_base = priv->device_base;
 	u32 reg;
 	/* we are going to shutdown the device */
 	islpci_set_state(priv, PRV_STATE_PREBOOT);
diff -Naur linux-2.4.28-pre3/drivers/net/wireless/prism54/islpci_dev.h linux-2.4.28-pre3msw/drivers/net/wireless/prism54/islpci_dev.h
--- linux-2.4.28-pre3/drivers/net/wireless/prism54/islpci_dev.h	2004-10-09 14:07:05.000000000 +0200
+++ linux-2.4.28-pre3msw/drivers/net/wireless/prism54/islpci_dev.h	2004-10-09 14:11:59.000000000 +0200
@@ -113,7 +113,7 @@
 	u32 pci_state[16];	/* used for suspend/resume */
 	char firmware[33];
 
-	void *device_base;	/* ioremapped device base address */
+	void __iomem *device_base;	/* ioremapped device base address */
 
 	/* consistent DMA region */
 	void *driver_mem_address;	/* base DMA address */
diff -Naur linux-2.4.28-pre3/drivers/net/wireless/prism54/prismcompat24.h linux-2.4.28-pre3msw/drivers/net/wireless/prism54/prismcompat24.h
--- linux-2.4.28-pre3/drivers/net/wireless/prism54/prismcompat24.h	2004-10-09 14:07:05.000000000 +0200
+++ linux-2.4.28-pre3msw/drivers/net/wireless/prism54/prismcompat24.h	2004-10-09 14:11:59.000000000 +0200
@@ -51,6 +51,10 @@
 #define INIT_WORK		INIT_TQUEUE
 #define schedule_work		schedule_task
 
+#ifndef __iomem
+#define __iomem
+#endif
+
 #if !defined(HAVE_NETDEV_PRIV)
 #define netdev_priv(x)		(x)->priv
 #endif

--Boundary-00=_iVNeBfZV2dBuz+6--

