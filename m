Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWCVGjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWCVGjL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWCVGiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:38:55 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:61056 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750877AbWCVGiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:38:09 -0500
Message-Id: <20060322063747.636585000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:30:49 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 09/35] Change __FIXADDR_TOP to leave room for the hypervisor.
Content-Disposition: inline; filename=08-i386-fixmap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the definition of __FIXADDR_TOP into a subarch include file so
that it can be overridden for subarch xen -- the hypervisor needs
about 64MB at the top of the address space.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/asm-i386/fixmap.h                   |    8 +-------
 include/asm-i386/mach-default/mach_fixmap.h |   11 +++++++++++
 include/asm-i386/mach-xen/mach_fixmap.h     |   11 +++++++++++
 3 files changed, 23 insertions(+), 7 deletions(-)

--- xen-subarch-2.6.orig/include/asm-i386/fixmap.h
+++ xen-subarch-2.6/include/asm-i386/fixmap.h
@@ -14,13 +14,7 @@
 #define _ASM_FIXMAP_H
 
 #include <linux/config.h>
-
-/* used by vmalloc.c, vsyscall.lds.S.
- *
- * Leave one empty page between vmalloc'ed areas and
- * the start of the fixmap.
- */
-#define __FIXADDR_TOP	0xfffff000
+#include <mach_fixmap.h>
 
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/mach-default/mach_fixmap.h
@@ -0,0 +1,11 @@
+#ifndef __ASM_MACH_FIXMAP_H
+#define __ASM_MACH_FIXMAP_H
+
+/* used by vmalloc.c, vsyscall.lds.S.
+ *
+ * Leave one empty page between vmalloc'ed areas and
+ * the start of the fixmap.
+ */
+#define __FIXADDR_TOP	0xfffff000
+
+#endif /* __ASM_MACH_FIXMAP_H */
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/mach-xen/mach_fixmap.h
@@ -0,0 +1,11 @@
+#ifndef __ASM_MACH_FIXMAP_H
+#define __ASM_MACH_FIXMAP_H
+
+/* used by vmalloc.c, vsyscall.lds.S.
+ *
+ * Leave one empty page between vmalloc'ed areas and
+ * the start of the fixmap.
+ */
+#define __FIXADDR_TOP	(HYPERVISOR_VIRT_START - 2 * PAGE_SIZE)
+
+#endif /* __ASM_MACH_FIXMAP_H */

--
