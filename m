Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbUBZDSC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUBZDQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:16:20 -0500
Received: from palrel12.hp.com ([156.153.255.237]:63724 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262627AbUBZDOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:14:46 -0500
Date: Wed, 25 Feb 2004 19:14:44 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] setup_dma
Message-ID: <20040226031444.GF32263@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irXXX_setup_dma.diff :
~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] Rename setup_dma to irda_setup_dma
		=> reduce namepace pollution


diff -Nru a/drivers/net/irda/ali-ircc.c b/drivers/net/irda/ali-ircc.c
--- a/drivers/net/irda/ali-ircc.c	Mon Feb 16 10:58:01 2004
+++ b/drivers/net/irda/ali-ircc.c	Mon Feb 16 10:58:01 2004
@@ -1571,10 +1571,10 @@
 	
 	self->io.direction = IO_XMIT;
 	
-	setup_dma(self->io.dma, 
-		  self->tx_fifo.queue[self->tx_fifo.ptr].start, 
-		  self->tx_fifo.queue[self->tx_fifo.ptr].len, 
-		  DMA_TX_MODE);
+	irda_setup_dma(self->io.dma, 
+		       self->tx_fifo.queue[self->tx_fifo.ptr].start, 
+		       self->tx_fifo.queue[self->tx_fifo.ptr].len, 
+		       DMA_TX_MODE);
 		
 	/* Reset Tx FIFO */
 	switch_bank(iobase, BANK0);
@@ -1724,8 +1724,8 @@
 	self->st_fifo.len = self->st_fifo.pending_bytes = 0;
 	self->st_fifo.tail = self->st_fifo.head = 0;
 		
-	setup_dma(self->io.dma, self->rx_buff.data, self->rx_buff.truesize, 
-		  DMA_RX_MODE);	
+	irda_setup_dma(self->io.dma, self->rx_buff.data, 
+		       self->rx_buff.truesize, DMA_RX_MODE);	
 	 
 	/* Set Receive Mode,Brick Wall */
 	//switch_bank(iobase, BANK0);
diff -Nru a/drivers/net/irda/nsc-ircc.c b/drivers/net/irda/nsc-ircc.c
--- a/drivers/net/irda/nsc-ircc.c	Mon Feb 16 10:58:01 2004
+++ b/drivers/net/irda/nsc-ircc.c	Mon Feb 16 10:58:01 2004
@@ -1408,10 +1408,10 @@
 	switch_bank(iobase, BANK2);
 	outb(ECR1_DMASWP|ECR1_DMANF|ECR1_EXT_SL, iobase+ECR1);
 	
-	setup_dma(self->io.dma, 
-		  self->tx_fifo.queue[self->tx_fifo.ptr].start, 
-		  self->tx_fifo.queue[self->tx_fifo.ptr].len, 
-		  DMA_TX_MODE);
+	irda_setup_dma(self->io.dma, 
+		       self->tx_fifo.queue[self->tx_fifo.ptr].start, 
+		       self->tx_fifo.queue[self->tx_fifo.ptr].len, 
+		       DMA_TX_MODE);
 
 	/* Enable DMA and SIR interaction pulse */
  	switch_bank(iobase, BANK0);	
@@ -1566,8 +1566,8 @@
 	self->st_fifo.len = self->st_fifo.pending_bytes = 0;
 	self->st_fifo.tail = self->st_fifo.head = 0;
 	
-	setup_dma(self->io.dma, self->rx_buff.data, self->rx_buff.truesize, 
-		  DMA_RX_MODE);
+	irda_setup_dma(self->io.dma, self->rx_buff.data, 
+		       self->rx_buff.truesize, DMA_RX_MODE);
 
 	/* Enable DMA */
 	switch_bank(iobase, BANK0);
diff -Nru a/drivers/net/irda/smsc-ircc2.c b/drivers/net/irda/smsc-ircc2.c
--- a/drivers/net/irda/smsc-ircc2.c	Mon Feb 16 10:58:01 2004
+++ b/drivers/net/irda/smsc-ircc2.c	Mon Feb 16 10:58:01 2004
@@ -1159,8 +1159,8 @@
 	     IRCC_CFGB_DMA_BURST, iobase+IRCC_SCE_CFGB);
 
 	/* Setup DMA controller (must be done after enabling chip DMA) */
-	setup_dma(self->io.dma, self->tx_buff.data, self->tx_buff.len, 
-		  DMA_TX_MODE);
+	irda_setup_dma(self->io.dma, self->tx_buff.data, self->tx_buff.len, 
+		       DMA_TX_MODE);
 
 	/* Enable interrupt */
 
@@ -1249,8 +1249,8 @@
 	outb(2050 & 0xff, iobase+IRCC_RX_SIZE_LO);
 
 	/* Setup DMA controller */
-	setup_dma(self->io.dma, self->rx_buff.data, self->rx_buff.truesize, 
-		  DMA_RX_MODE);
+	irda_setup_dma(self->io.dma, self->rx_buff.data,
+		       self->rx_buff.truesize, DMA_RX_MODE);
 
 	/* Enable burst mode chip Rx DMA */
 	register_bank(iobase, 1);
diff -Nru a/drivers/net/irda/via-ircc.c b/drivers/net/irda/via-ircc.c
--- a/drivers/net/irda/via-ircc.c	Mon Feb 16 10:58:01 2004
+++ b/drivers/net/irda/via-ircc.c	Mon Feb 16 10:58:01 2004
@@ -816,8 +816,8 @@
 	EnTXDMA(iobase, ON);
 	EnRXDMA(iobase, OFF);
 
