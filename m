Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751661AbWEIIvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWEIIvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWEIIvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:51:31 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:13440 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751607AbWEIIt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:28 -0400
Message-Id: <20060509085150.509458000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:07 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 07/35] Make LOAD_OFFSET defined by subarch
Content-Disposition: inline; filename=i386-load-offset
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change LOAD_OFFSET so that the kernel has virtual addresses in the elf header fields.

Unlike bare metal kernels, Xen kernels start with virtual address
management turned on and thus the addresses to load to should be
virtual addresses.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/vmlinux.lds.S                   |    2 +-
 include/asm-i386/mach-default/mach_vmlinux.lds.h |    6 ++++++
 include/asm-i386/mach-xen/mach_vmlinux.lds.h     |    6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

--- linus-2.6.orig/arch/i386/kernel/vmlinux.lds.S
+++ linus-2.6/arch/i386/kernel/vmlinux.lds.S
@@ -2,7 +2,7 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
 
-#define LOAD_OFFSET __PAGE_OFFSET
+#include "mach_vmlinux.lds.h"
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-default/mach_vmlinux.lds.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_VMLINUX_LDS_H
+#define __ASM_MACH_VMLINUX_LDS_H
+
+#define LOAD_OFFSET __PAGE_OFFSET
+
+#endif /* __ASM_MACH_VMLINUX_LDS_H */
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-xen/mach_vmlinux.lds.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_VMLINUX_LDS_H
+#define __ASM_MACH_VMLINUX_LDS_H
+
+#define LOAD_OFFSET 0
+
+#endif /* __ASM_MACH_VMLINUX_LDS_H */

--
