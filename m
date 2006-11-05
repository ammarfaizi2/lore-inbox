Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWKEUli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWKEUli (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWKEUli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:41:38 -0500
Received: from il.qumranet.com ([62.219.232.206]:13226 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1422646AbWKEUlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:41:37 -0500
Subject: [PATCH 13/14] KVM: plumbing
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 05 Nov 2006 20:41:35 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <454E4941.7000108@qumranet.com>
In-Reply-To: <454E4941.7000108@qumranet.com>
Message-Id: <20061105204135.EA0CB2500A7@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a config entry and a Makefile for KVM.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/Kconfig
===================================================================
--- linux-2.6.orig/drivers/Kconfig
+++ linux-2.6/drivers/Kconfig
@@ -78,4 +78,6 @@ source "drivers/rtc/Kconfig"
 
 source "drivers/dma/Kconfig"
 
+source "drivers/kvm/Kconfig"
+
 endmenu
Index: linux-2.6/drivers/Makefile
===================================================================
--- linux-2.6.orig/drivers/Makefile
+++ linux-2.6/drivers/Makefile
@@ -77,3 +77,4 @@ obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
 obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
 obj-$(CONFIG_DMA_ENGINE)	+= dma/
+obj-$(CONFIG_KVM)		+= kvm/
Index: linux-2.6/drivers/kvm/Makefile
===================================================================
--- /dev/null
+++ linux-2.6/drivers/kvm/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for Kernel-based Virtual Machine module
+#
+
+kvm-objs := kvm_main.o mmu.o x86_emulate.o
+obj-$(CONFIG_KVM) += kvm.o
Index: linux-2.6/drivers/kvm/Kconfig
===================================================================
--- /dev/null
+++ linux-2.6/drivers/kvm/Kconfig
@@ -0,0 +1,18 @@
+#
+# KVM configuration
+#
+config KVM
+	tristate "Kernel-based Virtual Machine (KVM) support"
+	depends on X86 && EXPERIMENTAL
+	---help---
+	  Support hosting fully virtualized guest machines using hardware
+	  virtualization extensions.  You will need a fairly recent Intel
+	  processor equipped with VT extensions.
+
+	  This module provides access to the hardware capabilities through
+	  a character device node named /dev/kvm.
+
+	  To compile this as a module, choose M here: the module
+	  will be called kvm.
+
+	  If unsure, say N.
