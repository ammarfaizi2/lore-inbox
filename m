Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269623AbUJGBsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269623AbUJGBsc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 21:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269629AbUJGBsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 21:48:32 -0400
Received: from fmr03.intel.com ([143.183.121.5]:48839 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S269623AbUJGBr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 21:47:58 -0400
Date: Wed, 6 Oct 2004 18:47:23 -0700
From: Suresh Siddha <suresh.b.siddha@intel.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: davej@redhat.com, ak@suse.de
Subject: [Patch] share i386/x86_64 intel cache descriptors table
Message-ID: <20041006184723.A10900@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some cache descriptors are missing from x86_64 table. So instead of
copying from i386 code, here is a patch to share the table between i386 and
x86_64.

thanks,
suresh
--

Share i386/x86_64 intel cache descriptors table and corresponding code.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>


diff -Nru linux-2.6.9-rc3/arch/i386/kernel/cpu/intel.c linux/arch/i386/kernel/cpu/intel.c
--- linux-2.6.9-rc3/arch/i386/kernel/cpu/intel.c	2004-09-29 20:04:24.000000000 -0700
+++ linux/arch/i386/kernel/cpu/intel.c	2004-09-11 15:45:30.000000000 -0700
@@ -56,62 +56,6 @@
 	return 0;
 }
 	
-#define LVL_1_INST	1
-#define LVL_1_DATA	2
-#define LVL_2		3
-#define LVL_3		4
-#define LVL_TRACE	5
-
-struct _cache_table
-{
-	unsigned char descriptor;
-	char cache_type;
-	short size;
-};
-
-/* all the cache descriptor types we care about (no TLB or trace cache entries) */
-static struct _cache_table cache_table[] __initdata =
-{
-	{ 0x06, LVL_1_INST, 8 },	/* 4-way set assoc, 32 byte line size */
-	{ 0x08, LVL_1_INST, 16 },	/* 4-way set assoc, 32 byte line size */
-	{ 0x0a, LVL_1_DATA, 8 },	/* 2 way set assoc, 32 byte line size */
-	{ 0x0c, LVL_1_DATA, 16 },	/* 4-way set assoc, 32 byte line size */
-	{ 0x22, LVL_3,      512 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x23, LVL_3,      1024 },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x25, LVL_3,      2048 },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x29, LVL_3,      4096 },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x2c, LVL_1_DATA, 32 },	/* 8-way set assoc, 64 byte line size */
-	{ 0x30, LVL_1_INST, 32 },	/* 8-way set assoc, 64 byte line size */
-	{ 0x39, LVL_2,      128 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3b, LVL_2,      128 },	/* 2-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3c, LVL_2,      256 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x41, LVL_2,      128 },	/* 4-way set assoc, 32 byte line size */
-	{ 0x42, LVL_2,      256 },	/* 4-way set assoc, 32 byte line size */
-	{ 0x43, LVL_2,      512 },	/* 4-way set assoc, 32 byte line size */
-	{ 0x44, LVL_2,      1024 },	/* 4-way set assoc, 32 byte line size */
-	{ 0x45, LVL_2,      2048 },	/* 4-way set assoc, 32 byte line size */
-	{ 0x60, LVL_1_DATA, 16 },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x66, LVL_1_DATA, 8 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x67, LVL_1_DATA, 16 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x68, LVL_1_DATA, 32 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x70, LVL_TRACE,  12 },	/* 8-way set assoc */
-	{ 0x71, LVL_TRACE,  16 },	/* 8-way set assoc */
-	{ 0x72, LVL_TRACE,  32 },	/* 8-way set assoc */
-	{ 0x78, LVL_2,    1024 },	/* 4-way set assoc, 64 byte line size */
-	{ 0x79, LVL_2,     128 },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7a, LVL_2,     256 },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7b, LVL_2,     512 },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7c, LVL_2,    1024 },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7d, LVL_2,    2048 },	/* 8-way set assoc, 64 byte line size */
-	{ 0x7f, LVL_2,     512 },	/* 2-way set assoc, 64 byte line size */
-	{ 0x82, LVL_2,     256 },	/* 8-way set assoc, 32 byte line size */
-	{ 0x83, LVL_2,     512 },	/* 8-way set assoc, 32 byte line size */
-	{ 0x84, LVL_2,    1024 },	/* 8-way set assoc, 32 byte line size */
-	{ 0x85, LVL_2,    2048 },	/* 8-way set assoc, 32 byte line size */
-	{ 0x86, LVL_2,     512 },	/* 4-way set assoc, 64 byte line size */
-	{ 0x87, LVL_2,    1024 },	/* 8-way set assoc, 64 byte line size */
-	{ 0x00, 0, 0}
-};
 
 /*
  * P4 Xeon errata 037 workaround.
@@ -135,8 +79,8 @@
 
 static void __init init_intel(struct cpuinfo_x86 *c)
 {
+	unsigned int l2 = 0;
 	char *p = NULL;
-	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
 
 #ifdef CONFIG_X86_F00F_BUG
 	/*
@@ -158,79 +102,7 @@
 #endif
 
 	select_idle_routine(c);
-	if (c->cpuid_level > 1) {
-		/* supports eax=2  call */
-		int i, j, n;
-		int regs[4];
-		unsigned char *dp = (unsigned char *)regs;
-
-		/* Number of times to iterate */
-		n = cpuid_eax(2) & 0xFF;
-
-		for ( i = 0 ; i < n ; i++ ) {
-			cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
-			
-			/* If bit 31 is set, this is an unknown format */
-			for ( j = 0 ; j < 3 ; j++ ) {
-				if ( regs[j] < 0 ) regs[j] = 0;
-			}
-
-			/* Byte 0 is level count, not a descriptor */
-			for ( j = 1 ; j < 16 ; j++ ) {
-				unsigned char des = dp[j];
-				unsigned char k = 0;
-
-				/* look up this descriptor in the table */
-				while (cache_table[k].descriptor != 0)
-				{
-					if (cache_table[k].descriptor == des) {
-						switch (cache_table[k].cache_type) {
-						case LVL_1_INST:
-							l1i += cache_table[k].size;
-							break;
-						case LVL_1_DATA:
-							l1d += cache_table[k].size;
-							break;
-						case LVL_2:
-							l2 += cache_table[k].size;
-							break;
-						case LVL_3:
-							l3 += cache_table[k].size;
-							break;
-						case LVL_TRACE:
-							trace += cache_table[k].size;
-							break;
-						}
-
-						break;
-					}
-
-					k++;
-				}
-			}
-		}
-
-		if ( trace )
-			printk (KERN_INFO "CPU: Trace cache: %dK uops", trace);
-		else if ( l1i )
-			printk (KERN_INFO "CPU: L1 I cache: %dK", l1i);
-		if ( l1d )
-			printk(", L1 D cache: %dK\n", l1d);
-		else
-			printk("\n");
-		if ( l2 )
-			printk(KERN_INFO "CPU: L2 cache: %dK\n", l2);
-		if ( l3 )
-			printk(KERN_INFO "CPU: L3 cache: %dK\n", l3);
-
-		/*
-		 * This assumes the L3 cache is shared; it typically lives in
-		 * the northbridge.  The L1 caches are included by the L2
-		 * cache, and so should not be included for the purpose of
-		 * SMP switching weights.
-		 */
-		c->x86_cache_size = l2 ? l2 : (l1i+l1d);
-	}
+	l2 = init_intel_cacheinfo(c);
 
 	/* SEP CPUID bug: Pentium Pro reports SEP but doesn't have it until model 3 mask 3 */
 	if ((c->x86<<8 | c->x86_model<<4 | c->x86_mask) < 0x633)
