Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTLOILg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 03:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTLOILg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 03:11:36 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:325 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263370AbTLOIKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 03:10:53 -0500
Date: Mon, 15 Dec 2003 00:10:45 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] rearrange cpumask.h headers in conventional structure
Message-Id: <20031215001045.41b98136.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please consider the following patch.  Perhaps it initially
goes into -mm, and then, when 2.6 is in a suitable state,
to there.

This patch applies the 'conventional' organization used by all
other include/asm-generic headers to the cpumask headers.

No semantic code changes are included - just header file
structure changes.

The current cpumask headers are organized in an 'unusual'
fashion, which entangles all arch's, and impedes any change
for one arch, due to the risk of impacting another.

By the conventional organization, all headers in
include/asm-generic are included from other include/asm-* files,
or from architecture specific files under arch.  There are 245
such inclusions in 2.6 test11, all following this convention.

Exactly 5 inclusions of include/asm-generic files are different,
the 5 inclusions of the various include/asm-generic/cpumask_*.h
files, all from include/linux/cpumask.h.

The convention for any facility that is partially generic,
partially arch specific is for each include/asm-* arch to
have it's own arch-specific header file (picked up via the
include/asm symlink to the current arch), and for those
arch-specific header files in turn to include asm-generic
headers, if and to the extend that they choose to make use of
the generic implementation.

The following 16 facilities all follow this convention:

    pci.h               pgtable.h         ide.h
    siginfo.h           tlb.h             rtc.h
    div64.h             errno.h           xor.h
    percpu.h            rmap.h            local.h
    statfs.h            topology.h        sections.h
    dma-mapping.h

The cpumask facility is different, unjustifiably so,
in my view.

The following patch applies the above conventions to the
cpumask headers.

 1) It changes all users of cpumask, from including
    linux/cpumask.h, to including asm/cpumask.h

 2) It moves the top level cpumask.h from linux to asm-generic

 3) It adds an asm-<arch>/cpumask.h file to each arch, that
    for now simply includes asm-generic/cpumask.h

With this change, the cpumask.h header follows the same
conventions as other such features, and individual arch's
will be able to provide arch-specific implementations of
cpumask, without impacting other arch's.

