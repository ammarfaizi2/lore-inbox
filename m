Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTIBISu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbTIBISt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:18:49 -0400
Received: from dp.samba.org ([66.70.73.150]:5270 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263633AbTIBISa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:18:30 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] MODULE_ALIAS() in char devices
Date: Tue, 02 Sep 2003 18:17:21 +1000
Message-Id: <20030902081829.1448E2C13D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: MODULE_ALIAS inside modules: character devices
Author: Rusty Russell
Status: Booted on 2.6.0-test4-bk3

D: Previously, default aliases were hardwired into modutils.  Now they
D: should be inside the modules, using MODULE_ALIAS() (they will be overridden
D: by any user alias).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16082-linux-2.6.0-test4-bk2/arch/i386/kernel/apm.c .16082-linux-2.6.0-test4-bk2.updated/arch/i386/kernel/apm.c
--- .16082-linux-2.6.0-test4-bk2/arch/i386/kernel/apm.c	2003-08-25 11:58:11.000000000 +1000
+++ .16082-linux-2.6.0-test4-bk2.updated/arch/i386/kernel/apm.c	2003-08-26 15:28:35.000000000 +1000
@@ -2080,4 +2080,4 @@ MODULE_PARM_DESC(idle_period,
 MODULE_PARM(smp, "i");
 MODULE_PARM_DESC(smp,
 	"Set this to enable APM use on an SMP platform. Use with caution on older systems");
-
+MODULE_ALIAS_MISCDEV(APM_MINOR_DEV);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16082-linux-2.6.0-test4-bk2/drivers/char/agp/backend.c .16082-linux-2.6.0-test4-bk2.updated/drivers/char/agp/backend.c
--- .16082-linux-2.6.0-test4-bk2/drivers/char/agp/backend.c	2003-08-25 11:58:16.000000000 +1000
+++ .16082-linux-2.6.0-test4-bk2.updated/drivers/char/agp/backend.c	2003-08-26 15:27:10.000000000 +1000
@@ -317,6 +317,7 @@ void __exit agp_exit(void)
 MODULE_AUTHOR("Dave Jones <davej@codemonkey.org.uk>");
 MODULE_DESCRIPTION("AGP GART driver");
 MODULE_LICENSE("GPL and additional rights");
+MODULE_ALIAS_MISCDEV(AGPGART_MINOR);
 
 module_init(agp_init);
 module_exit(agp_exit);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16082-linux-2.6.0-test4-bk2/drivers/char/agp/frontend.c .16082-linux-2.6.0-test4-bk2.updated/drivers/char/agp/frontend.c
--- .16082-linux-2.6.0-test4-bk2/drivers/char/agp/frontend.c	2003-07-14 16:58:36.000000000 +1000
+++ .16082-linux-2.6.0-test4-bk2.updated/drivers/char/agp/frontend.c	2003-08-26 15:27:03.000000000 +1000
@@ -1097,4 +1097,3 @@ void agp_frontend_cleanup(void)
 {
 	misc_deregister(&agp_miscdev);
 }
-
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16082-linux-2.6.0-test4-bk2/drivers/char/busmouse.c .16082-linux-2.6.0-test4-bk2.updated/drivers/char/busmouse.c
--- .16082-linux-2.6.0-test4-bk2/drivers/char/busmouse.c	2003-07-31 01:50:09.000000000 +1000
+++ .16082-linux-2.6.0-test4-bk2.updated/drivers/char/busmouse.c	2003-08-26 15:22:33.000000000 +1000
@@ -452,4 +452,5 @@ EXPORT_SYMBOL(busmouse_add_buttons);
 EXPORT_SYMBOL(register_busmouse);
 EXPORT_SYMBOL(unregister_busmouse);
 
+MODULE_ALIAS_MISCDEV(BUSMOUSE_MINOR);
 MODULE_LICENSE("GPL");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16082-linux-2.6.0-test4-bk2/drivers/char/lp.c .16082-linux-2.6.0-test4-bk2.updated/drivers/char/lp.c
--- .16082-linux-2.6.0-test4-bk2/drivers/char/lp.c	2003-05-27 15:02:07.000000000 +1000
+++ .16082-linux-2.6.0-test4-bk2.updated/drivers/char/lp.c	2003-08-26 15:22:33.000000000 +1000
@@ -965,4 +965,5 @@ __setup("lp=", lp_setup);
 module_init(lp_init_module);
 module_exit(lp_cleanup_module);
 
+MODULE_ALIAS("char-major-" __stringify(LP_MAJOR));
 MODULE_LICENSE("GPL");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16082-linux-2.6.0-test4-bk2/drivers/char/nvram.c .16082-linux-2.6.0-test4-bk2.updated/drivers/char/nvram.c
--- .16082-linux-2.6.0-test4-bk2/drivers/char/nvram.c	2003-03-18 05:01:43.000000000 +1100
+++ .16082-linux-2.6.0-test4-bk2.updated/drivers/char/nvram.c	2003-08-26 15:46:09.000000000 +1000
@@ -923,3 +923,4 @@ EXPORT_SYMBOL(__nvram_check_checksum);
 EXPORT_SYMBOL(nvram_check_checksum);
 EXPORT_SYMBOL(__nvram_set_checksum);
 EXPORT_SYMBOL(nvram_set_checksum);
+MODULE_ALIAS_MISCDEV(NVRAM_MINOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16082-linux-2.6.0-test4-bk2/drivers/char/rtc.c .16082-linux-2.6.0-test4-bk2.updated/drivers/char/rtc.c
--- .16082-linux-2.6.0-test4-bk2/drivers/char/rtc.c	2003-08-25 11:58:16.000000000 +1000
+++ .16082-linux-2.6.0-test4-bk2.updated/drivers/char/rtc.c	2003-08-26 15:48:25.000000000 +1000
@@ -1280,3 +1280,4 @@ static void set_rtc_irq_bit(unsigned cha
 
 MODULE_AUTHOR("Paul Gortmaker");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(RTC_MINOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16082-linux-2.6.0-test4-bk2/drivers/char/watchdog/wdt.c .16082-linux-2.6.0-test4-bk2.updated/drivers/char/watchdog/wdt.c
--- .16082-linux-2.6.0-test4-bk2/drivers/char/watchdog/wdt.c	2003-05-05 12:36:59.000000000 +1000
+++ .16082-linux-2.6.0-test4-bk2.updated/drivers/char/watchdog/wdt.c	2003-08-26 15:22:33.000000000 +1000
@@ -579,4 +579,6 @@ module_exit(wdt_exit);
 
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("Driver for ISA ICS watchdog cards (WDT500/501)");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+MODULE_ALIAS_MISCDEV(TEMP_MINOR);
 MODULE_LICENSE("GPL");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16082-linux-2.6.0-test4-bk2/drivers/media/video/bttv-driver.c .16082-linux-2.6.0-test4-bk2.updated/drivers/media/video/bttv-driver.c
--- .16082-linux-2.6.0-test4-bk2/drivers/media/video/bttv-driver.c	2003-08-25 11:58:18.000000000 +1000
+++ .16082-linux-2.6.0-test4-bk2.updated/drivers/media/video/bttv-driver.c	2003-08-26 15:42:59.000000000 +1000
@@ -115,6 +115,7 @@ MODULE_PARM(v4l2,"i");
 MODULE_DESCRIPTION("bttv - v4l/v4l2 driver module for bt848/878 based cards");
 MODULE_AUTHOR("Ralph Metzler & Marcus Metzler & Gerd Knorr");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV_MAJOR(VIDEO_MAJOR);
 
 /* kernel args */
 #ifndef MODULE
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16082-linux-2.6.0-test4-bk2/drivers/net/ppp_generic.c .16082-linux-2.6.0-test4-bk2.updated/drivers/net/ppp_generic.c
--- .16082-linux-2.6.0-test4-bk2/drivers/net/ppp_generic.c	2003-08-25 11:58:22.000000000 +1000
+++ .16082-linux-2.6.0-test4-bk2.updated/drivers/net/ppp_generic.c	2003-08-26 15:44:13.000000000 +1000
@@ -2670,3 +2670,4 @@ EXPORT_SYMBOL(ppp_unregister_compressor)
 EXPORT_SYMBOL(all_ppp_units); /* for debugging */
 EXPORT_SYMBOL(all_channels); /* for debugging */
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV_MAJOR(PPP_MAJOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16082-linux-2.6.0-test4-bk2/drivers/net/tun.c .16082-linux-2.6.0-test4-bk2.updated/drivers/net/tun.c
--- .16082-linux-2.6.0-test4-bk2/drivers/net/tun.c	2003-08-25 11:58:23.000000000 +1000
+++ .16082-linux-2.6.0-test4-bk2.updated/drivers/net/tun.c	2003-08-26 15:27:26.000000000 +1000
@@ -640,3 +640,4 @@ void tun_cleanup(void)
 module_init(tun_init);
 module_exit(tun_cleanup);
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(TUN_MINOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16082-linux-2.6.0-test4-bk2/include/linux/device.h .16082-linux-2.6.0-test4-bk2.updated/include/linux/device.h
--- .16082-linux-2.6.0-test4-bk2/include/linux/device.h	2003-08-25 11:58:34.000000000 +1000
+++ .16082-linux-2.6.0-test4-bk2.updated/include/linux/device.h	2003-08-26 15:41:49.000000000 +1000
@@ -398,4 +398,9 @@ extern void firmware_unregister(struct s
 #define dev_warn(dev, format, arg...)		\
 	dev_printk(KERN_WARNING , dev , format , ## arg)
 
+/* Create alias, so I can be autoloaded. */
+#define MODULE_ALIAS_CHARDEV(major,minor) \
+	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
+#define MODULE_ALIAS_CHARDEV_MAJOR(major) \
+	MODULE_ALIAS("char-major-" __stringify(major) "-*")
 #endif /* _DEVICE_H_ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16082-linux-2.6.0-test4-bk2/include/linux/miscdevice.h .16082-linux-2.6.0-test4-bk2.updated/include/linux/miscdevice.h
--- .16082-linux-2.6.0-test4-bk2/include/linux/miscdevice.h	2003-05-05 12:37:12.000000000 +1000
+++ .16082-linux-2.6.0-test4-bk2.updated/include/linux/miscdevice.h	2003-08-26 15:22:33.000000000 +1000
@@ -1,5 +1,7 @@
 #ifndef _LINUX_MISCDEVICE_H
 #define _LINUX_MISCDEVICE_H
+#include <linux/module.h>
+#include <linux/major.h>
 
 #define BUSMOUSE_MINOR 0
 #define PSMOUSE_MINOR  1
@@ -48,4 +50,7 @@ struct miscdevice 
 extern int misc_register(struct miscdevice * misc);
 extern int misc_deregister(struct miscdevice * misc);
 
+#define MODULE_ALIAS_MISCDEV(minor)				\
+	MODULE_ALIAS("char-major-" __stringify(MISC_MAJOR)	\
+	"-" __stringify(minor))
 #endif

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
