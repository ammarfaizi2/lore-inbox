Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318213AbSIEVyT>; Thu, 5 Sep 2002 17:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318211AbSIEVxo>; Thu, 5 Sep 2002 17:53:44 -0400
Received: from hermes.domdv.de ([193.102.202.1]:41225 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S318213AbSIEVvt>;
	Thu, 5 Sep 2002 17:51:49 -0400
Message-ID: <3D77C8DE.3040005@domdv.de>
Date: Thu, 05 Sep 2002 23:13:02 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.20pre5 trivial compiler warning fix for irport.c
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070503060402060603030900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070503060402060603030900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

the attached patch fixes deprecated usage warnings for __FUNCTION__ in 
irport.c.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--------------070503060402060603030900
Content-Type: text/plain;
 name="irport.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irport.c.diff"

--- drivers/net/irda/irport.c.orig	2002-09-05 22:58:26.000000000 +0200
+++ drivers/net/irda/irport.c	2002-09-05 23:09:16.000000000 +0200
@@ -126,7 +126,7 @@
 {
  	int i;
 
-        IRDA_DEBUG( 4, __FUNCTION__ "()\n");
+        IRDA_DEBUG( 4, "%s()\n", __FUNCTION__);
 
 	for (i=0; i < 4; i++) {
  		if (dev_self[i])
@@ -143,15 +143,15 @@
 	void *ret;
 	int err;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	/*
 	 *  Allocate new instance of the driver
 	 */
 	self = kmalloc(sizeof(struct irport_cb), GFP_KERNEL);
 	if (!self) {
-		ERROR(__FUNCTION__ "(), can't allocate memory for "
-		      "control block!\n");
+		ERROR("%s(), can't allocate memory for "
+		      "control block!\n", __FUNCTION__);
 		return NULL;
 	}
 	memset(self, 0, sizeof(struct irport_cb));
@@ -171,8 +171,8 @@
 	/* Lock the port that we need */
 	ret = request_region(self->io.sir_base, self->io.sir_ext, driver_name);
 	if (!ret) { 
-		IRDA_DEBUG(0, __FUNCTION__ "(), can't get iobase of 0x%03x\n",
-			   self->io.sir_base);
+		IRDA_DEBUG(0, "%s(), can't get iobase of 0x%03x\n",
+			   __FUNCTION__, self->io.sir_base);
 		return NULL;
 	}
 
@@ -215,7 +215,7 @@
 	self->mode = IRDA_IRLAP;
 
 	if (!(dev = dev_alloc("irda%d", &err))) {
-		ERROR(__FUNCTION__ "(), dev_alloc() failed!\n");
+		ERROR("%s(), dev_alloc() failed!\n", __FUNCTION__);
 		return NULL;
 	}
 	self->netdev = dev;
@@ -243,7 +243,7 @@
 	err = register_netdevice(dev);
 	rtnl_unlock();
 	if (err) {
-		ERROR(__FUNCTION__ "(), register_netdev() failed!\n");
+		ERROR("%s(), register_netdev() failed!\n", __FUNCTION__);
 		return NULL;
 	}
 	MESSAGE("IrDA: Registered device %s\n", dev->name);
@@ -268,8 +268,8 @@
 	}
 
 	/* Release the IO-port that this driver is using */
-	IRDA_DEBUG(0 , __FUNCTION__ "(), Releasing Region %03x\n", 
-		   self->io.sir_base);
+	IRDA_DEBUG(0 , "%s(), Releasing Region %03x\n", 
+		   __FUNCTION__, self->io.sir_base);
 	release_region(self->io.sir_base, self->io.sir_ext);
 
 	if (self->tx_buff.head)
@@ -332,7 +332,7 @@
  */
 int irport_probe(int iobase)
 {
-	IRDA_DEBUG(4, __FUNCTION__ "(), iobase=%#x\n", iobase);
+	IRDA_DEBUG(4, "%s(), iobase=%#x\n", __FUNCTION__, iobase);
 
 	return 0;
 }
@@ -352,7 +352,7 @@
 	int lcr;    /* Line control reg */
 	int divisor;
 
-	IRDA_DEBUG(0, __FUNCTION__ "(), Setting speed to: %d\n", speed);
+	IRDA_DEBUG(0, "%s(), Setting speed to: %d\n", __FUNCTION__, speed);
 
 	ASSERT(self != NULL, return;);
 
@@ -407,7 +407,7 @@
 	__u32 speed = (__u32) task->param;
 	int ret = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), <%ld>\n", jiffies); 
+	IRDA_DEBUG(2, "%s(), <%ld>\n", __FUNCTION__, jiffies); 
 
 	self = (struct irport_cb *) task->instance;
 
@@ -449,8 +449,8 @@
 			irda_task_next_state(task, IRDA_TASK_CHILD_DONE);
 		break;
 	case IRDA_TASK_CHILD_WAIT:
-		WARNING(__FUNCTION__ 
-			"(), changing speed of dongle timed out!\n");
+		WARNING("%s(), changing speed of dongle timed out!\n",
+			__FUNCTION__);
 		ret = -1;		
 		break;
 	case IRDA_TASK_CHILD_DONE:
@@ -460,7 +460,7 @@
 		irda_task_next_state(task, IRDA_TASK_DONE);
 		break;
 	default:
-		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		ERROR("%s(), unknown state %d\n", __FUNCTION__, task->state);
 		irda_task_next_state(task, IRDA_TASK_DONE);
 		ret = -1;
 		break;
@@ -483,7 +483,7 @@
 
 	ASSERT(self != NULL, return;);
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	iobase = self->io.sir_base;
 
@@ -501,7 +501,7 @@
 		 *  if we need to change the speed of the hardware
 		 */
 		if (self->new_speed) {
-			IRDA_DEBUG(5, __FUNCTION__ "(), Changing speed!\n");
+			IRDA_DEBUG(5, "%s(), Changing speed!\n", __FUNCTION__);
 			irda_task_execute(self, __irport_change_speed, 
 					  irport_change_speed_complete, 
 					  NULL, (void *) self->new_speed);
@@ -541,7 +541,7 @@
 
 	/* Tx FIFO should be empty! */
 	if (!(inb(iobase+UART_LSR) & UART_LSR_THRE)) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), failed, fifo not empty!\n");
+		IRDA_DEBUG(0, "%s(), failed, fifo not empty!\n", __FUNCTION__);
 		return 0;
 	}
         
