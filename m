Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262527AbSI0RO3>; Fri, 27 Sep 2002 13:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262531AbSI0RO3>; Fri, 27 Sep 2002 13:14:29 -0400
Received: from [216.40.201.6] ([216.40.201.6]:44049 "EHLO
	www.businesssite.com.br") by vger.kernel.org with ESMTP
	id <S262527AbSI0ROR>; Fri, 27 Sep 2002 13:14:17 -0400
Date: Fri, 27 Sep 2002 14:15:58 -0300
To: benjamin_kong@ali.com.tw
Cc: linux-kernel@vger.kernel.org
Subject: [patch] __FUNCTION__ issue (ali-ircc)
Message-ID: <20020927171558.GO20649@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


-- 
aris

--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ali-ircc.patch"

--- linux-2.5.38-vanilla/include/net/irda/ali-ircc.h	2002-09-22 01:25:11.000000000 -0300
+++ linux-2.5.38/include/net/irda/ali-ircc.h	2002-09-27 11:18:43.000000000 -0300
@@ -28,6 +28,13 @@
 #include <linux/pm.h>
 #include <asm/io.h>
 
+#define DPRINT_START(x)	IRDA_DEBUG(x, \
+			"%s(), ---------------- Start ----------------\n",\
+			__FUNCTION__);
+#define DPRINT_END(x)	IRDA_DEBUG(x, \
+			"%s(), ----------------- End -----------------\n",\
+			__FUNCTION__);
+
 /* SIR Register */
 /* Usr definition of linux/serial_reg.h */

--- linux-2.5.38-vanilla/drivers/net/irda/ali-ircc.c	2002-09-22 01:25:07.000000000 -0300
+++ linux-2.5.38/drivers/net/irda/ali-ircc.c	2002-09-27 11:17:58.000000000 -0300
@@ -140,8 +140,8 @@
 	int cfg, cfg_base;
 	int reg, revision;
 	int i = 0;
-	
-	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);
+
+	DPRINT_START(2);
 	
 	/* Probe for all the ALi chipsets we know about */
 	for (chip= chips; chip->name; chip++, i++) 
@@ -210,7 +210,7 @@
 		}
 	}		
 		
-	IRDA_DEBUG(2, "%s(), ----------------- End -----------------\n", __FUNCTION__);					   		
+	DPRINT_END(2);					   		
 	return ret;
 }
 
@@ -224,7 +224,7 @@
 {
 	int i;
 
-	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);	
+	DPRINT_START(2);	
 	
 	pm_unregister_all(ali_ircc_pmproc);
 
@@ -233,7 +233,7 @@
 			ali_ircc_close(dev_self[i]);
 	}
 	
-	IRDA_DEBUG(2, "%s(), ----------------- End -----------------\n", __FUNCTION__);
+	DPRINT_END(2);
 }
 
 /*
@@ -251,7 +251,7 @@
 	int ret;
 	int err;
 			
-	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);	
+	DPRINT_START(2);	
 	
 	/* Set FIR FIFO and DMA Threshold */
 	if ((ali_ircc_setup(info)) == -1)
@@ -371,7 +371,7 @@
         if (pmdev)
                 pmdev->data = self;
 
-	IRDA_DEBUG(2, "%s(), ----------------- End -----------------\n", __FUNCTION__);
+	DPRINT_END(2);
 	
 	return 0;
 }
@@ -387,7 +387,7 @@
 {
 	int iobase;
 
-	IRDA_DEBUG(4, "%s(), ---------------- Start ----------------\n", __FUNCTION__);
+	DPRINT_START(4);
 
 	ASSERT(self != NULL, return -1;);
 
@@ -413,7 +413,7 @@
 	dev_self[self->index] = NULL;
 	kfree(self);
 	
-	IRDA_DEBUG(2, "%s(), ----------------- End -----------------\n", __FUNCTION__);
+	DPRINT_END(2);
 	
 	return 0;
 }
@@ -456,7 +456,7 @@
 	int cfg_base = info->cfg_base;
 	int hi, low, reg;
 	
-	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);
+	DPRINT_START(2);
 	
 	/* Enter Configuration */
 	outb(chip->entr1, cfg_base);
@@ -508,7 +508,7 @@
 	/* Exit configuration */
 	outb(0xbb, cfg_base);
 		
