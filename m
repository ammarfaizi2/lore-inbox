Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbTIEDOc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 23:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbTIEDOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 23:14:32 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:43377 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261966AbTIEDOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 23:14:31 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Question: monolitic_clock, timer_{tsc,hpet} and CPUFREQ
Date: Thu, 4 Sep 2003 22:14:24 -0500
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309042214.28179.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that although timer_tsc registers cpufreq notifier to detect
frequency changes and adjust cpu_khz it does not set cyc2ns_scale. Is
monotonic clocks supposed to be also accurate?

Will something like this suffice for timer_tsc (compiled, not yet booted):

--- 2.6.0-test4/arch/i386/kernel/timers/timer_tsc.c	2003-08-26 21:56:19.000000000 -0500
+++ linux-2.6.0-test4/arch/i386/kernel/timers/timer_tsc.c	2003-09-04 22:08:27.000000000 -0500
@@ -315,6 +315,7 @@
 		if (use_tsc) {
 			fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
 			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
+			set_cyc2ns_scale(cpu_khz/1000);
 		}
 #endif
 	}