@@ -566,7 +566,7 @@
 {
 	struct irport_cb *self;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	self = (struct irport_cb *) task->instance;
 
@@ -617,7 +617,7 @@
 	int iobase;
 	s32 speed;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	ASSERT(dev != NULL, return 0;);
 	
@@ -688,7 +688,7 @@
 
 		/* Make sure we don't stay here to long */
 		if (boguscount++ > 32) {
-			IRDA_DEBUG(2,__FUNCTION__ "(), breaking!\n");
+			IRDA_DEBUG(2, "%s(), breaking!\n", __FUNCTION__);
 			break;
 		}
 	} while (inb(iobase+UART_LSR) & UART_LSR_DR);	
@@ -708,7 +708,7 @@
 	int iir, lsr;
 
 	if (!dev) {
-		WARNING(__FUNCTION__ "() irq %d for unknown device.\n", irq);
+		WARNING("%s() irq %d for unknown device.\n", __FUNCTION__, irq);
 		return;
 	}
 	self = (struct irport_cb *) dev->priv;
@@ -722,13 +722,12 @@
 		/* Clear interrupt */
 		lsr = inb(iobase+UART_LSR);
 
-		IRDA_DEBUG(4, __FUNCTION__ 
-			   "(), iir=%02x, lsr=%02x, iobase=%#x\n", 
-			   iir, lsr, iobase);
+		IRDA_DEBUG(4, "%s(), iir=%02x, lsr=%02x, iobase=%#x\n", 
+			   __FUNCTION__, iir, lsr, iobase);
 
 		switch (iir) {
 		case UART_IIR_RLSI:
-			IRDA_DEBUG(2, __FUNCTION__ "(), RLSI\n");
+			IRDA_DEBUG(2, "%s(), RLSI\n", __FUNCTION__);
 			break;
 		case UART_IIR_RDI:
 			/* Receive interrupt */
@@ -740,7 +739,8 @@
 				irport_write_wakeup(self);
 			break;
 		default:
-			IRDA_DEBUG(0, __FUNCTION__ "(), unhandled IIR=%#x\n", iir);
+			IRDA_DEBUG(0, "%s(), unhandled IIR=%#x\n",
+				__FUNCTION__, iir);
 			break;
 		} 
 		
@@ -775,7 +775,7 @@
 	int iobase;
 	char hwname[16];
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 	
 	ASSERT(dev != NULL, return -1;);
 	self = (struct irport_cb *) dev->priv;
@@ -784,8 +784,8 @@
 
 	if (request_irq(self->io.irq, self->interrupt, 0, dev->name, 
 			(void *) dev)) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), unable to allocate irq=%d\n",
-			   self->io.irq);
+		IRDA_DEBUG(0, "%s(), unable to allocate irq=%d\n",
+			   __FUNCTION__, self->io.irq);
 		return -EAGAIN;
 	}
 
@@ -822,7 +822,7 @@
 	struct irport_cb *self;
 	int iobase;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(dev != NULL, return -1;);
 	self = (struct irport_cb *) dev->priv;
@@ -863,7 +863,7 @@
 
 	/* Wait until Tx FIFO is empty */
 	while (!(inb(iobase+UART_LSR) & UART_LSR_THRE)) {
-		IRDA_DEBUG(2, __FUNCTION__ "(), waiting!\n");
+		IRDA_DEBUG(2, "%s(), waiting!\n", __FUNCTION__);
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(MSECS_TO_JIFFIES(60));
 	}
@@ -918,7 +918,7 @@
 
 	/* Tx FIFO should be empty! */
 	if (!(inb(iobase+UART_LSR) & UART_LSR_THRE)) {
-		IRDA_DEBUG( 0, __FUNCTION__ "(), failed, fifo not empty!\n");
+		IRDA_DEBUG( 0, "%s(), failed, fifo not empty!\n", __FUNCTION__);
 		return -1;
 	}
         
@@ -952,7 +952,7 @@
 
 	ASSERT(self != NULL, return -1;);
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
+	IRDA_DEBUG(2, "%s(), %s, (cmd=0x%X)\n", __FUNCTION__, dev->name, cmd);
 	
 	/* Disable interrupts & save flags */
 	save_flags(flags);

--------------070503060402060603030900--


