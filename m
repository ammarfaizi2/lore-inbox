Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262889AbVAKWGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbVAKWGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVAKVlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:41:20 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:42132 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S262893AbVAKVjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:39:23 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, dhowells@redhat.com, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050111213941.9256.91595.67080@localhost.localdomain>
In-Reply-To: <20050111213927.9256.16501.54102@localhost.localdomain>
References: <20050111213927.9256.16501.54102@localhost.localdomain>
Subject: [PATCH 2/2] frv: replace cli()/sti() in arch/frv/kernel/pm.c
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [209.158.220.243] at Tue, 11 Jan 2005 15:39:21 -0600
Date: Tue, 11 Jan 2005 15:39:22 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm2-original/arch/frv/kernel/pm.c linux-2.6.10-mm2/arch/frv/kernel/pm.c
--- linux-2.6.10-mm2-original/arch/frv/kernel/pm.c	2005-01-08 12:16:28.000000000 -0500
+++ linux-2.6.10-mm2/arch/frv/kernel/pm.c	2005-01-08 12:28:00.000000000 -0500
@@ -36,7 +36,7 @@
 
 int pm_do_suspend(void)
 {
-	cli();
+	local_irq_disable();
 
 	__set_LEDS(0xb1);
 
@@ -45,7 +45,7 @@
 
 	__set_LEDS(0xb2);
 
-	sti();
+	local_irq_enable();
 
 	return 0;
 }
@@ -84,7 +84,7 @@
 
 int pm_do_bus_sleep(void)
 {
-	cli();
+	local_irq_disable();
 
 	/*
          * Here is where we need some platform-dependent setup
@@ -113,7 +113,7 @@
 	 */
 	__power_switch_wake_cleanup();
 
-	sti();
+	local_irq_enable();
 
 	return 0;
 }
@@ -191,7 +191,7 @@
 	pm_send_all(PM_SUSPEND, (void *)3);
 
 	/* now change cmode */
-	cli();
+	local_irq_disable();
 	frv_dma_pause_all();
 
 	frv_change_cmode(new_cmode);
@@ -203,7 +203,7 @@
 	determine_clocks(1);
 #endif
 	frv_dma_resume_all();
-	sti();
+	local_irq_enable();
 
 	/* tell all the drivers we're resuming */
 	pm_send_all(PM_RESUME, (void *)0);
