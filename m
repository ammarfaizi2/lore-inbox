Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273293AbTG3TEK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273292AbTG3TEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:04:10 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:47249 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S273293AbTG3TDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:03:37 -0400
Date: Wed, 30 Jul 2003 21:02:56 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test2 - Watchdog patches - new module_param (patch 1 + 2)
Message-ID: <20030730210256.A2578@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm looking for people to test the following two patches.
The first patch convert these watchdog modules to the new module_param syntax.
The second patch fixes machzwd.c (you need to declare the variable before using the module_param subroutine).

Thanks,
Wim.

====================================================================================================
diff -Nru a/drivers/char/watchdog/acquirewdt.c b/drivers/char/watchdog/acquirewdt.c
--- a/drivers/char/watchdog/acquirewdt.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/acquirewdt.c	Wed Jul 30 20:53:31 2003
@@ -24,6 +24,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
@@ -55,7 +56,7 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 /*
diff -Nru a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
--- a/drivers/char/watchdog/alim7101_wdt.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/alim7101_wdt.c	Wed Jul 30 20:53:31 2003
@@ -38,6 +38,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/moduleparam.h>
 #include <linux/pci.h>
 
 #include <asm/io.h>
@@ -79,7 +80,7 @@
 static int nowayout = 0;
 #endif
  
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 /*
diff -Nru a/drivers/char/watchdog/ib700wdt.c b/drivers/char/watchdog/ib700wdt.c
--- a/drivers/char/watchdog/ib700wdt.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/ib700wdt.c	Wed Jul 30 20:53:31 2003
@@ -42,6 +42,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
+#include <linux/moduleparam.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -122,7 +123,7 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 
diff -Nru a/drivers/char/watchdog/indydog.c b/drivers/char/watchdog/indydog.c
--- a/drivers/char/watchdog/indydog.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/indydog.c	Wed Jul 30 20:53:31 2003
@@ -20,6 +20,7 @@
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/init.h>
+#include <linux/moduleparam.h>
 #include <asm/uaccess.h>
 #include <asm/sgi/sgimc.h>
 
@@ -33,7 +34,7 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 static void indydog_ping()
diff -Nru a/drivers/char/watchdog/machzwd.c b/drivers/char/watchdog/machzwd.c
--- a/drivers/char/watchdog/machzwd.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/machzwd.c	Wed Jul 30 20:53:31 2003
@@ -30,6 +30,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/timer.h>
 #include <linux/jiffies.h>
@@ -97,7 +98,8 @@
 MODULE_AUTHOR("Fernando Fuganti <fuganti@conectiva.com.br>");
 MODULE_DESCRIPTION("MachZ ZF-Logic Watchdog driver");
 MODULE_LICENSE("GPL");
-MODULE_PARM(action, "i");
+
+module_param(action, int, 0);
 MODULE_PARM_DESC(action, "after watchdog resets, generate: 0 = RESET(*)  1 = SMI  2 = NMI  3 = SCI");
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
@@ -106,7 +108,7 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 #define PFX "machzwd"
diff -Nru a/drivers/char/watchdog/mixcomwd.c b/drivers/char/watchdog/mixcomwd.c
--- a/drivers/char/watchdog/mixcomwd.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/mixcomwd.c	Wed Jul 30 20:53:31 2003
@@ -36,6 +36,7 @@
 #define VERSION "0.5" 
   
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
@@ -67,7 +68,7 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 static void mixcomwd_ping(void)
diff -Nru a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	Wed Jul 30 20:53:30 2003
+++ b/drivers/char/watchdog/pcwd.c	Wed Jul 30 20:53:30 2003
@@ -45,6 +45,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/timer.h>
 #include <linux/config.h>
@@ -87,7 +88,7 @@
 static int timeout = 2;
 static int expect_close = 0;
 
-MODULE_PARM(timeout,"i");
+module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default=2)"); 
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
@@ -96,7 +97,7 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 
diff -Nru a/drivers/char/watchdog/sa1100_wdt.c b/drivers/char/watchdog/sa1100_wdt.c
--- a/drivers/char/watchdog/sa1100_wdt.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/sa1100_wdt.c	Wed Jul 30 20:53:31 2003
@@ -19,6 +19,7 @@
  */
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
@@ -208,9 +209,11 @@
 
 MODULE_AUTHOR("Oleg Drokin <green@crimea.edu>");
 MODULE_DESCRIPTION("SA1100 Watchdog");
-MODULE_PARM(margin,"i");
+
+module_param(margin, int, 0);
 MODULE_PARM_DESC(margin, "Watchdog margin in seconds (default 60s)");
 
