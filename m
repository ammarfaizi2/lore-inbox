Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTE3Ngl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 09:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263668AbTE3Ngk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 09:36:40 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:6847 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S263665AbTE3Nfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 09:35:33 -0400
Message-Id: <200305301348.h4UDmgsG003066@ginger.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup 
In-reply-to: Your message of "Thu, 29 May 2003 20:01:01 PDT."
             <20030529.200101.118622651.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 30 May 2003 09:46:59 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030529.200101.118622651.davem@redhat.com>,"David S. Miller" write
s:
>You can integrate ideas posted in this thread in subsequent
>patches.

[ATM]: more coding style cleanups in HE driver

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1161  -> 1.1162 
#	    drivers/atm/he.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/30	chas@relax.cmf.nrl.navy.mil	1.1162
# he.c:
#   [ATM]: more coding style cleanups in HE driver
# --------------------------------------------
#
diff -Nru a/drivers/atm/he.c b/drivers/atm/he.c
--- a/drivers/atm/he.c	Fri May 30 09:10:54 2003
+++ b/drivers/atm/he.c	Fri May 30 09:10:54 2003
@@ -77,14 +77,6 @@
 #include <linux/atmdev.h>
 #include <linux/atm.h>
 #include <linux/sonet.h>
-#ifndef ATM_OC12_PCR
-#define ATM_OC12_PCR (622080000/1080*1040/8/53)
-#endif
-
-#ifdef BUS_INT_WAR
-void sn_add_polled_interrupt(int irq, int interval);
-void sn_delete_polled_interrupt(int irq);
-#endif
 
 #define USE_TASKLET
 #define USE_HE_FIND_VCC
@@ -171,22 +163,17 @@
 
 static struct atmdev_ops he_ops =
 {
-   open:	he_open,
-   close:	he_close,	
-   ioctl:	he_ioctl,	
-   send:	he_send,
-   sg_send:	he_sg_send,	
-   phy_put:	he_phy_put,
-   phy_get:	he_phy_get,
-   proc_read:	he_proc_read,
-   owner:	THIS_MODULE
+	.open =		he_open,
+	.close =	he_close,	
+	.ioctl =	he_ioctl,	
+	.send =		he_send,
+	.sg_send =	he_sg_send,	
+	.phy_put =	he_phy_put,
+	.phy_get =	he_phy_get,
+	.proc_read =	he_proc_read,
+	.owner =	THIS_MODULE
 };
 
-/* see the comments in he.h about global_lock */
-
-#define HE_SPIN_LOCK(dev, flags)	spin_lock_irqsave(&(dev)->global_lock, flags)
-#define HE_SPIN_UNLOCK(dev, flags)	spin_unlock_irqrestore(&(dev)->global_lock, flags)
-
 #define he_writel(dev, val, reg)	do { writel(val, (dev)->membase + (reg)); wmb(); } while (0)
 #define he_readl(dev, reg)		readl((dev)->membase + (reg))
 
@@ -233,26 +220,26 @@
 
 /* figure 2.2 connection id */
 
-#define he_mkcid(dev, vpi, vci)		(((vpi<<(dev)->vcibits) | vci) & 0x1fff)
+#define he_mkcid(dev, vpi, vci)		(((vpi << (dev)->vcibits) | vci) & 0x1fff)
 
 /* 2.5.1 per connection transmit state registers */
 
 #define he_writel_tsr0(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 0)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 0)
 #define he_readl_tsr0(dev, cid) \
-		he_readl_tcm(dev, CONFIG_TSRA | (cid<<3) | 0)
+		he_readl_tcm(dev, CONFIG_TSRA | (cid << 3) | 0)
 
 #define he_writel_tsr1(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 1)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 1)
 
 #define he_writel_tsr2(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 2)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 2)
 
 #define he_writel_tsr3(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 3)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 3)
 
 #define he_writel_tsr4(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 4)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 4)
 
 	/* from page 2-20
 	 *
@@ -263,43 +250,43 @@
 	 */
 
 #define he_writel_tsr4_upper(dev, val, cid) \
