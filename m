Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWGRJ0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWGRJ0v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWGRJU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:20:59 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:60290 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932113AbWGRJUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:20:31 -0400
Message-Id: <20060718091949.842251000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:05 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 05/33] Makefile support to build Xen subarch
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

diff -r 02d1f5dae39e arch/i386/Makefile
--- a/arch/i386/Makefile	Wed Mar 29 17:18:15 2006 +0100
+++ b/arch/i386/Makefile	Mon Apr  3 14:34:30 2006 +0100
@@ -71,6 +71,10 @@ mflags-$(CONFIG_X86_SUMMIT) := -Iinclude
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
 
diff -r 02d1f5dae39e arch/i386/mach-xen/Makefile
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/arch/i386/mach-xen/Makefile	Mon Apr  3 14:34:30 2006 +0100
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y				:= setup.o
+
+setup-y				:= ../mach-default/setup.o

--
