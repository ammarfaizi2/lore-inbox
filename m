Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318211AbSIEVyU>; Thu, 5 Sep 2002 17:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318208AbSIEVx1>; Thu, 5 Sep 2002 17:53:27 -0400
Received: from hermes.domdv.de ([193.102.202.1]:40969 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S318211AbSIEVvn>;
	Thu, 5 Sep 2002 17:51:43 -0400
Message-ID: <3D77CD82.1030602@domdv.de>
Date: Thu, 05 Sep 2002 23:32:50 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.20pre5 trivial compiler warning fix for nsc-ircc.c
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090905080100080508090503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090905080100080508090503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

the attached patch fixes deprecated usage warnings for __FUNCTION__ in 
nsc-ircc.c.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--------------090905080100080508090503
Content-Type: text/plain;
 name="nsc-ircc.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsc-ircc.c.diff"

--- drivers/net/irda/nsc-ircc.c.orig	2002-09-05 23:14:05.000000000 +0200
+++ drivers/net/irda/nsc-ircc.c	2002-09-05 23:27:30.000000000 +0200
@@ -165,7 +165,7 @@
 
 	/* Probe for all the NSC chipsets we know about */
 	for (chip=chips; chip->name ; chip++) {
-		IRDA_DEBUG(2, __FUNCTION__"(), Probing for %s ...\n", 
+		IRDA_DEBUG(2, "%s(), Probing for %s ...\n", __FUNCTION__,
 			   chip->name);
 		
 		/* Try all config registers for this chip */
@@ -183,8 +183,8 @@
 			/* Read index register */
 			reg = inb(cfg_base);
 			if (reg == 0xff) {
-				IRDA_DEBUG(2, __FUNCTION__ 
-					   "() no chip at 0x%03x\n", cfg_base);
+				IRDA_DEBUG(2, "%s() no chip at 0x%03x\n",
+					   __FUNCTION__, cfg_base);
 				continue;
 			}
 			
@@ -192,8 +192,9 @@
 			outb(chip->cid_index, cfg_base);
 			id = inb(cfg_base+1);
 			if ((id & chip->cid_mask) == chip->cid_value) {
-				IRDA_DEBUG(2, __FUNCTION__ 
-					   "() Found %s chip, revision=%d\n",
+				IRDA_DEBUG(2,
+					   "%s() Found %s chip, revision=%d\n",
+					   __FUNCTION__,
 					   chip->name, id & ~chip->cid_mask);
 				/* 
 				 * If the user supplies the base address, then
@@ -209,8 +210,8 @@
 					ret = 0;
 				i++;
 			} else {
-				IRDA_DEBUG(2, __FUNCTION__ 
-					   "(), Wrong chip id=0x%02x\n", id);
+				IRDA_DEBUG(2, "%s(), Wrong chip id=0x%02x\n",
+					   __FUNCTION__, id);
 			}
 		} 
 		
@@ -253,7 +254,7 @@
 	void *ret;
 	int err;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	MESSAGE("%s, Found chip at base=0x%03x\n", driver_name,
 		info->cfg_base);
@@ -266,8 +267,8 @@
 	/* Allocate new instance of the driver */
 	self = kmalloc(sizeof(struct nsc_ircc_cb), GFP_KERNEL);
 	if (self == NULL) {
-		ERROR(__FUNCTION__ "(), can't allocate memory for "
-		       "control block!\n");
+		ERROR("%s(), can't allocate memory for "
+		       "control block!\n", __FUNCTION__);
 		return -ENOMEM;
 	}
 	memset(self, 0, sizeof(struct nsc_ircc_cb));
@@ -288,7 +289,7 @@
 	/* Reserve the ioports that we need */
 	ret = request_region(self->io.fir_base, self->io.fir_ext, driver_name);
 	if (!ret) {
-		WARNING(__FUNCTION__ "(), can't get iobase of 0x%03x\n",
+		WARNING("%s(), can't get iobase of 0x%03x\n", __FUNCTION__,
 			self->io.fir_base);
 		dev_self[i] = NULL;
 		kfree(self);
@@ -339,7 +340,7 @@
 	self->tx_fifo.tail = self->tx_buff.head;
 
 	if (!(dev = dev_alloc("irda%d", &err))) {
-		ERROR(__FUNCTION__ "(), dev_alloc() failed!\n");
+		ERROR("%s(), dev_alloc() failed!\n", __FUNCTION__);
 		return -ENOMEM;
 	}
 
@@ -358,7 +359,7 @@
 	err = register_netdevice(dev);
 	rtnl_unlock();
 	if (err) {
-		ERROR(__FUNCTION__ "(), register_netdev() failed!\n");
+		ERROR("%s(), register_netdev() failed!\n", __FUNCTION__);
 		return -1;
 	}
 	MESSAGE("IrDA: Registered device %s\n", dev->name);
@@ -395,7 +396,7 @@
 {
 	int iobase;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 
@@ -409,7 +410,7 @@
 	}
 
 	/* Release the PORT that this driver is using */
-	IRDA_DEBUG(4, __FUNCTION__ "(), Releasing Region %03x\n", 
+	IRDA_DEBUG(4, "%s(), Releasing Region %03x\n", __FUNCTION__, 
 		   self->io.fir_base);
 	release_region(self->io.fir_base, self->io.fir_ext);
 
@@ -447,7 +448,7 @@
 	case 0x2e8: outb(0x15, cfg_base+1); break;
 	case 0x3f8: outb(0x16, cfg_base+1); break;
 	case 0x2f8: outb(0x17, cfg_base+1); break;
-	default: ERROR(__FUNCTION__ "(), invalid base_address");
+	default: ERROR("%s(), invalid base_address", __FUNCTION__);
 	}
 	
 	/* Control Signal Routing Register (CSRT) */
@@ -459,7 +460,7 @@
 	case 9:  temp = 0x05; break;
 	case 11: temp = 0x06; break;
 	case 15: temp = 0x07; break;
-	default: ERROR(__FUNCTION__ "(), invalid irq");
+	default: ERROR("%s(), invalid irq", __FUNCTION__);
 	}
 	outb(1, cfg_base);
 	
@@ -467,7 +468,7 @@
 	case 0: outb(0x08+temp, cfg_base+1); break;
 	case 1: outb(0x10+temp, cfg_base+1); break;
 	case 3: outb(0x18+temp, cfg_base+1); break;
-	default: ERROR(__FUNCTION__ "(), invalid dma");
+	default: ERROR("%s(), invalid dma", __FUNCTION__);
 	}
 	
 	outb(2, cfg_base);      /* Mode Control Register (MCTL) */
@@ -506,7 +507,7 @@
 		break;
 	}
 	info->sir_base = info->fir_base;
-	IRDA_DEBUG(2, __FUNCTION__ "(), probing fir_base=0x%03x\n", 
+	IRDA_DEBUG(2, "%s(), probing fir_base=0x%03x\n", __FUNCTION__,
 		   info->fir_base);
 
 	/* Read control signals routing register (CSRT) */
@@ -539,7 +540,7 @@
 		info->irq = 15;
 		break;
 	}
-	IRDA_DEBUG(2, __FUNCTION__ "(), probing irq=%d\n", info->irq);
+	IRDA_DEBUG(2, "%s(), probing irq=%d\n", __FUNCTION__, info->irq);
 
 	/* Currently we only read Rx DMA but it will also be used for Tx */
 	switch ((reg >> 3) & 0x03) {
@@ -556,7 +557,7 @@
 		info->dma = 3;
 		break;
 	}
-	IRDA_DEBUG(2, __FUNCTION__ "(), probing dma=%d\n", info->dma);
+	IRDA_DEBUG(2, "%s(), probing dma=%d\n", __FUNCTION__, info->dma);
 
 	/* Read mode control register (MCTL) */
 	outb(CFG_MCTL, cfg_base);
@@ -702,7 +703,7 @@
 	switch_bank(iobase, BANK3);
 	version = inb(iobase+MID);
 
-	IRDA_DEBUG(2, __FUNCTION__  "() Driver %s Found chip version %02x\n",
+	IRDA_DEBUG(2, "%s() Driver %s Found chip version %02x\n", __FUNCTION__,
 		   driver_name, version);
 
 	/* Should be 0x2? */
@@ -805,39 +806,39 @@
 	switch (dongle_id) {
 	case 0x00: /* same as */
 	case 0x01: /* Differential serial interface */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s not defined by irda yet\n",
-			   dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
+			   __FUNCTION__, dongle_types[dongle_id]); 
 		break;
 	case 0x02: /* same as */
 	case 0x03: /* Reserved */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s not defined by irda yet\n",
-			   dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
+			   __FUNCTION__, dongle_types[dongle_id]); 
 		break;
 	case 0x04: /* Sharp RY5HD01 */
 		break;
 	case 0x05: /* Reserved, but this is what the Thinkpad reports */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s not defined by irda yet\n",
-			   dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
+			   __FUNCTION__, dongle_types[dongle_id]); 
 		break;
 	case 0x06: /* Single-ended serial interface */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s not defined by irda yet\n",
-			   dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
+			   __FUNCTION__, dongle_types[dongle_id]); 
 		break;
 	case 0x07: /* Consumer-IR only */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s is not for IrDA mode\n",
-			   dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s is not for IrDA mode\n",
+			   __FUNCTION__, dongle_types[dongle_id]); 
 		break;
 	case 0x08: /* HP HSDL-2300, HP HSDL-3600/HSDL-3610 */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s\n",
-			   dongle_types[dongle_id]);
+		IRDA_DEBUG(0, "%s(), %s\n",
+			   __FUNCTION__, dongle_types[dongle_id]);
 		break;
 	case 0x09: /* IBM31T1100 or Temic TFDS6000/TFDS6500 */
 		outb(0x28, iobase+7); /* Set irsl[0-2] as output */
 		break;
 	case 0x0A: /* same as */
 	case 0x0B: /* Reserved */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s not defined by irda yet\n",
