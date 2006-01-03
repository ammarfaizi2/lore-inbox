Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWACIE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWACIE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 03:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWACIE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 03:04:59 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:50408 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751151AbWACIE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 03:04:58 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] fix a few "warning: 'cleanup_card' defined but not used"
Date: Tue, 3 Jan 2006 10:03:47 +0200
User-Agent: KMail/1.8.2
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_k/iuDK+pk6yEnWv"
Message-Id: <200601031003.48023.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_k/iuDK+pk6yEnWv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

These warnings are emitted if non-modular network drivers are built.
Fixes just move cleanup_card() definitions into #ifdef MODULE region.
--
vda

--Boundary-00=_k/iuDK+pk6yEnWv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.6.15-rc7.cleanup_card.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.15-rc7.cleanup_card.patch"

  CC      drivers/net/wd.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/net/wd.c:131: warning: 'cleanup_card' defined but not used
  CC      drivers/net/3c503.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/net/3c503.c:152: warning: 'cleanup_card' defined but not used
  CC      drivers/net/ne.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/net/ne.c:216: warning: 'cleanup_card' defined but not used
  CC      drivers/net/hp.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/net/hp.c:106: warning: 'cleanup_card' defined but not used
  CC      drivers/net/hp-plus.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/net/hp-plus.c:142: warning: 'cleanup_card' defined but not used
  CC      drivers/net/smc-ultra.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/net/smc-ultra.c:172: warning: 'cleanup_card' defined but not used
  CC      drivers/net/smc-ultra32.o
  CC      drivers/net/e2100.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/net/e2100.c:144: warning: 'cleanup_card' defined but not used
  CC      drivers/net/es3210.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/net/es3210.c:159: warning: 'cleanup_card' defined but not used
  CC      drivers/net/lne390.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/net/lne390.c:149: warning: 'cleanup_card' defined but not used
  CC      drivers/net/ne3210.o
  CC      drivers/net/b44.o
  CC      drivers/net/forcedeth.o
  CC      drivers/net/lance.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/net/lance.c:313: warning: 'cleanup_card' defined but not used
  CC      drivers/net/3c501.o
  CC      drivers/net/3c507.o
  CC      drivers/net/3c515.o
  CC      drivers/net/eepro.o
  CC      drivers/net/8139cp.o
  CC      drivers/net/8139too.o
  CC      drivers/net/depca.o
  CC      drivers/net/ewrk3.o
  CC      drivers/net/ni52.o
  CC      drivers/net/ni65.o
  CC      drivers/net/3c505.o
  CC      drivers/net/ac3200.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/net/ac3200.c:127: warning: 'cleanup_card' defined but not used
  CC      drivers/net/82596.o


diff -urpN linux-2.6.15-rc7.src/drivers/net/3c503.c linux-2.6.15-rc7.fix/drivers/net/3c503.c
--- linux-2.6.15-rc7.src/drivers/net/3c503.c	Mon Aug 29 02:41:01 2005
+++ linux-2.6.15-rc7.fix/drivers/net/3c503.c	Sun Jan  1 16:54:08 2006
@@ -148,14 +148,6 @@ el2_pio_probe(struct net_device *dev)
     return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	/* NB: el2_close() handles free_irq */
-	release_region(dev->base_addr, EL2_IO_EXTENT);
-	if (ei_status.mem)
-		iounmap(ei_status.mem);
-}
-
 #ifndef MODULE
 struct net_device * __init el2_probe(int unit)
 {
@@ -724,6 +716,14 @@ init_module(void)
 	if (found)
 		return 0;
 	return -ENXIO;
+}
+
+static void cleanup_card(struct net_device *dev)
+{
+	/* NB: el2_close() handles free_irq */
+	release_region(dev->base_addr, EL2_IO_EXTENT);
+	if (ei_status.mem)
+		iounmap(ei_status.mem);
 }
 
 void