diff -Nru linux-2.6.9-rc3/arch/i386/kernel/cpu/intel_cacheinfo.c linux/arch/i386/kernel/cpu/intel_cacheinfo.c
--- linux-2.6.9-rc3/arch/i386/kernel/cpu/intel_cacheinfo.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/arch/i386/kernel/cpu/intel_cacheinfo.c	2004-09-11 15:44:53.000000000 -0700
@@ -0,0 +1,140 @@
+#include <linux/init.h>
+#include <asm/processor.h>
+
+#define LVL_1_INST	1
+#define LVL_1_DATA	2
+#define LVL_2		3
+#define LVL_3		4
+#define LVL_TRACE	5
+
+struct _cache_table
+{
+	unsigned char descriptor;
+	char cache_type;
+	short size;
+};
+
+/* all the cache descriptor types we care about (no TLB or trace cache entries) */
+static struct _cache_table cache_table[] __initdata =
+{
+	{ 0x06, LVL_1_INST, 8 },	/* 4-way set assoc, 32 byte line size */
+	{ 0x08, LVL_1_INST, 16 },	/* 4-way set assoc, 32 byte line size */
+	{ 0x0a, LVL_1_DATA, 8 },	/* 2 way set assoc, 32 byte line size */
+	{ 0x0c, LVL_1_DATA, 16 },	/* 4-way set assoc, 32 byte line size */
+	{ 0x22, LVL_3,      512 },	/* 4-way set assoc, sectored cache, 64 byte line size */
+	{ 0x23, LVL_3,      1024 },	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x25, LVL_3,      2048 },	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x29, LVL_3,      4096 },	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x2c, LVL_1_DATA, 32 },	/* 8-way set assoc, 64 byte line size */
+	{ 0x30, LVL_1_INST, 32 },	/* 8-way set assoc, 64 byte line size */
+	{ 0x39, LVL_2,      128 },	/* 4-way set assoc, sectored cache, 64 byte line size */
+	{ 0x3b, LVL_2,      128 },	/* 2-way set assoc, sectored cache, 64 byte line size */
+	{ 0x3c, LVL_2,      256 },	/* 4-way set assoc, sectored cache, 64 byte line size */
+	{ 0x41, LVL_2,      128 },	/* 4-way set assoc, 32 byte line size */
+	{ 0x42, LVL_2,      256 },	/* 4-way set assoc, 32 byte line size */
+	{ 0x43, LVL_2,      512 },	/* 4-way set assoc, 32 byte line size */
+	{ 0x44, LVL_2,      1024 },	/* 4-way set assoc, 32 byte line size */
+	{ 0x45, LVL_2,      2048 },	/* 4-way set assoc, 32 byte line size */
+	{ 0x60, LVL_1_DATA, 16 },	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x66, LVL_1_DATA, 8 },	/* 4-way set assoc, sectored cache, 64 byte line size */
+	{ 0x67, LVL_1_DATA, 16 },	/* 4-way set assoc, sectored cache, 64 byte line size */
+	{ 0x68, LVL_1_DATA, 32 },	/* 4-way set assoc, sectored cache, 64 byte line size */
+	{ 0x70, LVL_TRACE,  12 },	/* 8-way set assoc */
+	{ 0x71, LVL_TRACE,  16 },	/* 8-way set assoc */
+	{ 0x72, LVL_TRACE,  32 },	/* 8-way set assoc */
+	{ 0x78, LVL_2,    1024 },	/* 4-way set assoc, 64 byte line size */
+	{ 0x79, LVL_2,     128 },	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x7a, LVL_2,     256 },	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x7b, LVL_2,     512 },	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x7c, LVL_2,    1024 },	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x7d, LVL_2,    2048 },	/* 8-way set assoc, 64 byte line size */
+	{ 0x7f, LVL_2,     512 },	/* 2-way set assoc, 64 byte line size */
+	{ 0x82, LVL_2,     256 },	/* 8-way set assoc, 32 byte line size */
+	{ 0x83, LVL_2,     512 },	/* 8-way set assoc, 32 byte line size */
+	{ 0x84, LVL_2,    1024 },	/* 8-way set assoc, 32 byte line size */
+	{ 0x85, LVL_2,    2048 },	/* 8-way set assoc, 32 byte line size */
+	{ 0x86, LVL_2,     512 },	/* 4-way set assoc, 64 byte line size */
+	{ 0x87, LVL_2,    1024 },	/* 8-way set assoc, 64 byte line size */
+	{ 0x00, 0, 0}
+};
+
+unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c)
+{
+	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
+
+	if (c->cpuid_level > 1) {
+		/* supports eax=2  call */
+		int i, j, n;
+		int regs[4];
+		unsigned char *dp = (unsigned char *)regs;
+
+		/* Number of times to iterate */
+		n = cpuid_eax(2) & 0xFF;
+
+		for ( i = 0 ; i < n ; i++ ) {
+			cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
+			
+			/* If bit 31 is set, this is an unknown format */
+			for ( j = 0 ; j < 3 ; j++ ) {
+				if ( regs[j] < 0 ) regs[j] = 0;
+			}
+
+			/* Byte 0 is level count, not a descriptor */
+			for ( j = 1 ; j < 16 ; j++ ) {
+				unsigned char des = dp[j];
+				unsigned char k = 0;
+
+				/* look up this descriptor in the table */
+				while (cache_table[k].descriptor != 0)
+				{
+					if (cache_table[k].descriptor == des) {
+						switch (cache_table[k].cache_type) {
+						case LVL_1_INST:
+							l1i += cache_table[k].size;
+							break;
+						case LVL_1_DATA:
+							l1d += cache_table[k].size;
+							break;
+						case LVL_2:
+							l2 += cache_table[k].size;
+							break;
+						case LVL_3:
+							l3 += cache_table[k].size;
+							break;
+						case LVL_TRACE:
+							trace += cache_table[k].size;
+							break;
+						}
+
+						break;
+					}
+
+					k++;
+				}
+			}
+		}
+
+		if ( trace )
+			printk (KERN_INFO "CPU: Trace cache: %dK uops", trace);
+		else if ( l1i )
+			printk (KERN_INFO "CPU: L1 I cache: %dK", l1i);
+		if ( l1d )
+			printk(", L1 D cache: %dK\n", l1d);
+		else
+			printk("\n");
+		if ( l2 )
+			printk(KERN_INFO "CPU: L2 cache: %dK\n", l2);
+		if ( l3 )
+			printk(KERN_INFO "CPU: L3 cache: %dK\n", l3);
+
+		/*
+		 * This assumes the L3 cache is shared; it typically lives in
+		 * the northbridge.  The L1 caches are included by the L2
+		 * cache, and so should not be included for the purpose of
+		 * SMP switching weights.
+		 */
+		c->x86_cache_size = l2 ? l2 : (l1i+l1d);
+	}
+	
+	return l2;
+}
diff -Nru linux-2.6.9-rc3/arch/i386/kernel/cpu/Makefile linux/arch/i386/kernel/cpu/Makefile
--- linux-2.6.9-rc3/arch/i386/kernel/cpu/Makefile	2004-09-29 20:04:57.000000000 -0700
+++ linux/arch/i386/kernel/cpu/Makefile	2004-09-11 23:23:31.197386752 -0700
@@ -8,7 +8,7 @@
 obj-y	+=	cyrix.o
 obj-y	+=	centaur.o
 obj-y	+=	transmeta.o
