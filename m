Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbUCXXnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 18:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUCXXnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 18:43:45 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:56227 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262224AbUCXXno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:43:44 -0500
Subject: [PATCH] linux-2.6.5-rc2_cpukhz-fix_A1
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Dominik Brodowski <linux@brodo.de>,
       dtor_core@ameritech.net
Content-Type: text/plain
Message-Id: <1080171809.5408.288.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 24 Mar 2004 15:43:30 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All, 
	This small patch insures that cpu_khz is adjusted on cpufreq
notifications even when the tsc timesource is not in use. It fixes the
mostly cosmetic issue when using the ACPI PM timesource of /proc/cpuinfo
not being properly updated when cpu frequency was lowered. 

Changelog:
A0: Original release
A1: Whitespace fix suggested by pavel@suse.cz

Andrew: Please consider for inclusion into your tree for further
testing.

thanks
-john

diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Wed Mar 24 15:35:23 2004
+++ b/arch/i386/kernel/timers/timer_tsc.c	Wed Mar 24 15:35:23 2004
@@ -360,8 +360,9 @@
 		if (variable_tsc)
 			cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
 #ifndef CONFIG_SMP
-		if (use_tsc) {
+		if (cpu_khz)
 			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
+		if (use_tsc) {
 			if (variable_tsc) {
 				fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
 				set_cyc2ns_scale(cpu_khz/1000);