-		he_writel_internal(dev, val, CONFIG_TSRA | (cid<<3) | 4, \
+		he_writel_internal(dev, val, CONFIG_TSRA | (cid << 3) | 4, \
 							CON_CTL_TCM \
 							| CON_BYTE_DISABLE_2 \
 							| CON_BYTE_DISABLE_1 \
 							| CON_BYTE_DISABLE_0)
 
 #define he_readl_tsr4(dev, cid) \
-		he_readl_tcm(dev, CONFIG_TSRA | (cid<<3) | 4)
+		he_readl_tcm(dev, CONFIG_TSRA | (cid << 3) | 4)
 
 #define he_writel_tsr5(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 5)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 5)
 
 #define he_writel_tsr6(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 6)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 6)
 
 #define he_writel_tsr7(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 7)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 7)
 
 
 #define he_writel_tsr8(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRB | (cid<<2) | 0)
+		he_writel_tcm(dev, val, CONFIG_TSRB | (cid << 2) | 0)
 
 #define he_writel_tsr9(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRB | (cid<<2) | 1)
+		he_writel_tcm(dev, val, CONFIG_TSRB | (cid << 2) | 1)
 
 #define he_writel_tsr10(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRB | (cid<<2) | 2)
+		he_writel_tcm(dev, val, CONFIG_TSRB | (cid << 2) | 2)
 
 #define he_writel_tsr11(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRB | (cid<<2) | 3)
+		he_writel_tcm(dev, val, CONFIG_TSRB | (cid << 2) | 3)
 
 
 #define he_writel_tsr12(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRC | (cid<<1) | 0)
+		he_writel_tcm(dev, val, CONFIG_TSRC | (cid << 1) | 0)
 
 #define he_writel_tsr13(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRC | (cid<<1) | 1)
+		he_writel_tcm(dev, val, CONFIG_TSRC | (cid << 1) | 1)
 
 
 #define he_writel_tsr14(dev, val, cid) \
@@ -315,30 +302,30 @@
 /* 2.7.1 per connection receive state registers */
 
 #define he_writel_rsr0(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 0)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 0)
 #define he_readl_rsr0(dev, cid) \
-		he_readl_rcm(dev, 0x00000 | (cid<<3) | 0)
+		he_readl_rcm(dev, 0x00000 | (cid << 3) | 0)
 
 #define he_writel_rsr1(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 1)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 1)
 
 #define he_writel_rsr2(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 2)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 2)
 
 #define he_writel_rsr3(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 3)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 3)
 
 #define he_writel_rsr4(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 4)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 4)
 
 #define he_writel_rsr5(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 5)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 5)
 
 #define he_writel_rsr6(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 6)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 6)
 
 #define he_writel_rsr7(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 7)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 7)
 
 static __inline__ struct atm_vcc*
 he_find_vcc(struct he_dev *he_dev, unsigned cid)
@@ -349,7 +336,7 @@
 	int vci;
 
 	vpi = cid >> he_dev->vcibits;
-	vci = cid & ((1<<he_dev->vcibits)-1);
+	vci = cid & ((1 << he_dev->vcibits) - 1);
 
 	spin_lock_irqsave(&he_dev->atm_dev->lock, flags);
 	for (vcc = he_dev->atm_dev->vccs; vcc; vcc = vcc->next)
@@ -443,12 +430,12 @@
 static unsigned
 rate_to_atmf(unsigned rate)		/* cps to atm forum format */
 {
-#define NONZERO (1<<14)
+#define NONZERO (1 << 14)
 
         unsigned exp = 0;
 
         if (rate == 0)
-		return(0);
+		return 0;
 
         rate <<= 9;
         while (rate > 0x3ff) {
@@ -669,10 +656,10 @@
 
 }
 
-static int __init
+static void __init
 he_init_cs_block_rcm(struct he_dev *he_dev)
 {
-	unsigned (*rategrid)[16][16];
+	unsigned rategrid[16][16];
 	unsigned rate, delta;
 	int i, j, reg;
 
@@ -680,10 +667,6 @@
 	unsigned long long rate_cps;
         int mult, buf, buf_limit = 4;
 
-	rategrid = kmalloc( sizeof(unsigned) * 16 * 16, GFP_KERNEL);
-	if (!rategrid)
-		return -ENOMEM;
-
 	/* initialize rate grid group table */
 
 	for (reg = 0x0; reg < 0xff; ++reg)
@@ -713,16 +696,16 @@
 	 */
 
 	for (j = 0; j < 16; j++) {
-		(*rategrid)[0][j] = rate;
+		rategrid[0][j] = rate;
 		rate -= delta;
 	}
 
 	for (i = 1; i < 16; i++)
 		for (j = 0; j < 16; j++)
 			if (i > 14)
-				(*rategrid)[i][j] = (*rategrid)[i - 1][j] / 4;
+				rategrid[i][j] = rategrid[i - 1][j] / 4;
 			else
-				(*rategrid)[i][j] = (*rategrid)[i - 1][j] / 2;
+				rategrid[i][j] = rategrid[i - 1][j] / 2;
 
 	/*
 	 * 2.4 transmit internal function
@@ -747,7 +730,7 @@
 			rate_cps = 10;	/* 2.2.1 minimum payload rate is 10 cps */
 
 		for (i = 255; i > 0; i--)
-			if ((*rategrid)[i/16][i%16] >= rate_cps)
+			if (rategrid[i/16][i%16] >= rate_cps)
 				break;	 /* pick nearest rate instead? */
 
 		/*
@@ -761,32 +744,30 @@
 				(he_dev->atm_dev->link_rate * 2);
 #else
 		/* this is pretty, but avoids _divdu3 and is mostly correct */
-                buf = 0;
                 mult = he_dev->atm_dev->link_rate / ATM_OC3_PCR;
-                if (rate_cps > (68 * mult))
-			buf = 1;
-                if (rate_cps > (136 * mult))
-			buf = 2;
-                if (rate_cps > (204 * mult))
-			buf = 3;
                 if (rate_cps > (272 * mult))
 			buf = 4;
+		else if (rate_cps > (204 * mult))
+			buf = 3;
+		else if (rate_cps > (136 * mult))
+			buf = 2;
+		else if (rate_cps > (68 * mult))
+			buf = 1;
+		else
+			buf = 0;
 #endif
                 if (buf > buf_limit)
 			buf = buf_limit;
-		reg = (reg<<16) | ((i<<8) | buf);
+		reg = (reg << 16) | ((i << 8) | buf);
 
 #define RTGTBL_OFFSET 0x400
 	  
 		if (rate_atmf & 0x1)
 			he_writel_rcm(he_dev, reg,
-				CONFIG_RCMABR + RTGTBL_OFFSET + (rate_atmf>>1));
+				CONFIG_RCMABR + RTGTBL_OFFSET + (rate_atmf >> 1));
 
 		++rate_atmf;
 	}
-
-	kfree(rategrid);
-	return 0;
 }
 
 static int __init
