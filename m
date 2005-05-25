Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVEYGzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVEYGzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVEYGxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:53:25 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:16516 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262290AbVEYGke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:40:34 -0400
Message-Id: <20050525064006.458654000.dtor_core@ameritech.net>
References: <20050525063738.864916000.dtor_core@ameritech.net>
Date: Wed, 25 May 2005 01:37:46 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: irda-users@lists.sourceforge.net
Cc: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: [patch 8/9] smsc-ircc2: use netdev_priv()
Content-Disposition: inline; filename=ircc2-netdev-priv.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRDA: smsc-ircc2 - use netdev_priv() instead of accessing pointer
      directly.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 smsc-ircc2.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

Index: dtor/drivers/net/irda/smsc-ircc2.c
===================================================================
--- dtor.orig/drivers/net/irda/smsc-ircc2.c
+++ dtor/drivers/net/irda/smsc-ircc2.c
@@ -426,7 +426,7 @@ static int __init smsc_ircc_open(unsigne
 	dev->do_ioctl        = smsc_ircc_net_ioctl;
 	dev->get_stats	     = smsc_ircc_net_get_stats;
 
-	self = dev->priv;
+	self = netdev_priv(dev);
 	self->netdev = dev;
 
 	/* Make ifconfig display some details */
@@ -693,7 +693,7 @@ static int smsc_ircc_net_ioctl(struct ne
 
 	IRDA_ASSERT(dev != NULL, return -1;);
 
-	self = dev->priv;
+	self = netdev_priv(dev);
 
 	IRDA_ASSERT(self != NULL, return -1;);
 
@@ -740,7 +740,7 @@ static int smsc_ircc_net_ioctl(struct ne
 
 static struct net_device_stats *smsc_ircc_net_get_stats(struct net_device *dev)
 {
-	struct smsc_ircc_cb *self = (struct smsc_ircc_cb *) dev->priv;
+	struct smsc_ircc_cb *self = netdev_priv(dev);
 
 	return &self->stats;
 }
@@ -755,11 +755,9 @@ static struct net_device_stats *smsc_irc
 
 static void smsc_ircc_timeout(struct net_device *dev)
 {
-	struct smsc_ircc_cb *self;
+	struct smsc_ircc_cb *self = netdev_priv(dev);
 	unsigned long flags;
 
-	self = (struct smsc_ircc_cb *) dev->priv;
-
 	IRDA_WARNING("%s: transmit timed out, changing speed to: %d\n",
 		     dev->name, self->io.speed);
 	spin_lock_irqsave(&self->lock, flags);
@@ -788,7 +786,7 @@ int smsc_ircc_hard_xmit_sir(struct sk_bu
 
 	IRDA_ASSERT(dev != NULL, return 0;);
 
-	self = (struct smsc_ircc_cb *) dev->priv;
+	self = netdev_priv(dev);
 	IRDA_ASSERT(self != NULL, return 0;);
 
 	netif_stop_queue(dev);
@@ -1096,7 +1094,7 @@ static int smsc_ircc_hard_xmit_fir(struc
 	int mtt;
 
 	IRDA_ASSERT(dev != NULL, return 0;);
-	self = (struct smsc_ircc_cb *) dev->priv;
+	self = netdev_priv(dev);
 	IRDA_ASSERT(self != NULL, return 0;);
 
 	netif_stop_queue(dev);
@@ -1427,7 +1425,8 @@ static irqreturn_t smsc_ircc_interrupt(i
 		       driver_name, irq);
 		goto irq_ret;
 	}
-	self = (struct smsc_ircc_cb *) dev->priv;
+
+	self = netdev_priv(dev);
 	IRDA_ASSERT(self != NULL, return IRQ_NONE;);
 
 	/* Serialise the interrupt handler in various CPUs, stop Tx path */
@@ -1485,7 +1484,7 @@ static irqreturn_t smsc_ircc_interrupt(i
  */
 static irqreturn_t smsc_ircc_interrupt_sir(struct net_device *dev)
 {
-	struct smsc_ircc_cb *self = dev->priv;
+	struct smsc_ircc_cb *self = netdev_priv(dev);
 	int boguscount = 0;
 	int iobase;
 	int iir, lsr;
@@ -1576,7 +1575,7 @@ static int smsc_ircc_net_open(struct net
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
 	IRDA_ASSERT(dev != NULL, return -1;);
-	self = (struct smsc_ircc_cb *) dev->priv;
+	self = netdev_priv(dev);
 	IRDA_ASSERT(self != NULL, return 0;);
 
 	if (self->io.suspended) {
@@ -1637,7 +1636,7 @@ static int smsc_ircc_net_close(struct ne
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
 	IRDA_ASSERT(dev != NULL, return -1;);
-	self = (struct smsc_ircc_cb *) dev->priv;
+	self = netdev_priv(dev);
 	IRDA_ASSERT(self != NULL, return 0;);
 
 	/* Stop device */