-	IRDA_DEBUG(2, "%s(), ----------------- End -----------------\n", __FUNCTION__);	
+	DPRINT_END(2);	
 	
 	return 0;	
 }
@@ -526,7 +526,7 @@
 	int version;
 	int iobase = info->fir_base;
 	
-	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);
+	DPRINT_START(2);
 	
 	/* Locking comments :
 	 * Most operations here need to be protected. We are called before
@@ -604,7 +604,7 @@
 	int dongle_id, reg;
 	int cfg_base = info->cfg_base;
 	
-	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);
+	DPRINT_START(2);
 		
 	/* Enter Configuration */
 	outb(chips[i].entr1, cfg_base);
@@ -640,7 +640,7 @@
 	struct net_device *dev = (struct net_device *) dev_id;
 	struct ali_ircc_cb *self;
 		
-	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);
+	DPRINT_START(2);
 		
  	if (!dev) {
 		WARNING("%s: irq %d for unknown device.\n", driver_name, irq);
@@ -672,7 +672,7 @@
 	__u8 eir, OldMessageCount;
 	int iobase, tmp;
 	
-	IRDA_DEBUG(1, "%s(), ---------------- Start ----------------\n", __FUNCTION__);
+	DPRINT_START(1);
 	
 	iobase = self->io.fir_base;
 	
@@ -793,7 +793,7 @@
 	int iobase;
 	int iir, lsr;
 	
-	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);
+	DPRINT_START(2);
 	
 	iobase = self->io.sir_base;
 
@@ -844,7 +844,7 @@
 	int boguscount = 0;
 	int iobase;
 	
-	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);
+	DPRINT_START(2);
 	ASSERT(self != NULL, return;);
 
 	iobase = self->io.sir_base;
@@ -864,7 +864,7 @@
 		}
 	} while (inb(iobase+UART_LSR) & UART_LSR_DR);	
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	IRDA_DEBUG(2, "%s (), ----------------- End ------------------\n", __FUNCTION__);
 }
 
 /*
@@ -881,7 +881,7 @@
 
 	ASSERT(self != NULL, return;);
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start ----------------\n");
+	DPRINT_START(2);
 	
 	iobase = self->io.sir_base;
 
@@ -900,16 +900,18 @@
 		{
 			/* We must wait until all data are gone */
 			while(!(inb(iobase+UART_LSR) & UART_LSR_TEMT))
-				IRDA_DEBUG(1, __FUNCTION__ "(), UART_LSR_THRE\n");
+				IRDA_DEBUG(1, "%s(), UART_LSR_THRE\n", __FUNCTION__);
 			
-			IRDA_DEBUG(1, __FUNCTION__ "(), Changing speed! self->new_speed = %d\n", self->new_speed);
+			IRDA_DEBUG(1, "%s(), Changing speed! self->new_speed = %d\n",
+							__FUNCTION__, self->new_speed);
 			ali_ircc_change_speed(self, self->new_speed);
 			self->new_speed = 0;			
 			
 			// benjamin 2000/11/10 06:32PM
 			if (self->io.speed > 115200)
 			{
-				IRDA_DEBUG(2, __FUNCTION__ "(), ali_ircc_change_speed from UART_LSR_TEMT \n");				
+				IRDA_DEBUG(2, "%s(), ali_ircc_change_speed from UART_LSR_TEMT \n",
+								__FUNCTION__);
 					
 				self->ier = IER_EOM;
 				// SetCOMInterrupts(self, TRUE);							
@@ -927,7 +929,7 @@
 		outb(UART_IER_RDI, iobase+UART_IER);
 	}
 		
-	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(2);
 }
 
 static void ali_ircc_change_speed(struct ali_ircc_cb *self, __u32 baud)
@@ -935,9 +937,9 @@
 	struct net_device *dev = self->netdev;
 	int iobase;
 	
-	IRDA_DEBUG(1, __FUNCTION__ "(), ---------------- Start ----------------\n");
+	DPRINT_START(1);
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(), setting speed = %d \n", baud);
+	IRDA_DEBUG(2, "%s(), setting speed = %d \n", __FUNCTION__, baud);
 	
 	/* This function *must* be called with irq off and spin-lock.
 	 * - Jean II */
@@ -974,9 +976,9 @@
 		
 	SetCOMInterrupts(self, TRUE);	// 2000/11/24 11:43AM
 		