@@ -839,7 +820,7 @@
 		he_dev->rbps_base[i].phys = dma_handle;
 
 	}
-	he_dev->rbps_tail = &he_dev->rbps_base[CONFIG_RBPS_SIZE-1];
+	he_dev->rbps_tail = &he_dev->rbps_base[CONFIG_RBPS_SIZE - 1];
 
 	he_writel(he_dev, he_dev->rbps_phys, G0_RBPS_S + (group * 32));
 	he_writel(he_dev, RBPS_MASK(he_dev->rbps_tail),
@@ -848,7 +829,7 @@
 						G0_RBPS_BS + (group * 32));
 	he_writel(he_dev,
 			RBP_THRESH(CONFIG_RBPS_THRESH) |
-			RBP_QSIZE(CONFIG_RBPS_SIZE-1) |
+			RBP_QSIZE(CONFIG_RBPS_SIZE - 1) |
 			RBP_INT_ENB,
 						G0_RBPS_QI + (group * 32));
 #else /* !USE_RBPS */
@@ -902,7 +883,7 @@
 		he_dev->rbpl_base[i].status = RBP_LOANED | (i << RBP_INDEX_OFF);
 		he_dev->rbpl_base[i].phys = dma_handle;
 	}
-	he_dev->rbpl_tail = &he_dev->rbpl_base[CONFIG_RBPL_SIZE-1];
+	he_dev->rbpl_tail = &he_dev->rbpl_base[CONFIG_RBPL_SIZE - 1];
 
 	he_writel(he_dev, he_dev->rbpl_phys, G0_RBPL_S + (group * 32));
 	he_writel(he_dev, RBPL_MASK(he_dev->rbpl_tail),
@@ -911,7 +892,7 @@
 						G0_RBPL_BS + (group * 32));
 	he_writel(he_dev,
 			RBP_THRESH(CONFIG_RBPL_THRESH) |
-			RBP_QSIZE(CONFIG_RBPL_SIZE-1) |
+			RBP_QSIZE(CONFIG_RBPL_SIZE - 1) |
 			RBP_INT_ENB,
 						G0_RBPL_QI + (group * 32));
 