-			   dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
+			   __FUNCTION__, dongle_types[dongle_id]); 
 		break;
 	case 0x0C: /* same as */
 	case 0x0D: /* HP HSDL-1100/HSDL-2100 */
@@ -851,15 +852,15 @@
 		outb(0x28, iobase+7); /* Set irsl[0-2] as output */
 		break;
 	case 0x0F: /* No dongle connected */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s\n",
-			   dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s\n",
+			   __FUNCTION__, dongle_types[dongle_id]); 
 
 		switch_bank(iobase, BANK0);
 		outb(0x62, iobase+MCR);
 		break;
 	default: 
-		IRDA_DEBUG(0, __FUNCTION__ "(), invalid dongle_id %#x", 
-			   dongle_id);
+		IRDA_DEBUG(0, "%s(), invalid dongle_id %#x", 
+			   __FUNCTION__, dongle_id);
 	}
 	
 	/* IRCFG1: IRSL1 and 2 are set to IrDA mode */
@@ -891,31 +892,31 @@
 	switch (dongle_id) {
 	case 0x00: /* same as */
 	case 0x01: /* Differential serial interface */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s not defined by irda yet\n",
-			   dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
+			   __FUNCTION__, dongle_types[dongle_id]); 
 		break;
 	case 0x02: /* same as */
 	case 0x03: /* Reserved */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s not defined by irda yet\n",
