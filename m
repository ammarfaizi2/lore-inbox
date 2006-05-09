Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWEITvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWEITvs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWEITvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:51:47 -0400
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:29347
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S1751052AbWEITvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:51:46 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
In-Reply-To: <2.628477917@selenic.com>
Message-Id: <7.628477917@selenic.com>
Subject: [PATCH 6/6] random: Remove redundant SA_SAMPLE_RANDOM from touchscreen drivers
Date: Tue, 09 May 2006 14:50:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant SA_SAMPLE_RANDOM from touchscreen drivers

The core input layer is already calling add_input_randomness.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/drivers/input/touchscreen/ads7846.c
===================================================================
--- 2.6.orig/drivers/input/touchscreen/ads7846.c	2006-05-02 17:29:26.000000000 -0500
+++ 2.6/drivers/input/touchscreen/ads7846.c	2006-05-03 11:58:51.000000000 -0500
@@ -770,8 +770,7 @@ static int __devinit ads7846_probe(struc
 
 	ts->last_msg = m;
 
-	if (request_irq(spi->irq, ads7846_irq,
-			SA_SAMPLE_RANDOM | SA_TRIGGER_FALLING,
+	if (request_irq(spi->irq, ads7846_irq, SA_TRIGGER_FALLING,
 			spi->dev.bus_id, ts)) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
 		err = -EBUSY;
Index: 2.6/drivers/input/touchscreen/h3600_ts_input.c
===================================================================
--- 2.6.orig/drivers/input/touchscreen/h3600_ts_input.c	2006-04-20 17:00:40.000000000 -0500
+++ 2.6/drivers/input/touchscreen/h3600_ts_input.c	2006-05-03 11:58:13.000000000 -0500
@@ -399,16 +399,14 @@ static int h3600ts_connect(struct serio 
 	set_GPIO_IRQ_edge(GPIO_BITSY_NPOWER_BUTTON, GPIO_RISING_EDGE);
 
 	if (request_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, action_button_handler,
-			SA_SHIRQ | SA_INTERRUPT | SA_SAMPLE_RANDOM,
-			"h3600_action", &ts->dev)) {
+			SA_SHIRQ | SA_INTERRUPT, "h3600_action", &ts->dev)) {
 		printk(KERN_ERR "h3600ts.c: Could not allocate Action Button IRQ!\n");
 		err = -EBUSY;
 		goto fail2;
 	}
 
 	if (request_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, npower_button_handler,
-			SA_SHIRQ | SA_INTERRUPT | SA_SAMPLE_RANDOM,
-			"h3600_suspend", &ts->dev)) {
+			SA_SHIRQ | SA_INTERRUPT, "h3600_suspend", &ts->dev)) {
 		printk(KERN_ERR "h3600ts.c: Could not allocate Power Button IRQ!\n");
 		err = -EBUSY;
 		goto fail3;