@@ -929,7 +910,7 @@
 	he_writel(he_dev, he_dev->rbrq_phys, G0_RBRQ_ST + (group * 16));
 	he_writel(he_dev, 0, G0_RBRQ_H + (group * 16));
 	he_writel(he_dev,
-		RBRQ_THRESH(CONFIG_RBRQ_THRESH) | RBRQ_SIZE(CONFIG_RBRQ_SIZE-1),
+		RBRQ_THRESH(CONFIG_RBRQ_THRESH) | RBRQ_SIZE(CONFIG_RBRQ_SIZE - 1),
 						G0_RBRQ_Q + (group * 16));
 	if (irq_coalesce) {
 		hprintk("coalescing interrupts\n");
@@ -979,7 +960,7 @@
 	he_dev->irq_head = he_dev->irq_base;
 	he_dev->irq_tail = he_dev->irq_base;
 
-	for (i=0; i < CONFIG_IRQ_SIZE; ++i)
+	for (i = 0; i < CONFIG_IRQ_SIZE; ++i)
 		he_dev->irq_base[i].isw = ITYPE_INVALID;
 
 	he_writel(he_dev, he_dev->irq_phys, IRQ0_BASE);
@@ -1018,11 +999,6 @@
 
 	he_dev->irq = he_dev->pci_dev->irq;
 
-#ifdef BUS_INT_WAR
-        HPRINTK("sn_add_polled_interrupt(irq %d, 1)\n", he_dev->irq);
-        sn_add_polled_interrupt(he_dev->irq, 1);
-#endif
-
 	return 0;
 }
 
@@ -1138,12 +1114,12 @@
 	pci_write_config_dword(pci_dev, GEN_CNTL_0, gen_cntl_0);
 
 	/* 4.7 read prom contents */
-	for (i=0; i<PROD_ID_LEN; ++i)
+	for (i = 0; i < PROD_ID_LEN; ++i)
 		he_dev->prod_id[i] = read_prom_byte(he_dev, PROD_ID + i);
 
 	he_dev->media = read_prom_byte(he_dev, MEDIA);
 
-	for (i=0; i<6; ++i)
+	for (i = 0; i < 6; ++i)
 		dev->esi[i] = read_prom_byte(he_dev, MAC_ADDR + i);
 
 	hprintk("%s%s, %x:%x:%x:%x:%x:%x\n",
@@ -1323,15 +1299,15 @@
 	he_writel(he_dev, 0x0, TXAAL5_PROTO);
 
 	he_writel(he_dev, PHY_INT_ENB |
-		(he_is622(he_dev) ? PTMR_PRE(67-1) : PTMR_PRE(50-1)),
+		(he_is622(he_dev) ? PTMR_PRE(67 - 1) : PTMR_PRE(50 - 1)),
 								RH_CONFIG);
 
 	/* 5.1.3 initialize connection memory */
 
-	for (i=0; i < TCM_MEM_SIZE; ++i)
+	for (i = 0; i < TCM_MEM_SIZE; ++i)
 		he_writel_tcm(he_dev, 0, i);
 
-	for (i=0; i < RCM_MEM_SIZE; ++i)
+	for (i = 0; i < RCM_MEM_SIZE; ++i)
 		he_writel_rcm(he_dev, 0, i);
 
 	/*
@@ -1484,8 +1460,7 @@
 
 	/* 5.1.8 cs block connection memory initialization */
 	
-	if (he_init_cs_block_rcm(he_dev) < 0)
-		return -ENOMEM;
+	he_init_cs_block_rcm(he_dev);
 
 	/* 5.1.10 initialize host structures */
 
@@ -1512,7 +1487,7 @@
 	}
 		
 	he_dev->tpd_head = he_dev->tpd_base;