diff -urpN linux-2.6.15-rc7.src/drivers/net/ac3200.c linux-2.6.15-rc7.fix/drivers/net/ac3200.c
--- linux-2.6.15-rc7.src/drivers/net/ac3200.c	Fri Dec 30 14:11:12 2005
+++ linux-2.6.15-rc7.fix/drivers/net/ac3200.c	Sun Jan  1 16:54:35 2006
@@ -123,14 +123,6 @@ static int __init do_ac3200_probe(struct
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	/* Someday free_irq may be in ac_close_card() */
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr, AC_IO_EXTENT);
-	iounmap(ei_status.mem);
-}
-
 #ifndef MODULE
 struct net_device * __init ac3200_probe(int unit)
 {
@@ -404,6 +396,14 @@ init_module(void)
 	if (found)
 		return 0;
 	return -ENXIO;
+}
+
+static void cleanup_card(struct net_device *dev)
+{
+	/* Someday free_irq may be in ac_close_card() */
+	free_irq(dev->irq, dev);
+	release_region(dev->base_addr, AC_IO_EXTENT);
+	iounmap(ei_status.mem);
 }
 
 void
diff -urpN linux-2.6.15-rc7.src/drivers/net/e2100.c linux-2.6.15-rc7.fix/drivers/net/e2100.c
--- linux-2.6.15-rc7.src/drivers/net/e2100.c	Mon Aug 29 02:41:01 2005
+++ linux-2.6.15-rc7.fix/drivers/net/e2100.c	Sun Jan  1 16:31:09 2006
@@ -140,13 +140,6 @@ static int  __init do_e2100_probe(struct
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	/* NB: e21_close() handles free_irq */
-	iounmap(ei_status.mem);
-	release_region(dev->base_addr, E21_IO_EXTENT);
-}
-
 #ifndef MODULE
 struct net_device * __init e2100_probe(int unit)
 {
@@ -461,6 +454,13 @@ init_module(void)
 	if (found)
 		return 0;
 	return -ENXIO;
+}
+
+static void cleanup_card(struct net_device *dev)
+{
+	/* NB: e21_close() handles free_irq */
+	iounmap(ei_status.mem);
+	release_region(dev->base_addr, E21_IO_EXTENT);
 }
 
 void
diff -urpN linux-2.6.15-rc7.src/drivers/net/es3210.c linux-2.6.15-rc7.fix/drivers/net/es3210.c
--- linux-2.6.15-rc7.src/drivers/net/es3210.c	Mon Aug 29 02:41:01 2005
+++ linux-2.6.15-rc7.fix/drivers/net/es3210.c	Sun Jan  1 16:33:17 2006
@@ -155,13 +155,6 @@ static int __init do_es_probe(struct net
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr, ES_IO_EXTENT);
-	iounmap(ei_status.mem);
-}
-
 #ifndef MODULE
 struct net_device * __init es_probe(int unit)
 {
@@ -454,6 +447,13 @@ init_module(void)
 	if (found)
 		return 0;
 	return -ENXIO;
+}
+
+static void cleanup_card(struct net_device *dev)
+{
+	free_irq(dev->irq, dev);
+	release_region(dev->base_addr, ES_IO_EXTENT);
+	iounmap(ei_status.mem);
 }
 
 void
diff -urpN linux-2.6.15-rc7.src/drivers/net/hp-plus.c linux-2.6.15-rc7.fix/drivers/net/hp-plus.c
--- linux-2.6.15-rc7.src/drivers/net/hp-plus.c	Mon Aug 29 02:41:01 2005
+++ linux-2.6.15-rc7.fix/drivers/net/hp-plus.c	Sun Jan  1 16:33:33 2006
@@ -138,12 +138,6 @@ static int __init do_hpp_probe(struct ne
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	/* NB: hpp_close() handles free_irq */
-	release_region(dev->base_addr - NIC_OFFSET, HP_IO_EXTENT);
-}
-
 #ifndef MODULE
 struct net_device * __init hp_plus_probe(int unit)
 {
@@ -471,6 +465,12 @@ init_module(void)
 	if (found)
 		return 0;
 	return -ENXIO;
+}
+
+static void cleanup_card(struct net_device *dev)
+{
+	/* NB: hpp_close() handles free_irq */
+	release_region(dev->base_addr - NIC_OFFSET, HP_IO_EXTENT);
 }
 
 void
