Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUDHTwT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUDHTwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:52:03 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:5092 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262182AbUDHTt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:49:58 -0400
Date: Thu, 8 Apr 2004 12:49:21 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 6c/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408124921.6517e05a.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P6c.remove_old_cpumask_files - Remove 26 no longer used cpumask headers.
	With the cpumask rewrite in the previous patch, these
	various include/asm-*/cpumask*.h headers are no longer used.

Index: 2.6.5.bitmap/include/asm-alpha/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-alpha/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-alpha/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_ALPHA_CPUMASK_H
-#define _ASM_ALPHA_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_ALPHA_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-arm/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-arm/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-arm/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_ARM_CPUMASK_H
-#define _ASM_ARM_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_ARM_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-arm26/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-arm26/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-arm26/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_ARM26_CPUMASK_H
-#define _ASM_ARM26_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_ARM26_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-cris/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-cris/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-cris/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_CRIS_CPUMASK_H
-#define _ASM_CRIS_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_CRIS_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-generic/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-generic/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-generic/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,40 +0,0 @@
-#ifndef __ASM_GENERIC_CPUMASK_H
-#define __ASM_GENERIC_CPUMASK_H
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
-#endif /* __ASM_GENERIC_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-generic/cpumask_arith.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-generic/cpumask_arith.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-generic/cpumask_arith.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,49 +0,0 @@
-#ifndef __ASM_GENERIC_CPUMASK_ARITH_H
-#define __ASM_GENERIC_CPUMASK_ARITH_H
-
-/*
- * Arithmetic type -based cpu bitmaps. A single unsigned long is used
- * to contain the whole cpu bitmap.
- */
-
-#define cpu_set(cpu, map)		set_bit(cpu, &(map))
-#define cpu_clear(cpu, map)		clear_bit(cpu, &(map))
-#define cpu_isset(cpu, map)		test_bit(cpu, &(map))
-#define cpu_test_and_set(cpu, map)	test_and_set_bit(cpu, &(map))
-
-#define cpus_and(dst,src1,src2)		do { dst = (src1) & (src2); } while (0)
-#define cpus_or(dst,src1,src2)		do { dst = (src1) | (src2); } while (0)
-#define cpus_clear(map)			do { map = 0; } while (0)
-#define cpus_complement(map)		do { map = ~(map); } while (0)
-#define cpus_equal(map1, map2)		((map1) == (map2))
-#define cpus_empty(map)			((map) == 0)
-#define cpus_addr(map)			(&(map))
-
-#if BITS_PER_LONG == 32
-#define cpus_weight(map)		hweight32(map)
-#elif BITS_PER_LONG == 64
-#define cpus_weight(map)		hweight64(map)
-#endif
-
-#define cpus_shift_right(dst, src, n)	do { dst = (src) >> (n); } while (0)
-#define cpus_shift_left(dst, src, n)	do { dst = (src) << (n); } while (0)
-
-#define any_online_cpu(map)			\
-({						\
-	cpumask_t __tmp__;			\
-	cpus_and(__tmp__, map, cpu_online_map);	\
-	__tmp__ ? first_cpu(__tmp__) : NR_CPUS;	\
-})
-
-#define CPU_MASK_ALL	(~((cpumask_t)0) >> (8*sizeof(cpumask_t) - NR_CPUS))
-#define CPU_MASK_NONE	((cpumask_t)0)
-
-/* only ever use this for things that are _never_ used on large boxen */
-#define cpus_coerce(map)		((unsigned long)(map))
-#define cpus_promote(map)		({ map; })
-#define cpumask_of_cpu(cpu)		({ ((cpumask_t)1) << (cpu); })
-
-#define first_cpu(map)			__ffs(map)
-#define next_cpu(cpu, map)		find_next_bit(&(map), NR_CPUS, cpu + 1)
-
-#endif /* __ASM_GENERIC_CPUMASK_ARITH_H */
Index: 2.6.5.bitmap/include/asm-generic/cpumask_array.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-generic/cpumask_array.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-generic/cpumask_array.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,54 +0,0 @@
-#ifndef __ASM_GENERIC_CPUMASK_ARRAY_H
-#define __ASM_GENERIC_CPUMASK_ARRAY_H
-
-/*
- * Array-based cpu bitmaps. An array of unsigned longs is used to contain
- * the bitmap, and then contained in a structure so it may be passed by
- * value.
- */
-
-#define CPU_ARRAY_SIZE		BITS_TO_LONGS(NR_CPUS)
-
-#define cpu_set(cpu, map)		set_bit(cpu, (map).mask)
-#define cpu_clear(cpu, map)		clear_bit(cpu, (map).mask)
-#define cpu_isset(cpu, map)		test_bit(cpu, (map).mask)
-#define cpu_test_and_set(cpu, map)	test_and_set_bit(cpu, (map).mask)
-
-#define cpus_and(dst,src1,src2)	bitmap_and((dst).mask,(src1).mask, (src2).mask, NR_CPUS)
-#define cpus_or(dst,src1,src2)	bitmap_or((dst).mask, (src1).mask, (src2).mask, NR_CPUS)
-#define cpus_clear(map)		bitmap_clear((map).mask, NR_CPUS)
-#define cpus_complement(map)	bitmap_complement((map).mask, (map).mask, NR_CPUS)
-#define cpus_equal(map1, map2)	bitmap_equal((map1).mask, (map2).mask, NR_CPUS)
-#define cpus_empty(map)		bitmap_empty(map.mask, NR_CPUS)
-#define cpus_addr(map)		((map).mask)
-#define cpus_weight(map)		bitmap_weight((map).mask, NR_CPUS)
-#define cpus_shift_right(d, s, n)	bitmap_shift_right((d).mask, (s).mask, n, NR_CPUS)
-#define cpus_shift_left(d, s, n)	bitmap_shift_left((d).mask, (s).mask, n, NR_CPUS)
-#define first_cpu(map)		find_first_bit((map).mask, NR_CPUS)
-#define next_cpu(cpu, map)	find_next_bit((map).mask, NR_CPUS, cpu + 1)
-
-/* only ever use this for things that are _never_ used on large boxen */
-#define cpus_coerce(map)	((map).mask[0])
-#define cpus_promote(map)	({ cpumask_t __cpu_mask = CPU_MASK_NONE;\
-					__cpu_mask.mask[0] = map;	\
-					__cpu_mask;			\
-				})
-#define cpumask_of_cpu(cpu)	({ cpumask_t __cpu_mask = CPU_MASK_NONE;\
-					cpu_set(cpu, __cpu_mask);	\
-					__cpu_mask;			\
-				})
-#define any_online_cpu(map)			\
-({						\
-	cpumask_t __tmp__;			\
-	cpus_and(__tmp__, map, cpu_online_map);	\
-	find_first_bit(__tmp__.mask, NR_CPUS);	\
-})
-
-
-/*
- * um, these need to be usable as static initializers
- */
-#define CPU_MASK_ALL	{ {[0 ... CPU_ARRAY_SIZE-1] = ~0UL} }
-#define CPU_MASK_NONE	{ {[0 ... CPU_ARRAY_SIZE-1] =  0UL} }
-
-#endif /* __ASM_GENERIC_CPUMASK_ARRAY_H */
Index: 2.6.5.bitmap/include/asm-generic/cpumask_const_reference.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-generic/cpumask_const_reference.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-generic/cpumask_const_reference.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,29 +0,0 @@
-#ifndef __ASM_GENERIC_CPUMASK_CONST_REFERENCE_H
-#define __ASM_GENERIC_CPUMASK_CONST_REFERENCE_H
-
-struct cpumask_ref {
-	const cpumask_t *val;
-};
-
-typedef const struct cpumask_ref cpumask_const_t;
-
-#define mk_cpumask_const(map)		((cpumask_const_t){ &(map) })
-#define cpu_isset_const(cpu, map)	cpu_isset(cpu, *(map).val)
-
-#define cpus_and_const(dst,src1,src2)	cpus_and(dst,*(src1).val,*(src2).val)
-#define cpus_or_const(dst,src1,src2)	cpus_or(dst,*(src1).val,*(src2).val)
-
-#define cpus_equal_const(map1, map2)	cpus_equal(*(map1).val, *(map2).val)
-
-#define cpus_copy_const(map1, map2)	bitmap_copy((map1).mask, (map2).val->mask, NR_CPUS)
-
-#define cpus_empty_const(map)		cpus_empty(*(map).val)
-#define cpus_weight_const(map)		cpus_weight(*(map).val)
-#define first_cpu_const(map)		first_cpu(*(map).val)
-#define next_cpu_const(cpu, map)	next_cpu(cpu, *(map).val)
-
-/* only ever use this for things that are _never_ used on large boxen */
-#define cpus_coerce_const(map)		cpus_coerce(*(map).val)
-#define any_online_cpu_const(map)	any_online_cpu(*(map).val)
-
-#endif /* __ASM_GENERIC_CPUMASK_CONST_REFERENCE_H */
Index: 2.6.5.bitmap/include/asm-generic/cpumask_const_value.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-generic/cpumask_const_value.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-generic/cpumask_const_value.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,21 +0,0 @@
-#ifndef __ASM_GENERIC_CPUMASK_CONST_VALUE_H
-#define __ASM_GENERIC_CPUMASK_CONST_VALUE_H
-
-typedef const cpumask_t cpumask_const_t;
-
-#define mk_cpumask_const(map)		(map)
-#define cpu_isset_const(cpu, map)	cpu_isset(cpu, map)
-#define cpus_and_const(dst,src1,src2)	cpus_and(dst, src1, src2)
-#define cpus_or_const(dst,src1,src2)	cpus_or(dst, src1, src2)
-#define cpus_equal_const(map1, map2)	cpus_equal(map1, map2)
-#define cpus_empty_const(map)		cpus_empty(map)
-#define cpus_copy_const(map1, map2)	do { map1 = (cpumask_t)map2; } while (0)
-#define cpus_weight_const(map)		cpus_weight(map)
-#define first_cpu_const(map)		first_cpu(map)
-#define next_cpu_const(cpu, map)	next_cpu(cpu, map)
-
-/* only ever use this for things that are _never_ used on large boxen */
-#define cpus_coerce_const(map)		cpus_coerce(map)
-#define any_online_cpu_const(map)	any_online_cpu(map)
-
-#endif /* __ASM_GENERIC_CPUMASK_CONST_VALUE_H */
Index: 2.6.5.bitmap/include/asm-generic/cpumask_up.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-generic/cpumask_up.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-generic/cpumask_up.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,59 +0,0 @@
-#ifndef __ASM_GENERIC_CPUMASK_UP_H
-#define __ASM_GENERIC_CPUMASK_UP_H
-
-#define cpus_coerce(map)	(map)
-
-#define cpu_set(cpu, map)		do { (void)(cpu); cpus_coerce(map) = 1UL; } while (0)
-#define cpu_clear(cpu, map)		do { (void)(cpu); cpus_coerce(map) = 0UL; } while (0)
-#define cpu_isset(cpu, map)		((void)(cpu), cpus_coerce(map) != 0UL)
-#define cpu_test_and_set(cpu, map)	((void)(cpu), test_and_set_bit(0, &(map)))
-
-#define cpus_and(dst, src1, src2)					\
-	do {								\
-		if (cpus_coerce(src1) && cpus_coerce(src2))		\
-			cpus_coerce(dst) = 1UL;				\
-		else							\
-			cpus_coerce(dst) = 0UL;				\
-	} while (0)
-
-#define cpus_or(dst, src1, src2)					\
-	do {								\
-		if (cpus_coerce(src1) || cpus_coerce(src2))		\
-			cpus_coerce(dst) = 1UL;				\
-		else							\
-			cpus_coerce(dst) = 0UL;				\
-	} while (0)
-
-#define cpus_clear(map)			do { cpus_coerce(map) = 0UL; } while (0)
-
-#define cpus_complement(map)						\
-	do {								\
-		cpus_coerce(map) = !cpus_coerce(map);			\
-	} while (0)
-
-#define cpus_equal(map1, map2)		(cpus_coerce(map1) == cpus_coerce(map2))
-#define cpus_empty(map)			(cpus_coerce(map) == 0UL)
-#define cpus_addr(map)			(&(map))
-#define cpus_weight(map)		(cpus_coerce(map) ? 1UL : 0UL)
-#define cpus_shift_right(d, s, n)	do { cpus_coerce(d) = 0UL; } while (0)
-#define cpus_shift_left(d, s, n)	do { cpus_coerce(d) = 0UL; } while (0)
-#define first_cpu(map)			(cpus_coerce(map) ? 0 : 1)
-#define next_cpu(cpu, map)		1
-
-/* only ever use this for things that are _never_ used on large boxen */
-#define cpus_promote(map)						\
-	({								\
-		cpumask_t __tmp__;					\
-		cpus_coerce(__tmp__) = map;				\
-		__tmp__;						\
-	})
-#define cpumask_of_cpu(cpu)		((void)(cpu), cpus_promote(1))
-#define any_online_cpu(map)		(cpus_coerce(map) ? 0 : 1)
-
-/*
- * um, these need to be usable as static initializers
- */
-#define CPU_MASK_ALL	1UL
-#define CPU_MASK_NONE	0UL
-
-#endif /* __ASM_GENERIC_CPUMASK_UP_H */
Index: 2.6.5.bitmap/include/asm-h8300/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-h8300/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-h8300/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_H8300_CPUMASK_H
-#define _ASM_H8300_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_H8300_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-i386/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-i386/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-i386/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_I386_CPUMASK_H
-#define _ASM_I386_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_I386_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-m68k/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-m68k/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-m68k/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_M68K_CPUMASK_H
-#define _ASM_M68K_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_M68K_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-m68knommu/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-m68knommu/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-m68knommu/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_M68KNOMMU_CPUMASK_H
-#define _ASM_M68KNOMMU_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_M68KNOMMU_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-mips/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-mips/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-mips/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_MIPS_CPUMASK_H
-#define _ASM_MIPS_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_MIPS_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-parisc/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-parisc/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-parisc/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_PARISC_CPUMASK_H
-#define _ASM_PARISC_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_PARISC_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-ppc/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-ppc/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-ppc/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_PPC_CPUMASK_H
-#define _ASM_PPC_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_PPC_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-ppc64/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-ppc64/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-ppc64/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_PPC64_CPUMASK_H
-#define _ASM_PPC64_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_PPC64_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-s390/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-s390/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-s390/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_S390_CPUMASK_H
-#define _ASM_S390_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_S390_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-sh/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-sh/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-sh/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_SH_CPUMASK_H
-#define _ASM_SH_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_SH_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-sparc/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-sparc/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-sparc/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_SPARC_CPUMASK_H
-#define _ASM_SPARC_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_SPARC_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-sparc64/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-sparc64/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-sparc64/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_SPARC64_CPUMASK_H
-#define _ASM_SPARC64_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_SPARC64_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-um/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-um/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-um/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_UM_CPUMASK_H
-#define _ASM_UM_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_UM_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-v850/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-v850/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-v850/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_V850_CPUMASK_H
-#define _ASM_V850_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_V850_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-x86_64/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-x86_64/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-x86_64/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_X86_64_CPUMASK_H
-#define _ASM_X86_64_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_X86_64_CPUMASK_H */
Index: 2.6.5.bitmap/include/asm-ia64/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-ia64/cpumask.h	2004-04-08 01:08:17.000000000 -0700
+++ 2.6.5.bitmap/include/asm-ia64/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_IA64_CPUMASK_H
-#define _ASM_IA64_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_IA64_CPUMASK_H */


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
