Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWEIIsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWEIIsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWEIIsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:48:37 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:51587 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750703AbWEIIsh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:48:37 -0400
Message-Id: <20060509085146.825885000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:02 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 02/35] Makefile support to build Xen subarch
Content-Disposition: inline; filename=i386-mach-xen
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use arch/i386/mach-xen when building Xen subarch. The separate
subarchitecture allows us to hide details of interfacing with the
hypervisor from i386 common code.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/Makefile          |    5 +++++
 arch/i386/mach-xen/Makefile |    7 +++++++
 2 files changed, 12 insertions(+)

--- linus-2.6.orig/arch/i386/Makefile
+++ linus-2.6/arch/i386/Makefile
@@ -71,6 +71,10 @@ mcore-$(CONFIG_X86_BIGSMP)	:= mach-defau
 mflags-$(CONFIG_X86_SUMMIT) := -Iinclude/asm-i386/mach-summit
 mcore-$(CONFIG_X86_SUMMIT)  := mach-default
 
+# Xen subarch support
+mflags-$(CONFIG_X86_XEN)	:= -Iinclude/asm-i386/mach-xen
+mcore-$(CONFIG_X86_XEN)		:= mach-xen
+
 # generic subarchitecture
 mflags-$(CONFIG_X86_GENERICARCH) := -Iinclude/asm-i386/mach-generic
 mcore-$(CONFIG_X86_GENERICARCH) := mach-default
@@ -99,6 +103,7 @@ drivers-$(CONFIG_PM)			+= arch/i386/powe
 
 CFLAGS += $(mflags-y)
 AFLAGS += $(mflags-y)
+CPPFLAGS += $(mflags-y)
 
 boot := arch/i386/boot
 
--- /dev/null
+++ linus-2.6/arch/i386/mach-xen/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y				:= setup.o
+
+setup-y				:= ../mach-default/setup.o

--
