Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWJWNcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWJWNcA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 09:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWJWNb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 09:31:59 -0400
Received: from il.qumranet.com ([62.219.232.206]:31189 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S964862AbWJWNbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 09:31:48 -0400
Subject: [PATCH 13/13] KVM: plumbing
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 23 Oct 2006 13:31:47 -0000
To: avi@qumranet.com, linux-kernel@vger.kernel.org
References: <453CC390.9080508@qumranet.com>
In-Reply-To: <453CC390.9080508@qumranet.com>
Message-Id: <20061023133147.067DF250143@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a config entry and a Makefile for KVM.

Signed-off-by: Avi Kivity <avi@qumranet.com>

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
@@ -0,0 +1,22 @@
+
+menu "Virtualization"
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
+
+endmenu
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
