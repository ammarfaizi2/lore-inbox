Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbUBZD3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUBZDXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:23:52 -0500
Received: from palrel10.hp.com ([156.153.255.245]:32907 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262673AbUBZDT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:19:26 -0500
Date: Wed, 25 Feb 2004 19:19:25 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] dev_flags
Message-ID: <20040226031925.GM32263@bougret.hpl.hp.com>
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

irXXX_dev_flags.diff :
~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] remove unused code


diff -Nru a/drivers/net/irda/ali-ircc.c b/drivers/net/irda/ali-ircc.c
--- a/drivers/net/irda/ali-ircc.c	Mon Feb 16 10:39:22 2004
+++ b/drivers/net/irda/ali-ircc.c	Mon Feb 16 10:39:22 2004
@@ -299,8 +299,6 @@
 			
 	irda_qos_bits_to_value(&self->qos);
 	
-	self->flags = IFF_FIR|IFF_MIR|IFF_SIR|IFF_DMA|IFF_PIO; 	// benjamin 2000/11/8 05:27PM	
-
 	/* Max DMA buffer size needed = (data_size + 6) * (window_size) + 6; */
 	self->rx_buff.truesize = 14384; 
 	self->tx_buff.truesize = 14384;
diff -Nru a/drivers/net/irda/donauboe.c b/drivers/net/irda/donauboe.c
--- a/drivers/net/irda/donauboe.c	Mon Feb 16 10:39:22 2004
+++ b/drivers/net/irda/donauboe.c	Mon Feb 16 10:39:22 2004
@@ -1646,21 +1646,17 @@
   if (max_baud >= 1152000)
     {
       self->qos.baud_rate.bits |= IR_1152000;
-      self->flags |= IFF_MIR;
     }
 #endif
   if (max_baud >= 4000000)
     {
       self->qos.baud_rate.bits |= (IR_4000000 << 8);
-      self->flags |= IFF_FIR;
     }
 
   /*FIXME: work this out... */
   self->qos.min_turn_time.bits = 0xff;
 
   irda_qos_bits_to_value (&self->qos);
-
-  self->flags = IFF_SIR | IFF_DMA | IFF_PIO;
 
   /* Allocate twice the size to guarantee alignment */
   self->ringbuf = (void *) kmalloc (OBOE_RING_LEN << 1, GFP_KERNEL);
diff -Nru a/drivers/net/irda/irda-usb.c b/drivers/net/irda/irda-usb.c
--- a/drivers/net/irda/irda-usb.c	Mon Feb 16 10:39:22 2004
+++ b/drivers/net/irda/irda-usb.c	Mon Feb 16 10:39:22 2004
@@ -1136,14 +1136,6 @@
 	 * the transmit path will be set differently - Jean II 
 	 */
 	irda_qos_bits_to_value(&self->qos);
-
-	self->flags |= IFF_SIR;
-	if (self->qos.baud_rate.value > 115200)
-		self->flags |= IFF_MIR;
-	if (self->qos.baud_rate.value > 1152000)
-		self->flags |= IFF_FIR;
-	if (self->qos.baud_rate.value > 4000000)
-		self->flags |= IFF_VFIR;
 }
 
 /*------------------------------------------------------------------*/
diff -Nru a/drivers/net/irda/irport.c b/drivers/net/irda/irport.c
--- a/drivers/net/irda/irport.c	Mon Feb 16 10:39:22 2004
+++ b/drivers/net/irda/irport.c	Mon Feb 16 10:39:22 2004
@@ -179,9 +179,6 @@
 	self->qos.min_turn_time.bits = qos_mtt_bits;
 	irda_qos_bits_to_value(&self->qos);
 	