diff -urpN linux-2.6.15-rc7.src/drivers/net/hp.c linux-2.6.15-rc7.fix/drivers/net/hp.c
--- linux-2.6.15-rc7.src/drivers/net/hp.c	Mon Aug 29 02:41:01 2005
+++ linux-2.6.15-rc7.fix/drivers/net/hp.c	Sun Jan  1 16:31:36 2006
@@ -102,12 +102,6 @@ static int __init do_hp_probe(struct net
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr - NIC_OFFSET, HP_IO_EXTENT);
-}
-
 #ifndef MODULE
 struct net_device * __init hp_probe(int unit)
 {
@@ -442,6 +436,12 @@ init_module(void)
 	if (found)
 		return 0;
 	return -ENXIO;
+}
+
+static void cleanup_card(struct net_device *dev)
+{
+	free_irq(dev->irq, dev);
+	release_region(dev->base_addr - NIC_OFFSET, HP_IO_EXTENT);
 }
 
 void
diff -urpN linux-2.6.15-rc7.src/drivers/net/lance.c linux-2.6.15-rc7.fix/drivers/net/lance.c
--- linux-2.6.15-rc7.src/drivers/net/lance.c	Fri Dec 30 14:17:46 2005
+++ linux-2.6.15-rc7.fix/drivers/net/lance.c	Sun Jan  1 16:32:50 2006
@@ -309,17 +309,6 @@ static void lance_tx_timeout (struct net
 
 
 
-static void cleanup_card(struct net_device *dev)
-{
-	struct lance_private *lp = dev->priv;
-	if (dev->dma != 4)
-		free_dma(dev->dma);
-	release_region(dev->base_addr, LANCE_TOTAL_SIZE);
-	kfree(lp->tx_bounce_buffs);
-	kfree((void*)lp->rx_buffs);
-	kfree(lp);
-}
-
 #ifdef MODULE
 #define MAX_CARDS		8	/* Max number of interfaces (cards) per module */
 
@@ -365,6 +354,17 @@ int init_module(void)
 	if (found != 0)
 		return 0;
 	return -ENXIO;
+}
+
+static void cleanup_card(struct net_device *dev)
+{
+	struct lance_private *lp = dev->priv;
+	if (dev->dma != 4)
+		free_dma(dev->dma);
+	release_region(dev->base_addr, LANCE_TOTAL_SIZE);
+	kfree(lp->tx_bounce_buffs);
+	kfree((void*)lp->rx_buffs);
+	kfree(lp);
 }
 
 void cleanup_module(void)
diff -urpN linux-2.6.15-rc7.src/drivers/net/lne390.c linux-2.6.15-rc7.fix/drivers/net/lne390.c
--- linux-2.6.15-rc7.src/drivers/net/lne390.c	Fri Dec 30 14:17:47 2005
+++ linux-2.6.15-rc7.fix/drivers/net/lne390.c	Sun Jan  1 16:33:51 2006
@@ -145,13 +145,6 @@ static int __init do_lne390_probe(struct
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr, LNE390_IO_EXTENT);
-	iounmap(ei_status.mem);
-}
-
 #ifndef MODULE
 struct net_device * __init lne390_probe(int unit)
 {
@@ -438,6 +431,13 @@ int init_module(void)
 	if (found)
 		return 0;
 	return -ENXIO;
+}
+
+static void cleanup_card(struct net_device *dev)
+{
+	free_irq(dev->irq, dev);
+	release_region(dev->base_addr, LNE390_IO_EXTENT);
+	iounmap(ei_status.mem);
 }
 
 void cleanup_module(void)
diff -urpN linux-2.6.15-rc7.src/drivers/net/ne.c linux-2.6.15-rc7.fix/drivers/net/ne.c
--- linux-2.6.15-rc7.src/drivers/net/ne.c	Fri Dec 30 14:17:47 2005
+++ linux-2.6.15-rc7.fix/drivers/net/ne.c	Sun Jan  1 16:31:54 2006
@@ -212,15 +212,6 @@ static int __init do_ne_probe(struct net
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	struct pnp_dev *idev = (struct pnp_dev *)ei_status.priv;
-	if (idev)
-		pnp_device_detach(idev);
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr, NE_IO_EXTENT);
-}
-
 #ifndef MODULE
 struct net_device * __init ne_probe(int unit)
 {
@@ -857,6 +848,15 @@ int init_module(void)
 	if (found)
 		return 0;
 	return -ENODEV;
+}
+
+static void cleanup_card(struct net_device *dev)
+{
+	struct pnp_dev *idev = (struct pnp_dev *)ei_status.priv;
+	if (idev)
+		pnp_device_detach(idev);
+	free_irq(dev->irq, dev);
+	release_region(dev->base_addr, NE_IO_EXTENT);
 }
 
 void cleanup_module(void)
