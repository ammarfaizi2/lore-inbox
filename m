Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265983AbUFIUvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265983AbUFIUvq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUFIUvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:51:45 -0400
Received: from aun.it.uu.se ([130.238.12.36]:43193 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265983AbUFIUvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:51:35 -0400
Date: Wed, 9 Jun 2004 22:51:27 +0200 (MEST)
Message-Id: <200406092051.i59KpRpP000627@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-rc3-mm1] perfctr Dothan support
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update perfctr/x86 to handle the new 90nm Pentium-M (Dothan).

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

diff -ruN linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c linux-2.6.7-rc3-mm1.perfctr-update/drivers/perfctr/x86.c
--- linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c	2004-06-09 19:38:38.000000000 +0200
+++ linux-2.6.7-rc3-mm1.perfctr-update/drivers/perfctr/x86.c	2004-06-09 21:04:33.000000000 +0200
@@ -1239,7 +1239,8 @@
 		clear_counters = p5_clear_counters;
 		return 0;
 	case 6:
-		if (current_cpu_data.x86_model == 9) {	/* Pentium M */
+		if (current_cpu_data.x86_model == 9 ||
+		    current_cpu_data.x86_model == 13) {	/* Pentium M */
 			/* Pentium M added the MISC_ENABLE MSR from P4. */
 			rdmsr_low(MSR_IA32_MISC_ENABLE, misc_enable);
 			if (!(misc_enable & MSR_IA32_MISC_ENABLE_PERF_AVAIL))
@@ -1263,7 +1264,8 @@
 			cpu_isuspend = p6_isuspend;
 			cpu_iresume = p6_iresume;
 			/* P-M apparently inherited P4's LVTPC auto-masking :-( */
-			if (current_cpu_data.x86_model == 9)
+			if (current_cpu_data.x86_model == 9 ||
+			    current_cpu_data.x86_model == 13)
 				lvtpc_reinit_needed = 1;
 		}
 #endif
