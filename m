Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTLPMP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 07:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTLPMP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 07:15:29 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:14616 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261506AbTLPMPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 07:15:14 -0500
Date: Tue, 16 Dec 2003 04:15:04 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Take 2: rearrange cpumask.h headers in conventional
 structure
Message-Id: <20031216041504.1b82952d.pj@sgi.com>
In-Reply-To: <20031215090331.2ca5a755.akpm@osdl.org>
References: <20031215001045.41b98136.pj@sgi.com>
	<20031215090331.2ca5a755.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please consider the following patch for inclusion.  It applies to test11.

==

Here is my second version of the patch to rearrange the cpumask headers.
Following Andrew's suggestion, include/linux/cpumask.h is retained,
and contains arch-independent cpumask things.  The using files are
no longer changed from including linux/cpumask.h to including asm/cpumask.h

See my original post in this thread for further explanation of the
motivations for this change.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1496  -> 1.1497 
#	include/linux/cpumask.h	1.1     -> 1.3     include/asm-generic/cpumask.h (moved)
#	               (new)	        -> 1.2     include/linux/cpumask.h
#	               (new)	        -> 1.1     include/asm-m68knommu/cpumask.h
#	               (new)	        -> 1.1     include/asm-um/cpumask.h
#	               (new)	        -> 1.1     include/asm-cris/cpumask.h
#	               (new)	        -> 1.1     include/asm-s390/cpumask.h
#	               (new)	        -> 1.1     include/asm-arm26/cpumask.h
#	               (new)	        -> 1.1     include/asm-v850/cpumask.h
#	               (new)	        -> 1.1     include/asm-mips/cpumask.h
#	               (new)	        -> 1.1     include/asm-sh/cpumask.h
#	               (new)	        -> 1.1     include/asm-arm/cpumask.h
#	               (new)	        -> 1.1     include/asm-alpha/cpumask.h
#	               (new)	        -> 1.1     include/asm-h8300/cpumask.h
#	               (new)	        -> 1.1     include/asm-x86_64/cpumask.h
#	               (new)	        -> 1.1     include/asm-ppc/cpumask.h
#	               (new)	        -> 1.1     include/asm-parisc/cpumask.h
#	               (new)	        -> 1.1     include/asm-i386/cpumask.h
#	               (new)	        -> 1.1     include/asm-sparc64/cpumask.h
#	               (new)	        -> 1.1     include/asm-m68k/cpumask.h
#	               (new)	        -> 1.1     include/asm-sparc/cpumask.h
#	               (new)	        -> 1.1     include/asm-ppc64/cpumask.h
#	               (new)	        -> 1.1     include/asm-ia64/cpumask.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/16	pj@sgi.com	1.1497
# Apply conventions used by all other generic headers to cpumask.h:
#  1) Each arch has its own include/asm-<arch>/cpumask.h file
#  2) That arch-specific header file can include <asm-generic/cpumask.h>,
#     if it wants to make use of the generic cpumask implementation.
#  3) Using code should continue to include linux/cpumask.h, which
#     in turn includes asm/cpumask.h.  Some common implementation
#     independent cpumask related items, such as the cpu_online_map,
#     are declared directly in linux/cpumask.h.
# Following the conventions used by all other such headers simplifies
# understanding the code, and enables an arch to have its own cpumask
# implementation details without affecting other arch's.
# --------------------------------------------
#
diff -Nru a/include/asm-alpha/cpumask.h b/include/asm-alpha/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-alpha/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_ALPHA_CPUMASK_H
+#define _ASM_ALPHA_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_ALPHA_CPUMASK_H */
diff -Nru a/include/asm-arm/cpumask.h b/include/asm-arm/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-arm/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_ARM_CPUMASK_H
+#define _ASM_ARM_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_ARM_CPUMASK_H */
diff -Nru a/include/asm-arm26/cpumask.h b/include/asm-arm26/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-arm26/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_ARM26_CPUMASK_H
+#define _ASM_ARM26_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_ARM26_CPUMASK_H */
diff -Nru a/include/asm-cris/cpumask.h b/include/asm-cris/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-cris/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_CRIS_CPUMASK_H
+#define _ASM_CRIS_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_CRIS_CPUMASK_H */
diff -Nru a/include/asm-generic/cpumask.h b/include/asm-generic/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-generic/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,40 @@
+#ifndef __ASM_GENERIC_CPUMASK_H
+#define __ASM_GENERIC_CPUMASK_H
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/threads.h>
+#include <linux/types.h>
+#include <linux/bitmap.h>
+
+#if NR_CPUS > BITS_PER_LONG && NR_CPUS != 1
+#define CPU_ARRAY_SIZE		BITS_TO_LONGS(NR_CPUS)
+
+struct cpumask
+{
+	unsigned long mask[CPU_ARRAY_SIZE];
+};
+
+typedef struct cpumask cpumask_t;
+
+#else
+typedef unsigned long cpumask_t;
+#endif
+
+#ifdef CONFIG_SMP
+#if NR_CPUS > BITS_PER_LONG
+#include <asm-generic/cpumask_array.h>
+#else
+#include <asm-generic/cpumask_arith.h>
+#endif
+#else
+#include <asm-generic/cpumask_up.h>
+#endif
+
+#if NR_CPUS <= 4*BITS_PER_LONG
+#include <asm-generic/cpumask_const_value.h>
+#else
+#include <asm-generic/cpumask_const_reference.h>
+#endif
+
+#endif /* __ASM_GENERIC_CPUMASK_H */
diff -Nru a/include/asm-h8300/cpumask.h b/include/asm-h8300/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-h8300/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_H8300_CPUMASK_H
+#define _ASM_H8300_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_H8300_CPUMASK_H */
diff -Nru a/include/asm-i386/cpumask.h b/include/asm-i386/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_I386_CPUMASK_H
+#define _ASM_I386_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_I386_CPUMASK_H */
diff -Nru a/include/asm-ia64/cpumask.h b/include/asm-ia64/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ia64/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_IA64_CPUMASK_H
+#define _ASM_IA64_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_IA64_CPUMASK_H */
diff -Nru a/include/asm-m68k/cpumask.h b/include/asm-m68k/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-m68k/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_M68K_CPUMASK_H
+#define _ASM_M68K_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_M68K_CPUMASK_H */
diff -Nru a/include/asm-m68knommu/cpumask.h b/include/asm-m68knommu/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-m68knommu/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_M68KNOMMU_CPUMASK_H
+#define _ASM_M68KNOMMU_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_M68KNOMMU_CPUMASK_H */
diff -Nru a/include/asm-mips/cpumask.h b/include/asm-mips/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-mips/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_MIPS_CPUMASK_H
+#define _ASM_MIPS_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_MIPS_CPUMASK_H */
diff -Nru a/include/asm-parisc/cpumask.h b/include/asm-parisc/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-parisc/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_PARISC_CPUMASK_H
+#define _ASM_PARISC_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_PARISC_CPUMASK_H */
diff -Nru a/include/asm-ppc/cpumask.h b/include/asm-ppc/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ppc/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_PPC_CPUMASK_H
+#define _ASM_PPC_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_PPC_CPUMASK_H */
diff -Nru a/include/asm-ppc64/cpumask.h b/include/asm-ppc64/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ppc64/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_PPC64_CPUMASK_H
+#define _ASM_PPC64_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_PPC64_CPUMASK_H */
diff -Nru a/include/asm-s390/cpumask.h b/include/asm-s390/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-s390/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_S390_CPUMASK_H
+#define _ASM_S390_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_S390_CPUMASK_H */
diff -Nru a/include/asm-sh/cpumask.h b/include/asm-sh/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-sh/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_SH_CPUMASK_H
+#define _ASM_SH_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_SH_CPUMASK_H */
diff -Nru a/include/asm-sparc/cpumask.h b/include/asm-sparc/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-sparc/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_SPARC_CPUMASK_H
+#define _ASM_SPARC_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_SPARC_CPUMASK_H */
diff -Nru a/include/asm-sparc64/cpumask.h b/include/asm-sparc64/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-sparc64/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_SPARC64_CPUMASK_H
+#define _ASM_SPARC64_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_SPARC64_CPUMASK_H */
diff -Nru a/include/asm-um/cpumask.h b/include/asm-um/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-um/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_UM_CPUMASK_H
+#define _ASM_UM_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_UM_CPUMASK_H */
diff -Nru a/include/asm-v850/cpumask.h b/include/asm-v850/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-v850/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_V850_CPUMASK_H
+#define _ASM_V850_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_V850_CPUMASK_H */
diff -Nru a/include/asm-x86_64/cpumask.h b/include/asm-x86_64/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-x86_64/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_X86_64_CPUMASK_H
+#define _ASM_X86_64_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_X86_64_CPUMASK_H */
diff -Nru a/include/linux/cpumask.h b/include/linux/cpumask.h
--- a/include/linux/cpumask.h	Tue Dec 16 03:09:14 2003
+++ b/include/linux/cpumask.h	Tue Dec 16 03:09:14 2003
@@ -1,42 +1,9 @@
 #ifndef __LINUX_CPUMASK_H
 #define __LINUX_CPUMASK_H
 
-#include <linux/config.h>
-#include <linux/kernel.h>
 #include <linux/threads.h>
-#include <linux/types.h>
-#include <linux/bitmap.h>
-
-#if NR_CPUS > BITS_PER_LONG && NR_CPUS != 1
-#define CPU_ARRAY_SIZE		BITS_TO_LONGS(NR_CPUS)
-
-struct cpumask
-{
-	unsigned long mask[CPU_ARRAY_SIZE];
-};
-
-typedef struct cpumask cpumask_t;
-
-#else
-typedef unsigned long cpumask_t;
-#endif
-
-#ifdef CONFIG_SMP
-#if NR_CPUS > BITS_PER_LONG
-#include <asm-generic/cpumask_array.h>
-#else
-#include <asm-generic/cpumask_arith.h>
-#endif
-#else
-#include <asm-generic/cpumask_up.h>
-#endif
-
-#if NR_CPUS <= 4*BITS_PER_LONG
-#include <asm-generic/cpumask_const_value.h>
-#else
-#include <asm-generic/cpumask_const_reference.h>
-#endif
-
+#include <asm/cpumask.h>
+#include <asm/bug.h>
 
 #ifdef CONFIG_SMP
 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
