Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262517AbRE3AnS>; Tue, 29 May 2001 20:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262511AbRE3AnI>; Tue, 29 May 2001 20:43:08 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:783 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262500AbRE3AnF>; Tue, 29 May 2001 20:43:05 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105300044.CAA04542@green.mif.pg.gda.pl>
Subject: [PATCH] net #6
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik), Philip.Blundell@pobox.com
Date: Wed, 30 May 2001 02:44:03 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch removes unnecessary #ifdefs from eexpress.c

Andrzej

************************** PATCH 6 *******************************
diff -uNr linux-2.4.5-ac4/drivers/net/eexpress.c linux/drivers/net/eexpress.c
--- linux-2.4.5-ac4/drivers/net/eexpress.c	Wed May 30 01:08:54 2001
+++ linux/drivers/net/eexpress.c	Wed May 30 01:13:49 2001
@@ -574,9 +574,7 @@
 static void eexp_timeout(struct net_device *dev)
 {
 	struct net_local *lp = (struct net_local *)dev->priv;
-#ifdef CONFIG_SMP
-	unsigned long flags;
-#endif
+	unsigned long __attribute__((unused)) flags;
 	int status;
 	
 	disable_irq(dev->irq);
@@ -586,10 +584,7 @@
 	 *	lets make it work first..
 	 */
 	 
-#ifdef CONFIG_SMP
 	spin_lock_irqsave(&lp->lock, flags);
-#endif
-
 	status = scb_status(dev);
 	unstick_cu(dev);
 	printk(KERN_INFO "%s: transmit timed out, %s?\n", dev->name,
@@ -602,9 +597,7 @@
 		outb(0,dev->base_addr+SIGNAL_CA);
 	}
 	netif_wake_queue(dev);	
-#ifdef CONFIG_SMP
 	spin_unlock_irqrestore(&lp->lock, flags);
-#endif
 }
 
 /*
@@ -614,9 +607,7 @@
 static int eexp_xmit(struct sk_buff *buf, struct net_device *dev)
 {
 	struct net_local *lp = (struct net_local *)dev->priv;
-#ifdef CONFIG_SMP
-	unsigned long flags;
-#endif
+	unsigned long __attribute__((unused)) flags;
 
 #if NET_DEBUG > 6
 	printk(KERN_DEBUG "%s: eexp_xmit()\n", dev->name);
@@ -629,10 +620,7 @@
 	 *	lets make it work first..
 	 */
 	 
-#ifdef CONFIG_SMP
 	spin_lock_irqsave(&lp->lock, flags);
-#endif
-  
 	{
 		unsigned short length = (ETH_ZLEN < buf->len) ? buf->len :
 			ETH_ZLEN;
@@ -643,9 +631,7 @@
 	        eexp_hw_tx_pio(dev,data,length);
 	}
 	dev_kfree_skb(buf);
-#ifdef CONFIG_SMP
 	spin_unlock_irqrestore(&lp->lock, flags);
-#endif
 	enable_irq(dev->irq);
 	return 0;
 }


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
