Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263487AbVCEAvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbVCEAvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbVCEAro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:47:44 -0500
Received: from palrel11.hp.com ([156.153.255.246]:7402 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263339AbVCEAav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:30:51 -0500
Date: Fri, 4 Mar 2005 16:30:42 -0800
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] remove unneeded EXPORT_SYMBOL's from irport.c
Message-ID: <20050305003042.GI23895@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irXXX_irport_exports.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Adrian Bunk>
	o [FEATURE] make needlessly global code static
	o [FEATURE] remove unneeded EXPORT_SYMBOL's from irport.c
Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


--- linux-2.6.11-rc3-mm2-full/drivers/net/irda/irtty-sir.c.old	2005-02-16 15:40:41.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/irda/irtty-sir.c	2005-02-16 15:40:52.000000000 +0100
@@ -413,7 +413,7 @@
 
 /* ------------------------------------------------------- */
 
-struct sir_driver sir_tty_drv = {
+static struct sir_driver sir_tty_drv = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "sir_tty",
 	.start_dev		= irtty_start_dev,
--- linux-2.6.11-rc3-mm2-full/drivers/net/irda/smsc-ircc2.c.old	2005-02-16 15:41:08.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/irda/smsc-ircc2.c	2005-02-16 15:41:17.000000000 +0100
@@ -203,7 +203,7 @@
 
 /* Transceivers for SMSC-ircc */
 
-smsc_transceiver_t smsc_transceivers[]=
+static smsc_transceiver_t smsc_transceivers[]=
 {
 	{ "Toshiba Satellite 1800 (GP data pin select)", smsc_ircc_set_transceiver_toshiba_sat1800, smsc_ircc_probe_transceiver_toshiba_sat1800},
 	{ "Fast pin select", smsc_ircc_set_transceiver_smsc_ircc_fast_pin_select, smsc_ircc_probe_transceiver_smsc_ircc_fast_pin_select},
--- linux-2.6.11-rc3-mm2-full/drivers/net/irda/irport.h.old	2005-02-16 15:42:36.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/irda/irport.h	2005-02-16 15:43:24.000000000 +0100
@@ -77,14 +77,4 @@
 	int (*interrupt)(int irq, void *dev_id, struct pt_regs *regs);
 };
 
-struct irport_cb *irport_open(int i, unsigned int iobase, unsigned int irq);
-int  irport_close(struct irport_cb *self);
-void irport_start(struct irport_cb *self);
-void irport_stop(struct irport_cb *self);
-void irport_change_speed(void *priv, __u32 speed);
-irqreturn_t irport_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-int  irport_hard_xmit(struct sk_buff *skb, struct net_device *dev);
-int  irport_net_open(struct net_device *dev);
-int  irport_net_close(struct net_device *dev);
-
 #endif /* IRPORT_H */
--- linux-2.6.11-rc3-mm2-full/drivers/net/irda/irport.c.old	2005-02-16 15:43:34.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/irda/irport.c	2005-02-16 15:49:06.000000000 +0100
@@ -87,50 +87,14 @@
 static int irport_change_speed_complete(struct irda_task *task);
 static void irport_timeout(struct net_device *dev);
 
-EXPORT_SYMBOL(irport_open);
-EXPORT_SYMBOL(irport_close);
-EXPORT_SYMBOL(irport_start);
-EXPORT_SYMBOL(irport_stop);
-EXPORT_SYMBOL(irport_interrupt);
-EXPORT_SYMBOL(irport_hard_xmit);
-EXPORT_SYMBOL(irport_timeout);
-EXPORT_SYMBOL(irport_change_speed);
-EXPORT_SYMBOL(irport_net_open);
-EXPORT_SYMBOL(irport_net_close);
+static irqreturn_t irport_interrupt(int irq, void *dev_id,
+				    struct pt_regs *regs);
+static int irport_hard_xmit(struct sk_buff *skb, struct net_device *dev);
+static void irport_change_speed(void *priv, __u32 speed);
+static int irport_net_open(struct net_device *dev);
+static int irport_net_close(struct net_device *dev);
 
-static int __init irport_init(void)
-{
- 	int i;
-
- 	for (i=0; (io[i] < 2000) && (i < 4); i++) {
- 		if (irport_open(i, io[i], irq[i]) != NULL)
- 			return 0;
- 	}
-	/* 
-	 * Maybe something failed, but we can still be usable for FIR drivers 
-	 */
- 	return 0;
-}
-
-/*
- * Function irport_cleanup ()
- *
- *    Close all configured ports
- *
- */
-static void __exit irport_cleanup(void)
-{
- 	int i;
-
-        IRDA_DEBUG( 4, "%s()\n", __FUNCTION__);
-
-	for (i=0; i < 4; i++) {
- 		if (dev_self[i])
- 			irport_close(dev_self[i]);
- 	}
-}
-
-struct irport_cb *
+static struct irport_cb *
 irport_open(int i, unsigned int iobase, unsigned int irq)
 {
 	struct net_device *dev;
@@ -254,7 +218,7 @@
 	return NULL;
 }
 
-int irport_close(struct irport_cb *self)
+static int irport_close(struct irport_cb *self)
 {
 	ASSERT(self != NULL, return -1;);
 
@@ -285,40 +249,40 @@
 	return 0;
 }
 
-void irport_start(struct irport_cb *self)
+static void irport_stop(struct irport_cb *self)
 {
 	int iobase;
 
 	iobase = self->io.sir_base;
 
-	irport_stop(self);
-	
 	/* We can't lock, we may be called from a FIR driver - Jean II */
 
-	/* Initialize UART */
-	outb(UART_LCR_WLEN8, iobase+UART_LCR);  /* Reset DLAB */
-	outb((UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2), iobase+UART_MCR);
+	/* We are not transmitting any more */
+	self->transmitting = 0;
+
+	/* Reset UART */
+	outb(0, iobase+UART_MCR);
 	
-	/* Turn on interrups */
-	outb(UART_IER_RLSI | UART_IER_RDI |UART_IER_THRI, iobase+UART_IER);
+	/* Turn off interrupts */
+	outb(0, iobase+UART_IER);
 }
 
-void irport_stop(struct irport_cb *self)
+static void irport_start(struct irport_cb *self)
 {
 	int iobase;
 
 	iobase = self->io.sir_base;
 
+	irport_stop(self);
+	
 	/* We can't lock, we may be called from a FIR driver - Jean II */
 
-	/* We are not transmitting any more */
-	self->transmitting = 0;
-
-	/* Reset UART */
-	outb(0, iobase+UART_MCR);
+	/* Initialize UART */
+	outb(UART_LCR_WLEN8, iobase+UART_LCR);  /* Reset DLAB */
+	outb((UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2), iobase+UART_MCR);
 	
-	/* Turn off interrupts */
-	outb(0, iobase+UART_IER);
+	/* Turn on interrups */
+	outb(UART_IER_RLSI | UART_IER_RDI |UART_IER_THRI, iobase+UART_IER);
 }
 
 /*
@@ -368,7 +332,7 @@
  *
  * This function should be called with irq off and spin-lock.
  */
-void irport_change_speed(void *priv, __u32 speed)
+static void irport_change_speed(void *priv, __u32 speed)
 {
 	struct irport_cb *self = (struct irport_cb *) priv;
 	int iobase; 
@@ -619,7 +583,7 @@
  *    waits until the next transmitt interrupt, and continues until the
  *    frame is transmitted.
  */
-int irport_hard_xmit(struct sk_buff *skb, struct net_device *dev)
+static int irport_hard_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct irport_cb *self;
 	unsigned long flags;
@@ -814,7 +778,8 @@
  *
  *    Interrupt handler
  */
-irqreturn_t irport_interrupt(int irq, void *dev_id, struct pt_regs *regs) 
+static irqreturn_t irport_interrupt(int irq, void *dev_id,
+				    struct pt_regs *regs) 
 {
 	struct net_device *dev = (struct net_device *) dev_id;
 	struct irport_cb *self;
@@ -888,7 +853,7 @@
  *    Network device is taken up. Usually this is done by "ifconfig irda0 up" 
  *   
  */
-int irport_net_open(struct net_device *dev)
+static int irport_net_open(struct net_device *dev)
 {
 	struct irport_cb *self;
 	int iobase;
@@ -941,7 +906,7 @@
  *    Network device is taken down. Usually this is done by 
  *    "ifconfig irda0 down" 
  */
-int irport_net_close(struct net_device *dev)
+static int irport_net_close(struct net_device *dev)
 {
 	struct irport_cb *self;
 	int iobase;
@@ -1134,6 +1099,38 @@
 	return &self->stats;
 }
 
+static int __init irport_init(void)
+{
+ 	int i;
+
+ 	for (i=0; (io[i] < 2000) && (i < 4); i++) {
+ 		if (irport_open(i, io[i], irq[i]) != NULL)
+ 			return 0;
+ 	}
+	/* 
+	 * Maybe something failed, but we can still be usable for FIR drivers 
+	 */
+ 	return 0;
+}
+
+/*
+ * Function irport_cleanup ()
+ *
+ *    Close all configured ports
+ *
+ */
+static void __exit irport_cleanup(void)
+{
+ 	int i;
+
+        IRDA_DEBUG( 4, "%s()\n", __FUNCTION__);
+
+	for (i=0; i < 4; i++) {
+ 		if (dev_self[i])
+ 			irport_close(dev_self[i]);
+ 	}
+}
+
 MODULE_PARM(io, "1-4i");
 MODULE_PARM_DESC(io, "Base I/O addresses");
 MODULE_PARM(irq, "1-4i");

