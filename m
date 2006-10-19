Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161421AbWJSN4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161421AbWJSN4O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161427AbWJSN4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:56:14 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:13490 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1161421AbWJSN4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:56:12 -0400
Message-ID: <453783F6.4050402@qumranet.com>
Date: Thu, 19 Oct 2006 15:56:06 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] KVM: plumbing
References: <4537818D.4060204@qumranet.com>
In-Reply-To: <4537818D.4060204@qumranet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2006 13:56:11.0543 (UTC) FILETIME=[55B06A70:01C6F386]
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
+    tristate "Kernel-based Virtual Machine (KVM) support"
+    depends on X86 && EXPERIMENTAL
+    ---help---
+      Support hosting fully virtualized guest machines using hardware
+      virtualization extensions.  You will need a fairly recent Intel
+      processor equipped with VT extensions.
+
+      This module provides access to the hardware capabilities through
+      a character device node named /dev/kvm.
+
+      To compile this as a module, choose M here: the module
+      will be called kvm.
+
+      If unsure, say N.
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
@@ -77,3 +77,4 @@ obj-$(CONFIG_CRYPTO)        += crypto/
 obj-$(CONFIG_SUPERH)        += sh/
 obj-$(CONFIG_GENERIC_TIME)    += clocksource/
 obj-$(CONFIG_DMA_ENGINE)    += dma/
+obj-$(CONFIG_KVM)        += kvm/

-- 
error compiling committee.c: too many arguments to function

