Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWILDag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWILDag (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 23:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWILDag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 23:30:36 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.201]:47271 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S964872AbWILDaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 23:30:35 -0400
Date: Mon, 11 Sep 2006 23:30:34 -0400
From: Nick Orlov <bugfixer@list.ru>
Subject: Re: [PATCH 2.6.18-rc6-mm1 1/2] cpufreq: make it harder for cpu to
 leave "hot" mode
In-reply-to: <20060912032924.GA3677@nickolas.homeunix.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>
Mail-followup-to: linux-kernel <linux-kernel@vger.kernel.org>,
 cpufreq@lists.linux.org.uk, Andrew Morton <akpm@osdl.org>,
 Dave Jones <davej@codemonkey.org.uk>
Message-id: <20060912033034.GB3677@nickolas.homeunix.com>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060912032924.GA3677@nickolas.homeunix.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Orlov <bugfixer@list.ru>

Make hysteresis wider (20% instead of 10).

Signed-off-by: Nick Orlov <bugfixer@list.ru>

--- linux-2.6.18-rc6/drivers/cpufreq/cpufreq_ondemand.c	2006-09-11 21:22:50.000000000 -0400
+++ linux-2.6.18-rc6-mm1-nick/drivers/cpufreq/cpufreq_ondemand.c	2006-09-11 20:49:10.000000000 -0400
@@ -25,7 +25,7 @@
  */
 
 #define DEF_FREQUENCY_UP_THRESHOLD		(80)
-#define MIN_FREQUENCY_UP_THRESHOLD		(11)
+#define MIN_FREQUENCY_UP_THRESHOLD		(21)
 #define MAX_FREQUENCY_UP_THRESHOLD		(100)
 
 /*
@@ -290,12 +315,12 @@
 	/*
 	 * The optimal frequency is the frequency that is the lowest that
 	 * can support the current CPU usage without triggering the up
-	 * policy. To be safe, we focus 10 points under the threshold.
+	 * policy. To be safe, we focus 20 points under the threshold.
 	 */
-	if (load < (dbs_tuners_ins.up_threshold - 10)) {
+	if (load < (dbs_tuners_ins.up_threshold - 20)) {
 		unsigned int freq_next;
 		freq_next = (policy->cur * load) /
-			(dbs_tuners_ins.up_threshold - 10);
+			(dbs_tuners_ins.up_threshold - 20);
 
 		__cpufreq_driver_target(policy, freq_next, CPUFREQ_RELATION_L);
 	}
_

-- 
With best wishes,
	Nick Orlov.