-	self->flags = IFF_SIR|IFF_PIO;
-	self->mode = IRDA_IRLAP;
-
 	/* Bootstrap ZeroCopy Rx */
 	self->rx_buff.truesize = IRDA_SKB_MAX_MTU;
 	self->rx_buff.skb = __dev_alloc_skb(self->rx_buff.truesize,
diff -Nru a/drivers/net/irda/nsc-ircc.c b/drivers/net/irda/nsc-ircc.c
--- a/drivers/net/irda/nsc-ircc.c	Mon Feb 16 10:39:22 2004
+++ b/drivers/net/irda/nsc-ircc.c	Mon Feb 16 10:39:22 2004
@@ -302,8 +302,6 @@
 	self->qos.min_turn_time.bits = qos_mtt_bits;
 	irda_qos_bits_to_value(&self->qos);
 	
-	self->flags = IFF_FIR|IFF_MIR|IFF_SIR|IFF_DMA|IFF_PIO|IFF_DONGLE;
-
 	/* Max DMA buffer size needed = (data_size + 6) * (window_size) + 6; */
 	self->rx_buff.truesize = 14384; 
 	self->tx_buff.truesize = 14384;
diff -Nru a/drivers/net/irda/sir_dev.c b/drivers/net/irda/sir_dev.c
--- a/drivers/net/irda/sir_dev.c	Mon Feb 16 10:39:22 2004
+++ b/drivers/net/irda/sir_dev.c	Mon Feb 16 10:39:22 2004
@@ -620,8 +620,6 @@
 
 	SET_MODULE_OWNER(ndev);
 
-	dev->flags = IFF_SIR | IFF_PIO;
-
 	/* Override the network functions we need to use */
 	ndev->hard_start_xmit = sirdev_hard_xmit;
 	ndev->open = sirdev_open;
diff -Nru a/drivers/net/irda/smsc-ircc2.c b/drivers/net/irda/smsc-ircc2.c
--- a/drivers/net/irda/smsc-ircc2.c	Mon Feb 16 10:39:22 2004
+++ b/drivers/net/irda/smsc-ircc2.c	Mon Feb 16 10:39:22 2004
@@ -441,8 +441,6 @@
 
 	smsc_ircc_setup_qos(self);
 
-	self->flags = IFF_FIR|IFF_MIR|IFF_SIR|IFF_DMA|IFF_PIO;
-		
 	smsc_ircc_init_chip(self);
 	
 	if(ircc_transceiver > 0  && 
diff -Nru a/drivers/net/irda/via-ircc.c b/drivers/net/irda/via-ircc.c
--- a/drivers/net/irda/via-ircc.c	Mon Feb 16 10:39:22 2004
+++ b/drivers/net/irda/via-ircc.c	Mon Feb 16 10:39:22 2004
@@ -377,9 +377,6 @@
 	self->qos.min_turn_time.bits = qos_mtt_bits;
 	irda_qos_bits_to_value(&self->qos);
 
-	self->flags =
-	    IFF_FIR | IFF_MIR | IFF_SIR | IFF_DMA | IFF_PIO | IFF_DONGLE;
-
 	/* Max DMA buffer size needed = (data_size + 6) * (window_size) + 6; */
 	self->rx_buff.truesize = 14384 + 2048;
 	self->tx_buff.truesize = 14384 + 2048;
diff -Nru a/drivers/net/irda/w83977af_ir.c b/drivers/net/irda/w83977af_ir.c
--- a/drivers/net/irda/w83977af_ir.c	Mon Feb 16 10:39:22 2004
+++ b/drivers/net/irda/w83977af_ir.c	Mon Feb 16 10:39:22 2004
@@ -202,8 +202,6 @@
 	self->qos.min_turn_time.bits = qos_mtt_bits;
 	irda_qos_bits_to_value(&self->qos);
 	
-	self->flags = IFF_FIR|IFF_MIR|IFF_SIR|IFF_DMA|IFF_PIO;
-
 	/* Max DMA buffer size needed = (data_size + 6) * (window_size) + 6; */
 	self->rx_buff.truesize = 14384; 
 	self->tx_buff.truesize = 4000;
diff -Nru a/include/net/irda/ali-ircc.h b/include/net/irda/ali-ircc.h
--- a/include/net/irda/ali-ircc.h	Mon Feb 16 10:39:22 2004
+++ b/include/net/irda/ali-ircc.h	Mon Feb 16 10:39:22 2004
@@ -212,7 +212,6 @@
 
 	spinlock_t lock;           /* For serializing operations */
 	
-	__u32 flags;               /* Interface flags */
 	__u32 new_speed;
 	int index;                 /* Instance index */
 	
diff -Nru a/include/net/irda/au1000_ircc.h b/include/net/irda/au1000_ircc.h
--- a/include/net/irda/au1000_ircc.h	Mon Feb 16 10:39:22 2004
+++ b/include/net/irda/au1000_ircc.h	Mon Feb 16 10:39:22 2004
@@ -115,7 +115,6 @@
 	struct irlap_cb		*irlap;
 	
 	u8 open;
-	u32 flags;               /* Interface flags */
 	u32 speed;
 	u32 newspeed;
 	
diff -Nru a/include/net/irda/irda-usb.h b/include/net/irda/irda-usb.h
--- a/include/net/irda/irda-usb.h	Mon Feb 16 10:39:22 2004
+++ b/include/net/irda/irda-usb.h	Mon Feb 16 10:39:22 2004
@@ -159,6 +159,5 @@
 	__s16 new_xbofs;		/* xbofs we need to set */
 	__u32 speed;			/* Current speed */
 	__s32 new_speed;		/* speed we need to set */
-	__u32 flags;			/* Interface flags */
 };
 
diff -Nru a/include/net/irda/nsc-ircc.h b/include/net/irda/nsc-ircc.h
--- a/include/net/irda/nsc-ircc.h	Mon Feb 16 10:39:22 2004
+++ b/include/net/irda/nsc-ircc.h	Mon Feb 16 10:39:22 2004
@@ -263,7 +263,6 @@
 
 	spinlock_t lock;           /* For serializing operations */
 	
-	__u32 flags;               /* Interface flags */
 	__u32 new_speed;
 	int index;                 /* Instance index */
 
diff -Nru a/include/net/irda/smc-ircc.h b/include/net/irda/smc-ircc.h
--- a/include/net/irda/smc-ircc.h	Mon Feb 16 10:39:22 2004
+++ b/include/net/irda/smc-ircc.h	Mon Feb 16 10:39:22 2004
@@ -170,7 +170,6 @@
 	 * synchronised - Jean II */
 	
 	__u32 new_speed;
-	__u32 flags;               /* Interface flags */
 
 	int tx_buff_offsets[10];   /* Offsets between frames in tx_buff */
 	int tx_len;                /* Number of frames in tx_buff */
diff -Nru a/include/net/irda/toshoboe.h b/include/net/irda/toshoboe.h
--- a/include/net/irda/toshoboe.h	Mon Feb 16 10:39:22 2004
+++ b/include/net/irda/toshoboe.h	Mon Feb 16 10:39:22 2004
@@ -146,7 +146,6 @@
 
     chipio_t io;                /* IrDA controller information */
 
-    __u32 flags;                /* Interface flags */
     __u32 new_speed;
 
     struct pci_dev *pdev;       /*PCI device */
diff -Nru a/include/net/irda/w83977af_ir.h b/include/net/irda/w83977af_ir.h
--- a/include/net/irda/w83977af_ir.h	Mon Feb 16 10:39:22 2004
+++ b/include/net/irda/w83977af_ir.h	Mon Feb 16 10:39:22 2004
@@ -185,7 +185,6 @@
 	 * locking strategy. - Jean II */
 	spinlock_t lock;           /* For serializing operations */
 	
-	__u32 flags;               /* Interface flags */
 	__u32 new_speed;
 };
 
