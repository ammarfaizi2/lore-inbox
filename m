Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVAEAIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVAEAIK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 19:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVADVoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:44:13 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:10639 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S262309AbVADVlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:41:05 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050104214124.21749.95220.20405@localhost.localdomain>
In-Reply-To: <20050104214048.21749.85722.89116@localhost.localdomain>
References: <20050104214048.21749.85722.89116@localhost.localdomain>
Subject: [PATCH 5/7] ppc: remove cli()/sti() in arch/ppc/platforms/pal4_setup.c
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 15:41:04 -0600
Date: Tue, 4 Jan 2005 15:41:05 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
 
