Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbUAMNTr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 08:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUAMNTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 08:19:47 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:33234 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S264257AbUAMNTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 08:19:45 -0500
To: David Mosberger <davidm@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@sgi.com>,
       Jack Steiner <steiner@sgi.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch] ia64 header cleanup
From: Jes Sorensen <jes@wildopensource.com>
Date: 13 Jan 2004 08:13:11 -0500
In-Reply-To: <200401120924.06881.bjorn.helgaas@hp.com>
Message-ID: <yq0brp8ouu0.fsf_-_@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I fixed the code to compile with CONFIG_ACPI_NUMA and
!CONFIG_DISCONTIG since it's actually possible to compile that
configuration as well as cleaned up the #include usage a litte.

Patch relative to 2.6.1 - I'd like to suggest it as a candidate for
2.6.2.

Thanks,
Jes

diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-jb-acpi-clean/arch/ia64/mm/numa.c linux-2.6.1-test/arch/ia64/mm/numa.c
--- orig/linux-2.6.1-jb-acpi-clean/arch/ia64/mm/numa.c	Wed Dec 17 18:58:38 2003
+++ linux-2.6.1-test/arch/ia64/mm/numa.c	Mon Jan 12 06:54:38 2004
@@ -18,6 +18,7 @@
 #include <linux/node.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <asm/mmzone.h>
 #include <asm/numa.h>
 
 static struct memblk *sysfs_memblks;
@@ -28,7 +29,7 @@
  * The following structures are usually initialized by ACPI or
  * similar mechanisms and describe the NUMA characteristics of the machine.
  */
-int num_memblks = 0;
+int num_memblks;
 struct node_memblk_s node_memblk[NR_MEMBLKS];
 struct node_cpuid_s node_cpuid[NR_CPUS];
 /*
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-jb-acpi-clean/include/asm-ia64/acpi.h linux-2.6.1-test/include/asm-ia64/acpi.h
--- orig/linux-2.6.1-jb-acpi-clean/include/asm-ia64/acpi.h	Sun Jan 11 07:00:36 2004
+++ linux-2.6.1-test/include/asm-ia64/acpi.h	Mon Jan 12 07:20:13 2004
@@ -30,6 +30,8 @@
 
 #ifdef __KERNEL__
 
+#include <linux/init.h>
+#include <linux/numa.h>
 #include <asm/system.h>
 
 #define COMPILER_DEPENDENT_INT64	long
@@ -92,7 +94,6 @@
 int acpi_irq_to_vector (u32 irq);
 
 #ifdef CONFIG_ACPI_NUMA
-#include <asm/numa.h>
 /* Proximity bitmap length; _PXM is at most 255 (8 bit)*/
 #define MAX_PXM_DOMAINS (256)
 extern int __initdata pxm_to_nid_map[MAX_PXM_DOMAINS];
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-jb-acpi-clean/include/asm-ia64/mmzone.h linux-2.6.1-test/include/asm-ia64/mmzone.h
--- orig/linux-2.6.1-jb-acpi-clean/include/asm-ia64/mmzone.h	Wed Dec 17 19:00:01 2003
+++ linux-2.6.1-test/include/asm-ia64/mmzone.h	Mon Jan 12 07:09:14 2004
@@ -33,5 +33,8 @@
 #define page_to_pfn(page)	((unsigned long) (page - vmem_map))
 #define pfn_to_page(pfn)	(vmem_map + (pfn))
 
+#else /* CONFIG_DISCONTIGMEM */
+#define NR_MEMBLKS		1
+
 #endif /* CONFIG_DISCONTIGMEM */
 #endif /* _ASM_IA64_MMZONE_H */
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-jb-acpi-clean/include/asm-ia64/numa.h linux-2.6.1-test/include/asm-ia64/numa.h
--- orig/linux-2.6.1-jb-acpi-clean/include/asm-ia64/numa.h	Sun Jan 11 07:00:36 2004
+++ linux-2.6.1-test/include/asm-ia64/numa.h	Mon Jan 12 06:56:51 2004
@@ -16,7 +16,6 @@
 #ifdef CONFIG_NUMA
 
 #include <linux/cache.h>
-#include <linux/cache.h>
 #include <linux/cpumask.h>
 #include <linux/numa.h>
 #include <linux/smp.h>
