Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319313AbSH2ThZ>; Thu, 29 Aug 2002 15:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319316AbSH2ThZ>; Thu, 29 Aug 2002 15:37:25 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:60918 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319313AbSH2ThX>; Thu, 29 Aug 2002 15:37:23 -0400
Subject: [TRIVIAL][PATCH] fix __FUNCTION__ pasting in arch/arm code
From: Paul Larson <plars@linuxtestproject.org>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Aug 2002 14:31:37 -0500
Message-Id: <1030649497.5187.51.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix for __FUNCTION__ pasting in arch/arm stuff against current bk tree.

-Paul Larson

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.555   -> 1.556  
#	arch/arm/mach-sa1100/dma.c	1.1     -> 1.2    
#	arch/arm/mach-sa1100/badge4.c	1.7     -> 1.8    
#	arch/arm/mach-sa1100/h3600.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/29	plars@austin.ibm.com	1.556
# fix __FUNCTION__ pasting in arch/arm code
# --------------------------------------------
#
diff -Nru a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
--- a/arch/arm/mach-sa1100/badge4.c	Thu Aug 29 15:17:30 2002
+++ b/arch/arm/mach-sa1100/badge4.c	Thu Aug 29 15:17:30 2002
@@ -57,8 +57,8 @@
 
 	ret = badge4_sa1111_init();
 	if (ret < 0)
-		printk(KERN_ERR __FUNCTION__
-		       ": SA-1111 initialization failed (%d)\n", ret);
+		printk(KERN_ERR "%s: SA-1111 initialization failed (%d)\n", 
+			__FUNCTION__, ret);
 
 	/* N.B, according to rmk this is the singular place that GPDR
            should be set */
@@ -132,11 +132,11 @@
 	/* detect on->off and off->on transitions */
 	if ((!old_5V_bitmap) && (badge4_5V_bitmap)) {
 		/* was off, now on */
-		printk(KERN_INFO __FUNCTION__ ": enabling 5V supply rail\n");
+		printk(KERN_INFO "%s: enabling 5V supply rail\n", __FUNCTION__);
 		GPSR = BADGE4_GPIO_PCMEN5V;
 	} else if ((old_5V_bitmap) && (!badge4_5V_bitmap)) {
 		/* was on, now off */
-		printk(KERN_INFO __FUNCTION__ ": disabling 5V supply rail\n");
+		printk(KERN_INFO "%s: disabling 5V supply rail\n", __FUNCTION__);
 		GPCR = BADGE4_GPIO_PCMEN5V;
 	}
 
diff -Nru a/arch/arm/mach-sa1100/dma.c b/arch/arm/mach-sa1100/dma.c
--- a/arch/arm/mach-sa1100/dma.c	Thu Aug 29 15:17:30 2002
+++ b/arch/arm/mach-sa1100/dma.c	Thu Aug 29 15:17:30 2002
@@ -126,9 +126,9 @@
 	err = request_irq(IRQ_DMA0 + i, dma_irq_handler, SA_INTERRUPT,
 			  device_id, regs);
 	if (err) {
-		printk(KERN_ERR __FUNCTION__
-		       "unable to request IRQ %d for %s\n",
-		       IRQ_DMA0 + i, device_id);
+		printk(KERN_ERR 
+		       "%s unable to request IRQ %d for %s\n",
+		       __FUNCTION__, IRQ_DMA0 + i, device_id);
 		dma->device = 0;
 		return err;
 	}
@@ -164,12 +164,12 @@
 		if (regs == (dma_regs_t *)&DDAR(i))
 			break;
 	if (i >= SA1100_DMA_CHANNELS) {
-		printk(KERN_ERR __FUNCTION__ ": bad DMA identifier\n");
+		printk(KERN_ERR "%s: bad DMA identifier\n", __FUNCTION__);
 		return;
 	}
 
 	if (!dma_chan[i].device) {
-		printk(KERN_ERR __FUNCTION__ "Trying to free free DMA\n");
+		printk(KERN_ERR "%s Trying to free free DMA\n", __FUNCTION__);
 		return;
 	}
 
@@ -324,7 +324,7 @@
 		if (regs == (dma_regs_t *)&DDAR(i))
 			break;
 	if (i >= SA1100_DMA_CHANNELS) {
-		printk(KERN_ERR __FUNCTION__ ": bad DMA identifier\n");
+		printk(KERN_ERR "%s: bad DMA identifier\n", __FUNCTION__);
 		return;
 	}
 
diff -Nru a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
--- a/arch/arm/mach-sa1100/h3600.c	Thu Aug 29 15:17:30 2002
+++ b/arch/arm/mach-sa1100/h3600.c	Thu Aug 29 15:17:30 2002
@@ -133,8 +133,8 @@
 
 	/*
 	if ( x != IPAQ_EGPIO_VPP_ON ) {
-		printk(__FUNCTION__ " : type=%d (%s) gpio=0x%x (0x%x) egpio=0x%x (0x%x) setp=%d\n",
-		       x, egpio_names[x], GPLR, gpio, h3600_egpio, egpio, setp );
+		printk("%s : type=%d (%s) gpio=0x%x (0x%x) egpio=0x%x (0x%x) setp=%d\n",
+		       __FUNCTION__, x, egpio_names[x], GPLR, gpio, h3600_egpio, egpio, setp );
 	}
 	*/
 }

