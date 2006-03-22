Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWCVGif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWCVGif (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWCVGie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:38:34 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:51074 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750900AbWCVGiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:38:21 -0500
Message-Id: <20060322063746.389133000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:30:47 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 07/35] Make LOAD_OFFSET defined by subarch
Content-Disposition: inline; filename=06-i386-load-offset
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

--- xen-subarch-2.6.orig/arch/i386/kernel/vmlinux.lds.S
+++ xen-subarch-2.6/arch/i386/kernel/vmlinux.lds.S
@@ -2,7 +2,7 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
 
-#define LOAD_OFFSET __PAGE_OFFSET
+#include "mach_vmlinux.lds.h"
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/mach-default/mach_vmlinux.lds.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_VMLINUX_LDS_H
+#define __ASM_MACH_VMLINUX_LDS_H
+
+#define LOAD_OFFSET __PAGE_OFFSET
+
+#endif /* __ASM_MACH_VMLINUX_LDS_H */
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/mach-xen/mach_vmlinux.lds.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_VMLINUX_LDS_H
+#define __ASM_MACH_VMLINUX_LDS_H
+
+#define LOAD_OFFSET 0
+
+#endif /* __ASM_MACH_VMLINUX_LDS_H */

--