-	netif_wake_queue(self->netdev);	
+	netif_wake_queue(self->netdev);
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	IRDA_DEBUG(2, "%s(), ----------------- End ------------------\n", __FUNCTION__);
 }
 
 static void ali_ircc_fir_change_speed(struct ali_ircc_cb *priv, __u32 baud)
@@ -986,14 +988,15 @@
 	struct ali_ircc_cb *self = (struct ali_ircc_cb *) priv;
 	struct net_device *dev;
 
-	IRDA_DEBUG(1, __FUNCTION__ "(), ---------------- Start ----------------\n");
+	DPRINT_START(1);
 		
 	ASSERT(self != NULL, return;);
 
 	dev = self->netdev;
 	iobase = self->io.fir_base;
 	
-	IRDA_DEBUG(1, __FUNCTION__ "(), self->io.speed = %d, change to speed = %d\n",self->io.speed,baud);
+	IRDA_DEBUG(1, "%s(), self->io.speed = %d, change to speed = %d\n",
+						__FUNCTION__, self->io.speed, baud);
 	
 	/* Come from SIR speed */
 	if(self->io.speed <=115200)
@@ -1007,7 +1010,7 @@
 	// Set Dongle Speed mode
 	ali_ircc_change_dongle_speed(self, baud);
 		
-	IRDA_DEBUG(1, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(1);
 }
 
 /*
@@ -1025,9 +1028,9 @@
 	int lcr;    /* Line control reg */
 	int divisor;
 
-	IRDA_DEBUG(1, __FUNCTION__ "(), ---------------- Start ----------------\n");
+	DPRINT_START(1);
 	
-	IRDA_DEBUG(1, __FUNCTION__ "(), Setting speed to: %d\n", speed);
+	IRDA_DEBUG(1, "%s(), Setting speed to: %d\n", __FUNCTION__, speed);
 
 	ASSERT(self != NULL, return;);
 
@@ -1081,7 +1084,7 @@
 	
 	spin_unlock_irqrestore(&self->lock, flags);
 	
-	IRDA_DEBUG(1, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(1);
 }
 
 static void ali_ircc_change_dongle_speed(struct ali_ircc_cb *priv, int speed)
@@ -1091,14 +1094,15 @@
 	int iobase,dongle_id;
 	int tmp = 0;
 			
-	IRDA_DEBUG(1, __FUNCTION__ "(), ---------------- Start ----------------\n");	
+	DPRINT_START(1);	
 	
 	iobase = self->io.fir_base; 	/* or iobase = self->io.sir_base; */
 	dongle_id = self->io.dongle_id;
 	
 	/* We are already locked, no need to do it again */
 		
-	IRDA_DEBUG(1, __FUNCTION__ "(), Set Speed for %s , Speed = %d\n", dongle_types[dongle_id], speed);		
+	IRDA_DEBUG(1, "%s(), Set Speed for %s , Speed = %d\n", __FUNCTION__,
+						dongle_types[dongle_id], speed);
 	
 	switch_bank(iobase, BANK2);
 	tmp = inb(iobase+FIR_IRDA_CR);
@@ -1261,8 +1265,8 @@
 	}
 			
 	switch_bank(iobase, BANK0);
-	
-	IRDA_DEBUG(1, __FUNCTION__ "(), ----------------- End ------------------\n");		
+
+	DPRINT_END(1);
 }
 
 /*
@@ -1274,12 +1278,12 @@
 static int ali_ircc_sir_write(int iobase, int fifo_size, __u8 *buf, int len)
 {
 	int actual = 0;
-	
-	IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start ----------------\n");
+
+	DPRINT_START(2);
 		
 	/* Tx FIFO should be empty! */
 	if (!(inb(iobase+UART_LSR) & UART_LSR_THRE)) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), failed, fifo not empty!\n");
+		IRDA_DEBUG(0, "%s(), failed, fifo not empty!\n", __FUNCTION__);
 		return 0;
 	}
         
@@ -1290,8 +1294,9 @@
 
 		actual++;
 	}
-	
-        IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
+
+	DPRINT_END(2);
+
 	return actual;
 }
 
@@ -1303,15 +1308,15 @@
  */
 static int ali_ircc_net_init(struct net_device *dev)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start ----------------\n");
+	DPRINT_START(2);
 	
 	/* Setup to be a normal IrDA network device driver */
 	irda_device_setup(dev);
 
 	/* Insert overrides below this line! */
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
-	
+	DPRINT_END(2);
+
 	return 0;
 }
 
