Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWGRJVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWGRJVc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWGRJVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:21:08 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:28802 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932110AbWGRJUW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:20:22 -0400
Message-Id: <20060718091951.477119000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:12 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 12/33] Change __FIXADDR_TOP to leave room for the hypervisor.
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

diff -r 1c88b225d413 include/asm-i386/fixmap.h
--- a/include/asm-i386/fixmap.h	Thu Jun 22 16:02:54 2006 -0400
+++ b/include/asm-i386/fixmap.h	Thu Jun 22 16:05:56 2006 -0400
@@ -13,13 +13,7 @@
 #ifndef _ASM_FIXMAP_H
 #define _ASM_FIXMAP_H
 
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
diff -r 1c88b225d413 include/asm-i386/mach-default/mach_fixmap.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-default/mach_fixmap.h	Thu Jun 22 16:05:56 2006 -0400
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
diff -r 1c88b225d413 include/asm-i386/mach-xen/mach_fixmap.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-xen/mach_fixmap.h	Thu Jun 22 16:05:56 2006 -0400
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_FIXMAP_H
+#define __ASM_MACH_FIXMAP_H
+
+#include <xen/interface/xen.h>
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
