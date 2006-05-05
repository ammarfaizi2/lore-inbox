Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWEEQp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWEEQp1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbWEEQo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:44:56 -0400
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:36228 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751653AbWEEQow
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:44:52 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
In-Reply-To: <2.420169009@selenic.com>
Message-Id: <10.420169009@selenic.com>
Subject: [PATCH 9/14] random: Remove SA_SAMPLE_RANDOM from i2c drivers
Date: Fri, 05 May 2006 11:42:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove SA_SAMPLE_RANDOM from i2c drivers

There's no obvious reason why all interrupts from an i2c bus interface
should be considered a good source of the sort of entropy needed by
/dev/random.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/drivers/i2c/chips/tps65010.c
===================================================================
--- 2.6.orig/drivers/i2c/chips/tps65010.c	2006-05-02 17:28:43.000000000 -0500
+++ 2.6/drivers/i2c/chips/tps65010.c	2006-05-03 13:15:45.000000000 -0500
@@ -521,8 +521,9 @@ tps65010_probe(struct i2c_adapter *bus, 
 		goto fail1;
 	}
 
+	irqflags = 0;
 #ifdef	CONFIG_ARM
-	irqflags = SA_SAMPLE_RANDOM | SA_TRIGGER_LOW;
+	irqflags |= SA_TRIGGER_LOW;
 	if (machine_is_omap_h2()) {
 		tps->model = TPS65010;
 		omap_cfg_reg(W4_GPIO58);
@@ -544,8 +545,6 @@ tps65010_probe(struct i2c_adapter *bus, 
 
 		// FIXME set up this board's IRQ ...
 	}
-#else
-	irqflags = SA_SAMPLE_RANDOM;
 #endif
 
 	if (tps->irq > 0) {