My primary motivation for this change, besides trying to
be a good citizen and clean up unconventional code, is to
make it possible for me to provide an improved cpumask for
the ia64 arch, without killing the sparc64 implementation.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1496  -> 1.1498 
#	include/asm-ppc64/smp.h	1.12    -> 1.13   
#	include/asm-i386/mpspec.h	1.16    -> 1.17   
#	include/asm-x86_64/smp.h	1.13    -> 1.14   
#	include/asm-um/smp.h	1.3     -> 1.4    
#	     net/core/flow.c	1.16    -> 1.17   
#	arch/i386/mach-generic/probe.c	1.2     -> 1.3    
#	arch/i386/mach-generic/default.c	1.4     -> 1.5    
#	include/linux/sched.h	1.175   -> 1.176  
#	arch/ppc64/kernel/open_pic.h	1.2     -> 1.3    
#	 drivers/base/node.c	1.15    -> 1.16   
#	include/asm-mips/smp.h	1.5     -> 1.6    
#	include/asm-i386/topology.h	1.7     -> 1.8    
#	include/asm-ppc/smp.h	1.14    -> 1.15   
#	include/asm-sparc/smp.h	1.8     -> 1.9    
#	include/linux/rcupdate.h	1.4     -> 1.5    
#	arch/i386/mach-generic/bigsmp.c	1.3     -> 1.4    
#	include/asm-sparc64/smp.h	1.18    -> 1.19   
#	include/asm-ia64/numa.h	1.11    -> 1.12   
#	include/linux/cpumask.h	1.1     -> 1.3     include/asm-generic/cpumask.h (moved)
#	 include/linux/irq.h	1.9     -> 1.10   
#	include/asm-ia64/smp.h	1.13    -> 1.14   
#	include/asm-s390/smp.h	1.11    -> 1.12   
#	include/asm-i386/smp.h	1.29    -> 1.30   
#	include/linux/topology.h	1.3     -> 1.4    
#	include/asm-parisc/smp.h	1.5     -> 1.6    
#	arch/ppc/kernel/irq.c	1.33    -> 1.34   
#	include/asm-alpha/smp.h	1.12    -> 1.13   
#	include/linux/node.h	1.5     -> 1.6    
#	arch/i386/mach-generic/summit.c	1.3     -> 1.4    
#	               (new)	        -> 1.1     include/asm-s390/cpumask.h
#	               (new)	        -> 1.1     include/asm-m68knommu/cpumask.h
#	               (new)	        -> 1.1     include/asm-sparc64/cpumask.h
#	               (new)	        -> 1.1     include/asm-ia64/cpumask.h
#	               (new)	        -> 1.1     include/asm-arm/cpumask.h
#	               (new)	        -> 1.1     include/asm-h8300/cpumask.h
#	               (new)	        -> 1.1     include/asm-mips/cpumask.h
#	               (new)	        -> 1.1     include/asm-v850/cpumask.h
#	               (new)	        -> 1.1     include/asm-ppc/cpumask.h
#	               (new)	        -> 1.1     include/asm-x86_64/cpumask.h
#	               (new)	        -> 1.1     include/asm-sparc/cpumask.h
#	               (new)	        -> 1.1     include/asm-m68k/cpumask.h
#	               (new)	        -> 1.1     include/asm-ppc64/cpumask.h
#	               (new)	        -> 1.1     include/asm-alpha/cpumask.h
#	               (new)	        -> 1.1     include/asm-arm26/cpumask.h
#	               (new)	        -> 1.1     include/asm-i386/cpumask.h
#	               (new)	        -> 1.1     include/asm-parisc/cpumask.h
#	               (new)	        -> 1.1     include/asm-um/cpumask.h
#	               (new)	        -> 1.1     include/asm-sh/cpumask.h
#	               (new)	        -> 1.1     include/asm-cris/cpumask.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/14	pj@sgi.com	1.1497
# Apply conventions used by all other generic headers to cpumask.h:
#  1) Using code should include <asm/cpumask.h> (not linux/cpumask.h)
#  2) Each arch has its own include/asm-<arch>/cpumask.h file
#  3) That arch-specific header file can include <asm-generic/cpumask.h>,
#     if it wants to make use of the generic cpumask implementation.
# Following the conventions used by all other such headers simplifies
# understanding the code, and enables an arch to have its own cpumask
# implementation details without affecting other arch's.
# --------------------------------------------
# 03/12/15	pj@sgi.com	1.1498
# Change cpumask.h ifndef symbol to match new asm-generic location.
# --------------------------------------------
#
diff -Nru a/arch/i386/mach-generic/bigsmp.c b/arch/i386/mach-generic/bigsmp.c
--- a/arch/i386/mach-generic/bigsmp.c	Mon Dec 15 00:04:43 2003
+++ b/arch/i386/mach-generic/bigsmp.c	Mon Dec 15 00:04:43 2003
@@ -5,7 +5,7 @@
 #define APIC_DEFINITION 1
 #include <linux/config.h>
 #include <linux/threads.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <asm/mpspec.h>
 #include <asm/genapic.h>
 #include <asm/fixmap.h>
diff -Nru a/arch/i386/mach-generic/default.c b/arch/i386/mach-generic/default.c
--- a/arch/i386/mach-generic/default.c	Mon Dec 15 00:04:43 2003
+++ b/arch/i386/mach-generic/default.c	Mon Dec 15 00:04:43 2003
@@ -4,7 +4,7 @@
 #define APIC_DEFINITION 1
 #include <linux/config.h>
 #include <linux/threads.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <asm/mpspec.h>
 #include <asm/mach-default/mach_apicdef.h>
 #include <asm/genapic.h>
diff -Nru a/arch/i386/mach-generic/probe.c b/arch/i386/mach-generic/probe.c
--- a/arch/i386/mach-generic/probe.c	Mon Dec 15 00:04:43 2003
+++ b/arch/i386/mach-generic/probe.c	Mon Dec 15 00:04:43 2003
@@ -5,7 +5,7 @@
  */  
 #include <linux/config.h>
 #include <linux/threads.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/ctype.h>
