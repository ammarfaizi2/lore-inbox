Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265482AbSJaXGW>; Thu, 31 Oct 2002 18:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265478AbSJaXFY>; Thu, 31 Oct 2002 18:05:24 -0500
Received: from kim.it.uu.se ([130.238.12.178]:31432 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S265470AbSJaXEO>;
	Thu, 31 Oct 2002 18:04:14 -0500
Date: Fri, 1 Nov 2002 00:10:39 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210312310.AAA07612@kim.it.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH] performance counters 3.1 for 2.5.45 [3/4]: shared glue files
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 3 of 4 of perfctr-3.1 for the 2.5.45 kernel:
common glue files.

 Kconfig  |   43 +++++++++++++++++++++++++++++++++++++++++++
 Makefile |   13 +++++++++++++
 2 files changed, 56 insertions(+)

diff -uN linux-2.5.45/drivers/perfctr/Kconfig linux-2.5.45.perfctr-3.1/drivers/perfctr/Kconfig
--- linux-2.5.45/drivers/perfctr/Kconfig	Thu Jan  1 01:00:00 1970
+++ linux-2.5.45.perfctr-3.1/drivers/perfctr/Kconfig	Thu Oct 31 22:36:50 2002
@@ -0,0 +1,43 @@
+# $Id: Kconfig,v 1.1 2002/10/31 21:36:50 mikpe Exp $
+# Performance-monitoring counters driver configuration
+#
+
+menu "Performance-monitoring counters support"
+
+config PERFCTR
+	bool "Performance monitoring counters support"
+	help
+	  This driver provides access to the performance-monitoring counter
+	  registers available in some (but not all) modern processors.
+	  These special-purpose registers can be programmed to count low-level
+	  performance-related events which occur during program execution,
+	  such as cache misses, pipeline stalls, etc.
+
+	  The driver supports most x86-class processors known to have
+	  performance-monitoring counters: Intel Pentium to Pentium 4,
+	  AMD K7, Cyrix 6x86MX/MII/III, VIA C3, and WinChip C6/2/3.
+
+	  On processors which have a time-stamp counter but no performance-
+	  monitoring counters, such as the AMD K6 family, the driver supports
+	  plain cycle-count performance measurements only.
+
+	  On WinChip C6/2/3 processors the performance-monitoring counters
+	  cannot be used unless the time-stamp counter has been disabled.
+	  Please read <file:drivers/perfctr/x86.c> for further information.
+
+	  You can safely say Y here, even if you intend to run the kernel
+	  on a processor without performance-monitoring counters.
+
+config PERFCTR_VIRTUAL
+	bool "Virtual performance counters support"
+	depends on PERFCTR
+	help
+	  The processor's performance-monitoring counters are special-purpose
+	  global registers. This option adds support for virtual per-process
+	  performance-monitoring counters which only run when the process
+	  to which they belong is executing. This improves the accuracy of
+	  performance measurements by reducing "noise" from other processes.
+
+	  Say Y.
+
+endmenu
diff -uN linux-2.5.45/drivers/perfctr/Makefile linux-2.5.45.perfctr-3.1/drivers/perfctr/Makefile
--- linux-2.5.45/drivers/perfctr/Makefile	Thu Jan  1 01:00:00 1970
+++ linux-2.5.45.perfctr-3.1/drivers/perfctr/Makefile	Thu Oct 31 23:16:59 2002
@@ -0,0 +1,13 @@
+# $Id: Makefile,v 1.11 2002/10/31 22:16:59 mikpe Exp $
+# Makefile for the Performance-monitoring counters driver.
+
+perfctr-objs-y :=
+
+perfctr-objs-$(CONFIG_X86) += x86.o
+
+perfctr-objs-$(CONFIG_PERFCTR_VIRTUAL) += virtual.o
+
+perfctr-objs		:= $(perfctr-objs-y)
+obj-$(CONFIG_PERFCTR)	:= perfctr.o
+
+include $(TOPDIR)/Rules.make
