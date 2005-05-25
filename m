Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVEYGzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVEYGzS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbVEYGxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:53:37 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:32087 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262292AbVEYGki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:40:38 -0400
Message-Id: <20050525064006.574361000.dtor_core@ameritech.net>
References: <20050525063738.864916000.dtor_core@ameritech.net>
Date: Wed, 25 May 2005 01:37:47 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: irda-users@lists.sourceforge.net
Cc: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: [patch 9/9] smsc-ircc2: dont use void * where specific type will do
Content-Disposition: inline; filename=ircc2-cleanup2.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRDA: smsc-ircc2 - do not over-use void * pointers, use specific
      types wherever possible.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 smsc-ircc2.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

Index: dtor/drivers/net/irda/smsc-ircc2.c
===================================================================
--- dtor.orig/drivers/net/irda/smsc-ircc2.c
+++ dtor/drivers/net/irda/smsc-ircc2.c
@@ -172,8 +172,8 @@ static int  smsc_ircc_hard_xmit_sir(stru
 static int  smsc_ircc_hard_xmit_fir(struct sk_buff *skb, struct net_device *dev);
 static void smsc_ircc_dma_xmit(struct smsc_ircc_cb *self, int bofs);
 static void smsc_ircc_dma_xmit_complete(struct smsc_ircc_cb *self);
-static void smsc_ircc_change_speed(void *priv, u32 speed);
-static void smsc_ircc_set_sir_speed(void *priv, u32 speed);
+static void smsc_ircc_change_speed(struct smsc_ircc_cb *self, u32 speed);
+static void smsc_ircc_set_sir_speed(struct smsc_ircc_cb *self, u32 speed);
 static irqreturn_t smsc_ircc_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static irqreturn_t smsc_ircc_interrupt_sir(struct net_device *dev);
 static void smsc_ircc_sir_start(struct smsc_ircc_cb *self);
@@ -966,9 +966,8 @@ static void smsc_ircc_fir_stop(struct sm
  * This function *must* be called with spinlock held, because it may
  * be called from the irq handler. - Jean II
  */
-static void smsc_ircc_change_speed(void *priv, u32 speed)
+static void smsc_ircc_change_speed(struct smsc_ircc_cb *self, u32 speed)
 {
-	struct smsc_ircc_cb *self = (struct smsc_ircc_cb *) priv;
 	struct net_device *dev;
 	int last_speed_was_sir;
 
@@ -1033,9 +1032,8 @@ static void smsc_ircc_change_speed(void 
  *    Set speed of IrDA port to specified baudrate
  *
  */
-void smsc_ircc_set_sir_speed(void *priv, __u32 speed)
+void smsc_ircc_set_sir_speed(struct smsc_ircc_cb *self, __u32 speed)
 {
-	struct smsc_ircc_cb *self = (struct smsc_ircc_cb *) priv;
 	int iobase;
 	int fcr;    /* FIFO control reg */
 	int lcr;    /* Line control reg */