-	he_dev->tpd_end = &he_dev->tpd_base[CONFIG_NUMTPDS-1];
+	he_dev->tpd_end = &he_dev->tpd_base[CONFIG_NUMTPDS - 1];
 #endif
 
 	if (he_init_group(he_dev, 0) != 0)
@@ -1652,12 +1627,8 @@
 		he_dev->atm_dev->phy->stop(he_dev->atm_dev);
 #endif /* CONFIG_ATM_HE_USE_SUNI */
 
-	if (he_dev->irq) {
-#ifdef BUS_INT_WAR
-		sn_delete_polled_interrupt(he_dev->irq);
-#endif
+	if (he_dev->irq)
 		free_irq(he_dev->irq, he_dev);
-	}
 
 	if (he_dev->irq_base)
 		pci_free_consistent(he_dev->pci_dev, (CONFIG_IRQ_SIZE+1)
@@ -1669,7 +1640,7 @@
 
 	if (he_dev->rbpl_base) {
 #ifdef USE_RBPL_POOL
-		for (i=0; i<CONFIG_RBPL_SIZE; ++i) {
+		for (i = 0; i < CONFIG_RBPL_SIZE; ++i) {
 			void *cpuaddr = he_dev->rbpl_virt[i].virt;
 			dma_addr_t dma_handle = he_dev->rbpl_base[i].phys;
 
@@ -1691,7 +1662,7 @@
 #ifdef USE_RBPS
 	if (he_dev->rbps_base) {
 #ifdef USE_RBPS_POOL
-		for (i=0; i<CONFIG_RBPS_SIZE; ++i) {
+		for (i = 0; i < CONFIG_RBPS_SIZE; ++i) {
 			void *cpuaddr = he_dev->rbps_virt[i].virt;
 			dma_addr_t dma_handle = he_dev->rbps_base[i].phys;
 
@@ -1790,7 +1761,7 @@
 }
 
 #define AAL5_LEN(buf,len) 						\
-			((((unsigned char *)(buf))[(len)-6]<<8) |	\
+			((((unsigned char *)(buf))[(len)-6] << 8) |	\
 				(((unsigned char *)(buf))[(len)-5]))
 
 /* 2.10.1.2 receive
@@ -1800,7 +1771,7 @@
  */
 
 #define TCP_CKSUM(buf,len) 						\
-			((((unsigned char *)(buf))[(len)-2]<<8) |	\
+			((((unsigned char *)(buf))[(len)-2] << 8) |	\
 				(((unsigned char *)(buf))[(len-1)]))
 
 static int
@@ -2171,7 +2142,7 @@
 
 	HPRINTK("tasklet (0x%lx)\n", data);
 #ifdef USE_TASKLET
-	HE_SPIN_LOCK(he_dev, flags);
+	spin_lock_irqsave(&he_dev->global_lock, flags);
 #endif
 
 	while (he_dev->irq_head != he_dev->irq_tail) {
@@ -2209,10 +2180,10 @@
 			case ITYPE_PHY:
 				HPRINTK("phy interrupt\n");
 #ifdef CONFIG_ATM_HE_USE_SUNI
-				HE_SPIN_UNLOCK(he_dev, flags);
+				spin_unlock_irqrestore(&he_dev->global_lock, flags);
 				if (he_dev->atm_dev->phy && he_dev->atm_dev->phy->interrupt)
 					he_dev->atm_dev->phy->interrupt(he_dev->atm_dev);
-				HE_SPIN_LOCK(he_dev, flags);
+				spin_lock_irqsave(&he_dev->global_lock, flags);
 #endif
 				break;
 			case ITYPE_OTHER:
@@ -2257,7 +2228,7 @@
 		(void) he_readl(he_dev, INT_FIFO); /* 8.1.2 controller errata */
 	}
 #ifdef USE_TASKLET
-	HE_SPIN_UNLOCK(he_dev, flags);
+	spin_unlock_irqrestore(&he_dev->global_lock, flags);
 #endif
 }
 
@@ -2271,7 +2242,7 @@
 	if (he_dev == NULL)
 		return IRQ_NONE;
 
-	HE_SPIN_LOCK(he_dev, flags);
+	spin_lock_irqsave(&he_dev->global_lock, flags);
 
 	he_dev->irq_tail = (struct he_irq *) (((unsigned long)he_dev->irq_base) |
 						(*he_dev->irq_tailoffset << 2));
@@ -2301,7 +2272,7 @@
 		(void) he_readl(he_dev, INT_FIFO);
 #endif
 	}
-	HE_SPIN_UNLOCK(he_dev, flags);
+	spin_unlock_irqrestore(&he_dev->global_lock, flags);
 	return IRQ_RETVAL(handled);
 
 }
@@ -2438,9 +2409,9 @@
 				goto open_failed;
 		}
 
-		HE_SPIN_LOCK(he_dev, flags);
+		spin_lock_irqsave(&he_dev->global_lock, flags);
 		tsr0 = he_readl_tsr0(he_dev, cid);
-		HE_SPIN_UNLOCK(he_dev, flags);
+		spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 		if (TSR0_CONN_STATE(tsr0) != 0) {
 			hprintk("cid 0x%x not idle (tsr0 = 0x%x)\n", cid, tsr0);
@@ -2467,7 +2438,7 @@
 					goto open_failed;
 				}
 
-				HE_SPIN_LOCK(he_dev, flags);			/* also protects he_dev->cs_stper[] */
+				spin_lock_irqsave(&he_dev->global_lock, flags);			/* also protects he_dev->cs_stper[] */
 
 				/* find an unused cs_stper register */
 				for (reg = 0; reg < HE_NUM_CS_STPER; ++reg)
@@ -2477,7 +2448,7 @@
 
 				if (reg == HE_NUM_CS_STPER) {
 					err = -EBUSY;
-					HE_SPIN_UNLOCK(he_dev, flags);
+					spin_unlock_irqrestore(&he_dev->global_lock, flags);
 					goto open_failed;
 				}
 
@@ -2495,7 +2466,7 @@
 
 				he_writel_mbox(he_dev, rate_to_atmf(period/2),
 							CS_STPER0 + reg);
-				HE_SPIN_UNLOCK(he_dev, flags);
+				spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 				tsr0 = TSR0_CBR | TSR0_GROUP(0) | tsr0_aal |
 							TSR0_RC_INDEX(reg);
@@ -2506,7 +2477,7 @@
 				goto open_failed;
 		}
 
-		HE_SPIN_LOCK(he_dev, flags);
+		spin_lock_irqsave(&he_dev->global_lock, flags);
 
 		he_writel_tsr0(he_dev, tsr0, cid);
 		he_writel_tsr4(he_dev, tsr4 | 1, cid);
@@ -2528,7 +2499,7 @@
 #ifdef CONFIG_IA64_SGI_SN2
 		(void) he_readl_tsr0(he_dev, cid);
 #endif
-		HE_SPIN_UNLOCK(he_dev, flags);
+		spin_unlock_irqrestore(&he_dev->global_lock, flags);
 	}
 
 	if (vcc->qos.rxtp.traffic_class != ATM_NONE) {
@@ -2549,11 +2520,11 @@
 				goto open_failed;
 		}
 
-		HE_SPIN_LOCK(he_dev, flags);
+		spin_lock_irqsave(&he_dev->global_lock, flags);
 
 		rsr0 = he_readl_rsr0(he_dev, cid);
 		if (rsr0 & RSR0_OPEN_CONN) {
-			HE_SPIN_UNLOCK(he_dev, flags);
+			spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 			hprintk("cid 0x%x not idle (rsr0 = 0x%x)\n", cid, rsr0);
 			err = -EBUSY;
@@ -2585,7 +2556,7 @@
 		(void) he_readl_rsr0(he_dev, cid);
 #endif
 
-		HE_SPIN_UNLOCK(he_dev, flags);
+		spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 #ifndef USE_HE_FIND_VCC
 		HE_LOOKUP_VCC(he_dev, cid) = vcc;
@@ -2631,7 +2602,7 @@
 
 		/* wait for previous close (if any) to finish */
 
-		HE_SPIN_LOCK(he_dev, flags);
+		spin_lock_irqsave(&he_dev->global_lock, flags);
 		while (he_readl(he_dev, RCC_STAT) & RCC_BUSY) {
 			HPRINTK("close cid 0x%x RCC_BUSY\n", cid);
 			udelay(250);
@@ -2645,7 +2616,7 @@
 		(void) he_readl_rsr0(he_dev, cid);
 #endif
 		he_writel_mbox(he_dev, cid, RXCON_CLOSE);
-		HE_SPIN_UNLOCK(he_dev, flags);
+		spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 		timeout = schedule_timeout(30*HZ);
 
@@ -2693,7 +2664,7 @@
 
 		/* 2.3.1.1 generic close operations with flush */
 
-		HE_SPIN_LOCK(he_dev, flags);
+		spin_lock_irqsave(&he_dev->global_lock, flags);
 		he_writel_tsr4_upper(he_dev, TSR4_FLUSH_CONN, cid);
 					/* also clears TSR4_SESSION_ENDED */
 #ifdef CONFIG_IA64_SGI_SN2
@@ -2724,7 +2695,7 @@
 		add_wait_queue(&he_vcc->tx_waitq, &wait);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		__enqueue_tpd(he_dev, tpd, cid);
-		HE_SPIN_UNLOCK(he_dev, flags);
+		spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 		timeout = schedule_timeout(30*HZ);
 
@@ -2736,7 +2707,7 @@
 			goto close_tx_incomplete;
 		}
 
-		HE_SPIN_LOCK(he_dev, flags);
+		spin_lock_irqsave(&he_dev->global_lock, flags);
 		while (!((tsr4 = he_readl_tsr4(he_dev, cid)) & TSR4_SESSION_ENDED)) {
 			HPRINTK("close tx cid 0x%x !TSR4_SESSION_ENDED (tsr4 = 0x%x)\n", cid, tsr4);
 			udelay(250);
@@ -2761,7 +2732,7 @@
 
 			he_dev->total_bw -= he_dev->cs_stper[reg].pcr;
 		}
-		HE_SPIN_UNLOCK(he_dev, flags);
+		spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 		HPRINTK("close tx cid 0x%x complete\n", cid);
 	}
@@ -2818,7 +2789,7 @@
 		return -EINVAL;
 	}
 #endif
-	HE_SPIN_LOCK(he_dev, flags);
+	spin_lock_irqsave(&he_dev->global_lock, flags);
 
 	tpd = __alloc_tpd(he_dev);
 	if (tpd == NULL) {
@@ -2827,7 +2798,7 @@
 		else
 			dev_kfree_skb_any(skb);
 		atomic_inc(&vcc->stats->tx_err);
-		HE_SPIN_UNLOCK(he_dev, flags);
+		spin_unlock_irqrestore(&he_dev->global_lock, flags);
 		return -ENOMEM;
 	}
 
@@ -2869,7 +2840,7 @@
 				else
 					dev_kfree_skb_any(skb);
 				atomic_inc(&vcc->stats->tx_err);
-				HE_SPIN_UNLOCK(he_dev, flags);
+				spin_unlock_irqrestore(&he_dev->global_lock, flags);
 				return -ENOMEM;
 			}
 			tpd->status |= TPD_USERCELL;