-obj-y	+=	intel.o
+obj-y	+=	intel.o intel_cacheinfo.o
 obj-y	+=	rise.o
 obj-y	+=	nexgen.o
 obj-y	+=	umc.o
diff -Nru linux-2.6.9-rc3/arch/x86_64/kernel/Makefile linux/arch/x86_64/kernel/Makefile
--- linux-2.6.9-rc3/arch/x86_64/kernel/Makefile	2004-09-29 20:05:21.000000000 -0700
+++ linux/arch/x86_64/kernel/Makefile	2004-09-11 23:23:50.453459384 -0700
@@ -29,9 +29,11 @@
 obj-$(CONFIG_MODULES)		+= module.o
 
 obj-y				+= topology.o
+obj-y				+= intel_cacheinfo.o
 
 bootflag-y			+= ../../i386/kernel/bootflag.o
 cpuid-$(subst m,y,$(CONFIG_X86_CPUID))  += ../../i386/kernel/cpuid.o
 topology-y                     += ../../i386/mach-default/topology.o
 swiotlb-$(CONFIG_SWIOTLB)      += ../../ia64/lib/swiotlb.o
 microcode-$(subst m,y,$(CONFIG_MICROCODE))  += ../../i386/kernel/microcode.o
+intel_cacheinfo-y		+= ../../i386/kernel/cpu/intel_cacheinfo.o
diff -Nru linux-2.6.9-rc3/arch/x86_64/kernel/setup.c linux/arch/x86_64/kernel/setup.c
--- linux-2.6.9-rc3/arch/x86_64/kernel/setup.c	2004-09-29 20:03:49.000000000 -0700
+++ linux/arch/x86_64/kernel/setup.c	2004-09-11 14:29:20.000000000 -0700
@@ -754,134 +754,12 @@
 #endif
 }
 	