@@ -1326,8 +1331,8 @@
 	struct ali_ircc_cb *self;
 	int iobase;
 	char hwname[32];
-		
-	IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start ----------------\n");
+
+	DPRINT_START(2);		
 	
 	ASSERT(dev != NULL, return -1;);
 	
@@ -1373,8 +1378,8 @@
 		
 	MOD_INC_USE_COUNT;
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
-	
+	DPRINT_END(2);
+
 	return 0;
 }
 
@@ -1390,8 +1395,8 @@
 	struct ali_ircc_cb *self;
 	//int iobase;
 			
-	IRDA_DEBUG(4, __FUNCTION__ "(), ---------------- Start ----------------\n");
-		
+	DPRINT_START(4);
+
 	ASSERT(dev != NULL, return -1;);
 
 	self = (struct ali_ircc_cb *) dev->priv;
@@ -1415,7 +1420,7 @@
 
 	MOD_DEC_USE_COUNT;
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(4);	
 	
 	return 0;
 }
@@ -1433,8 +1438,8 @@
 	int iobase;
 	__u32 speed;
 	int mtt, diff;
-	
-	IRDA_DEBUG(1, __FUNCTION__ "(), ---------------- Start -----------------\n");	
+
+	DPRINT_START(1);
 	
 	self = (struct ali_ircc_cb *) dev->priv;
 	iobase = self->io.fir_base;
@@ -1488,7 +1493,8 @@
 			diff = self->now.tv_usec - self->stamp.tv_usec;
 			/* self->stamp is set from ali_ircc_dma_receive_complete() */
 							
-			IRDA_DEBUG(1, __FUNCTION__ "(), ******* diff = %d ******* \n", diff);	
+			IRDA_DEBUG(1, "%s(), ******* diff = %d ******* \n",
+							__FUNCTION__, diff);
 			
 			if (diff < 0) 
 				diff += 1000000;
@@ -1510,7 +1516,8 @@
 					/* Adjust for timer resolution */
 					mtt = (mtt+250) / 500; 	/* 4 discard, 5 get advanced, Let's round off */
 					
-					IRDA_DEBUG(1, __FUNCTION__ "(), ************** mtt = %d ***********\n", mtt);	
+					IRDA_DEBUG(1, "%s(), ************** mtt = %d ***********\n",
+							__FUNCTION__, mtt);
 					
 					/* Setup timer */
 					if (mtt == 1) /* 500 us */
@@ -1566,7 +1573,7 @@
 	spin_unlock_irqrestore(&self->lock, flags);
 	dev_kfree_skb(skb);
 
-	IRDA_DEBUG(1, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(1);	
 	return 0;	
 }
 
@@ -1576,8 +1583,7 @@
 	int iobase, tmp;
 	unsigned char FIFO_OPTI, Hi, Lo;
 	
-	
-	IRDA_DEBUG(1, __FUNCTION__ "(), ---------------- Start -----------------\n");	
+	DPRINT_START(1);
 	
 	iobase = self->io.fir_base;
 	
@@ -1627,7 +1633,8 @@
 	tmp = inb(iobase+FIR_LCR_B);
 	tmp &= ~0x20; // Disable SIP
 	outb(((unsigned char)(tmp & 0x3f) | LCR_B_TX_MODE) & ~LCR_B_BW, iobase+FIR_LCR_B);
-	IRDA_DEBUG(1, __FUNCTION__ "(), ******* Change to TX mode: FIR_LCR_B = 0x%x ******* \n", inb(iobase+FIR_LCR_B));
+	IRDA_DEBUG(1, "%s(), ******* Change to TX mode: FIR_LCR_B = 0x%x ******* \n",
+					__FUNCTION__, inb(iobase+FIR_LCR_B));
 	
 	outb(0, iobase+FIR_LSR);
 			
@@ -1637,16 +1644,16 @@
 	
 	switch_bank(iobase, BANK0); 
 	