-MODULE_PARM(nowayout, "i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
+
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/char/watchdog/sbc60xxwdt.c b/drivers/char/watchdog/sbc60xxwdt.c
--- a/drivers/char/watchdog/sbc60xxwdt.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/sbc60xxwdt.c	Wed Jul 30 20:53:31 2003
@@ -56,6 +56,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/timer.h>
 #include <linux/jiffies.h>
@@ -111,7 +112,7 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 /*
diff -Nru a/drivers/char/watchdog/sc520_wdt.c b/drivers/char/watchdog/sc520_wdt.c
--- a/drivers/char/watchdog/sc520_wdt.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/sc520_wdt.c	Wed Jul 30 20:53:31 2003
@@ -49,6 +49,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/timer.h>
 #include <linux/miscdevice.h>
@@ -111,7 +112,7 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 static spinlock_t wdt_spinlock;
diff -Nru a/drivers/char/watchdog/scx200_wdt.c b/drivers/char/watchdog/scx200_wdt.c
--- a/drivers/char/watchdog/scx200_wdt.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/scx200_wdt.c	Wed Jul 30 20:53:31 2003
@@ -19,6 +19,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
@@ -41,11 +42,11 @@
 #endif
 
 static int margin = 60;		/* in seconds */
-MODULE_PARM(margin, "i");
+module_param(margin, int, 0);
 MODULE_PARM_DESC(margin, "Watchdog margin in seconds");
 
 static int nowayout = CONFIG_WATCHDOG_NOWAYOUT;
-MODULE_PARM(nowayout, "i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Disable watchdog shutdown on close");
 
 static u16 wdto_restart;
diff -Nru a/drivers/char/watchdog/shwdt.c b/drivers/char/watchdog/shwdt.c
--- a/drivers/char/watchdog/shwdt.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/shwdt.c	Wed Jul 30 20:53:31 2003
@@ -1,5 +1,5 @@
 /*
- * drivers/char/shwdt.c
+ * drivers/char/watchdog/shwdt.c
  *
  * Watchdog driver for integrated watchdog in the SuperH processors.
  *
@@ -19,6 +19,7 @@
  */
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
@@ -395,9 +396,11 @@
 MODULE_AUTHOR("Paul Mundt <lethal@linux-sh.org>");
 MODULE_DESCRIPTION("SuperH watchdog driver");
 MODULE_LICENSE("GPL");
-MODULE_PARM(clock_division_ratio, "i");
+
+module_param(clock_division_ratio, int, 0);
 MODULE_PARM_DESC(clock_division_ratio, "Clock division ratio. Valid ranges are from 0x5 (1.31ms) to 0x7 (5.25ms). Defaults to 0x7.");
-MODULE_PARM(nowayout,"i");
+
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 module_init(sh_wdt_init);
diff -Nru a/drivers/char/watchdog/softdog.c b/drivers/char/watchdog/softdog.c
--- a/drivers/char/watchdog/softdog.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/softdog.c	Wed Jul 30 20:53:31 2003
@@ -37,6 +37,7 @@
  */
  
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
@@ -56,8 +57,8 @@
 static int soft_noboot = 0;
 #endif  /* ONLY_TESTING */
 
-MODULE_PARM(soft_margin,"i");
-MODULE_PARM(soft_noboot,"i");
+module_param(soft_margin, int, 0);
+module_param(soft_noboot, int, 0);
 MODULE_LICENSE("GPL");
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
@@ -66,7 +67,7 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 /*
diff -Nru a/drivers/char/watchdog/wafer5823wdt.c b/drivers/char/watchdog/wafer5823wdt.c
--- a/drivers/char/watchdog/wafer5823wdt.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/wafer5823wdt.c	Wed Jul 30 20:53:31 2003
@@ -27,6 +27,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/fs.h>
@@ -63,7 +64,7 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 static void wafwdt_ping(void)
diff -Nru a/drivers/char/watchdog/wdt285.c b/drivers/char/watchdog/wdt285.c
--- a/drivers/char/watchdog/wdt285.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/wdt285.c	Wed Jul 30 20:53:31 2003
@@ -16,6 +16,7 @@
  */
  
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
@@ -222,7 +223,7 @@
 MODULE_DESCRIPTION("Footbridge watchdog driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(soft_margin,"i");
+module_param(soft_margin, int, 0);
 MODULE_PARM_DESC(soft_margin,"Watchdog timeout in seconds");
 
 module_init(footbridge_watchdog_init);
diff -Nru a/drivers/char/watchdog/wdt977.c b/drivers/char/watchdog/wdt977.c
--- a/drivers/char/watchdog/wdt977.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/wdt977.c	Wed Jul 30 20:53:31 2003
@@ -21,6 +21,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -44,9 +45,9 @@
 static	int testmode;
 static int expect_close = 0;
 
-MODULE_PARM(timeout, "i");
+module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,"Watchdog timeout in seconds (60..15300), default=60");
-MODULE_PARM(testmode, "i");
+module_param(testmode, int, 0);
 MODULE_PARM_DESC(testmode,"Watchdog testmode (1 = no reboot), default=0");
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
@@ -55,7 +56,7 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 
diff -Nru a/drivers/char/watchdog/wdt_pci.c b/drivers/char/watchdog/wdt_pci.c
--- a/drivers/char/watchdog/wdt_pci.c	Wed Jul 30 20:53:31 2003
+++ b/drivers/char/watchdog/wdt_pci.c	Wed Jul 30 20:53:31 2003
@@ -38,6 +38,7 @@
 #include <linux/config.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
@@ -88,7 +89,7 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 /*
====================================================================================================
diff -Nru a/drivers/char/watchdog/machzwd.c b/drivers/char/watchdog/machzwd.c
--- a/drivers/char/watchdog/machzwd.c	Wed Jul 30 20:54:08 2003
+++ b/drivers/char/watchdog/machzwd.c	Wed Jul 30 20:54:08 2003
@@ -99,9 +99,6 @@
 MODULE_DESCRIPTION("MachZ ZF-Logic Watchdog driver");
 MODULE_LICENSE("GPL");
 
-module_param(action, int, 0);
-MODULE_PARM_DESC(action, "after watchdog resets, generate: 0 = RESET(*)  1 = SMI  2 = NMI  3 = SCI");
-
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
 #else
@@ -129,6 +126,9 @@
  * defaults to GEN_RESET (0)
  */
 static int action = 0;
+module_param(action, int, 0);
+MODULE_PARM_DESC(action, "after watchdog resets, generate: 0 = RESET(*)  1 = SMI  2 = NMI  3 = SCI");
+
 static int zf_action = GEN_RESET;
 static int zf_is_open = 0;
 static int zf_expect_close = 0;
