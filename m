Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWHQH5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWHQH5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWHQH5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:57:40 -0400
Received: from msr20.hinet.net ([168.95.4.120]:23757 "EHLO msr20.hinet.net")
	by vger.kernel.org with ESMTP id S932240AbWHQH5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:57:39 -0400
Subject: [PATCH 3/7] ip1000: remove threshold config from ipg_io_config
From: Jesse Huang <jesse@icplus.com.tw>
To: romieu@fr.zoreil.com, penberg@cs.Helsinki.FI, akpm@osdl.org,
       dvrabel@cantab.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net, jesse@icplus.com.tw
Content-Type: text/plain
Date: Thu, 17 Aug 2006 15:44:42 -0400
Message-Id: <1155843882.5006.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

remove threshold config from ipg_io_config

Change Logs:
    remove threshold config from ipg_io_config

---

 drivers/net/ipg.c |   10 +---------
 drivers/net/ipg.h |   38 --------------------------------------
 2 files changed, 1 insertions(+), 47 deletions(-)

28a5c5965399fa91d31420cf41b9e7c483f2f672
diff --git a/drivers/net/ipg.c b/drivers/net/ipg.c
index 67bf552..a996c45 100644
--- a/drivers/net/ipg.c
+++ b/drivers/net/ipg.c
@@ -943,15 +943,7 @@ static int ipg_io_config(struct net_devi
 	ipg_nic_set_multicast_list(dev);
 
 	iowrite16(IPG_MAX_RXFRAME_SIZE, ioaddr + MAX_FRAME_SIZE);
-	iowrite16(IPG_RE_RSVD_MASK & (IPG_RXEARLYTHRESH_VALUE),
-		  ioaddr + RX_EARLY_THRESH);
-	iowrite32(IPG_TT_RSVD_MASK & (IPG_TXSTARTTHRESH_VALUE),
-		  ioaddr + TX_START_THRESH);
-	iowrite32((IPG_RI_RSVD_MASK &
-		   ((IPG_RI_RXFRAME_COUNT & IPG_RXFRAME_COUNT) |
-		    (IPG_RI_PRIORITY_THRESH & (IPG_PRIORITY_THRESH << 12)) |
-		    (IPG_RI_RXDMAWAIT_TIME & (IPG_RXDMAWAIT_TIME << 16)))),
-		  ioaddr + RX_DMA_INT_CTRL);
+
 	iowrite8(IPG_RP_RSVD_MASK & (IPG_RXDMAPOLLPERIOD_VALUE),
 		 ioaddr + RX_DMA_POLL_PERIOD);
 	iowrite8(IPG_RU_RSVD_MASK & (IPG_RXDMAURGENTTHRESH_VALUE),
diff --git a/drivers/net/ipg.h b/drivers/net/ipg.h
index 9f841d2..818a677 100644
--- a/drivers/net/ipg.h
+++ b/drivers/net/ipg.h
@@ -80,14 +80,11 @@ enum ipg_regs {
 	RX_DMA_BURST_THRESH	= 0x24,
 	RX_DMA_URGENT_THRESH	= 0x25,
 	RX_DMA_POLL_PERIOD	= 0x26,
-	RX_DMA_INT_CTRL		= 0x28,
 	DEBUG_CTRL		= 0x2c,
 	ASIC_CTRL		= 0x30,
 	FIFO_CTRL		= 0x38, // Unused
-	RX_EARLY_THRESH		= 0x3a,
 	FLOW_OFF_THRESH		= 0x3c,
 	FLOW_ON_THRESH		= 0x3e,
-	TX_START_THRESH		= 0x44,
 	EEPROM_DATA		= 0x48,
 	EEPROM_CTRL		= 0x4a,
 	EXPROM_ADDR		= 0x4c, // Unused
@@ -324,12 +321,6 @@ #define IPG_RU_RSVD_MASK                
 /* RxDMAPollPeriod */
 #define IPG_RP_RSVD_MASK                0xFF
 
-/* TxStartThresh */
-#define IPG_TT_RSVD_MASK                0x0FFF
-
-/* RxEarlyThresh */
-#define IPG_RE_RSVD_MASK                0x07FF
-
 /* ReceiveMode */
 #define IPG_RM_RSVD_MASK                0x3F
 #define IPG_RM_RECEIVEUNICAST           0x01
@@ -496,12 +487,6 @@ #define IPG_MC_RX_DISABLE               
 #define IPG_MC_RX_ENABLED               0x20000000
 #define IPG_MC_PAUSED                   0x40000000
 
-/* RxDMAIntCtrl */
-#define IPG_RI_RSVD_MASK                0xFFFF1CFF
-#define IPG_RI_RXFRAME_COUNT            0x000000FF
-#define IPG_RI_PRIORITY_THRESH          0x00001C00
-#define IPG_RI_RXDMAWAIT_TIME           0xFFFF0000
-
 /*
  *	Tune
  */
@@ -662,32 +647,11 @@ #define		IPG_MAXRFDPROCESS_COUNT	0x80
  */
 #define		IPG_MINUSEDRFDSTOFREE	0x80
 
-/* Specify priority threshhold for a RxDMAPriority interrupt. */
-#define		IPG_PRIORITY_THRESH		0x07
-
-/* Specify the number of receive frames transferred via DMA
- * before a RX interrupt is issued.
- */
-#define		IPG_RXFRAME_COUNT		0x08
-
 /* specify the jumbo frame maximum size
  * per unit is 0x600 (the RxBuffer size that one RFD can carry)
  */
 #define     MAX_JUMBOSIZE	        0x8	// max is 12K
 
-/* Specify the maximum amount of time (in 64ns increments) to wait
- * before issuing a RX interrupt if number of frames received
- * is less than IPG_RXFRAME_COUNT.
- *
- * Value	Time
- * -------------------
- * 0x3D09	~1ms
- * 0x061A	~100us
- * 0x009C	~10us
- * 0x000F	~1us
- */
-#define		IPG_RXDMAWAIT_TIME		0x009C
-
 /* Key register values loaded at driver start up. */
 
 /* TXDMAPollPeriod is specified in 320ns increments.
@@ -700,7 +664,6 @@ #define		IPG_RXDMAWAIT_TIME		0x009C
  * 0xFF		~82us
  */
 #define		IPG_TXDMAPOLLPERIOD_VALUE	0x26
-#define		IPG_TXSTARTTHRESH_VALUE	0x0FFF
 
 /* TxDMAUrgentThresh specifies the minimum amount of
  * data in the transmit FIFO before asserting an
@@ -737,7 +700,6 @@ #define		IPG_TXDMABURSTTHRESH_VALUE	0x30
  * 0xFF		~82us
  */
 #define		IPG_RXDMAPOLLPERIOD_VALUE	0x01
-#define		IPG_RXEARLYTHRESH_VALUE	0x07FF
 
 /* RxDMAUrgentThresh specifies the minimum amount of
  * free space within the receive FIFO before asserting
-- 
1.3.2