-	IRDA_DEBUG(1, __FUNCTION__ "(), ----------------- End ------------------\n");
+	DPRINT_END(1);
 }
 
 static int  ali_ircc_dma_xmit_complete(struct ali_ircc_cb *self)
 {
 	int iobase;
 	int ret = TRUE;
-	
-	IRDA_DEBUG(1, __FUNCTION__ "(), ---------------- Start -----------------\n");	
-	
+
+	DPRINT_START(1);
+
 	iobase = self->io.fir_base;
 	
 	/* Disable DMA */
@@ -1701,7 +1708,8 @@
 		
 	switch_bank(iobase, BANK0); 
 	
-	IRDA_DEBUG(1, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(1);	
+
 	return ret;
 }
 
@@ -1715,8 +1723,8 @@
 static int ali_ircc_dma_receive(struct ali_ircc_cb *self) 
 {
 	int iobase, tmp;
-	
-	IRDA_DEBUG(1, __FUNCTION__ "(), ---------------- Start -----------------\n");	
+
+	DPRINT_START(1);
 	
 	iobase = self->io.fir_base;
 	
@@ -1754,7 +1762,8 @@
 	//switch_bank(iobase, BANK0);
 	tmp = inb(iobase+FIR_LCR_B);
 	outb((unsigned char)(tmp &0x3f) | LCR_B_RX_MODE | LCR_B_BW , iobase + FIR_LCR_B); // 2000/12/1 05:16PM
-	IRDA_DEBUG(1, __FUNCTION__ "(), *** Change To RX mode: FIR_LCR_B = 0x%x *** \n", inb(iobase+FIR_LCR_B));
+	IRDA_DEBUG(1, "%s(), *** Change To RX mode: FIR_LCR_B = 0x%x *** \n",
+					__FUNCTION__, inb(iobase+FIR_LCR_B));
 			
 	/* Set Rx Threshold */
 	switch_bank(iobase, BANK1);
@@ -1766,7 +1775,8 @@
 	outb(CR_DMA_EN | CR_DMA_BURST, iobase+FIR_CR);
 				
 	switch_bank(iobase, BANK0); 
-	IRDA_DEBUG(1, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(1);
+
 	return 0;
 }
 
@@ -1777,7 +1787,7 @@
 	__u8 status, MessageCount;
 	int len, i, iobase, val;	
 
-	IRDA_DEBUG(1, __FUNCTION__ "(), ---------------- Start -----------------\n");	
+	DPRINT_START(1);
 
 	st_fifo = &self->st_fifo;		
 	iobase = self->io.fir_base;	
@@ -1786,7 +1796,8 @@
 	MessageCount = inb(iobase+ FIR_LSR)&0x07;
 	
 	if (MessageCount > 0)	
-		IRDA_DEBUG(0, __FUNCTION__ "(), Messsage count = %d,\n", MessageCount);	
+		IRDA_DEBUG(0, "%s(), Messsage count = %d,\n", __FUNCTION__,
+				MessageCount);
 		
 	for (i=0; i<=MessageCount; i++)
 	{
@@ -1799,11 +1810,13 @@
 		len = len << 8; 
 		len |= inb(iobase+FIR_RX_DSR_LO);
 		
-		IRDA_DEBUG(1, __FUNCTION__ "(), RX Length = 0x%.2x,\n", len);	
-		IRDA_DEBUG(1, __FUNCTION__ "(), RX Status = 0x%.2x,\n", status);
+		IRDA_DEBUG(1, "%s(), RX Length = 0x%.2x,\n", __FUNCTION__,
+									len);
+		IRDA_DEBUG(1, "%s(), RX Status = 0x%.2x,\n", __FUNCTION__,
+									status);
 		
 		if (st_fifo->tail >= MAX_RX_WINDOW) {
-			IRDA_DEBUG(0, __FUNCTION__ "(), window is full!\n");
+			IRDA_DEBUG(0, "%s(), window is full!\n", __FUNCTION__);
 			continue;
 		}
 			
@@ -1826,7 +1839,8 @@
 		/* Check for errors */
 		if ((status & 0xd8) || self->rcvFramesOverflow || (len==0)) 		
 		{
-			IRDA_DEBUG(0,__FUNCTION__ "(), ************* RX Errors ************ \n");	
+			IRDA_DEBUG(0, "%s(), ************* RX Errors ************ \n",
+								__FUNCTION__);
 			
 			/* Skip frame */
 			self->stats.rx_errors++;
@@ -1836,29 +1850,34 @@
 			if (status & LSR_FIFO_UR) 
 			{
 				self->stats.rx_frame_errors++;
-				IRDA_DEBUG(0,__FUNCTION__ "(), ************* FIFO Errors ************ \n");
+				IRDA_DEBUG(0, "%s(), ************* FIFO Errors ************ \n",
+								__FUNCTION__);
 			}	
 			if (status & LSR_FRAME_ERROR)
 			{
 				self->stats.rx_frame_errors++;
-				IRDA_DEBUG(0,__FUNCTION__ "(), ************* FRAME Errors ************ \n");
+				IRDA_DEBUG(0, "%s(), ************* FRAME Errors ************ \n",
+								__FUNCTION__);
 			}
 							
 			if (status & LSR_CRC_ERROR) 
 			{
 				self->stats.rx_crc_errors++;
-				IRDA_DEBUG(0,__FUNCTION__ "(), ************* CRC Errors ************ \n");
+				IRDA_DEBUG(0, "%s(), ************* CRC Errors ************ \n",
+								__FUNCTION__);
 			}
 			
 			if(self->rcvFramesOverflow)
 			{
 				self->stats.rx_frame_errors++;
-				IRDA_DEBUG(0,__FUNCTION__ "(), ************* Overran DMA buffer ************ \n");								
+				IRDA_DEBUG(0, "%s(), ************* Overran DMA buffer ************ \n",
+								__FUNCTION__);
 			}
 			if(len == 0)
 			{
 				self->stats.rx_frame_errors++;
-				IRDA_DEBUG(0,__FUNCTION__ "(), ********** Receive Frame Size = 0 ********* \n");
+				IRDA_DEBUG(0, "%s(), ********** Receive Frame Size = 0 ********* \n",
+								__FUNCTION__);
 			}
 		}	 
 		else 
@@ -1870,7 +1889,8 @@
 				val = inb(iobase+FIR_BSR);	
 				if ((val& BSR_FIFO_NOT_EMPTY)== 0x80) 
 				{
-					IRDA_DEBUG(0, __FUNCTION__ "(), ************* BSR_FIFO_NOT_EMPTY ************ \n");
+					IRDA_DEBUG(0, "%s(), ************* BSR_FIFO_NOT_EMPTY ************ \n",
+								__FUNCTION__);
 					
 					/* Put this entry back in fifo */
 					st_fifo->head--;
@@ -1934,7 +1954,8 @@
 	
 	switch_bank(iobase, BANK0);	
 		
-	IRDA_DEBUG(1, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(1);
+
 	return TRUE;
 }
 
@@ -1953,7 +1974,7 @@
 	int iobase;
 	__u32 speed;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start ----------------\n");
+	DPRINT_START(2);
 	
 	ASSERT(dev != NULL, return 0;);
 	
@@ -2000,7 +2021,7 @@
 
 	dev_kfree_skb(skb);
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(2);	
 	
 	return 0;	
 }
@@ -2019,7 +2040,7 @@
 	unsigned long flags;
 	int ret = 0;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start ----------------\n");
+	DPRINT_START(2);
 	
 	ASSERT(dev != NULL, return -1;);
 
@@ -2027,11 +2048,11 @@
 
 	ASSERT(self != NULL, return -1;);
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
+	IRDA_DEBUG(2, "%s(), %s, (cmd=0x%X)\n", __FUNCTION__, dev->name, cmd);
 	
 	switch (cmd) {
 	case SIOCSBANDWIDTH: /* Set bandwidth */
-		IRDA_DEBUG(1, __FUNCTION__ "(), SIOCSBANDWIDTH\n");
+		IRDA_DEBUG(1, "%s(), SIOCSBANDWIDTH\n", __FUNCTION__);
 		/*
 		 * This function will also be used by IrLAP to change the
 		 * speed, so we still must allow for speed change within
@@ -2045,13 +2066,13 @@
 		spin_unlock_irqrestore(&self->lock, flags);
 		break;
 	case SIOCSMEDIABUSY: /* Set media busy */
-		IRDA_DEBUG(1, __FUNCTION__ "(), SIOCSMEDIABUSY\n");
+		IRDA_DEBUG(1, "%s(), SIOCSMEDIABUSY\n", __FUNCTION__);
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 		irda_device_set_media_busy(self->netdev, TRUE);
 		break;
 	case SIOCGRECEIVING: /* Check if we are receiving right now */
-		IRDA_DEBUG(2, __FUNCTION__ "(), SIOCGRECEIVING\n");
+		IRDA_DEBUG(2, "%s(), SIOCGRECEIVING\n", __FUNCTION__);
 		/* This is protected */
 		irq->ifr_receiving = ali_ircc_is_receiving(self);
 		break;
@@ -2059,7 +2080,7 @@
 		ret = -EOPNOTSUPP;
 	}
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(2);	
 	
 	return ret;
 }
@@ -2076,7 +2097,7 @@
 	int status = FALSE;
 	int iobase;		
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start -----------------\n");
+	DPRINT_START(2);
 	
 	ASSERT(self != NULL, return FALSE;);
 
@@ -2090,7 +2111,8 @@
 		if((inb(iobase+FIR_FIFO_FR) & 0x3f) != 0) 		
 		{
 			/* We are receiving something */
-			IRDA_DEBUG(1, __FUNCTION__ "(), We are receiving something\n");
+			IRDA_DEBUG(1, "%s(), We are receiving something\n",
+								__FUNCTION__);
 			status = TRUE;
 		}
 		switch_bank(iobase, BANK0);		
@@ -2102,7 +2124,7 @@
 	
 	spin_unlock_irqrestore(&self->lock, flags);
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");
+	DPRINT_END(2);
 	
 	return status;
 }
@@ -2111,16 +2133,16 @@
 {
 	struct ali_ircc_cb *self = (struct ali_ircc_cb *) dev->priv;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start ----------------\n");
+	DPRINT_START(2);
 		
-	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(2);	
 	
 	return &self->stats;
 }
 
 static void ali_ircc_suspend(struct ali_ircc_cb *self)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start ----------------\n");
+	DPRINT_START(2);
 	
 	MESSAGE("%s, Suspending\n", driver_name);
 
@@ -2131,12 +2153,12 @@
 
 	self->io.suspended = 1;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(2);	
 }
 
 static void ali_ircc_wakeup(struct ali_ircc_cb *self)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start ----------------\n");
