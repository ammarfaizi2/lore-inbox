Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267926AbUIAXAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267926AbUIAXAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267435AbUIAVCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:02:16 -0400
Received: from baikonur.stro.at ([213.239.196.228]:57832 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268005AbUIAU6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:58:00 -0400
Subject: [patch 25/25]  synclink: replace jiffies_from_ms() with 	msecs_to_jiffies()
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:57:55 +0200
Message-ID: <E1C2cB2-0007X7-2v@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitors list.

-Nish



Description: Uses msecs_to_jiffies() instead of the custom
jiffies_from_ms().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/synclink.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff -puN drivers/char/synclink.c~use-msecs-to-jiffies-drivers_char_synclink drivers/char/synclink.c
--- linux-2.6.9-rc1-bk7/drivers/char/synclink.c~use-msecs-to-jiffies-drivers_char_synclink	2004-09-01 19:35:56.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/synclink.c	2004-09-01 19:35:56.000000000 +0200
@@ -851,8 +851,6 @@ static int mgsl_rxenable(struct mgsl_str
 static int mgsl_wait_event(struct mgsl_struct * info, int __user *mask);
 static int mgsl_loopmode_send_done( struct mgsl_struct * info );
 
-#define jiffies_from_ms(a) ((((a) * HZ)/1000)+1)
-
 /* set non-zero on successful registration with PCI subsystem */
 static int pci_registered;
 
@@ -4171,7 +4169,7 @@ int load_next_tx_holding_buffer(struct m
 				info->get_tx_holding_index=0;
 
 			/* restart transmit timer */
-			mod_timer(&info->tx_timer, jiffies + jiffies_from_ms(5000));
+			mod_timer(&info->tx_timer, jiffies + msecs_to_jiffies(5000));
 
 			ret = 1;
 		}
@@ -5800,7 +5798,7 @@ void usc_start_transmitter( struct mgsl_
 			
 			usc_TCmd( info, TCmd_SendFrame );
 			
-			info->tx_timer.expires = jiffies + jiffies_from_ms(5000);
+			info->tx_timer.expires = jiffies + msecs_to_jiffies(5000);
 			add_timer(&info->tx_timer);	
 		}
 		info->tx_active = 1;
@@ -7196,7 +7194,7 @@ BOOLEAN mgsl_irq_test( struct mgsl_struc
 	EndTime=100;
 	while( EndTime-- && !info->irq_occurred ) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(jiffies_from_ms(10));
+		schedule_timeout(msecs_to_jiffies(10));
 	}
 	
 	spin_lock_irqsave(&info->irq_spinlock,flags);
@@ -7335,7 +7333,7 @@ BOOLEAN mgsl_dma_test( struct mgsl_struc
 	/*************************************************************/
 
 	/* Wait 100ms for interrupt. */
-	EndTime = jiffies + jiffies_from_ms(100);
+	EndTime = jiffies + msecs_to_jiffies(100);
 
 	for(;;) {
 		if (time_after(jiffies, EndTime)) {
@@ -7391,7 +7389,7 @@ BOOLEAN mgsl_dma_test( struct mgsl_struc
 	/**********************************/
 	
 	/* Wait 100ms */
-	EndTime = jiffies + jiffies_from_ms(100);
+	EndTime = jiffies + msecs_to_jiffies(100);
 
 	for(;;) {
 		if (time_after(jiffies, EndTime)) {
@@ -7433,7 +7431,7 @@ BOOLEAN mgsl_dma_test( struct mgsl_struc
 		/******************************/
 
 		/* Wait 100ms */
-		EndTime = jiffies + jiffies_from_ms(100);
+		EndTime = jiffies + msecs_to_jiffies(100);
 
 		/* While timer not expired wait for transmit complete */
 
@@ -7464,7 +7462,7 @@ BOOLEAN mgsl_dma_test( struct mgsl_struc
 		/* WAIT FOR RECEIVE COMPLETE */
 
 		/* Wait 100ms */
-		EndTime = jiffies + jiffies_from_ms(100);
+		EndTime = jiffies + msecs_to_jiffies(100);
 
 		/* Wait for 16C32 to write receive status to buffer entry. */
 		status=info->rx_buffer_list[0].status;

_
