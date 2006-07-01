Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWGAPDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWGAPDa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWGAPDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:03:08 -0400
Received: from www.osadl.org ([213.239.205.134]:10405 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751855AbWGAO5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:40 -0400
Message-Id: <20060701145228.136251000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:55:09 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>
Subject: [RFC][patch 42/44] video: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-video.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/video/arcfb.c                |    2 +-
 drivers/video/aty/atyfb_base.c       |    2 +-
 drivers/video/au1200fb.c             |    2 +-
 drivers/video/matrox/matroxfb_base.c |    2 +-
 drivers/video/pxafb.c                |    2 +-
 drivers/video/s3c2410fb.c            |    2 +-
 drivers/video/sa1100fb.c             |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.git/drivers/video/arcfb.c
===================================================================
--- linux-2.6.git.orig/drivers/video/arcfb.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/video/arcfb.c	2006-07-01 16:51:49.000000000 +0200
@@ -561,7 +561,7 @@ static int __init arcfb_probe(struct pla
 	platform_set_drvdata(dev, info);
 	if (irq) {
 		par->irq = irq;
-		if (request_irq(par->irq, &arcfb_interrupt, SA_SHIRQ,
+		if (request_irq(par->irq, &arcfb_interrupt, IRQF_SHARED,
 				"arcfb", info)) {
 			printk(KERN_INFO
 				"arcfb: Failed req IRQ %d\n", par->irq);
Index: linux-2.6.git/drivers/video/au1200fb.c
===================================================================
--- linux-2.6.git.orig/drivers/video/au1200fb.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/video/au1200fb.c	2006-07-01 16:51:49.000000000 +0200
@@ -1694,7 +1694,7 @@ static int au1200fb_drv_probe(struct dev
 
 	/* Now hook interrupt too */
 	if ((ret = request_irq(AU1200_LCD_INT, au1200fb_handle_irq,
-		 	  SA_INTERRUPT | SA_SHIRQ, "lcd", (void *)dev)) < 0) {
+		 	  IRQF_DISABLED | IRQF_SHARED, "lcd", (void *)dev)) < 0) {
 		print_err("fail to request interrupt line %d (err: %d)",
 			  AU1200_LCD_INT, ret);
 		goto failed;
Index: linux-2.6.git/drivers/video/pxafb.c
===================================================================
--- linux-2.6.git.orig/drivers/video/pxafb.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/video/pxafb.c	2006-07-01 16:51:49.000000000 +0200
@@ -1334,7 +1334,7 @@ int __init pxafb_probe(struct platform_d
 		goto failed;
 	}
 
-	ret = request_irq(IRQ_LCD, pxafb_handle_irq, SA_INTERRUPT, "LCD", fbi);
+	ret = request_irq(IRQ_LCD, pxafb_handle_irq, IRQF_DISABLED, "LCD", fbi);
 	if (ret) {
 		dev_err(&dev->dev, "request_irq failed: %d\n", ret);
 		ret = -EBUSY;
Index: linux-2.6.git/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.git.orig/drivers/video/s3c2410fb.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/video/s3c2410fb.c	2006-07-01 16:51:49.000000000 +0200
@@ -735,7 +735,7 @@ static int __init s3c2410fb_probe(struct
 
 	dprintk("got LCD region\n");
 
-	ret = request_irq(irq, s3c2410fb_irq, SA_INTERRUPT, pdev->name, info);
+	ret = request_irq(irq, s3c2410fb_irq, IRQF_DISABLED, pdev->name, info);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot get irq %d - err %d\n", irq, ret);
 		ret = -EBUSY;
Index: linux-2.6.git/drivers/video/sa1100fb.c
===================================================================
--- linux-2.6.git.orig/drivers/video/sa1100fb.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/video/sa1100fb.c	2006-07-01 16:51:49.000000000 +0200
@@ -1472,7 +1472,7 @@ static int __init sa1100fb_probe(struct 
 	if (ret)
 		goto failed;
 
-	ret = request_irq(irq, sa1100fb_handle_irq, SA_INTERRUPT,
+	ret = request_irq(irq, sa1100fb_handle_irq, IRQF_DISABLED,
 			  "LCD", fbi);
 	if (ret) {
 		printk(KERN_ERR "sa1100fb: request_irq failed: %d\n", ret);
Index: linux-2.6.git/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6.git.orig/drivers/video/aty/atyfb_base.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/video/aty/atyfb_base.c	2006-07-01 16:51:49.000000000 +0200
@@ -1567,7 +1567,7 @@ static int aty_enable_irq(struct atyfb_p
 	u32 int_cntl;
 
 	if (!test_and_set_bit(0, &par->irq_flags)) {
-		if (request_irq(par->irq, aty_irq, SA_SHIRQ, "atyfb", par)) {
+		if (request_irq(par->irq, aty_irq, IRQF_SHARED, "atyfb", par)) {
 			clear_bit(0, &par->irq_flags);
 			return -EINVAL;
 		}
Index: linux-2.6.git/drivers/video/matrox/matroxfb_base.c
===================================================================
--- linux-2.6.git.orig/drivers/video/matrox/matroxfb_base.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/video/matrox/matroxfb_base.c	2006-07-01 16:51:49.000000000 +0200
@@ -233,7 +233,7 @@ int matroxfb_enable_irq(WPMINFO int reen
 
 	if (!test_and_set_bit(0, &ACCESS_FBINFO(irq_flags))) {
 		if (request_irq(ACCESS_FBINFO(pcidev)->irq, matrox_irq,
-				SA_SHIRQ, "matroxfb", MINFO)) {
+				IRQF_SHARED, "matroxfb", MINFO)) {
 			clear_bit(0, &ACCESS_FBINFO(irq_flags));
 			return -EINVAL;
 		}

--

