Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966878AbWKTWbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966878AbWKTWbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966449AbWKTWbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:31:08 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:65531 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S966878AbWKTWbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:31:03 -0500
Date: Mon, 20 Nov 2006 16:30:58 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net
Subject: [POWERPC][PATCH 2/2] Revert "[POWERPC] Add powerpc get/set_rtc_time
 interface to new generic rtc class"
Message-Id: <20061120163058.518f9118.kim.phillips@freescale.com>
Organization: Freescale Semiconductor
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAQ=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7a69af63e788a324d162201a0b23df41bcf158dd.

As advised by David Brownell:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116387226902131&w=2
---
 arch/powerpc/kernel/time.c |   42 ------------------------------------------
 include/asm-powerpc/time.h |    6 +-----
 2 files changed, 1 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index a1b5e4b..46a24de 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -1014,48 +1014,6 @@ void __init time_init(void)
 	set_dec(tb_ticks_per_jiffy);
 }
 
-#ifdef CONFIG_RTC_CLASS
-static int set_rtc_class_time(struct rtc_time *tm)
-{
-	int err;
-	struct class_device *class_dev =
-		rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
-
-	if (class_dev == NULL)
-		return -ENODEV;
-
-	err = rtc_set_time(class_dev, tm);
-
-	rtc_class_close(class_dev);
-
-	return 0;
-}
-
-static void get_rtc_class_time(struct rtc_time *tm)
-{
-	int err;
-	struct class_device *class_dev =
-		rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
-
-	if (class_dev == NULL)
-		return;
-
-	err = rtc_read_time(class_dev, tm);
-
-	rtc_class_close(class_dev);
-
-	return;
-}
-
-int __init rtc_class_hookup(void)
-{
-	ppc_md.get_rtc_time = get_rtc_class_time;
-	ppc_md.set_rtc_time = set_rtc_class_time;
-
-	return 0;
-}
-#endif /* CONFIG_RTC_CLASS */
-
 
 #define FEBRUARY	2
 #define	STARTOFTIME	1970
diff --git a/include/asm-powerpc/time.h b/include/asm-powerpc/time.h
index a782850..268c623 100644
--- a/include/asm-powerpc/time.h
+++ b/include/asm-powerpc/time.h
@@ -39,10 +39,6 @@ extern void generic_calibrate_decr(void)
 extern void wakeup_decrementer(void);
 extern void snapshot_timebase(void);
 
-#ifdef CONFIG_RTC_CLASS
-extern int __init rtc_class_hookup(void);
-#endif
-
 /* Some sane defaults: 125 MHz timebase, 1GHz processor */
 extern unsigned long ppc_proc_freq;
 #define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
-- 
1.4.2.3

