Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268085AbUIKKhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268085AbUIKKhG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 06:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUIKKhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 06:37:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:65496 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268085AbUIKKhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 06:37:02 -0400
Subject: [PATCH] ppc32: pmac cpufreq for ibook 2 600
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1094898889.2578.187.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 11 Sep 2004 20:34:49 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds support for the 750CX based ibook2 600Mhz to
the cpufreq powermac driver.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc/platforms/pmac_cpufreq.c 1.14 vs edited =====
--- 1.14/arch/ppc/platforms/pmac_cpufreq.c	2004-09-08 16:32:57 +10:00
+++ edited/arch/ppc/platforms/pmac_cpufreq.c	2004-09-11 20:31:55 +10:00
@@ -498,7 +498,7 @@
  *  - Titanium PowerBook 800 (PMU based, 667Mhz & 800Mhz)
  *  - Titanium PowerBook 400 (PMU based, 300Mhz & 400Mhz)
  *  - Titanium PowerBook 500 (PMU based, 300Mhz & 500Mhz)
- *  - iBook2 500 (PMU based, 400Mhz & 500Mhz)
+ *  - iBook2 500/600 (PMU based, 400Mhz & 500/600Mhz)
  *  - iBook2 700 (CPU based, 400Mhz & 700Mhz, support low voltage)
  *  - Recent MacRISC3 laptops
  *  - iBook G4s and PowerBook G4s with 7447A CPUs
@@ -533,11 +533,8 @@
 		   machine_is_compatible("PowerBook3,5") ||
 		   machine_is_compatible("MacRISC3")) {
 		pmac_cpufreq_init_MacRISC3(cpunode);
-	/* Else check for iBook2 500 */
+	/* Else check for iBook2 500/600 */
 	} else if (machine_is_compatible("PowerBook4,1")) {
-		/* We only know about 500Mhz model */
-		if (cur_freq < 450000 || cur_freq > 550000)
-			goto out;
 		hi_freq = cur_freq;
 		low_freq = 400000;
 		set_speed_proc = pmu_set_cpu_speed;