-#define LVL_1_INST	1
-#define LVL_1_DATA	2
-#define LVL_2		3
-#define LVL_3		4
-#define LVL_TRACE	5
-
-struct _cache_table
-{
-	unsigned char descriptor;
-	char cache_type;
-	short size;
-};
-
-/* all the cache descriptor types we care about (no TLB or trace cache entries) */
-static struct _cache_table cache_table[] __initdata =
-{
-	{ 0x06, LVL_1_INST, 8 },
-	{ 0x08, LVL_1_INST, 16 },
-	{ 0x0a, LVL_1_DATA, 8 },
-	{ 0x0c, LVL_1_DATA, 16 },
-	{ 0x22, LVL_3,      512 },
-	{ 0x23, LVL_3,      1024 },
-	{ 0x25, LVL_3,      2048 },
-	{ 0x29, LVL_3,      4096 },
-	{ 0x2c, LVL_1_DATA, 32 },
-	{ 0x30, LVL_1_INST, 32 },
-	{ 0x39, LVL_2,      128 },
-	{ 0x3b, LVL_2,      128 },
-	{ 0x3c, LVL_2,      256 },
-	{ 0x41, LVL_2,      128 },
-	{ 0x42, LVL_2,      256 },
-	{ 0x43, LVL_2,      512 },
-	{ 0x44, LVL_2,      1024 },
-	{ 0x45, LVL_2,      2048 },
-	{ 0x60, LVL_1_DATA, 16 },
-	{ 0x66, LVL_1_DATA, 8 },
-	{ 0x67, LVL_1_DATA, 16 },
-	{ 0x68, LVL_1_DATA, 32 },
-	{ 0x70, LVL_TRACE,  12 },
-	{ 0x71, LVL_TRACE,  16 },
-	{ 0x72, LVL_TRACE,  32 },
-	{ 0x79, LVL_2,      128 },
-	{ 0x7a, LVL_2,      256 },
-	{ 0x7b, LVL_2,      512 },
-	{ 0x7c, LVL_2,      1024 },
-	{ 0x82, LVL_2,      256 },
-	{ 0x83, LVL_2,      512 },
-	{ 0x84, LVL_2,      1024 },
-	{ 0x85, LVL_2,      2048 },
-	{ 0x86, LVL_2,      512 },
-	{ 0x87, LVL_2,      1024 },
-	{ 0x00, 0, 0}
-};
-
 static void __init init_intel(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
-	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0; 
 	unsigned n;
 
-	if (c->cpuid_level > 1) {
-		/* supports eax=2  call */
-		int i, j, n;
-		int regs[4];
-		unsigned char *dp = (unsigned char *)regs;
-
-		/* Number of times to iterate */
-		n = cpuid_eax(2) & 0xFF;
-
-		for ( i = 0 ; i < n ; i++ ) {
-			cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
-			
-			/* If bit 31 is set, this is an unknown format */
-			for ( j = 0 ; j < 3 ; j++ ) {
-				if ( regs[j] < 0 ) regs[j] = 0;
-			}
-
-			/* Byte 0 is level count, not a descriptor */
-			for ( j = 1 ; j < 16 ; j++ ) {
-				unsigned char des = dp[j];
-				unsigned char k = 0;
-
-				/* look up this descriptor in the table */
-				while (cache_table[k].descriptor != 0)
-				{
-					if (cache_table[k].descriptor == des) {
-						switch (cache_table[k].cache_type) {
-						case LVL_1_INST:
-							l1i += cache_table[k].size;
-							break;
-						case LVL_1_DATA:
-							l1d += cache_table[k].size;
-							break;
-						case LVL_2:
-							l2 += cache_table[k].size;
-							break;
-						case LVL_3:
-							l3 += cache_table[k].size;
-							break;
-						case LVL_TRACE:
-							trace += cache_table[k].size;
-							break;
-						}
-
-						break;
-					}
-
-					k++;
-				}
-			}
-		}
-
-		if (trace)
-			printk (KERN_INFO "CPU: Trace cache: %dK uops", trace);
-		else if (l1i)
-			printk (KERN_INFO "CPU: L1 I cache: %dK", l1i);
-		if (l1d)
-			printk(", L1 D cache: %dK\n", l1d);
-		else
-			printk("\n"); 
-		if (l2)
-			printk(KERN_INFO "CPU: L2 cache: %dK\n", l2);
-		if (l3)
-			printk(KERN_INFO "CPU: L3 cache: %dK\n", l3);
-
-		c->x86_cache_size = l2 ? l2 : (l1i+l1d);
-	}
-
+	init_intel_cacheinfo(c);
 	n = cpuid_eax(0x80000000);
 	if (n >= 0x80000008) {
 		unsigned eax = cpuid_eax(0x80000008);
diff -Nru linux-2.6.9-rc3/include/asm-i386/processor.h linux/include/asm-i386/processor.h
--- linux-2.6.9-rc3/include/asm-i386/processor.h	2004-09-29 20:03:49.000000000 -0700
+++ linux/include/asm-i386/processor.h	2004-09-11 15:46:27.000000000 -0700
@@ -100,6 +100,7 @@
 
 extern void identify_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
+extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern void dodgy_tsc(void);
 
 /*
diff -Nru linux-2.6.9-rc3/include/asm-x86_64/processor.h linux/include/asm-x86_64/processor.h
--- linux-2.6.9-rc3/include/asm-x86_64/processor.h	2004-09-29 20:05:52.000000000 -0700
+++ linux/include/asm-x86_64/processor.h	2004-09-11 22:57:17.782582160 -0700
@@ -90,6 +90,7 @@
 
 extern void identify_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
+extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern void dodgy_tsc(void);
 
 /*