diff -Nru a/arch/i386/mach-generic/summit.c b/arch/i386/mach-generic/summit.c
--- a/arch/i386/mach-generic/summit.c	Mon Dec 15 00:04:43 2003
+++ b/arch/i386/mach-generic/summit.c	Mon Dec 15 00:04:43 2003
@@ -4,7 +4,7 @@
 #define APIC_DEFINITION 1
 #include <linux/config.h>
 #include <linux/threads.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <asm/mpspec.h>
 #include <asm/genapic.h>
 #include <asm/fixmap.h>
diff -Nru a/arch/ppc/kernel/irq.c b/arch/ppc/kernel/irq.c
--- a/arch/ppc/kernel/irq.c	Mon Dec 15 00:04:43 2003
+++ b/arch/ppc/kernel/irq.c	Mon Dec 15 00:04:43 2003
@@ -45,7 +45,7 @@
 #include <linux/proc_fs.h>
 #include <linux/random.h>
 #include <linux/seq_file.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
diff -Nru a/arch/ppc64/kernel/open_pic.h b/arch/ppc64/kernel/open_pic.h
--- a/arch/ppc64/kernel/open_pic.h	Mon Dec 15 00:04:43 2003
+++ b/arch/ppc64/kernel/open_pic.h	Mon Dec 15 00:04:43 2003
@@ -13,7 +13,7 @@
 #define _PPC64_KERNEL_OPEN_PIC_H
 
 #include <linux/config.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 
 #define OPENPIC_SIZE	0x40000
 