+	DPRINT_START(2);
 	
 	if (!self->io.suspended)
 		return;
@@ -2147,14 +2169,14 @@
 
 	self->io.suspended = 0;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(2);	
 }
 
 static int ali_ircc_pmproc(struct pm_dev *dev, pm_request_t rqst, void *data)
 {
         struct ali_ircc_cb *self = (struct ali_ircc_cb*) dev->data;
         
-        IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start ----------------\n");
+        DPRINT_START(2);
 	
         if (self) {
                 switch (rqst) {
@@ -2167,7 +2189,7 @@
                 }
         }
         
-        IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
+        DPRINT_END(2);	
         
 	return 0;
 }
@@ -2182,7 +2204,8 @@
 	
 	int iobase = self->io.fir_base; /* or sir_base */
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), -------- Start -------- ( Enable = %d )\n", enable);	
+	IRDA_DEBUG(2, "%s(), -------- Start -------- ( Enable = %d )\n",
+							__FUNCTION__, enable);
 	
 	/* Enable the interrupt which we wish to */
 	if (enable){
@@ -2223,14 +2246,14 @@
 	else
 		outb(newMask, iobase+UART_IER);
 		
-	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(2);	
 }
 
 static void SIR2FIR(int iobase)
 {
 	//unsigned char tmp;
 		
-	IRDA_DEBUG(1, __FUNCTION__ "(), ---------------- Start ----------------\n");
+	DPRINT_START(1);
 	
 	/* Already protected (change_speed() or setup()), no need to lock.
 	 * Jean II */
@@ -2246,14 +2269,14 @@
 	//tmp |= 0x20;
 	//outb(tmp, iobase+FIR_LCR_B);	
 	
-	IRDA_DEBUG(1, __FUNCTION__ "(), ----------------- End ------------------\n");	
+	DPRINT_END(1);	
 }
 
 static void FIR2SIR(int iobase)
 {
 	unsigned char val;
 	
-	IRDA_DEBUG(1, __FUNCTION__ "(), ---------------- Start ----------------\n");
+	DPRINT_START(1);
 	
 	/* Already protected (change_speed() or setup()), no need to lock.
 	 * Jean II */
@@ -2269,7 +2292,7 @@
 	val = inb(iobase+UART_LSR);
 	val = inb(iobase+UART_MSR);
 	
-	IRDA_DEBUG(1, __FUNCTION__ "(), ----------------- End ------------------\n");
+	DPRINT_END(1);
 }
 
 MODULE_AUTHOR("Benjamin Kong <benjamin_kong@ali.com.tw>");

--SxgehGEc6vB0cZwN--
