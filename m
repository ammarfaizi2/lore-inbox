Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWAXCwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWAXCwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 21:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWAXCwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 21:52:24 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:61375 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030260AbWAXCwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 21:52:23 -0500
Subject: [PATCH -mm] Time: Keep clock=pmtmr functional, but depricated
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 18:52:20 -0800
Message-Id: <1138071141.15682.81.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the new clocksource code, the ACPI PM timer is now called acpi_pm.
This has confused users that are familiar w/ using the clock=pmtmr boot
option.

This patch insures that the clock=pmtmr boot option will still function,
but will warn the users to use clocksource=acpi_pm in the future.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

---

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index d62cff0..c974305 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -325,8 +325,13 @@ __setup("clocksource=", boot_override_cl
  */
 static int __init boot_override_clock(char* str)
 {
-	printk("Warning! clock= boot option is deprecated.\n");
-
+	if (!strcmp(str, "pmtmr")) {
+		printk("Warning: clock=pmtmr is depricated. "
+			"Use clocksource=acpi_pm.\n");
+		return boot_override_clocksource("acpi_pm");
+	}
+	printk("Warning! clock= boot option is deprecated. "
+		"Use clocksource=xyz\n");
 	return boot_override_clocksource(str);
 }
 