diff -Nru a/drivers/base/node.c b/drivers/base/node.c
--- a/drivers/base/node.c	Mon Dec 15 00:04:43 2003
+++ b/drivers/base/node.c	Mon Dec 15 00:04:43 2003
@@ -7,7 +7,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/node.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <linux/topology.h>
 
 static struct sysdev_class node_class = {
diff -Nru a/include/asm-alpha/cpumask.h b/include/asm-alpha/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-alpha/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_ALPHA_CPUMASK_H
+#define _ASM_ALPHA_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_ALPHA_CPUMASK_H */
diff -Nru a/include/asm-alpha/smp.h b/include/asm-alpha/smp.h
--- a/include/asm-alpha/smp.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-alpha/smp.h	Mon Dec 15 00:04:43 2003
@@ -3,7 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/threads.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <linux/bitops.h>
 #include <asm/pal.h>
 
diff -Nru a/include/asm-arm/cpumask.h b/include/asm-arm/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-arm/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_ARM_CPUMASK_H
+#define _ASM_ARM_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_ARM_CPUMASK_H */
diff -Nru a/include/asm-arm26/cpumask.h b/include/asm-arm26/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-arm26/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_ARM26_CPUMASK_H
+#define _ASM_ARM26_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_ARM26_CPUMASK_H */
diff -Nru a/include/asm-cris/cpumask.h b/include/asm-cris/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-cris/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_CRIS_CPUMASK_H
+#define _ASM_CRIS_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_CRIS_CPUMASK_H */
diff -Nru a/include/asm-generic/cpumask.h b/include/asm-generic/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-generic/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,71 @@
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
+
+#ifdef CONFIG_SMP
+
+extern cpumask_t cpu_online_map;
+
+#define num_online_cpus()		cpus_weight(cpu_online_map)
+#define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
+#else
+#define	cpu_online_map			cpumask_of_cpu(0)
+#define num_online_cpus()		1
+#define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
+#endif
+
+static inline int next_online_cpu(int cpu, cpumask_t map)
+{
+	do
+		cpu = next_cpu_const(cpu, map);
+	while (cpu < NR_CPUS && !cpu_online(cpu));
+	return cpu;
+}
+
+#define for_each_cpu(cpu, map)						\
+	for (cpu = first_cpu_const(map);				\
+		cpu < NR_CPUS;						\
+		cpu = next_cpu_const(cpu,map))
+
+#define for_each_online_cpu(cpu, map)					\
+	for (cpu = first_cpu_const(map);				\
+		cpu < NR_CPUS;						\
+		cpu = next_online_cpu(cpu,map))
+
+#endif /* __ASM_GENERIC_CPUMASK_H */
diff -Nru a/include/asm-h8300/cpumask.h b/include/asm-h8300/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-h8300/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_H8300_CPUMASK_H
+#define _ASM_H8300_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_H8300_CPUMASK_H */
diff -Nru a/include/asm-i386/cpumask.h b/include/asm-i386/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_I386_CPUMASK_H
+#define _ASM_I386_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_I386_CPUMASK_H */
diff -Nru a/include/asm-i386/mpspec.h b/include/asm-i386/mpspec.h
--- a/include/asm-i386/mpspec.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-i386/mpspec.h	Mon Dec 15 00:04:43 2003
@@ -1,7 +1,7 @@
 #ifndef __ASM_MPSPEC_H
 #define __ASM_MPSPEC_H
 
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <asm/mpspec_def.h>
 #include <mach_mpspec.h>
 
diff -Nru a/include/asm-i386/smp.h b/include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-i386/smp.h	Mon Dec 15 00:04:43 2003
@@ -8,7 +8,7 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/threads.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
diff -Nru a/include/asm-i386/topology.h b/include/asm-i386/topology.h
--- a/include/asm-i386/topology.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-i386/topology.h	Mon Dec 15 00:04:43 2003
@@ -31,7 +31,7 @@
 
 #include <asm/mpspec.h>
 
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 
 /* Mappings between logical cpu number and node number */
 extern cpumask_t node_2_cpu_mask[];
diff -Nru a/include/asm-ia64/cpumask.h b/include/asm-ia64/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ia64/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_IA64_CPUMASK_H
+#define _ASM_IA64_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_IA64_CPUMASK_H */
diff -Nru a/include/asm-ia64/numa.h b/include/asm-ia64/numa.h
--- a/include/asm-ia64/numa.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-ia64/numa.h	Mon Dec 15 00:04:43 2003
@@ -17,7 +17,7 @@
 
 #include <linux/cache.h>
 #include <linux/cache.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <linux/numa.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
diff -Nru a/include/asm-ia64/smp.h b/include/asm-ia64/smp.h
--- a/include/asm-ia64/smp.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-ia64/smp.h	Mon Dec 15 00:04:43 2003
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 
 #include <asm/bitops.h>
 #include <asm/io.h>
diff -Nru a/include/asm-m68k/cpumask.h b/include/asm-m68k/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-m68k/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_M68K_CPUMASK_H
+#define _ASM_M68K_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_M68K_CPUMASK_H */
diff -Nru a/include/asm-m68knommu/cpumask.h b/include/asm-m68knommu/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-m68knommu/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_M68KNOMMU_CPUMASK_H
+#define _ASM_M68KNOMMU_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_M68KNOMMU_CPUMASK_H */
diff -Nru a/include/asm-mips/cpumask.h b/include/asm-mips/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-mips/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_MIPS_CPUMASK_H
+#define _ASM_MIPS_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_MIPS_CPUMASK_H */
diff -Nru a/include/asm-mips/smp.h b/include/asm-mips/smp.h
--- a/include/asm-mips/smp.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-mips/smp.h	Mon Dec 15 00:04:43 2003
@@ -17,7 +17,7 @@
 
 #include <linux/bitops.h>
 #include <linux/threads.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <asm/atomic.h>
 
 #define smp_processor_id()	(current_thread_info()->cpu)
diff -Nru a/include/asm-parisc/cpumask.h b/include/asm-parisc/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-parisc/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_PARISC_CPUMASK_H
+#define _ASM_PARISC_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_PARISC_CPUMASK_H */
diff -Nru a/include/asm-parisc/smp.h b/include/asm-parisc/smp.h
--- a/include/asm-parisc/smp.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-parisc/smp.h	Mon Dec 15 00:04:43 2003
@@ -14,7 +14,7 @@
 #ifndef ASSEMBLY
 #include <linux/bitops.h>
 #include <linux/threads.h>	/* for NR_CPUS */
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 typedef unsigned long address_t;
 
 extern cpumask_t cpu_online_map;
diff -Nru a/include/asm-ppc/cpumask.h b/include/asm-ppc/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ppc/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_PPC_CPUMASK_H
+#define _ASM_PPC_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_PPC_CPUMASK_H */
diff -Nru a/include/asm-ppc/smp.h b/include/asm-ppc/smp.h
--- a/include/asm-ppc/smp.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-ppc/smp.h	Mon Dec 15 00:04:43 2003
@@ -14,7 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <linux/threads.h>
 
 #ifdef CONFIG_SMP
diff -Nru a/include/asm-ppc64/cpumask.h b/include/asm-ppc64/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ppc64/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_PPC64_CPUMASK_H
+#define _ASM_PPC64_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_PPC64_CPUMASK_H */
diff -Nru a/include/asm-ppc64/smp.h b/include/asm-ppc64/smp.h
--- a/include/asm-ppc64/smp.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-ppc64/smp.h	Mon Dec 15 00:04:43 2003
@@ -19,7 +19,7 @@
 
 #include <linux/config.h>
 #include <linux/threads.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <linux/kernel.h>
 
 #ifdef CONFIG_SMP
diff -Nru a/include/asm-s390/cpumask.h b/include/asm-s390/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-s390/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_S390_CPUMASK_H
+#define _ASM_S390_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_S390_CPUMASK_H */
diff -Nru a/include/asm-s390/smp.h b/include/asm-s390/smp.h
--- a/include/asm-s390/smp.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-s390/smp.h	Mon Dec 15 00:04:43 2003
@@ -11,7 +11,7 @@
 
 #include <linux/config.h>
 #include <linux/threads.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <linux/bitops.h>
 
 #if defined(__KERNEL__) && defined(CONFIG_SMP) && !defined(__ASSEMBLY__)
diff -Nru a/include/asm-sh/cpumask.h b/include/asm-sh/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-sh/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_SH_CPUMASK_H
+#define _ASM_SH_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_SH_CPUMASK_H */
diff -Nru a/include/asm-sparc/cpumask.h b/include/asm-sparc/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-sparc/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_SPARC_CPUMASK_H
+#define _ASM_SPARC_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_SPARC_CPUMASK_H */
diff -Nru a/include/asm-sparc/smp.h b/include/asm-sparc/smp.h
--- a/include/asm-sparc/smp.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-sparc/smp.h	Mon Dec 15 00:04:43 2003
@@ -13,7 +13,7 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 
 /* PROM provided per-processor information we need
  * to start them all up.
diff -Nru a/include/asm-sparc64/cpumask.h b/include/asm-sparc64/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-sparc64/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_SPARC64_CPUMASK_H
+#define _ASM_SPARC64_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_SPARC64_CPUMASK_H */
diff -Nru a/include/asm-sparc64/smp.h b/include/asm-sparc64/smp.h
--- a/include/asm-sparc64/smp.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-sparc64/smp.h	Mon Dec 15 00:04:43 2003
@@ -14,7 +14,7 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <linux/cache.h>
 
 #endif /* !(__ASSEMBLY__) */
diff -Nru a/include/asm-um/cpumask.h b/include/asm-um/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-um/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_UM_CPUMASK_H
+#define _ASM_UM_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_UM_CPUMASK_H */
diff -Nru a/include/asm-um/smp.h b/include/asm-um/smp.h
--- a/include/asm-um/smp.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-um/smp.h	Mon Dec 15 00:04:43 2003
@@ -6,7 +6,7 @@
 #include "linux/config.h"
 #include "linux/bitops.h"
 #include "asm/current.h"
-#include "linux/cpumask.h"
+#include "asm/cpumask.h"
 
 extern cpumask_t cpu_online_map;
 
diff -Nru a/include/asm-v850/cpumask.h b/include/asm-v850/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-v850/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_V850_CPUMASK_H
+#define _ASM_V850_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_V850_CPUMASK_H */
diff -Nru a/include/asm-x86_64/cpumask.h b/include/asm-x86_64/cpumask.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-x86_64/cpumask.h	Mon Dec 15 00:04:43 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_X86_64_CPUMASK_H
+#define _ASM_X86_64_CPUMASK_H
+
+#include <asm-generic/cpumask.h>
+
+#endif /* _ASM_X86_64_CPUMASK_H */
diff -Nru a/include/asm-x86_64/smp.h b/include/asm-x86_64/smp.h
--- a/include/asm-x86_64/smp.h	Mon Dec 15 00:04:43 2003
+++ b/include/asm-x86_64/smp.h	Mon Dec 15 00:04:43 2003
@@ -7,7 +7,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/config.h>
 #include <linux/threads.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <linux/bitops.h>
 extern int disable_apic;
 #endif
diff -Nru a/include/linux/cpumask.h b/include/linux/cpumask.h
--- a/include/linux/cpumask.h	Mon Dec 15 00:04:43 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,71 +0,0 @@
-#ifndef __LINUX_CPUMASK_H
-#define __LINUX_CPUMASK_H
-
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/threads.h>
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
-
-#ifdef CONFIG_SMP
-
-extern cpumask_t cpu_online_map;
-
-#define num_online_cpus()		cpus_weight(cpu_online_map)
-#define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
-#else
-#define	cpu_online_map			cpumask_of_cpu(0)
-#define num_online_cpus()		1
-#define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
-#endif
-
-static inline int next_online_cpu(int cpu, cpumask_t map)
-{
-	do
-		cpu = next_cpu_const(cpu, map);
-	while (cpu < NR_CPUS && !cpu_online(cpu));
-	return cpu;
-}
-
-#define for_each_cpu(cpu, map)						\
-	for (cpu = first_cpu_const(map);				\
-		cpu < NR_CPUS;						\
-		cpu = next_cpu_const(cpu,map))
-
-#define for_each_online_cpu(cpu, map)					\
-	for (cpu = first_cpu_const(map);				\
-		cpu < NR_CPUS;						\
-		cpu = next_online_cpu(cpu,map))
-
-#endif /* __LINUX_CPUMASK_H */
diff -Nru a/include/linux/irq.h b/include/linux/irq.h
--- a/include/linux/irq.h	Mon Dec 15 00:04:43 2003
+++ b/include/linux/irq.h	Mon Dec 15 00:04:43 2003
@@ -15,7 +15,7 @@
 
 #include <linux/cache.h>
 #include <linux/spinlock.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 
 #include <asm/irq.h>
 #include <asm/ptrace.h>
diff -Nru a/include/linux/node.h b/include/linux/node.h
--- a/include/linux/node.h	Mon Dec 15 00:04:43 2003
+++ b/include/linux/node.h	Mon Dec 15 00:04:43 2003
@@ -20,7 +20,7 @@
 #define _LINUX_NODE_H_
 
 #include <linux/sysdev.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 
 struct node {
 	cpumask_t cpumap;	/* Bitmap of CPUs on the Node */
diff -Nru a/include/linux/rcupdate.h b/include/linux/rcupdate.h
--- a/include/linux/rcupdate.h	Mon Dec 15 00:04:43 2003
+++ b/include/linux/rcupdate.h	Mon Dec 15 00:04:43 2003
@@ -40,7 +40,7 @@
 #include <linux/spinlock.h>
 #include <linux/threads.h>
 #include <linux/percpu.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 
 /**
  * struct rcu_head - callback structure for use with RCU
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Mon Dec 15 00:04:43 2003
+++ b/include/linux/sched.h	Mon Dec 15 00:04:43 2003
@@ -12,7 +12,7 @@
 #include <linux/jiffies.h>
 #include <linux/rbtree.h>
 #include <linux/thread_info.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
diff -Nru a/include/linux/topology.h b/include/linux/topology.h
--- a/include/linux/topology.h	Mon Dec 15 00:04:43 2003
+++ b/include/linux/topology.h	Mon Dec 15 00:04:43 2003
@@ -27,7 +27,7 @@
 #ifndef _LINUX_TOPOLOGY_H
 #define _LINUX_TOPOLOGY_H
 
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <linux/bitops.h>
 #include <linux/mmzone.h>
 #include <linux/smp.h>
diff -Nru a/net/core/flow.c b/net/core/flow.c
--- a/net/core/flow.c	Mon Dec 15 00:04:43 2003
+++ b/net/core/flow.c	Mon Dec 15 00:04:43 2003
@@ -19,7 +19,7 @@
 #include <linux/bitops.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
-#include <linux/cpumask.h>
+#include <asm/cpumask.h>
 #include <net/flow.h>
 #include <asm/atomic.h>
 #include <asm/semaphore.h>


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
