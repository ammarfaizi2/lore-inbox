Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWD3DYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWD3DYs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 23:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWD3DYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 23:24:47 -0400
Received: from fmr18.intel.com ([134.134.136.17]:46733 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750894AbWD3DYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 23:24:47 -0400
Subject: [PATCH] timer TSC check suspend notifier change
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 30 Apr 2006 11:23:26 +0800
Message-Id: <1146367406.21486.9.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in suspend time, the TSC CPUFREQ_SUSPENDCHANGE notifier change might wrongly
enable interrupt. cpufreq driver suspend/resume is in interrupt disabled environment.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc3-root/arch/i386/kernel/timers/timer_tsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/timers/timer_tsc.c~timer_tsc_check_suspend_change arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.17-rc3/arch/i386/kernel/timers/timer_tsc.c~timer_tsc_check_suspend_change	2006-04-29 08:25:38.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/i386/kernel/timers/timer_tsc.c	2006-04-29 08:29:33.000000000 +0800
@@ -279,7 +279,7 @@ time_cpufreq_notifier(struct notifier_bl
 {
 	struct cpufreq_freqs *freq = data;
 
-	if (val != CPUFREQ_RESUMECHANGE)
+	if (val != CPUFREQ_RESUMECHANGE && val != CPUFREQ_SUSPENDCHANGE)
 		write_seqlock_irq(&xtime_lock);
 	if (!ref_freq) {
 		if (!freq->old){
@@ -312,7 +312,7 @@ time_cpufreq_notifier(struct notifier_bl
 	}
 
 end:
-	if (val != CPUFREQ_RESUMECHANGE)
+	if (val != CPUFREQ_RESUMECHANGE && val != CPUFREQ_SUSPENDCHANGE)
 		write_sequnlock_irq(&xtime_lock);
 
 	return 0;
_


