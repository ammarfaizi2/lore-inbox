Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267156AbSLQWaz>; Tue, 17 Dec 2002 17:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbSLQWaz>; Tue, 17 Dec 2002 17:30:55 -0500
Received: from air-2.osdl.org ([65.172.181.6]:14524 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267156AbSLQWam>;
	Tue, 17 Dec 2002 17:30:42 -0500
Date: Tue, 17 Dec 2002 14:33:55 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andrew Morton <akpm@digeo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] (v3) move LOG_BUF_SIZE to header/config
In-Reply-To: <3DFF5E67.C0BA874C@digeo.com>
Message-ID: <Pine.LNX.4.33L2.0212171427520.17648-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changes from yesterday:

a.  use a shift value (suggested by HCH); probably still not as quite
    as free and open as he suggested, but I had user-friendliness
    problems with that.

b.  allow a wider range of values (HCH and James Cloos):
    smaller added, larger can be added as needed.

c.  put common config into kernel/Kconfig and include that in each
    arch/*/Kconfig


More comments?

-- 
~Randy



patch_name:	logbuf-config-2552.patch
patch_version:	2002.12.17
author:		Randy Dunlap <rddunlap@osdl.org>
description:	change LOG_BUF_SIZE to a config option (LOG_BUF_SHIFT)
product:	linux
product_versions: 2.5.52
changelog:	(a) move to a common kernel/Kconfig;
		(b) use a SHIFT value (enforces power of 2, gives more choices)
URL:
requires:	kconfig in 2.5.52
conflicts:
diffstat:
 arch/alpha/Kconfig     |    2 +
 arch/arm/Kconfig       |    2 +
 arch/cris/Kconfig      |    2 +
 arch/ia64/Kconfig      |    3 ++
 arch/m68k/Kconfig      |    2 +
 arch/m68knommu/Kconfig |    2 +
 arch/mips/Kconfig      |    2 +
 arch/mips64/Kconfig    |    2 +
 arch/parisc/Kconfig    |    2 +
 arch/ppc/Kconfig       |    2 +
 arch/ppc64/Kconfig     |    2 +
 arch/s390/Kconfig      |    2 +
 arch/s390x/Kconfig     |    2 +
 arch/sh/Kconfig        |    2 +
 arch/sparc/Kconfig     |    2 +
 arch/sparc64/Kconfig   |    2 +
 arch/um/Kconfig        |    2 +
 arch/v850/Kconfig      |    2 +
 arch/x86_64/Kconfig    |    2 +
 kernel/Kconfig         |   55 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/printk.c        |   11 ---------
 21 files changed, 95 insertions(+), 10 deletions(-)


--- ./arch/m68k/Kconfig%LOGBUF	Sun Dec 15 18:08:11 2002
+++ ./arch/m68k/Kconfig	Tue Dec 17 14:08:33 2002
@@ -2346,3 +2346,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/sparc/Kconfig%LOGBUF	Sun Dec 15 18:07:42 2002
+++ ./arch/sparc/Kconfig	Tue Dec 17 14:11:06 2002
@@ -1422,3 +1422,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/sparc64/Kconfig%LOGBUF	Sun Dec 15 18:08:16 2002
+++ ./arch/sparc64/Kconfig	Tue Dec 17 14:11:13 2002
@@ -1710,3 +1710,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/ppc/Kconfig%LOGBUF	Sun Dec 15 18:08:23 2002
+++ ./arch/ppc/Kconfig	Tue Dec 17 14:10:18 2002
@@ -1872,3 +1872,5 @@

 source "crypto/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/m68knommu/Kconfig%LOGBUF	Sun Dec 15 18:08:13 2002
+++ ./arch/m68knommu/Kconfig	Tue Dec 17 14:08:52 2002
@@ -759,3 +759,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/alpha/Kconfig%LOGBUF	Sun Dec 15 18:08:14 2002
+++ ./arch/alpha/Kconfig	Tue Dec 17 14:07:34 2002
@@ -1030,3 +1030,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/cris/Kconfig%LOGBUF	Sun Dec 15 18:08:19 2002
+++ ./arch/cris/Kconfig	Tue Dec 17 14:08:06 2002
@@ -759,3 +759,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/mips/Kconfig%LOGBUF	Sun Dec 15 18:07:56 2002
+++ ./arch/mips/Kconfig	Tue Dec 17 14:08:59 2002
@@ -1284,3 +1284,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/x86_64/Kconfig%LOGBUF	Sun Dec 15 18:08:14 2002
+++ ./arch/x86_64/Kconfig	Tue Dec 17 14:11:54 2002
@@ -700,3 +700,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/ppc64/Kconfig%LOGBUF	Sun Dec 15 18:08:09 2002
+++ ./arch/ppc64/Kconfig	Tue Dec 17 14:10:25 2002
@@ -559,3 +559,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/um/Kconfig%LOGBUF	Sun Dec 15 18:07:57 2002
+++ ./arch/um/Kconfig	Tue Dec 17 14:11:35 2002
@@ -171,3 +171,5 @@

 endmenu

+source "kernel/Kconfig"
+
--- ./arch/arm/Kconfig%LOGBUF	Sun Dec 15 18:08:09 2002
+++ ./arch/arm/Kconfig	Tue Dec 17 14:07:56 2002
@@ -1228,3 +1228,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/parisc/Kconfig%LOGBUF	Sun Dec 15 18:08:11 2002
+++ ./arch/parisc/Kconfig	Tue Dec 17 14:10:11 2002
@@ -423,3 +423,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/ia64/Kconfig%LOGBUF	Sun Dec 15 18:08:21 2002
+++ ./arch/ia64/Kconfig	Tue Dec 17 14:08:24 2002
@@ -891,3 +891,6 @@
 source "security/Kconfig"

 source "crypto/Kconfig"
+
+source "kernel/Kconfig"
+
--- ./arch/mips64/Kconfig%LOGBUF	Sun Dec 15 18:07:52 2002
+++ ./arch/mips64/Kconfig	Tue Dec 17 14:09:07 2002
@@ -727,3 +727,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/s390x/Kconfig%LOGBUF	Sun Dec 15 18:07:59 2002
+++ ./arch/s390x/Kconfig	Tue Dec 17 14:10:41 2002
@@ -346,3 +346,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/v850/Kconfig%LOGBUF	Sun Dec 15 18:07:56 2002
+++ ./arch/v850/Kconfig	Tue Dec 17 14:11:46 2002
@@ -452,4 +452,6 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
 #############################################################################
--- ./arch/sh/Kconfig%LOGBUF	Sun Dec 15 18:08:23 2002
+++ ./arch/sh/Kconfig	Tue Dec 17 14:10:52 2002
@@ -1276,3 +1276,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./arch/s390/Kconfig%LOGBUF	Sun Dec 15 18:07:54 2002
+++ ./arch/s390/Kconfig	Tue Dec 17 14:10:33 2002
@@ -337,3 +337,5 @@

 source "lib/Kconfig"

+source "kernel/Kconfig"
+
--- ./kernel/Kconfig%LOGBUF	Tue Dec 17 14:00:31 2002
+++ ./kernel/Kconfig	Tue Dec 17 14:16:36 2002
@@ -0,0 +1,55 @@
+# This general setup config file is read _after_ all other config files.
+# It is for generic kernel options that cannot be handled elsewhere,
+# including some generic options that are processor-dependent.
+# This is also _not_ for device driver options.
+# They should be handled in their driver subsystem areas.
+
+menu "Common kernel setup (more)"
+
+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_SHIFT_17 if ARCH_S390
+	default LOG_BUF_SHIFT_16 if X86_NUMAQ || IA64
+	default LOG_BUF_SHIFT_15 if SMP
+	default LOG_BUF_SHIFT_14
+	help
+	  Select kernel log buffer size from this list (power of 2).
+	  Defaults:  17 (=> 128 KB for S/390)
+		     16 (=> 64 KB for x86 NUMAQ or IA-64)
+	             15 (=> 32 KB for SMP)
+	             14 (=> 16 KB for uniprocessor)
+
+config LOG_BUF_SHIFT_17
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_SHIFT_16
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_SHIFT_15
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_SHIFT_14
+	bool "16 KB"
+
+config LOG_BUF_SHIFT_13
+	bool "8 KB"
+
+config LOG_BUF_SHIFT_12
+	bool "4 KB"
+
+endchoice
+
+config LOG_BUF_SHIFT
+	int
+	default 17 if LOG_BUF_SHIFT_17=y
+	default 16 if LOG_BUF_SHIFT_16=y
+	default 15 if LOG_BUF_SHIFT_15=y
+	default 14 if LOG_BUF_SHIFT_14=y
+	default 13 if LOG_BUF_SHIFT_13=y
+	default 12 if LOG_BUF_SHIFT_12=y
+
+endmenu
+
--- ./kernel/printk.c%LOGBUF	Sun Dec 15 18:08:24 2002
+++ ./kernel/printk.c	Tue Dec 17 14:01:50 2002
@@ -30,16 +30,7 @@

 #include <asm/uaccess.h>

-#if defined(CONFIG_X86_NUMAQ) || defined(CONFIG_IA64)
-#define LOG_BUF_LEN	(65536)
-#elif defined(CONFIG_ARCH_S390)
-#define LOG_BUF_LEN	(131072)
-#elif defined(CONFIG_SMP)
-#define LOG_BUF_LEN	(32768)
-#else
-#define LOG_BUF_LEN	(16384)			/* This must be a power of two */
-#endif
-
+#define LOG_BUF_LEN	(1 << CONFIG_LOG_BUF_SHIFT)
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)

 #ifndef arch_consoles_callable

