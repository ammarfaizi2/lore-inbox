Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVAHRNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVAHRNL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 12:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVAHRG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 12:06:27 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:21177 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261223AbVAHRE2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 12:04:28 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050108170447.32690.74320.16655@localhost.localdomain>
In-Reply-To: <20050108170406.32690.36989.11853@localhost.localdomain>
References: <20050108170406.32690.36989.11853@localhost.localdomain>
Subject: [RESEND] [PATCH 5/7] ppc: remove cli()/sti() in arch/ppc/platforms/pal4_setup.c
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.220.243] at Sat, 8 Jan 2005 11:04:27 -0600
Date: Sat, 8 Jan 2005 11:04:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cli() function calls with local_irq_disable() in shutdown/restart code.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/ppc/platforms/pal4_setup.c linux-2.6.10-mm1/arch/ppc/platforms/pal4_setup.c
--- linux-2.6.10-mm1-original/arch/ppc/platforms/pal4_setup.c	2004-12-24 16:35:28.000000000 -0500
+++ linux-2.6.10-mm1/arch/ppc/platforms/pal4_setup.c	2005-01-03 19:49:42.123501068 -0500
@@ -81,7 +81,7 @@
 static void
 pal4_restart(char *cmd)
 {
-        __cli();
+        local_irq_disable();
         __asm__ __volatile__("lis  3,0xfff0\n \
                               ori  3,3,0x100\n \
                               mtspr 26,3\n \
@@ -95,7 +95,7 @@
 static void
 pal4_power_off(void)
 {
-	__cli();
+	local_irq_disable();
 	for(;;);
 }
 
