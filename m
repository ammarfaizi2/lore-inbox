Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbUFBJTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUFBJTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 05:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUFBJTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 05:19:47 -0400
Received: from alsvidh.mathematik.uni-muenchen.de ([129.187.111.42]:460 "EHLO
	alsvidh.mathematik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S262381AbUFBJTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 05:19:43 -0400
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org
Subject: [PATCH] OProfile driver in 2.6
Organization: Lehrstuhl fuer vergleichende Astrozoologie
X-Mahlzeit: Das ist per Saldo Gemuetlichkeit
Reply-To: Jens Schmalzing <j.s@lmu.de>
From: Jens Schmalzing <j.s@lmu.de>
Date: 02 Jun 2004 11:19:41 +0200
Message-ID: <hhwu2qs4eq.fsf@alsvidh.mathematik.uni-muenchen.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

I noticed that the driver for the OProfile profiling system, which
existed in the linuxppc-2.5-benh tree, is disabled in the mainline,
even though the driver still exists.  Is there a reason for this?  The
attached patch re-enables the driver.

Regards, Jens.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=oprofile.diff
Content-Description: OProfile profiling system

diff -Nur kernel-source-2.6.6/arch/ppc/Kconfig linuxppc-2.5-benh/arch/ppc/Kconfig
--- kernel-source-2.6.6/arch/ppc/Kconfig        2004-04-05 11:49:23.000000000 +0200
+++ linuxppc-2.5-benh/arch/ppc/Kconfig  2004-03-29 08:34:26.000000000 +0200
@@ -1121,6 +1121,7 @@
 
 source "lib/Kconfig"
 
+source "arch/ppc/oprofile/Kconfig"
 
 menu "Kernel hacking"
 
diff -Nur kernel-source-2.6.6/arch/ppc/oprofile/Kconfig linuxppc-2.5-benh/arch/ppc/oprofile/Kconfig
--- kernel-source-2.6.6/arch/ppc/oprofile/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linuxppc-2.5-benh/arch/ppc/oprofile/Kconfig	2003-12-31 03:50:43.000000000 +0100
@@ -0,0 +1,23 @@
+
+menu "Profiling support"
+	depends on EXPERIMENTAL
+
+config PROFILING
+	bool "Profiling support (EXPERIMENTAL)"
+	help
+	  Say Y here to enable the extended profiling support mechanisms used
+	  by profilers such as OProfile.
+
+
+config OPROFILE
+	tristate "OProfile system profiling (EXPERIMENTAL)"
+	depends on PROFILING
+	help
+	  OProfile is a profiling system capable of profiling the
+	  whole system, include the kernel, kernel modules, libraries,
+	  and applications.
+
+	  If unsure, say N.
+
+endmenu
+
diff -Nur kernel-source-2.6.6/arch/ppc/oprofile/Makefile linuxppc-2.5-benh/arch/ppc/oprofile/Makefile
--- kernel-source-2.6.6/arch/ppc/oprofile/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linuxppc-2.5-benh/arch/ppc/oprofile/Makefile	2003-12-31 03:50:44.000000000 +0100
@@ -0,0 +1,9 @@
+obj-$(CONFIG_OPROFILE) += oprofile.o
+
+DRIVER_OBJS := $(addprefix ../../../drivers/oprofile/, \
+		oprof.o cpu_buffer.o buffer_sync.o \
+		event_buffer.o oprofile_files.o \
+		oprofilefs.o oprofile_stats.o \
+		timer_int.o )
+
+oprofile-y := $(DRIVER_OBJS) init.o
diff -Nur kernel-source-2.6.6/arch/ppc/oprofile/init.c linuxppc-2.5-benh/arch/ppc/oprofile/init.c
--- kernel-source-2.6.6/arch/ppc/oprofile/init.c	1970-01-01 01:00:00.000000000 +0100
+++ linuxppc-2.5-benh/arch/ppc/oprofile/init.c	2003-12-31 03:50:45.000000000 +0100
@@ -0,0 +1,25 @@
+/**
+ * @file init.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/oprofile.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+
+extern void timer_init(struct oprofile_operations ** ops);
+
+int __init oprofile_arch_init(struct oprofile_operations ** ops)
+{
+	return -ENODEV;
+}
+
+
+void oprofile_arch_exit(void)
+{
+}

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


--=20
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je p=E9zqbpbe je djuz tqtaj!

--=-=-=--
