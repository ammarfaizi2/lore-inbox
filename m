Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262591AbTCRWtX>; Tue, 18 Mar 2003 17:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262594AbTCRWtX>; Tue, 18 Mar 2003 17:49:23 -0500
Received: from air-2.osdl.org ([65.172.181.6]:39639 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262591AbTCRWtW>;
	Tue, 18 Mar 2003 17:49:22 -0500
Subject: [PATCH] add write_seqlock to cpufreq change notifier for TSC
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1048028418.6297.48.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Mar 2003 15:00:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU frequency change detection code can change the values used to
compute time of day with TSC; but there was no locking around it.


--- timer_tsc.c.orig	2003-03-18 14:52:25.000000000 -0800
+++ timer_tsc.c	2003-03-18 14:55:13.000000000 -0800
@@ -213,6 +213,7 @@
 {
 	struct cpufreq_freqs *freq = data;
 
+	write_seqlock(&xtime_lock);
 	if (!ref_freq) {
 		ref_freq = freq->old;
 		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
@@ -232,6 +233,7 @@
 		}
 #endif
 	}
+	write_sequnlock(&xtime_lock);
 
 	return 0;
 }



