Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbWCRABA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbWCRABA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 19:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbWCRAAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 19:00:44 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:37777 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751742AbWCRAAQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 19:00:16 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.132654658@selenic.com>
Message-Id: <13.132654658@selenic.com>
Subject: [PATCH 12/14] RTC: Remove RTC UIP synchronization on Alpha
Date: Fri, 17 Mar 2006 17:30:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RTC UIP synchronization on Alpha

The sync may still be needed for CPU clock calibration but we don't
sync in the regular case.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rtc/arch/alpha/kernel/time.c
===================================================================
--- rtc.orig/arch/alpha/kernel/time.c	2005-10-27 19:02:08.000000000 -0500
+++ rtc/arch/alpha/kernel/time.c	2006-03-12 13:00:48.000000000 -0600
@@ -318,10 +318,11 @@ time_init(void)
 	if (!est_cycle_freq)
 		est_cycle_freq = validate_cc_value(calibrate_cc_with_pit());
 
-	cc1 = rpcc_after_update_in_progress();
+	cc1 = rpcc();
 
 	/* Calibrate CPU clock -- attempt #2.  */
 	if (!est_cycle_freq) {
+		cc1 = rpcc_after_update_in_progress();
 		cc2 = rpcc_after_update_in_progress();
 		est_cycle_freq = validate_cc_value(cc2 - cc1);
 		cc1 = cc2;