-	setup_dma(self->io.dma, self->tx_buff.data, self->tx_buff.len,
-		  DMA_TX_MODE);
+	irda_setup_dma(self->io.dma, self->tx_buff.data, self->tx_buff.len,
+		       DMA_TX_MODE);
 
 	SetSendByte(iobase, self->tx_buff.len);
 	RXStart(iobase, OFF);
@@ -896,9 +896,9 @@
 	EnAllInt(iobase, ON);
 	EnTXDMA(iobase, ON);
 	EnRXDMA(iobase, OFF);
-	setup_dma(self->io.dma,
-		  self->tx_fifo.queue[self->tx_fifo.ptr].start,
-		  self->tx_fifo.queue[self->tx_fifo.ptr].len, DMA_TX_MODE);
+	irda_setup_dma(self->io.dma,
+		       self->tx_fifo.queue[self->tx_fifo.ptr].start,
+		       self->tx_fifo.queue[self->tx_fifo.ptr].len, DMA_TX_MODE);
 #ifdef	DBGMSG
 	DBG(printk
 	    (KERN_INFO "dma_xmit:tx_fifo.ptr=%x,len=%x,tx_fifo.len=%x..\n",
@@ -1022,8 +1022,8 @@
 	EnAllInt(iobase, ON);
 	EnTXDMA(iobase, OFF);
 	EnRXDMA(iobase, ON);
-	setup_dma(self->io.dma2, self->rx_buff.data,
-		  self->rx_buff.truesize, DMA_RX_MODE);
+	irda_setup_dma(self->io.dma2, self->rx_buff.data,
+		       self->rx_buff.truesize, DMA_RX_MODE);
 	TXStart(iobase, OFF);
 	RXStart(iobase, ON);
 
diff -Nru a/drivers/net/irda/w83977af_ir.c b/drivers/net/irda/w83977af_ir.c
--- a/drivers/net/irda/w83977af_ir.c	Mon Feb 16 10:58:01 2004
+++ b/drivers/net/irda/w83977af_ir.c	Mon Feb 16 10:58:01 2004
@@ -609,8 +609,8 @@
 	set_dma_addr(self->io.dma, isa_virt_to_bus(self->tx_buff.data));
 	set_dma_count(self->io.dma, self->tx_buff.len);
 #else
-	setup_dma(self->io.dma, self->tx_buff.data, self->tx_buff.len, 
-		  DMA_MODE_WRITE);	
+	irda_setup_dma(self->io.dma, self->tx_buff.data, self->tx_buff.len, 
+		       DMA_MODE_WRITE);	
 #endif
 	self->io.direction = IO_XMIT;
 	
@@ -766,8 +766,8 @@
 	set_dma_addr(self->io.dma, isa_virt_to_bus(self->rx_buff.data));
 	set_dma_count(self->io.dma, self->rx_buff.truesize);
 #else
-	setup_dma(self->io.dma, self->rx_buff.data, self->rx_buff.truesize, 
-		  DMA_MODE_READ);
+	irda_setup_dma(self->io.dma, self->rx_buff.data, self->rx_buff.truesize, 
+		       DMA_MODE_READ);
 #endif
 	/* 
 	 * Reset Rx FIFO. This will also flush the ST_FIFO, it's very 
diff -Nru a/include/net/irda/irda_device.h b/include/net/irda/irda_device.h
--- a/include/net/irda/irda_device.h	Mon Feb 16 10:58:01 2004
+++ b/include/net/irda/irda_device.h	Mon Feb 16 10:58:01 2004
@@ -215,7 +215,7 @@
 int irda_device_dongle_cleanup(dongle_t *dongle);
 
 #ifdef CONFIG_ISA
-void setup_dma(int channel, char *buffer, int count, int mode);
+void irda_setup_dma(int channel, char *buffer, int count, int mode);
 #endif
 
 void irda_task_delete(struct irda_task *task);
diff -Nru a/net/irda/irda_device.c b/net/irda/irda_device.c
--- a/net/irda/irda_device.c	Mon Feb 16 10:58:01 2004
+++ b/net/irda/irda_device.c	Mon Feb 16 10:58:01 2004
@@ -550,7 +550,7 @@
  *    Setup the DMA channel. Commonly used by ISA FIR drivers
  *
  */
-void setup_dma(int channel, char *buffer, int count, int mode)
+void irda_setup_dma(int channel, char *buffer, int count, int mode)
 {
 	unsigned long flags;
 
@@ -565,4 +565,5 @@
 
 	release_dma_lock(flags);
 }
+EXPORT_SYMBOL(irda_setup_dma);
 #endif
diff -Nru a/net/irda/irsyms.c b/net/irda/irsyms.c
--- a/net/irda/irsyms.c	Mon Feb 16 10:58:01 2004
+++ b/net/irda/irsyms.c	Mon Feb 16 10:58:01 2004
@@ -167,9 +167,6 @@
 EXPORT_SYMBOL(irda_calc_crc16);
 EXPORT_SYMBOL(irda_crc16_table);
 EXPORT_SYMBOL(irda_start_timer);
-#ifdef CONFIG_ISA
-EXPORT_SYMBOL(setup_dma);
-#endif
 
 #ifdef CONFIG_IRTTY
 EXPORT_SYMBOL(irtty_set_dtr_rts);
