Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932655AbWJBGix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbWJBGix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 02:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWJBGix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 02:38:53 -0400
Received: from msr34.hinet.net ([168.95.4.134]:21992 "EHLO msr34.hinet.net")
	by vger.kernel.org with ESMTP id S932652AbWJBGiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 02:38:52 -0400
Subject: [PATCH 1/5] remove TxStartThresh and RxEarlyThresh
From: Jesse Huang <jesse@icplus.com.tw>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, jesse@icplus.com.tw
Content-Type: text/plain
Date: Mon, 02 Oct 2006 14:23:51 -0400
Message-Id: <1159813431.2576.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

Change Logs:
For pattern issue need to remove TxStartThresh and RxEarlyThresh.

Signed-off-by: Jesse Huang <jesse@icplus.com.tw>
---

 drivers/net/sundance.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

3751714e0fc36905c87a230172d9561c29321833
diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
index 6b8f4ba..a5dd1c3 100755
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -264,8 +264,6 @@ enum alta_offsets {
 	ASICCtrl = 0x30,
 	EEData = 0x34,
 	EECtrl = 0x36,
-	TxStartThresh = 0x3c,
-	RxEarlyThresh = 0x3e,
 	FlashAddr = 0x40,
 	FlashData = 0x44,
 	TxStatus = 0x46,
@@ -1111,6 +1109,7 @@ static irqreturn_t intr_handler(int irq,
 	int tx_cnt;
 	int tx_status;
 	int handled = 0;
+	int i;
 
 
 	do {
@@ -1153,17 +1152,14 @@ static irqreturn_t intr_handler(int irq,
 						np->stats.tx_fifo_errors++;
 					if (tx_status & 0x02)
 						np->stats.tx_window_errors++;
+
 					/*
 					** This reset has been verified on
 					** DFE-580TX boards ! phdm@macqel.be.
 					*/
 					if (tx_status & 0x10) {	/* TxUnderrun */
-						unsigned short txthreshold;
-
-						txthreshold = ioread16 (ioaddr + TxStartThresh);
 						/* Restart Tx FIFO and transmitter */
 						sundance_reset(dev, (NetworkReset|FIFOReset|TxReset) << 16);
-						iowrite16 (txthreshold, ioaddr + TxStartThresh);
 						/* No need to reset the Tx pointer here */
 					}
 					/* Restart the Tx. */
-- 
1.3.GIT



