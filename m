Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVG2JtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVG2JtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVG2Jra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:47:30 -0400
Received: from tim.rpsys.net ([194.106.48.114]:60863 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262551AbVG2Jqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:46:51 -0400
Subject: [patch 1/8] Corgi Keyboard: Fix a couple of compile errors
From: Richard Purdie <rpurdie@rpsys.net>
To: akpm@osdl.org
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 29 Jul 2005 10:46:30 +0100
Message-Id: <1122630390.7747.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a couple of compile errors in the corgi keyboard driver.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/drivers/input/keyboard/corgikbd.c
===================================================================
--- linux-2.6.12.orig/drivers/input/keyboard/corgikbd.c	2005-07-28 15:18:23.000000000 +0100
+++ linux-2.6.12/drivers/input/keyboard/corgikbd.c	2005-07-28 16:42:46.000000000 +0100
@@ -235,7 +235,7 @@
 	unsigned long gprr;
 	unsigned long flags;
 
-	gprr = read_scoop_reg(SCOOP_GPRR) & (CORGI_SCP_SWA | CORGI_SCP_SWB);
+	gprr = read_scoop_reg(&corgiscoop_device.dev, SCOOP_GPRR) & (CORGI_SCP_SWA | CORGI_SCP_SWB);
 	if (gprr != sharpsl_hinge_state) {
 		hinge_count = 0;
 		sharpsl_hinge_state = gprr;
@@ -267,7 +267,7 @@
 	dev_set_drvdata(dev,corgikbd);
 	strcpy(corgikbd->phys, "corgikbd/input0");
 
-	spin_lock_init(corgikbd->lock);
+	spin_lock_init(&corgikbd->lock);
 
 	/* Init Keyboard rescan timer */
 	init_timer(&corgikbd->timer);


