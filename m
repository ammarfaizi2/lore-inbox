Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVCCRNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVCCRNk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVCCRMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:12:31 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:10674 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262483AbVCCRKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:10:30 -0500
Subject: [PATCH] clean up FIXME in do_timer_interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 12:10:28 -0500
Message-Id: <1109869828.2908.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AFAICT this code is equivalent and cleans up the (efi_)set_rtc_mmss code
referred to as "horrible... FIXME" in the comments.  Completely
untested.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--- linux-2.6.11-rc4/arch/i386/kernel/time.c.orig	2005-03-03 11:52:32.000000000 -0500
+++ linux-2.6.11-rc4/arch/i386/kernel/time.c	2005-03-03 12:02:20.000000000 -0500
@@ -254,16 +254,10 @@
 			>= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000)
 			<= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
-		/* horrible...FIXME */
-		if (efi_enabled) {
-	 		if (efi_set_rtc_mmss(xtime.tv_sec) == 0)
-				last_rtc_update = xtime.tv_sec;
-			else
-				last_rtc_update = xtime.tv_sec - 600;
-		} else if (set_rtc_mmss(xtime.tv_sec) == 0)
-			last_rtc_update = xtime.tv_sec;
-		else
-			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
+	        last_rtc_update = xtime.tv_sec;
+		if (efi_enabled && efi_set_rtc_mmss(xtime.tv_sec) || 
+			set_rtc_mmss(xtime.tv_sec))
+			last_rtc_update -= 600;
 	}
 
 	if (MCA_bus) {


