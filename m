Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264638AbSKIEqm>; Fri, 8 Nov 2002 23:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264641AbSKIEqm>; Fri, 8 Nov 2002 23:46:42 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:57358
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264638AbSKIEql>; Fri, 8 Nov 2002 23:46:41 -0500
Date: Fri, 8 Nov 2002 23:52:21 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] notsc option needs some attention/TLC
Message-ID: <Pine.LNX.4.44.0211082349170.10475-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

notsc doesn't work on a box with a TSC, when we need need the option the 
most...

Index: linux-2.5.46-bochs/arch/i386/kernel/cpu/common.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.46/arch/i386/kernel/cpu/common.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 common.c
--- linux-2.5.46-bochs/arch/i386/kernel/cpu/common.c	5 Nov 2002 01:47:31 -0000	1.1.1.1
+++ linux-2.5.46-bochs/arch/i386/kernel/cpu/common.c	9 Nov 2002 03:10:45 -0000
@@ -12,6 +12,11 @@
 
 static int cachesize_override __initdata = -1;
 static int disable_x86_fxsr __initdata = 0;
+#ifdef CONFIG_X86_TSC
+static int tsc_disable __initdata = 0;
+#else
+#define tsc_disable	1
+#endif
 
 struct cpu_dev * cpu_devs[X86_VENDOR_NUM] = {};
 
@@ -42,24 +47,14 @@
 }
 __setup("cachesize=", cachesize_setup);
 
-#ifndef CONFIG_X86_TSC
-static int tsc_disable __initdata = 0;
-
+#ifdef CONFIG_X86_TSC
 static int __init tsc_setup(char *str)
 {
 	tsc_disable = 1;
 	return 1;
 }
-#else
-#define tsc_disable 0
-
-static int __init tsc_setup(char *str)
-{
-	printk("notsc: Kernel compiled with CONFIG_X86_TSC, cannot disable TSC.\n");
-	return 1;
-}
-#endif
 __setup("notsc", tsc_setup);
+#endif
 
 int __init get_model_name(struct cpuinfo_x86 *c)
 {

-- 
function.linuxpower.ca

