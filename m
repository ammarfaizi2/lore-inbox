Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWCMSOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWCMSOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWCMSOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:14:40 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:42765 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932301AbWCMSOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:14:38 -0500
Date: Mon, 13 Mar 2006 10:14:37 -0800
Message-Id: <200603131814.k2DIEbpA005766@zach-dev.vmware.com>
Subject: [RFC, PATCH 20/24] i386 Vmi module fixups
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 13 Mar 2006 18:14:37.0893 (UTC) FILETIME=[FD50A750:01C646C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sub-arch specifier to the module identification string to avoid
cross loading modules from different subarch compiles.

XXX FIXME.  Module loading is broken in paravirtualized VMI kernels,
since there is no annotation fixup applied to modules.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc3/include/asm-i386/module.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-i386/module.h	2006-02-24 16:00:21.000000000 -0800
+++ linux-2.6.16-rc3/include/asm-i386/module.h	2006-02-24 16:02:02.000000000 -0800
@@ -1,6 +1,8 @@
 #ifndef _ASM_I386_MODULE_H
 #define _ASM_I386_MODULE_H
 
+#include <mach_module.h>
+
 /* x86 is simple */
 struct mod_arch_specific
 {
@@ -72,6 +74,7 @@ struct mod_arch_specific
 #define MODULE_STACKSIZE ""
 #endif
 
-#define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY MODULE_REGPARM MODULE_STACKSIZE
+#define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY MODULE_REGPARM MODULE_STACKSIZE \
+	MODULE_SUBARCH_VERMAGIC
 
 #endif /* _ASM_I386_MODULE_H */
Index: linux-2.6.16-rc3/include/asm-i386/mach-vmi/mach_module.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-i386/mach-vmi/mach_module.h	2006-02-24 16:02:02.000000000 -0800
+++ linux-2.6.16-rc3/include/asm-i386/mach-vmi/mach_module.h	2006-02-24 16:02:02.000000000 -0800
@@ -0,0 +1,6 @@
+#ifndef _ASM_I386_ARCH_MODULE_H
+#define _ASM_I386_ARCH_MODULE_H
+
+#define MODULE_SUBARCH_VERMAGIC "VMI "
+
+#endif /* _ASM_I386_ARCH_MODULE_H */
Index: linux-2.6.16-rc3/include/asm-i386/mach-default/mach_module.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-i386/mach-default/mach_module.h	2006-02-24 16:02:02.000000000 -0800
+++ linux-2.6.16-rc3/include/asm-i386/mach-default/mach_module.h	2006-02-24 16:02:02.000000000 -0800
@@ -0,0 +1,6 @@
+#ifndef _ASM_I386_ARCH_MODULE_H
+#define _ASM_I386_ARCH_MODULE_H
+
+#define MODULE_SUBARCH_VERMAGIC
+
+#endif /* _ASM_I386_ARCH_MODULE_H */
