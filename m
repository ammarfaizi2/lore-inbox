Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291432AbSBHGaW>; Fri, 8 Feb 2002 01:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291434AbSBHGaN>; Fri, 8 Feb 2002 01:30:13 -0500
Received: from holomorphy.com ([216.36.33.161]:52880 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291432AbSBHG35>;
	Fri, 8 Feb 2002 01:29:57 -0500
Date: Thu, 7 Feb 2002 22:29:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com
Subject: [PATCH] fix conflicting pcnet32 definitions
Message-ID: <20020208062942.GF11971@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, 2.4.9 had all the same #defines -- could you check this out and
see if it's the right thing to do? I read over it fairly quick, and
test compiled it, but didn't give it a run just yet on my box with a
pcnet32 in it (it's had enough uptime I don't want to disturb it).

(I did do the doublecheck to make sure none of the defines changed
 were not private to pcnet32 in the 2.4.9 version or current 2.4.x.)

Thanks,
Bill

--- linux/drivers/net/pcnet32.c.orig	Thu Feb  7 22:18:26 2002
+++ linux/drivers/net/pcnet32.c	Thu Feb  7 22:19:07 2002
@@ -72,15 +72,15 @@
 static const int max_interrupt_work = 80;
 static const int rx_copybreak = 200;
 
-#define PORT_AUI      0x00
-#define PORT_10BT     0x01
-#define PORT_GPSI     0x02
-#define PORT_MII      0x03
-
-#define PORT_PORTSEL  0x03
-#define PORT_ASEL     0x04
-#define PORT_100      0x40
-#define PORT_FD	      0x80
+#define PCNET32_PORT_AUI      0x00
+#define PCNET32_PORT_10BT     0x01
+#define PCNET32_PORT_GPSI     0x02
+#define PCNET32_PORT_MII      0x03
+
+#define PCNET32_PORT_PORTSEL  0x03
+#define PCNET32_PORT_ASEL     0x04
+#define PCNET32_PORT_100      0x40
+#define PCNET32_PORT_FD	      0x80
 
 #define PCNET32_DMA_MASK 0xffffffff
 
@@ -89,22 +89,22 @@
  * to internal options
  */
 static unsigned char options_mapping[] = {
-    PORT_ASEL,			   /*  0 Auto-select	  */
-    PORT_AUI,			   /*  1 BNC/AUI	  */
-    PORT_AUI,			   /*  2 AUI/BNC	  */ 
-    PORT_ASEL,			   /*  3 not supported	  */
-    PORT_10BT | PORT_FD,	   /*  4 10baseT-FD	  */
-    PORT_ASEL,			   /*  5 not supported	  */
-    PORT_ASEL,			   /*  6 not supported	  */
-    PORT_ASEL,			   /*  7 not supported	  */
-    PORT_ASEL,			   /*  8 not supported	  */
-    PORT_MII,			   /*  9 MII 10baseT	  */
-    PORT_MII | PORT_FD,		   /* 10 MII 10baseT-FD	  */
-    PORT_MII,			   /* 11 MII (autosel)	  */
-    PORT_10BT,			   /* 12 10BaseT	  */
-    PORT_MII | PORT_100,	   /* 13 MII 100BaseTx	  */
-    PORT_MII | PORT_100 | PORT_FD, /* 14 MII 100BaseTx-FD */
-    PORT_ASEL			   /* 15 not supported	  */
+    PCNET32_PORT_ASEL,			   /*  0 Auto-select	  */
+    PCNET32_PORT_AUI,			   /*  1 BNC/AUI	  */
+    PCNET32_PORT_AUI,			   /*  2 AUI/BNC	  */ 
+    PCNET32_PORT_ASEL,			   /*  3 not supported	  */
+    PCNET32_PORT_10BT | PCNET32_PORT_FD,	   /*  4 10baseT-FD	  */
+    PCNET32_PORT_ASEL,			   /*  5 not supported	  */
+    PCNET32_PORT_ASEL,			   /*  6 not supported	  */
+    PCNET32_PORT_ASEL,			   /*  7 not supported	  */
+    PCNET32_PORT_ASEL,			   /*  8 not supported	  */
+    PCNET32_PORT_MII,			   /*  9 MII 10baseT	  */
+    PCNET32_PORT_MII | PCNET32_PORT_FD,		   /* 10 MII 10baseT-FD	  */
+    PCNET32_PORT_MII,			   /* 11 MII (autosel)	  */
+    PCNET32_PORT_10BT,			   /* 12 10BaseT	  */
+    PCNET32_PORT_MII | PCNET32_PORT_100,	   /* 13 MII 100BaseTx	  */
+    PCNET32_PORT_MII | PCNET32_PORT_100 | PCNET32_PORT_FD, /* 14 MII 100BaseTx-FD */
+    PCNET32_PORT_ASEL			   /* 15 not supported	  */
 };
 
 #define MAX_UNITS 8
@@ -725,15 +725,15 @@
     lp->ltint = ltint;
     lp->mii = mii;
     if (options[card_idx] > sizeof (options_mapping))
-	lp->options = PORT_ASEL;
+	lp->options = PCNET32_PORT_ASEL;
     else
 	lp->options = options_mapping[options[card_idx]];
     lp->mii_if.dev = dev;
     lp->mii_if.mdio_read = mdio_read;
     lp->mii_if.mdio_write = mdio_write;
     
-    if (fdx && !(lp->options & PORT_ASEL) && full_duplex[card_idx])
-	lp->options |= PORT_FD;
+    if (fdx && !(lp->options & PCNET32_PORT_ASEL) && full_duplex[card_idx])
+	lp->options |= PCNET32_PORT_FD;
     
     if (a == NULL) {
       printk(KERN_ERR "pcnet32: No access methods\n");
@@ -745,7 +745,7 @@
     
     /* detect special T1/E1 WAN card by checking for MAC address */
     if (dev->dev_addr[0] == 0x00 && dev->dev_addr[1] == 0xe0 && dev->dev_addr[2] == 0x75)
-	lp->options = PORT_FD | PORT_GPSI;
+	lp->options = PCNET32_PORT_FD | PCNET32_PORT_GPSI;
 
     lp->init_block.mode = le16_to_cpu(0x0003);	/* Disable Rx and Tx. */
     lp->init_block.tlen_rlen = le16_to_cpu(TX_RING_LEN_BITS | RX_RING_LEN_BITS); 
@@ -846,16 +846,16 @@
     
     /* set/reset autoselect bit */
     val = lp->a.read_bcr (ioaddr, 2) & ~2;
-    if (lp->options & PORT_ASEL)
+    if (lp->options & PCNET32_PORT_ASEL)
 	val |= 2;
     lp->a.write_bcr (ioaddr, 2, val);
     
     /* handle full duplex setting */
     if (lp->mii_if.full_duplex) {
 	val = lp->a.read_bcr (ioaddr, 9) & ~3;
-	if (lp->options & PORT_FD) {
+	if (lp->options & PCNET32_PORT_FD) {
 	    val |= 1;
-	    if (lp->options == (PORT_FD | PORT_AUI))
+	    if (lp->options == (PCNET32_PORT_FD | PCNET32_PORT_AUI))
 		val |= 2;
 	}
 	lp->a.write_bcr (ioaddr, 9, val);
@@ -863,19 +863,19 @@
     
     /* set/reset GPSI bit in test register */
     val = lp->a.read_csr (ioaddr, 124) & ~0x10;
-    if ((lp->options & PORT_PORTSEL) == PORT_GPSI)
+    if ((lp->options & PCNET32_PORT_PORTSEL) == PCNET32_PORT_GPSI)
 	val |= 0x10;
     lp->a.write_csr (ioaddr, 124, val);
     
-    if (lp->mii && !(lp->options & PORT_ASEL)) {
+    if (lp->mii && !(lp->options & PCNET32_PORT_ASEL)) {
 	val = lp->a.read_bcr (ioaddr, 32) & ~0x38; /* disable Auto Negotiation, set 10Mpbs, HD */
-	if (lp->options & PORT_FD)
+	if (lp->options & PCNET32_PORT_FD)
 	    val |= 0x10;
-	if (lp->options & PORT_100)
+	if (lp->options & PCNET32_PORT_100)
 	    val |= 0x08;
 	lp->a.write_bcr (ioaddr, 32, val);
     } else {
-	if (lp->options & PORT_ASEL) {  /* enable auto negotiate, setup, disable fd */
+	if (lp->options & PCNET32_PORT_ASEL) {  /* enable auto negotiate, setup, disable fd */
 		val = lp->a.read_bcr(ioaddr, 32) & ~0x98;
 		val |= 0x20;
 		lp->a.write_bcr(ioaddr, 32, val);
@@ -895,7 +895,7 @@
 	lp->a.write_csr (ioaddr, 5, val);
     }
    
-    lp->init_block.mode = le16_to_cpu((lp->options & PORT_PORTSEL) << 7);
+    lp->init_block.mode = le16_to_cpu((lp->options & PCNET32_PORT_PORTSEL) << 7);
     lp->init_block.filter[0] = 0x00000000;
     lp->init_block.filter[1] = 0x00000000;
     if (pcnet32_init_ring(dev))
@@ -1494,9 +1494,9 @@
     if (dev->flags&IFF_PROMISC) {
 	/* Log any net taps. */
 	printk(KERN_INFO "%s: Promiscuous mode enabled.\n", dev->name);
-	lp->init_block.mode = le16_to_cpu(0x8000 | (lp->options & PORT_PORTSEL) << 7);
+	lp->init_block.mode = le16_to_cpu(0x8000 | (lp->options & PCNET32_PORT_PORTSEL) << 7);
     } else {
-	lp->init_block.mode = le16_to_cpu((lp->options & PORT_PORTSEL) << 7);
+	lp->init_block.mode = le16_to_cpu((lp->options & PCNET32_PORT_PORTSEL) << 7);
 	pcnet32_load_multicast (dev);
     }
     