diff -urpN linux-2.6.15-rc7.src/drivers/net/ne2.c linux-2.6.15-rc7.fix/drivers/net/ne2.c
--- linux-2.6.15-rc7.src/drivers/net/ne2.c	Mon Aug 29 02:41:01 2005
+++ linux-2.6.15-rc7.fix/drivers/net/ne2.c	Sun Jan  1 16:32:18 2006
@@ -278,14 +278,6 @@ static int __init do_ne2_probe(struct ne
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	mca_mark_as_unused(ei_status.priv);
-	mca_set_adapter_procfn( ei_status.priv, NULL, NULL);
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr, NE_IO_EXTENT);
-}
-
 #ifndef MODULE
 struct net_device * __init ne2_probe(int unit)
 {
@@ -810,6 +802,14 @@ int init_module(void)
 		return 0;
 	printk(KERN_WARNING "ne2.c: No NE/2 card found\n");
 	return -ENXIO;
+}
+
+static void cleanup_card(struct net_device *dev)
+{
+	mca_mark_as_unused(ei_status.priv);
+	mca_set_adapter_procfn( ei_status.priv, NULL, NULL);
+	free_irq(dev->irq, dev);
+	release_region(dev->base_addr, NE_IO_EXTENT);
 }
 
 void cleanup_module(void)
diff -urpN linux-2.6.15-rc7.src/drivers/net/smc-ultra.c linux-2.6.15-rc7.fix/drivers/net/smc-ultra.c
--- linux-2.6.15-rc7.src/drivers/net/smc-ultra.c	Fri Dec 30 14:11:14 2005
+++ linux-2.6.15-rc7.fix/drivers/net/smc-ultra.c	Sun Jan  1 16:53:50 2006
@@ -168,18 +168,6 @@ static int __init do_ultra_probe(struct 
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	/* NB: ultra_close_card() does free_irq */
-#ifdef __ISAPNP__
-	struct pnp_dev *idev = (struct pnp_dev *)ei_status.priv;
-	if (idev)
-		pnp_device_detach(idev);
-#endif
-	release_region(dev->base_addr - ULTRA_NIC_OFFSET, ULTRA_IO_EXTENT);
-	iounmap(ei_status.mem);
-}
-
 #ifndef MODULE
 struct net_device * __init ultra_probe(int unit)
 {
@@ -592,6 +580,18 @@ init_module(void)
 	if (found)
 		return 0;
 	return -ENXIO;
+}
+
+static void cleanup_card(struct net_device *dev)
+{
+	/* NB: ultra_close_card() does free_irq */
+#ifdef __ISAPNP__
+	struct pnp_dev *idev = (struct pnp_dev *)ei_status.priv;
+	if (idev)
+		pnp_device_detach(idev);
+#endif
+	release_region(dev->base_addr - ULTRA_NIC_OFFSET, ULTRA_IO_EXTENT);
+	iounmap(ei_status.mem);
 }
 
 void
diff -urpN linux-2.6.15-rc7.src/drivers/net/wd.c linux-2.6.15-rc7.fix/drivers/net/wd.c
--- linux-2.6.15-rc7.src/drivers/net/wd.c	Mon Aug 29 02:41:01 2005
+++ linux-2.6.15-rc7.fix/drivers/net/wd.c	Sun Jan  1 16:32:05 2006
@@ -127,13 +127,6 @@ static int __init do_wd_probe(struct net
 	return -ENODEV;
 }
 
-static void cleanup_card(struct net_device *dev)
-{
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr - WD_NIC_OFFSET, WD_IO_EXTENT);
-	iounmap(ei_status.mem);
-}
-
 #ifndef MODULE
 struct net_device * __init wd_probe(int unit)
 {
@@ -536,6 +529,13 @@ init_module(void)
 	if (found)
 		return 0;
 	return -ENXIO;
+}
+
+static void cleanup_card(struct net_device *dev)
+{
+	free_irq(dev->irq, dev);
+	release_region(dev->base_addr - WD_NIC_OFFSET, WD_IO_EXTENT);
+	iounmap(ei_status.mem);
 }
 
 void

--Boundary-00=_k/iuDK+pk6yEnWv--
