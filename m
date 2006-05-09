Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWEII4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWEII4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWEII4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:56:24 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:3200 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751516AbWEIItR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:17 -0400
Message-Id: <20060509085151.530327000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:09 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 09/35] Change __FIXADDR_TOP to leave room for the hypervisor.
Content-Disposition: inline; filename=i386-fixmap
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

--- linus-2.6.orig/include/asm-i386/fixmap.h
+++ linus-2.6/include/asm-i386/fixmap.h
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
+++ linus-2.6/include/asm-i386/mach-default/mach_fixmap.h
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
+++ linus-2.6/include/asm-i386/mach-xen/mach_fixmap.h
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