@@ -2884,7 +2855,7 @@
 
 	}
 
-	tpd->iovec[slot-1].len |= TPD_LST;
+	tpd->iovec[slot - 1].len |= TPD_LST;
 #else
 	tpd->address0 = pci_map_single(he_dev->pci_dev, skb->data, skb->len, PCI_DMA_TODEVICE);
 	tpd->length0 = skb->len | TPD_LST;
@@ -2897,7 +2868,7 @@
 	ATM_SKB(skb)->vcc = vcc;
 
 	__enqueue_tpd(he_dev, tpd, cid);
-	HE_SPIN_UNLOCK(he_dev, flags);
+	spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 	atomic_inc(&vcc->stats->tx);
 
@@ -2919,7 +2890,7 @@
 
 			copy_from_user(&reg, (struct he_ioctl_reg *) arg,
 						sizeof(struct he_ioctl_reg));
-			HE_SPIN_LOCK(he_dev, flags);
+			spin_lock_irqsave(&he_dev->global_lock, flags);
 			switch (reg.type) {
 				case HE_REGTYPE_PCI:
 					reg.val = he_readl(he_dev, reg.addr);
@@ -2940,7 +2911,7 @@
 					err = -EINVAL;
 					break;
 			}
-			HE_SPIN_UNLOCK(he_dev, flags);
+			spin_unlock_irqrestore(&he_dev->global_lock, flags);
 			if (err == 0)
 				copy_to_user((struct he_ioctl_reg *) arg, &reg,
 							sizeof(struct he_ioctl_reg));