-			   dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
+			   __FUNCTION__, dongle_types[dongle_id]); 
 		break;
 	case 0x04: /* Sharp RY5HD01 */
 		break;
 	case 0x05: /* Reserved */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s not defined by irda yet\n",
-			   dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
+			   __FUNCTION__, dongle_types[dongle_id]); 
 		break;
 	case 0x06: /* Single-ended serial interface */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s not defined by irda yet\n",
-			   dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
+			   __FUNCTION__, dongle_types[dongle_id]); 
 		break;
 	case 0x07: /* Consumer-IR only */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s is not for IrDA mode\n",
-			   dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s is not for IrDA mode\n",
+			   __FUNCTION__, dongle_types[dongle_id]); 
 		break;
 	case 0x08: /* HP HSDL-2300, HP HSDL-3600/HSDL-3610 */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s\n", 
-			   dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s\n", 
+			   __FUNCTION__, dongle_types[dongle_id]); 
 		outb(0x00, iobase+4);
 		if (speed > 115200)
 			outb(0x01, iobase+4);
@@ -934,8 +935,8 @@
 		break;
 	case 0x0A: /* same as */
 	case 0x0B: /* Reserved */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s not defined by irda yet\n",
-			   dongle_types[dongle_id]); 
+		IRDA_DEBUG(0, "%s(), %s not defined by irda yet\n",
+			   __FUNCTION__, dongle_types[dongle_id]); 
 		break;
 	case 0x0C: /* same as */
 	case 0x0D: /* HP HSDL-1100/HSDL-2100 */
@@ -943,14 +944,14 @@
 	case 0x0E: /* Supports SIR Mode only */
 		break;
 	case 0x0F: /* No dongle connected */
-		IRDA_DEBUG(0, __FUNCTION__ "(), %s is not for IrDA mode\n",
-			   dongle_types[dongle_id]);
+		IRDA_DEBUG(0, "%s(), %s is not for IrDA mode\n",
+			   __FUNCTION__, dongle_types[dongle_id]);
 
 		switch_bank(iobase, BANK0); 
 		outb(0x62, iobase+MCR);
 		break;
 	default: 
-		IRDA_DEBUG(0, __FUNCTION__ "(), invalid data_rate\n");
+		IRDA_DEBUG(0, "%s(), invalid data_rate\n", __FUNCTION__);
 	}
 	/* Restore bank register */
 	outb(bank, iobase+BSR);
@@ -969,7 +970,7 @@
 	int iobase; 
 	__u8 bank;
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), speed=%d\n", speed);
+	IRDA_DEBUG(2, "%s(), speed=%d\n", __FUNCTION__, speed);
 
 	ASSERT(self != NULL, return;);
 
