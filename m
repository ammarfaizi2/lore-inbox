Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267518AbUIXASr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267518AbUIXASr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267612AbUIXASp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:18:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:47072 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267518AbUIXAR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:17:29 -0400
Subject: [PATCH] ppc32: Fix bogus return value in pmac_cpufreq.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095985037.3832.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 10:17:17 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

There's an obvious uninitialized return value in pmac_cpufreq, here's
a fix:

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc/platforms/pmac_cpufreq.c 1.15 vs edited =====
--- 1.15/arch/ppc/platforms/pmac_cpufreq.c	2004-09-14 10:23:16 +10:00
+++ edited/arch/ppc/platforms/pmac_cpufreq.c	2004-09-24 10:15:41 +10:00
@@ -301,7 +301,6 @@
 static int __pmac do_set_cpu_speed(int speed_mode)
 {
 	struct cpufreq_freqs freqs;
-	int rc;
 
 	freqs.old = cur_freq;
 	freqs.new = (speed_mode == PMAC_CPU_HIGH_SPEED) ? hi_freq : low_freq;
@@ -315,7 +314,7 @@
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 	cur_freq = (speed_mode == PMAC_CPU_HIGH_SPEED) ? hi_freq : low_freq;
 
-	return rc;
+	return 0;
 }
 
 static int __pmac pmac_cpufreq_verify(struct cpufreq_policy *policy)