@@ -2966,12 +2937,12 @@
 
 	HPRINTK("phy_put(val 0x%x, addr 0x%lx)\n", val, addr);
 
-	HE_SPIN_LOCK(he_dev, flags);
+	spin_lock_irqsave(&he_dev->global_lock, flags);
         he_writel(he_dev, val, FRAMER + (addr*4));
 #ifdef CONFIG_IA64_SGI_SN2
 	(void) he_readl(he_dev, FRAMER + (addr*4));
 #endif
-	HE_SPIN_UNLOCK(he_dev, flags);
+	spin_unlock_irqrestore(&he_dev->global_lock, flags);
 }
  
         
@@ -2982,9 +2953,9 @@
 	struct he_dev *he_dev = HE_DEV(atm_dev);
 	unsigned reg;
 
-	HE_SPIN_LOCK(he_dev, flags);
+	spin_lock_irqsave(&he_dev->global_lock, flags);
         reg = he_readl(he_dev, FRAMER + (addr*4));
-	HE_SPIN_UNLOCK(he_dev, flags);
+	spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 	HPRINTK("phy_get(addr 0x%lx) =0x%x\n", addr, reg);
 	return reg;
@@ -3015,12 +2986,12 @@
 	if (!left--)
 		return sprintf(page, "Mismatched Cells  VPI/VCI Not Open  Dropped Cells  RCM Dropped Cells\n");
 