@@ -1002,19 +1003,19 @@
 		outb(inb(iobase+4) | 0x04, iobase+4);
 	       
 		mcr = MCR_MIR;
-		IRDA_DEBUG(0, __FUNCTION__ "(), handling baud of 576000\n");
+		IRDA_DEBUG(0, "%s(), handling baud of 576000\n", __FUNCTION__);
 		break;
 	case 1152000:
 		mcr = MCR_MIR;
-		IRDA_DEBUG(0, __FUNCTION__ "(), handling baud of 1152000\n");
+		IRDA_DEBUG(0, "%s(), handling baud of 1152000\n", __FUNCTION__);
 		break;
 	case 4000000:
 		mcr = MCR_FIR;
-		IRDA_DEBUG(0, __FUNCTION__ "(), handling baud of 4000000\n");
+		IRDA_DEBUG(0, "%s(), handling baud of 4000000\n", __FUNCTION__);
 		break;
 	default:
 		mcr = MCR_FIR;
-		IRDA_DEBUG(0, __FUNCTION__ "(), unknown baud rate of %d\n", 
+		IRDA_DEBUG(0, "%s(), unknown baud rate of %d\n", __FUNCTION__,
 			   speed);
 		break;
 	}
@@ -1278,15 +1279,15 @@
 	int actual = 0;
 	__u8 bank;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	/* Save current bank */
 	bank = inb(iobase+BSR);
 
 	switch_bank(iobase, BANK0);
 	if (!(inb_p(iobase+LSR) & LSR_TXEMP)) {
-		IRDA_DEBUG(4, __FUNCTION__ 
-			   "(), warning, FIFO not empty yet!\n");
+		IRDA_DEBUG(4, "%s(), warning, FIFO not empty yet!\n",
+			   __FUNCTION__);
 
 		/* FIFO may still be filled to the Tx interrupt threshold */
 		fifo_size -= 17;
@@ -1298,7 +1299,7 @@
 		outb(buf[actual++], iobase+TXD);
 	}
         
-	IRDA_DEBUG(4, __FUNCTION__ "(), fifo_size %d ; %d sent of %d\n", 
+	IRDA_DEBUG(4, "%s(), fifo_size %d ; %d sent of %d\n", __FUNCTION__,
 		   fifo_size, actual, len);
 	
 	/* Restore bank */
@@ -1320,7 +1321,7 @@
 	__u8 bank;
 	int ret = TRUE;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	iobase = self->io.fir_base;
 
@@ -1456,7 +1457,7 @@
 		len = inb(iobase+RFLFL) | ((inb(iobase+RFLFH) & 0x1f) << 8);
 
 		if (st_fifo->tail >= MAX_RX_WINDOW) {
-			IRDA_DEBUG(0, __FUNCTION__ "(), window is full!\n");
+			IRDA_DEBUG(0, "%s(), window is full!\n", __FUNCTION__);
 			continue;
 		}
 			
@@ -1546,8 +1547,8 @@
 
 			skb = dev_alloc_skb(len+1);
 			if (skb == NULL)  {
-				WARNING(__FUNCTION__ "(), memory squeeze, "
-					"dropping frame.\n");
+				WARNING("%s(), memory squeeze, "
+					"dropping frame.\n", __FUNCTION__);
 				self->stats.rx_dropped++;
 
 				/* Restore bank register */
@@ -1643,7 +1644,7 @@
 	if (eir & EIR_TXEMP_EV) {
 		/* Check if we need to change the speed? */
 		if (self->new_speed) {
-			IRDA_DEBUG(2, __FUNCTION__ "(), Changing speed!\n");
+			IRDA_DEBUG(2, "%s(), Changing speed!\n", __FUNCTION__);
 			nsc_ircc_change_speed(self, self->new_speed);
 			self->new_speed = 0;
 
@@ -1822,7 +1823,7 @@
  */
 static int nsc_ircc_net_init(struct net_device *dev)
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	/* Setup to be a normal IrDA network device driver */
 	irda_device_setup(dev);
@@ -1845,7 +1846,7 @@
 	char hwname[32];
 	__u8 bank;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	ASSERT(dev != NULL, return -1;);
 	self = (struct nsc_ircc_cb *) dev->priv;
@@ -1909,7 +1910,7 @@
 	int iobase;
 	__u8 bank;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	ASSERT(dev != NULL, return -1;);
 
@@ -1965,7 +1966,7 @@
 
 	ASSERT(self != NULL, return -1;);
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
+	IRDA_DEBUG(2, "%s(), %s, (cmd=0x%X)\n", __FUNCTION__, dev->name, cmd);
 	
 	/* Disable interrupts & save flags */
 	save_flags(flags);

--------------090905080100080508090503--


