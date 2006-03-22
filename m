Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWCVGh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWCVGh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWCVGh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:37:27 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45442 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750867AbWCVGh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:37:26 -0500
Message-Id: <20060322063742.985223000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:30:42 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 02/35] Makefile support to build Xen subarch
Content-Disposition: inline; filename=01-i386-mach-xen
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

--- xen-subarch-2.6.orig/arch/i386/Makefile
+++ xen-subarch-2.6/arch/i386/Makefile
@@ -68,6 +68,10 @@ mcore-$(CONFIG_X86_BIGSMP)	:= mach-defau
 mflags-$(CONFIG_X86_SUMMIT) := -Iinclude/asm-i386/mach-summit
 mcore-$(CONFIG_X86_SUMMIT)  := mach-default
 
+# Xen subarch support
+mflags-$(CONFIG_X86_XEN)	:= -Iinclude/asm-i386/mach-xen
+mcore-$(CONFIG_X86_XEN)		:= mach-xen
+
 # generic subarchitecture
 mflags-$(CONFIG_X86_GENERICARCH) := -Iinclude/asm-i386/mach-generic
 mcore-$(CONFIG_X86_GENERICARCH) := mach-default
@@ -96,6 +100,7 @@ drivers-$(CONFIG_PM)			+= arch/i386/powe
 
 CFLAGS += $(mflags-y)
 AFLAGS += $(mflags-y)
+CPPFLAGS += $(mflags-y)
 
 boot := arch/i386/boot
 
--- /dev/null
+++ xen-subarch-2.6/arch/i386/mach-xen/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y				:= setup.o
+ 
+setup-y				:= ../mach-default/setup.o

--