-	HE_SPIN_LOCK(he_dev, flags);
+	spin_lock_irqsave(&he_dev->global_lock, flags);
 	mcc += he_readl(he_dev, MCC);
 	oec += he_readl(he_dev, OEC);
 	dcc += he_readl(he_dev, DCC);
 	cec += he_readl(he_dev, CEC);
-	HE_SPIN_UNLOCK(he_dev, flags);
+	spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 	if (!left--)
 		return sprintf(page, "%16ld  %16ld  %13ld  %17ld\n\n", 
@@ -3090,26 +3061,26 @@
 	he_writel(he_dev, val, HOST_CNTL);
        
 	/* Send READ instruction */
-	for (i=0; i<sizeof(readtab)/sizeof(readtab[0]); i++) {
+	for (i = 0; i < sizeof(readtab)/sizeof(readtab[0]); i++) {
 		he_writel(he_dev, val | readtab[i], HOST_CNTL);
 		udelay(EEPROM_DELAY);
 	}
        
         /* Next, we need to send the byte address to read from */
-	for (i=7; i>=0; i--) {
+	for (i = 7; i >= 0; i--) {
 		he_writel(he_dev, val | clocktab[j++] | (((addr >> i) & 1) << 9), HOST_CNTL);
 		udelay(EEPROM_DELAY);
 		he_writel(he_dev, val | clocktab[j++] | (((addr >> i) & 1) << 9), HOST_CNTL);
 		udelay(EEPROM_DELAY);
 	}
        
-	j=0;
+	j = 0;
 
 	val &= 0xFFFFF7FF;      /* Turn off write enable */
 	he_writel(he_dev, val, HOST_CNTL);
        
 	/* Now, we can read data from the EEPROM by clocking it in */
-	for (i=7; i>=0; i--) {
+	for (i = 7; i >= 0; i--) {
 		he_writel(he_dev, val | clocktab[j++], HOST_CNTL);
 	        udelay(EEPROM_DELAY);
 	        tmp_read = he_readl(he_dev, HOST_CNTL);
