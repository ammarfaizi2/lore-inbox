Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUHYJPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUHYJPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 05:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUHYJOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 05:14:47 -0400
Received: from [212.209.10.220] ([212.209.10.220]:30429 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S263448AbUHYJNr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 05:13:47 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>
Subject: [2.6 PATCH 1/6] CRIS architecture update
Date: Wed, 25 Aug 2004 11:13:41 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66818F514@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains changes related to configuration and build.

diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/Makefile
lx25/arch/cris/Makefile
--- ../linux/arch/cris/Makefile	Sat Aug 14 07:36:57 2004
+++ lx25/arch/cris/Makefile	Thu Aug 19 11:49:36 2004
@@ -1,4 +1,4 @@
-# $Id: Makefile,v 1.20 2004/05/14 14:35:58 orjanf Exp $
+# $Id: Makefile,v 1.22 2004/08/19 09:49:36 pkj Exp $
 # cris/Makefile
 #
 # This file is included by the global makefile so that you can add your own
@@ -15,6 +15,7 @@
 
 arch-y := v10
 arch-$(CONFIG_ETRAX_ARCH_V10) := v10
+arch-$(CONFIG_ETRAX_ARCH_V32) := v32
 
 # No config avaiable for make clean etc
 ifneq ($(arch-y),)
@@ -82,7 +83,7 @@
 archmrproper:
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/$(ARCH)/boot
-	rm -f timage vmlinux.bin cramfs.img
+	rm -f timage vmlinux.bin decompress.bin rescue.bin cramfs.img
 	rm -rf $(LD_SCRIPT).tmp
 
 prepare: arch/$(ARCH)/.links include/asm-$(ARCH)/.arch \
diff -urNP --exclude='*.cvsignore'
../linux/arch/cris/arch-v10/kernel/Makefile
lx25/arch/cris/arch-v10/kernel/Makefile
--- ../linux/arch/cris/arch-v10/kernel/Makefile	Sat Aug 14 07:36:10 2004
+++ lx25/arch/cris/arch-v10/kernel/Makefile	Wed Jun  2 10:24:38 2004
@@ -1,4 +1,4 @@
-# $Id: Makefile,v 1.4 2003/07/04 12:57:13 tobiasa Exp $
+# $Id: Makefile,v 1.5 2004/06/02 08:24:38 starvik Exp $
 #
 # Makefile for the linux kernel.
 #
@@ -11,6 +11,7 @@
 
 obj-$(CONFIG_ETRAX_KGDB) += kgdb.o
 obj-$(CONFIG_ETRAX_FAST_TIMER) += fasttimer.o
+obj-$(CONFIG_MODULES)    += crisksyms.o
 
 clean:
 
diff -urNP --exclude='*.cvsignore'
../linux/arch/cris/arch-v10/kernel/crisksyms.c
lx25/arch/cris/arch-v10/kernel/crisksyms.c
--- ../linux/arch/cris/arch-v10/kernel/crisksyms.c	Thu Jan  1 01:00:00
1970
+++ lx25/arch/cris/arch-v10/kernel/crisksyms.c	Wed Jun  2 10:24:38 2004
@@ -0,0 +1,17 @@
+#include <linux/config.h>
+#include <linux/module.h>
+#include <asm/io.h>
+#include <asm/arch/svinto.h>
+
+/* Export shadow registers for the CPU I/O pins */
+EXPORT_SYMBOL(genconfig_shadow);
+EXPORT_SYMBOL(port_pa_data_shadow);
+EXPORT_SYMBOL(port_pa_dir_shadow);
+EXPORT_SYMBOL(port_pb_data_shadow);
+EXPORT_SYMBOL(port_pb_dir_shadow);
+EXPORT_SYMBOL(port_pb_config_shadow);
+EXPORT_SYMBOL(port_g_data_shadow);
+
+/* Cache flush functions */
+EXPORT_SYMBOL(flush_etrax_cache);
+EXPORT_SYMBOL(prepare_rx_descriptor);

