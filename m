Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268711AbUILLcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268711AbUILLcS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268680AbUILL27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:28:59 -0400
Received: from aun.it.uu.se ([130.238.12.36]:39419 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268681AbUILLYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:24:51 -0400
Date: Sun, 12 Sep 2004 13:24:32 +0200 (MEST)
Message-Id: <200409121124.i8CBOWg3015182@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: gregkh@us.ibm.com, marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre3] IBM PCI hotplug controller driver gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
kernel's IBM PCI hotplug controller driver. The changes are all
backports from the 2.6 kernel.

/Mikael

--- linux-2.4.28-pre3/drivers/hotplug/ibmphp_hpc.c.~1~	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.28-pre3/drivers/hotplug/ibmphp_hpc.c	2004-09-12 01:56:20.000000000 +0200
@@ -184,14 +184,14 @@
 	}
 
 	wpg_data = swab32 (data);	// swap data before writing
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMOSUP_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMOSUP_OFFSET;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
 	// READ - step 2 : clear the message buffer
 	data = 0x00000000;
 	wpg_data = swab32 (data);
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMBUFL_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMBUFL_OFFSET;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
@@ -199,7 +199,7 @@
 	//                 2020 : [20] OR operation at [20] offset 0x20
 	data = WPG_I2CMCNTL_STARTOP_MASK;
 	wpg_data = swab32 (data);
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMCNTL_OFFSET + (ulong) WPG_I2C_OR;
+	wpg_addr = WPGBbar + WPG_I2CMCNTL_OFFSET + WPG_I2C_OR;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
@@ -207,7 +207,7 @@
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
 		long_delay (1 * HZ / 100);
-		(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMCNTL_OFFSET;
+		wpg_addr = WPGBbar + WPG_I2CMCNTL_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
 		if (!(data & WPG_I2CMCNTL_STARTOP_MASK))
@@ -223,7 +223,7 @@
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
 		long_delay (1 * HZ / 100);
-		(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CSTAT_OFFSET;
+		wpg_addr = WPGBbar + WPG_I2CSTAT_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
 		if (HPC_I2CSTATUS_CHECK (data))
@@ -237,7 +237,7 @@
 
 	//--------------------------------------------------------------------
 	// READ - step 6 : get DATA
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMBUFL_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMBUFL_OFFSET;
 	wpg_data = readl (wpg_addr);
 	data = swab32 (wpg_data);
 
@@ -295,14 +295,14 @@
 	}
 
 	wpg_data = swab32 (data);	// swap data before writing
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMOSUP_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMOSUP_OFFSET;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
 	// WRITE - step 2 : clear the message buffer
 	data = 0x00000000 | (ulong) cmd;
 	wpg_data = swab32 (data);
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMBUFL_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMBUFL_OFFSET;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
@@ -310,7 +310,7 @@
 	//                 2020 : [20] OR operation at [20] offset 0x20
 	data = WPG_I2CMCNTL_STARTOP_MASK;
 	wpg_data = swab32 (data);
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMCNTL_OFFSET + (ulong) WPG_I2C_OR;
+	wpg_addr = WPGBbar + WPG_I2CMCNTL_OFFSET + WPG_I2C_OR;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
@@ -318,7 +318,7 @@
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
 		long_delay (1 * HZ / 100);
-		(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMCNTL_OFFSET;
+		wpg_addr = WPGBbar + WPG_I2CMCNTL_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
 		if (!(data & WPG_I2CMCNTL_STARTOP_MASK))
@@ -335,7 +335,7 @@
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
 		long_delay (1 * HZ / 100);
-		(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CSTAT_OFFSET;
+		wpg_addr = WPGBbar + WPG_I2CSTAT_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
 		if (HPC_I2CSTATUS_CHECK (data))
