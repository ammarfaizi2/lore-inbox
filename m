Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbUAAUyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264964AbUAAUxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:53:53 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.16]:19809 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S264929AbUAAUDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:41 -0500
Date: Thu, 1 Jan 2004 21:03:35 +0100
Message-Id: <200401012003.i01K3ZIK031932@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 383] M68k extern inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k core: Replace (variants of) `extern inline' by `static inline'

--- linux-2.6.0/arch/m68k/kernel/traps.c	2003-10-19 16:22:28.000000000 +0200
+++ linux-m68k-2.6.0/arch/m68k/kernel/traps.c	2003-11-23 20:59:33.000000000 +0100
@@ -447,7 +448,7 @@
 
 /* sun3 version of bus_error030 */
 
-extern inline void bus_error030 (struct frame *fp)
+static inline void bus_error030 (struct frame *fp)
 {
 	unsigned char buserr_type = sun3_get_buserr ();
 	unsigned long addr, errorcode;
--- linux-2.6.0/arch/m68k/math-emu/multi_arith.h	2002-04-01 13:00:29.000000000 +0200
+++ linux-m68k-2.6.0/arch/m68k/math-emu/multi_arith.h	2003-11-23 21:02:35.000000000 +0100
@@ -38,17 +38,14 @@
 
 /* Convenience functions to stuff various integer values into int128s */
 
-extern inline void zero128(int128 a)
+static inline void zero128(int128 a)
 {
 	a[LSW128] = a[NLSW128] = a[NMSW128] = a[MSW128] = 0;
 }
 
 /* Human-readable word order in the arguments */
-extern inline void set128(unsigned int i3,
-			  unsigned int i2,
-			  unsigned int i1,
-			  unsigned int i0,
-			  int128 a)
+static inline void set128(unsigned int i3, unsigned int i2, unsigned int i1,
+			  unsigned int i0, int128 a)
 {
 	a[LSW128] = i0;
 	a[NLSW128] = i1;
@@ -57,21 +54,19 @@
 }
 
 /* Convenience functions (for testing as well) */
-extern inline void int64_to_128(unsigned long long src,
-				int128 dest)
+static inline void int64_to_128(unsigned long long src, int128 dest)
 {
 	dest[LSW128] = (unsigned int) src;
 	dest[NLSW128] = src >> 32;
 	dest[NMSW128] = dest[MSW128] = 0;
 }
 
-extern inline void int128_to_64(const int128 src,
-				unsigned long long *dest)
+static inline void int128_to_64(const int128 src, unsigned long long *dest)
 {
 	*dest = src[LSW128] | (long long) src[NLSW128] << 32;
 }
 
-extern inline void put_i128(const int128 a)
+static inline void put_i128(const int128 a)
 {
 	printk("%08x %08x %08x %08x\n", a[MSW128], a[NMSW128],
 	       a[NLSW128], a[LSW128]);
@@ -82,7 +77,7 @@
    Note that these are only good for 0 < count < 32.
  */
 
-extern inline void _lsl128(unsigned int count, int128 a)
+static inline void _lsl128(unsigned int count, int128 a)
 {
 	a[MSW128] = (a[MSW128] << count) | (a[NMSW128] >> (32 - count));
 	a[NMSW128] = (a[NMSW128] << count) | (a[NLSW128] >> (32 - count));
@@ -90,7 +85,7 @@
 	a[LSW128] <<= count;
 }
 
-extern inline void _lsr128(unsigned int count, int128 a)
+static inline void _lsr128(unsigned int count, int128 a)
 {
 	a[LSW128] = (a[LSW128] >> count) | (a[NLSW128] << (32 - count));
 	a[NLSW128] = (a[NLSW128] >> count) | (a[NMSW128] << (32 - count));
@@ -100,7 +95,7 @@
 
 /* Should be faster, one would hope */
 
-extern inline void lslone128(int128 a)
+static inline void lslone128(int128 a)
 {
 	asm volatile ("lsl.l #1,%0\n"
 		      "roxl.l #1,%1\n"
@@ -118,7 +113,7 @@
 		      "3"(a[MSW128]));
 }
 
-extern inline void lsrone128(int128 a)
+static inline void lsrone128(int128 a)
 {
 	asm volatile ("lsr.l #1,%0\n"
 		      "roxr.l #1,%1\n"
@@ -140,7 +135,7 @@
 
    These bit-shift to a multiple of 32, then move whole longwords.  */
 
-extern inline void lsl128(unsigned int count, int128 a)
+static inline void lsl128(unsigned int count, int128 a)
 {
 	int wordcount, i;
 
@@ -159,7 +154,7 @@
 	}
 }
 
-extern inline void lsr128(unsigned int count, int128 a)
+static inline void lsr128(unsigned int count, int128 a)
 {
 	int wordcount, i;
 
@@ -177,18 +172,18 @@
 	}
 }
 
-extern inline int orl128(int a, int128 b)
+static inline int orl128(int a, int128 b)
 {
 	b[LSW128] |= a;
 }
 
-extern inline int btsthi128(const int128 a)
+static inline int btsthi128(const int128 a)
 {
 	return a[MSW128] & 0x80000000;
 }
 
 /* test bits (numbered from 0 = LSB) up to and including "top" */
-extern inline int bftestlo128(int top, const int128 a)
+static inline int bftestlo128(int top, const int128 a)
 {
 	int r = 0;
 
@@ -206,7 +201,7 @@
 
 /* Aargh.  We need these because GCC is broken */
 /* FIXME: do them in assembly, for goodness' sake! */
-extern inline void mask64(int pos, unsigned long long *mask)
+static inline void mask64(int pos, unsigned long long *mask)
 {
 	*mask = 0;
 
@@ -218,7 +213,7 @@
 	HI_WORD(*mask) = (1 << (pos - 32)) - 1;
 }
 
-extern inline void bset64(int pos, unsigned long long *dest)
+static inline void bset64(int pos, unsigned long long *dest)
 {
 	/* This conditional will be optimized away.  Thanks, GCC! */
 	if (pos < 32)
@@ -229,7 +224,7 @@
 			      (HI_WORD(*dest)):"id"(pos - 32));
 }
 
-extern inline int btst64(int pos, unsigned long long dest)
+static inline int btst64(int pos, unsigned long long dest)
 {
 	if (pos < 32)
 		return (0 != (LO_WORD(dest) & (1 << pos)));
@@ -237,7 +232,7 @@
 		return (0 != (HI_WORD(dest) & (1 << (pos - 32))));
 }
 
-extern inline void lsl64(int count, unsigned long long *dest)
+static inline void lsl64(int count, unsigned long long *dest)
 {
 	if (count < 32) {
 		HI_WORD(*dest) = (HI_WORD(*dest) << count)
@@ -250,7 +245,7 @@
 	LO_WORD(*dest) = 0;
 }
 
-extern inline void lsr64(int count, unsigned long long *dest)
+static inline void lsr64(int count, unsigned long long *dest)
 {
 	if (count < 32) {
 		LO_WORD(*dest) = (LO_WORD(*dest) >> count)
@@ -264,7 +259,7 @@
 }
 #endif
 
-extern inline void fp_denormalize(struct fp_ext *reg, unsigned int cnt)
+static inline void fp_denormalize(struct fp_ext *reg, unsigned int cnt)
 {
 	reg->exp += cnt;
 
@@ -306,7 +301,7 @@
 	}
 }
 
-extern inline int fp_overnormalize(struct fp_ext *reg)
+static inline int fp_overnormalize(struct fp_ext *reg)
 {
 	int shift;
 
@@ -324,7 +319,7 @@
 	return shift;
 }
 
-extern inline int fp_addmant(struct fp_ext *dest, struct fp_ext *src)
+static inline int fp_addmant(struct fp_ext *dest, struct fp_ext *src)
 {
 	int carry;
 
@@ -340,7 +335,7 @@
 	return carry;
 }
 
-extern inline int fp_addcarry(struct fp_ext *reg)
+static inline int fp_addcarry(struct fp_ext *reg)
 {
 	if (++reg->exp == 0x7fff) {
 		if (reg->mant.m64)
@@ -357,7 +352,8 @@
 	return 1;
 }
 
-extern inline void fp_submant(struct fp_ext *dest, struct fp_ext *src1, struct fp_ext *src2)
+static inline void fp_submant(struct fp_ext *dest, struct fp_ext *src1,
+			      struct fp_ext *src2)
 {
 	/* we assume here, gcc only insert move and a clr instr */
 	asm volatile ("sub.b %1,%0" : "=d,g" (dest->lowmant)
@@ -407,7 +403,8 @@
 	carry;								\
 })
 
-extern inline void fp_multiplymant(union fp_mant128 *dest, struct fp_ext *src1, struct fp_ext *src2)
+static inline void fp_multiplymant(union fp_mant128 *dest, struct fp_ext *src1,
+				   struct fp_ext *src2)
 {
 	union fp_mant64 temp;
 
@@ -421,7 +418,8 @@
 	fp_addx96(dest, temp);
 }
 
-extern inline void fp_dividemant(union fp_mant128 *dest, struct fp_ext *src, struct fp_ext *div)
+static inline void fp_dividemant(union fp_mant128 *dest, struct fp_ext *src,
+				 struct fp_ext *div)
 {
 	union fp_mant128 tmp;
 	union fp_mant64 tmp64;
@@ -484,7 +482,7 @@
 }
 
 #if 0
-extern inline unsigned int fp_fls128(union fp_mant128 *src)
+static inline unsigned int fp_fls128(union fp_mant128 *src)
 {
 	unsigned long data;
 	unsigned int res, off;
@@ -504,7 +502,7 @@
 	return res + off;
 }
 
-extern inline void fp_shiftmant128(union fp_mant128 *src, int shift)
+static inline void fp_shiftmant128(union fp_mant128 *src, int shift)
 {
 	unsigned long sticky;
 
@@ -594,7 +592,8 @@
 }
 #endif
 
-extern inline void fp_putmant128(struct fp_ext *dest, union fp_mant128 *src, int shift)
+static inline void fp_putmant128(struct fp_ext *dest, union fp_mant128 *src,
+				 int shift)
 {
 	unsigned long tmp;
 
@@ -639,7 +638,7 @@
 }
 
 #if 0 /* old code... */
-extern inline int fls(unsigned int a)
+static inline int fls(unsigned int a)
 {
 	int r;
 
@@ -649,7 +648,7 @@
 }
 
 /* fls = "find last set" (cf. ffs(3)) */
-extern inline int fls128(const int128 a)
+static inline int fls128(const int128 a)
 {
 	if (a[MSW128])
 		return fls(a[MSW128]);
@@ -668,12 +667,12 @@
 		return -1;
 }
 
-extern inline int zerop128(const int128 a)
+static inline int zerop128(const int128 a)
 {
 	return !(a[LSW128] | a[NLSW128] | a[NMSW128] | a[MSW128]);
 }
 
-extern inline int nonzerop128(const int128 a)
+static inline int nonzerop128(const int128 a)
 {
 	return (a[LSW128] | a[NLSW128] | a[NMSW128] | a[MSW128]);
 }
@@ -681,7 +680,7 @@
 /* Addition and subtraction */
 /* Do these in "pure" assembly, because "extended" asm is unmanageable
    here */
-extern inline void add128(const int128 a, int128 b)
+static inline void add128(const int128 a, int128 b)
 {
 	/* rotating carry flags */
 	unsigned int carry[2];
@@ -699,7 +698,7 @@
 }
 
 /* Note: assembler semantics: "b -= a" */
-extern inline void sub128(const int128 a, int128 b)
+static inline void sub128(const int128 a, int128 b)
 {
 	/* rotating borrow flags */
 	unsigned int borrow[2];
@@ -717,9 +716,7 @@
 }
 
 /* Poor man's 64-bit expanding multiply */
-extern inline void mul64(unsigned long long a,
-		  unsigned long long b,
-		  int128 c)
+static inline void mul64(unsigned long long a, unsigned long long b, int128 c)
 {
 	unsigned long long acc;
 	int128 acc128;
@@ -756,7 +753,7 @@
 }
 
 /* Note: unsigned */
-extern inline int cmp128(int128 a, int128 b)
+static inline int cmp128(int128 a, int128 b)
 {
 	if (a[MSW128] < b[MSW128])
 		return -1;
--- linux-2.6.0/include/asm-m68k/atariints.h	1997-04-24 04:01:27.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/atariints.h	2003-11-23 17:54:26.000000000 +0100
@@ -180,14 +180,14 @@
  * "stored"
  */
 
-extern inline void atari_turnon_irq( unsigned irq )
+static inline void atari_turnon_irq( unsigned irq )
 
 {
 	if (irq < STMFP_SOURCE_BASE || irq >= SCC_SOURCE_BASE) return;
 	set_mfp_bit( irq, MFP_ENABLE );
 }
 
-extern inline void atari_turnoff_irq( unsigned irq )
+static inline void atari_turnoff_irq( unsigned irq )
 
 {
 	if (irq < STMFP_SOURCE_BASE || irq >= SCC_SOURCE_BASE) return;
@@ -195,14 +195,14 @@
 	clear_mfp_bit( irq, MFP_PENDING );
 }
 
-extern inline void atari_clear_pending_irq( unsigned irq )
+static inline void atari_clear_pending_irq( unsigned irq )
 
 {
 	if (irq < STMFP_SOURCE_BASE || irq >= SCC_SOURCE_BASE) return;
 	clear_mfp_bit( irq, MFP_PENDING );
 }
 
-extern inline int atari_irq_pending( unsigned irq )
+static inline int atari_irq_pending( unsigned irq )
 
 {
 	if (irq < STMFP_SOURCE_BASE || irq >= SCC_SOURCE_BASE) return( 0 );
--- linux-2.6.0/include/asm-m68k/bitops.h	2003-09-19 15:50:33.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/bitops.h	2003-11-23 17:57:23.000000000 +0100
@@ -21,7 +21,8 @@
    __constant_test_and_set_bit(nr, vaddr) : \
    __generic_test_and_set_bit(nr, vaddr))
 
-extern __inline__ int __constant_test_and_set_bit(int nr,volatile unsigned long * vaddr)
+static inline int __constant_test_and_set_bit(int nr,
+					      volatile unsigned long *vaddr)
 {
 	char retval;
 
@@ -32,7 +33,8 @@
 	return retval;
 }
 
-extern __inline__ int __generic_test_and_set_bit(int nr,volatile unsigned long * vaddr)
+static inline int __generic_test_and_set_bit(int nr,
+					     volatile unsigned long *vaddr)
 {
 	char retval;
 
@@ -49,13 +51,13 @@
 
 #define __set_bit(nr,vaddr) set_bit(nr,vaddr) 
 
-extern __inline__ void __constant_set_bit(int nr, volatile unsigned long * vaddr)
+static inline void __constant_set_bit(int nr, volatile unsigned long *vaddr)
 {
 	__asm__ __volatile__ ("bset %1,%0"
 	     : "+m" (((volatile char *)vaddr)[(nr^31) >> 3]) : "di" (nr & 7));
 }
 
-extern __inline__ void __generic_set_bit(int nr, volatile unsigned long * vaddr)
+static inline void __generic_set_bit(int nr, volatile unsigned long *vaddr)
 {
 	__asm__ __volatile__ ("bfset %1@{%0:#1}"
 	     : : "d" (nr^31), "a" (vaddr) : "memory");
@@ -68,7 +70,8 @@
 
 #define __test_and_clear_bit(nr,vaddr) test_and_clear_bit(nr,vaddr)
 
-extern __inline__ int __constant_test_and_clear_bit(int nr, volatile unsigned long * vaddr)
+static inline int __constant_test_and_clear_bit(int nr,
+						volatile unsigned long *vaddr)
 {
 	char retval;
 
@@ -79,7 +82,8 @@
 	return retval;
 }
 
-extern __inline__ int __generic_test_and_clear_bit(int nr, volatile unsigned long * vaddr)
+static inline int __generic_test_and_clear_bit(int nr,
+					       volatile unsigned long *vaddr)
 {
 	char retval;
 
@@ -101,13 +105,13 @@
    __generic_clear_bit(nr, vaddr))
 #define __clear_bit(nr,vaddr) clear_bit(nr,vaddr)
 
-extern __inline__ void __constant_clear_bit(int nr, volatile unsigned long * vaddr)
+static inline void __constant_clear_bit(int nr, volatile unsigned long *vaddr)
 {
 	__asm__ __volatile__ ("bclr %1,%0"
 	     : "+m" (((volatile char *)vaddr)[(nr^31) >> 3]) : "di" (nr & 7));
 }
 
-extern __inline__ void __generic_clear_bit(int nr, volatile unsigned long * vaddr)
+static inline void __generic_clear_bit(int nr, volatile unsigned long *vaddr)
 {
 	__asm__ __volatile__ ("bfclr %1@{%0:#1}"
 	     : : "d" (nr^31), "a" (vaddr) : "memory");
@@ -121,7 +125,8 @@
 #define __test_and_change_bit(nr,vaddr) test_and_change_bit(nr,vaddr)
 #define __change_bit(nr,vaddr) change_bit(nr,vaddr)
 
-extern __inline__ int __constant_test_and_change_bit(int nr, volatile unsigned long * vaddr)
+static inline int __constant_test_and_change_bit(int nr,
+						 volatile unsigned long *vaddr)
 {
 	char retval;
 
@@ -132,7 +137,8 @@
 	return retval;
 }
 
-extern __inline__ int __generic_test_and_change_bit(int nr, volatile unsigned long * vaddr)
+static inline int __generic_test_and_change_bit(int nr,
+						volatile unsigned long *vaddr)
 {
 	char retval;
 
@@ -147,25 +153,25 @@
    __constant_change_bit(nr, vaddr) : \
    __generic_change_bit(nr, vaddr))
 
-extern __inline__ void __constant_change_bit(int nr, volatile unsigned long * vaddr)
+static inline void __constant_change_bit(int nr, volatile unsigned long *vaddr)
 {
 	__asm__ __volatile__ ("bchg %1,%0"
 	     : "+m" (((volatile char *)vaddr)[(nr^31) >> 3]) : "di" (nr & 7));
 }
 
-extern __inline__ void __generic_change_bit(int nr, volatile unsigned long * vaddr)
+static inline void __generic_change_bit(int nr, volatile unsigned long *vaddr)
 {
 	__asm__ __volatile__ ("bfchg %1@{%0:#1}"
 	     : : "d" (nr^31), "a" (vaddr) : "memory");
 }
 
-extern __inline__ int test_bit(int nr, const volatile unsigned long * vaddr)
+static inline int test_bit(int nr, const volatile unsigned long *vaddr)
 {
 	return ((1UL << (nr & 31)) & (((const volatile unsigned long *) vaddr)[nr >> 5])) != 0;
 }
 
-extern __inline__ int find_first_zero_bit(const unsigned long *vaddr,
-					  unsigned size)
+static inline int find_first_zero_bit(const unsigned long *vaddr,
+				      unsigned size)
 {
 	const unsigned long *p = vaddr, *addr = vaddr;
 	unsigned long allones = ~0UL;
@@ -188,8 +194,8 @@
 	return ((p - addr) << 5) + (res ^ 31);
 }
 
-extern __inline__ int find_next_zero_bit (const unsigned long *vaddr, int size,
-				      int offset)
+static inline int find_next_zero_bit(const unsigned long *vaddr, int size,
+				     int offset)
 {
 	const unsigned long *addr = vaddr;
 	const unsigned long *p = addr + (offset >> 5);
@@ -218,7 +224,7 @@
  * ffz = Find First Zero in word. Undefined if no zero exists,
  * so code should check against ~0UL first..
  */
-extern __inline__ unsigned long ffz(unsigned long word)
+static inline unsigned long ffz(unsigned long word)
 {
 	int res;
 
@@ -289,8 +295,7 @@
 
 /* Bitmap functions for the minix filesystem */
 
-extern __inline__ int
-minix_find_first_zero_bit (const void *vaddr, unsigned size)
+static inline int minix_find_first_zero_bit(const void *vaddr, unsigned size)
 {
 	const unsigned short *p = vaddr, *addr = vaddr;
 	int res;
@@ -312,8 +317,7 @@
 	return ((p - addr) << 4) + (res ^ 31);
 }
 
-extern __inline__ int
-minix_test_and_set_bit (int nr, volatile void *vaddr)
+static inline int minix_test_and_set_bit(int nr, volatile void *vaddr)
 {
 	char retval;
 
@@ -325,8 +329,7 @@
 
 #define minix_set_bit(nr,addr)	((void)minix_test_and_set_bit(nr,addr))
 
-extern __inline__ int
-minix_test_and_clear_bit (int nr, volatile void *vaddr)
+static inline int minix_test_and_clear_bit(int nr, volatile void *vaddr)
 {
 	char retval;
 
@@ -336,16 +339,14 @@
 	return retval;
 }
 
-extern __inline__ int
-minix_test_bit (int nr, const volatile void *vaddr)
+static inline int minix_test_bit(int nr, const volatile void *vaddr)
 {
 	return ((1U << (nr & 15)) & (((const volatile unsigned short *) vaddr)[nr >> 4])) != 0;
 }
 
 /* Bitmap functions for the ext2 filesystem. */
 
-extern __inline__ int
-ext2_set_bit (int nr, volatile void *vaddr)
+static inline int ext2_set_bit(int nr, volatile void *vaddr)
 {
 	char retval;
 
@@ -355,8 +356,7 @@
 	return retval;
 }
 
-extern __inline__ int
-ext2_clear_bit (int nr, volatile void *vaddr)
+static inline int ext2_clear_bit(int nr, volatile void *vaddr)
 {
 	char retval;
 
@@ -384,14 +384,12 @@
 		ret;					\
 	})
 
-extern __inline__ int
-ext2_test_bit (int nr, const volatile void *vaddr)
+static inline int ext2_test_bit(int nr, const volatile void *vaddr)
 {
 	return ((1U << (nr & 7)) & (((const volatile unsigned char *) vaddr)[nr >> 3])) != 0;
 }
 
-extern __inline__ int
-ext2_find_first_zero_bit (const void *vaddr, unsigned size)
+static inline int ext2_find_first_zero_bit(const void *vaddr, unsigned size)
 {
 	const unsigned long *p = vaddr, *addr = vaddr;
 	int res;
@@ -413,8 +411,8 @@
 	return (p - addr) * 32 + res;
 }
 
-extern __inline__ int
-ext2_find_next_zero_bit (const void *vaddr, unsigned size, unsigned offset)
+static inline int ext2_find_next_zero_bit(const void *vaddr, unsigned size,
+					  unsigned offset)
 {
 	const unsigned long *addr = vaddr;
 	const unsigned long *p = addr + (offset >> 5);
--- linux-2.6.0/include/asm-m68k/cacheflush.h	2003-10-26 14:52:21.000000000 +0100
+++ linux-m68k-2.6.0/include/asm-m68k/cacheflush.h	2003-11-23 17:57:33.000000000 +0100
@@ -83,7 +83,7 @@
 #define flush_cache_vmap(start, end)		flush_cache_all()
 #define flush_cache_vunmap(start, end)		flush_cache_all()
 
-extern inline void flush_cache_mm(struct mm_struct *mm)
+static inline void flush_cache_mm(struct mm_struct *mm)
 {
 	if (mm == current->mm)
 		__flush_cache_030();
@@ -91,7 +91,7 @@
 
 /* flush_cache_range/flush_cache_page must be macros to avoid
    a dependency on linux/mm.h, which includes this file... */
-extern inline void flush_cache_range(struct vm_area_struct *vma,
+static inline void flush_cache_range(struct vm_area_struct *vma,
 				     unsigned long start,
 				     unsigned long end)
 {
@@ -99,7 +99,7 @@
 	        __flush_cache_030();
 }
 
-extern inline void flush_cache_page(struct vm_area_struct *vma,
+static inline void flush_cache_page(struct vm_area_struct *vma,
 				    unsigned long vmaddr)
 {
  	if (vma->vm_mm == current->mm)
@@ -109,7 +109,7 @@
 
 /* Push the page at kernel virtual address and clear the icache */
 /* RZ: use cpush %bc instead of cpush %dc, cinv %ic */
-extern inline void __flush_page_to_ram(void *vaddr)
+static inline void __flush_page_to_ram(void *vaddr)
 {
 	if (CPU_IS_040_OR_060) {
 		__asm__ __volatile__("nop\n\t"
--- linux-2.6.0/include/asm-m68k/delay.h	2001-01-04 22:00:55.000000000 +0100
+++ linux-m68k-2.6.0/include/asm-m68k/delay.h	2003-11-23 17:57:45.000000000 +0100
@@ -9,7 +9,7 @@
  * Delay routines, using a pre-computed "loops_per_jiffy" value.
  */
 
-extern __inline__ void __delay(unsigned long loops)
+static inline void __delay(unsigned long loops)
 {
 	__asm__ __volatile__ ("1: subql #1,%0; jcc 1b"
 		: "=d" (loops) : "0" (loops));
@@ -43,7 +43,8 @@
 	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 4295)) : \
 	__udelay(n))
 
-extern __inline__ unsigned long muldiv(unsigned long a, unsigned long b, unsigned long c)
+static inline unsigned long muldiv(unsigned long a, unsigned long b,
+				   unsigned long c)
 {
 	unsigned long tmp;
 
--- linux-2.6.0/include/asm-m68k/dvma.h	2003-03-05 10:07:36.000000000 +0100
+++ linux-m68k-2.6.0/include/asm-m68k/dvma.h	2003-11-23 17:58:00.000000000 +0100
@@ -58,7 +58,8 @@
 #define dvma_vtob(x) dvma_vtop(x)
 #define dvma_btov(x) dvma_ptov(x)
 
-extern inline int dvma_map_cpu(unsigned long kaddr, unsigned long vaddr, int len)
+static inline int dvma_map_cpu(unsigned long kaddr, unsigned long vaddr,
+			       int len)
 {
 	return 0;
 }
--- linux-2.6.0/include/asm-m68k/io.h	2003-05-09 11:04:08.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/io.h	2003-11-23 17:58:11.000000000 +0100
@@ -285,20 +285,20 @@
 #endif /* CONFIG_PCI */
 
 
-extern inline void *ioremap(unsigned long physaddr, unsigned long size)
+static inline void *ioremap(unsigned long physaddr, unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
 }
-extern inline void *ioremap_nocache(unsigned long physaddr, unsigned long size)
+static inline void *ioremap_nocache(unsigned long physaddr, unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
 }
-extern inline void *ioremap_writethrough(unsigned long physaddr,
+static inline void *ioremap_writethrough(unsigned long physaddr,
 					 unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
 }
-extern inline void *ioremap_fullcache(unsigned long physaddr,
+static inline void *ioremap_fullcache(unsigned long physaddr,
 				      unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
--- linux-2.6.0/include/asm-m68k/mac_psc.h	2003-02-10 21:59:26.000000000 +0100
+++ linux-m68k-2.6.0/include/asm-m68k/mac_psc.h	2003-11-23 17:58:19.000000000 +0100
@@ -215,32 +215,32 @@
  *	Access functions
  */
  
-extern inline void psc_write_byte(int offset, __u8 data)
+static inline void psc_write_byte(int offset, __u8 data)
 {
 	*((volatile __u8 *)(psc + offset)) = data;
 }
 
-extern inline void psc_write_word(int offset, __u16 data)
+static inline void psc_write_word(int offset, __u16 data)
 {
 	*((volatile __u16 *)(psc + offset)) = data;
 }
 
-extern inline void psc_write_long(int offset, __u32 data)
+static inline void psc_write_long(int offset, __u32 data)
 {
 	*((volatile __u32 *)(psc + offset)) = data;
 }
 
-extern inline u8 psc_read_byte(int offset)
+static inline u8 psc_read_byte(int offset)
 {
 	return *((volatile __u8 *)(psc + offset));
 }
 
-extern inline u16 psc_read_word(int offset)
+static inline u16 psc_read_word(int offset)
 {
 	return *((volatile __u16 *)(psc + offset));
 }
 
-extern inline u32 psc_read_long(int offset)
+static inline u32 psc_read_long(int offset)
 {
 	return *((volatile __u32 *)(psc + offset));
 }
--- linux-2.6.0/include/asm-m68k/mac_via.h	2002-07-17 09:36:15.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/mac_via.h	2003-11-23 17:58:25.000000000 +0100
@@ -255,7 +255,8 @@
 extern int rbv_present,via_alt_mapping;
 extern __u8 rbv_clear;
 
-extern __inline__ int rbv_set_video_bpp(int bpp) {
+static inline int rbv_set_video_bpp(int bpp)
+{
 	char val = (bpp==1)?0:(bpp==2)?1:(bpp==4)?2:(bpp==8)?3:-1;
 	if (!rbv_present || val<0) return -1;
 	via2[rMonP] = (via2[rMonP] & ~RBV_DEPTH) | val;
--- linux-2.6.0/include/asm-m68k/mmu_context.h	2003-07-11 11:35:19.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/mmu_context.h	2003-11-23 17:58:43.000000000 +0100
@@ -13,8 +13,8 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 
-extern inline int
-init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+static inline int init_new_context(struct task_struct *tsk,
+				   struct mm_struct *mm)
 {
 	mm->context = virt_to_phys(mm->pgd);
 	return 0;
@@ -22,7 +22,7 @@
 
 #define destroy_context(mm)		do { } while(0)
 
-extern inline void switch_mm_0230(struct mm_struct *mm)
+static inline void switch_mm_0230(struct mm_struct *mm)
 {
 	unsigned long crp[2] = {
 		0x80000000 | _PAGE_TABLE, mm->context
@@ -55,7 +55,7 @@
 	asm volatile (".chip 68k");
 }
 
-extern inline void switch_mm_0460(struct mm_struct *mm)
+static inline void switch_mm_0460(struct mm_struct *mm)
 {
 	asm volatile (".chip 68040");
 
@@ -91,7 +91,7 @@
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
-extern inline void activate_mm(struct mm_struct *prev_mm,
+static inline void activate_mm(struct mm_struct *prev_mm,
 			       struct mm_struct *next_mm)
 {
 	next_mm->context = virt_to_phys(next_mm->pgd);
@@ -144,7 +144,7 @@
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
-extern inline void activate_mm(struct mm_struct *prev_mm,
+static inline void activate_mm(struct mm_struct *prev_mm,
 			       struct mm_struct *next_mm)
 {
 	activate_context(next_mm);
--- linux-2.6.0/include/asm-m68k/motorola_pgtable.h	2003-10-19 16:22:26.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/motorola_pgtable.h	2003-11-23 18:00:27.000000000 +0100
@@ -100,10 +100,13 @@
  */
 #define mk_pte(page, pgprot) pfn_pte(page_to_pfn(page), (pgprot))
 
-extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
-{ pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot); return pte; }
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+	pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot);
+	return pte;
+}
 
-extern inline void pmd_set(pmd_t * pmdp, pte_t * ptep)
+static inline void pmd_set(pmd_t *pmdp, pte_t *ptep)
 {
 	unsigned long ptbl = virt_to_phys(ptep) | _PAGE_TABLE | _PAGE_ACCESSED;
 	unsigned long *ptr = pmdp->pmd;
@@ -114,8 +117,10 @@
 	}
 }
 
-extern inline void pgd_set(pgd_t * pgdp, pmd_t * pmdp)
-{ pgd_val(*pgdp) = _PAGE_TABLE | _PAGE_ACCESSED | __pa(pmdp); }
+static inline void pgd_set(pgd_t *pgdp, pmd_t *pmdp)
+{
+	pgd_val(*pgdp) = _PAGE_TABLE | _PAGE_ACCESSED | __pa(pmdp);
+}
 
 #define __pte_page(pte) ((unsigned long)__va(pte_val(pte) & PAGE_MASK))
 #define __pmd_page(pmd) ((unsigned long)__va(pmd_val(pmd) & _TABLE_MASK))
@@ -159,36 +164,40 @@
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
-extern inline int pte_read(pte_t pte)		{ return 1; }
-extern inline int pte_write(pte_t pte)		{ return !(pte_val(pte) & _PAGE_RONLY); }
-extern inline int pte_exec(pte_t pte)		{ return 1; }
-extern inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
-extern inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
+static inline int pte_read(pte_t pte)		{ return 1; }
+static inline int pte_write(pte_t pte)		{ return !(pte_val(pte) & _PAGE_RONLY); }
+static inline int pte_exec(pte_t pte)		{ return 1; }
+static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
+static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
 static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
 
-extern inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) |= _PAGE_RONLY; return pte; }
-extern inline pte_t pte_rdprotect(pte_t pte)	{ return pte; }
-extern inline pte_t pte_exprotect(pte_t pte)	{ return pte; }
-extern inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~_PAGE_DIRTY; return pte; }
-extern inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
-extern inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) &= ~_PAGE_RONLY; return pte; }
-extern inline pte_t pte_mkread(pte_t pte)	{ return pte; }
-extern inline pte_t pte_mkexec(pte_t pte)	{ return pte; }
-extern inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= _PAGE_DIRTY; return pte; }
-extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= _PAGE_ACCESSED; return pte; }
-extern inline pte_t pte_mknocache(pte_t pte)
+static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) |= _PAGE_RONLY; return pte; }
+static inline pte_t pte_rdprotect(pte_t pte)	{ return pte; }
+static inline pte_t pte_exprotect(pte_t pte)	{ return pte; }
+static inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~_PAGE_DIRTY; return pte; }
+static inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
+static inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) &= ~_PAGE_RONLY; return pte; }
+static inline pte_t pte_mkread(pte_t pte)	{ return pte; }
+static inline pte_t pte_mkexec(pte_t pte)	{ return pte; }
+static inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= _PAGE_DIRTY; return pte; }
+static inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= _PAGE_ACCESSED; return pte; }
+static inline pte_t pte_mknocache(pte_t pte)
 {
 	pte_val(pte) = (pte_val(pte) & _CACHEMASK040) | m68k_pgtable_cachemode;
 	return pte;
 }
-extern inline pte_t pte_mkcache(pte_t pte)	{ pte_val(pte) = (pte_val(pte) & _CACHEMASK040) | m68k_supervisor_cachemode; return pte; }
+static inline pte_t pte_mkcache(pte_t pte)
+{
+	pte_val(pte) = (pte_val(pte) & _CACHEMASK040) | m68k_supervisor_cachemode;
+	return pte;
+}
 
 #define PAGE_DIR_OFFSET(tsk,address) pgd_offset((tsk),(address))
 
 #define pgd_index(address)     ((address) >> PGDIR_SHIFT)
 
 /* to find an entry in a page-table-directory */
-extern inline pgd_t * pgd_offset(struct mm_struct * mm, unsigned long address)
+static inline pgd_t *pgd_offset(struct mm_struct *mm, unsigned long address)
 {
 	return mm->pgd + pgd_index(address);
 }
@@ -196,20 +205,20 @@
 #define swapper_pg_dir kernel_pg_dir
 extern pgd_t kernel_pg_dir[128];
 
-extern inline pgd_t * pgd_offset_k(unsigned long address)
+static inline pgd_t *pgd_offset_k(unsigned long address)
 {
 	return kernel_pg_dir + (address >> PGDIR_SHIFT);
 }
 
 
 /* Find an entry in the second-level page table.. */
-extern inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
+static inline pmd_t *pmd_offset(pgd_t *dir, unsigned long address)
 {
 	return (pmd_t *)__pgd_page(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PMD-1));
 }
 
 /* Find an entry in the third-level page table.. */ 
-extern inline pte_t * pte_offset_kernel(pmd_t * pmdp, unsigned long address)
+static inline pte_t *pte_offset_kernel(pmd_t *pmdp, unsigned long address)
 {
 	return (pte_t *)__pmd_page(*pmdp) + ((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1));
 }
--- linux-2.6.0/include/asm-m68k/nubus.h	2002-11-05 10:10:13.000000000 +0100
+++ linux-m68k-2.6.0/include/asm-m68k/nubus.h	2003-11-23 18:00:35.000000000 +0100
@@ -15,25 +15,25 @@
 #define nubus_memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define nubus_memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
-extern inline void *nubus_remap_nocache_ser(unsigned long physaddr,
+static inline void *nubus_remap_nocache_ser(unsigned long physaddr,
 					    unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
 }
 
-extern inline void *nubus_remap_nocache_nonser(unsigned long physaddr,
+static inline void *nubus_remap_nocache_nonser(unsigned long physaddr,
 					       unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_NONSER);
 }
 
-extern inline void *nbus_remap_writethrough(unsigned long physaddr,
+static inline void *nbus_remap_writethrough(unsigned long physaddr,
 					    unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
 }
 
-extern inline void *nubus_remap_fullcache(unsigned long physaddr,
+static inline void *nubus_remap_fullcache(unsigned long physaddr,
 					  unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
--- linux-2.6.0/include/asm-m68k/page.h	2003-04-20 12:28:58.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/page.h	2003-11-23 18:00:42.000000000 +0100
@@ -110,7 +110,7 @@
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
 /* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
+static inline int get_order(unsigned long size)
 {
 	int order;
 
--- linux-2.6.0/include/asm-m68k/pci.h	2003-09-11 08:44:51.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/pci.h	2003-11-23 18:00:47.000000000 +0100
@@ -37,12 +37,12 @@
 
 #define pcibios_assign_all_busses()	0
 
-extern inline void pcibios_set_master(struct pci_dev *dev)
+static inline void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
 }
 
-extern inline void pcibios_penalize_isa_irq(int irq)
+static inline void pcibios_penalize_isa_irq(int irq)
 {
 	/* We don't do dynamic PCI IRQ allocation */
 }
--- linux-2.6.0/include/asm-m68k/pgtable.h	2003-10-09 10:03:12.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/pgtable.h	2003-11-23 18:01:02.000000000 +0100
@@ -114,7 +114,7 @@
  * It makes no sense to consider whether we cross a memory boundary if
  * we support just one physical chunk of memory.
  */
-extern inline int mm_end_of_chunk (unsigned long addr, int len)
+static inline int mm_end_of_chunk(unsigned long addr, int len)
 {
 	return 0;
 }
@@ -129,8 +129,8 @@
  * tables contain all the necessary information.  The Sun3 does, but
  * they are updated on demand.
  */
-extern inline void update_mmu_cache(struct vm_area_struct * vma,
-	unsigned long address, pte_t pte)
+static inline void update_mmu_cache(struct vm_area_struct *vma,
+				    unsigned long address, pte_t pte)
 {
 }
 
--- linux-2.6.0/include/asm-m68k/processor.h	2003-09-28 09:57:11.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/processor.h	2003-11-23 18:01:17.000000000 +0100
@@ -19,14 +19,16 @@
 #include <asm/fpu.h>
 #include <asm/ptrace.h>
 
-extern inline unsigned long rdusp(void) {
-  	unsigned long usp;
+static inline unsigned long rdusp(void)
+{
+	unsigned long usp;
 
 	__asm__ __volatile__("move %/usp,%0" : "=a" (usp));
 	return usp;
 }
 
-extern inline void wrusp(unsigned long usp) {
+static inline void wrusp(unsigned long usp)
+{
 	__asm__ __volatile__("move %0,%/usp" : : "a" (usp));
 }
 
--- linux-2.6.0/include/asm-m68k/sbus.h	2003-01-02 12:55:08.000000000 +0100
+++ linux-m68k-2.6.0/include/asm-m68k/sbus.h	2003-11-23 18:01:26.000000000 +0100
@@ -20,17 +20,17 @@
 /* sbus IO functions stolen from include/asm-sparc/io.h for the serial driver */
 /* No SBUS on the Sun3, kludge -- sam */
 
-extern inline void _sbus_writeb(unsigned char val, unsigned long addr)
+static inline void _sbus_writeb(unsigned char val, unsigned long addr)
 {
 	*(volatile unsigned char *)addr = val;
 }
 
-extern inline unsigned char _sbus_readb(unsigned long addr)
+static inline unsigned char _sbus_readb(unsigned long addr)
 {
 	return *(volatile unsigned char *)addr;
 }
 
-extern inline void _sbus_writel(unsigned long val, unsigned long addr)
+static inline void _sbus_writel(unsigned long val, unsigned long addr)
 {
 	*(volatile unsigned long *)addr = val;
 
--- linux-2.6.0/include/asm-m68k/semaphore.h	2003-09-09 10:13:32.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/semaphore.h	2003-11-23 18:01:47.000000000 +0100
@@ -52,7 +52,7 @@
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-extern inline void sema_init (struct semaphore *sem, int val)
+static inline void sema_init(struct semaphore *sem, int val)
 {
 	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER(*sem, val);
 }
@@ -82,7 +82,7 @@
  * "down_failed" is a special asm handler that calls the C
  * routine that actually waits. See arch/m68k/lib/semaphore.S
  */
-extern inline void down(struct semaphore * sem)
+static inline void down(struct semaphore *sem)
 {
 	register struct semaphore *sem1 __asm__ ("%a1") = sem;
 
@@ -104,7 +104,7 @@
 		: "memory");
 }
 
-extern inline int down_interruptible(struct semaphore * sem)
+static inline int down_interruptible(struct semaphore *sem)
 {
 	register struct semaphore *sem1 __asm__ ("%a1") = sem;
 	register int result __asm__ ("%d0");
@@ -129,7 +129,7 @@
 	return result;
 }
 
-extern inline int down_trylock(struct semaphore * sem)
+static inline int down_trylock(struct semaphore *sem)
 {
 	register struct semaphore *sem1 __asm__ ("%a1") = sem;
 	register int result __asm__ ("%d0");
@@ -160,7 +160,7 @@
  * The default case (no contention) will result in NO
  * jumps for both down() and up().
  */
-extern inline void up(struct semaphore * sem)
+static inline void up(struct semaphore *sem)
 {
 	register struct semaphore *sem1 __asm__ ("%a1") = sem;
 
--- linux-2.6.0/include/asm-m68k/signal.h	2003-09-28 09:36:42.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/signal.h	2003-11-23 18:01:59.000000000 +0100
@@ -176,25 +176,25 @@
 
 #define __HAVE_ARCH_SIG_BITOPS
 
-extern __inline__ void sigaddset(sigset_t *set, int _sig)
+static inline void sigaddset(sigset_t *set, int _sig)
 {
 	__asm__("bfset %0{%1,#1}" : "=m" (*set) : "id" ((_sig - 1) ^ 31)
 		: "cc");
 }
 
-extern __inline__ void sigdelset(sigset_t *set, int _sig)
+static inline void sigdelset(sigset_t *set, int _sig)
 {
 	__asm__("bfclr %0{%1,#1}" : "=m"(*set) : "id"((_sig - 1) ^ 31)
 		: "cc");
 }
 
-extern __inline__ int __const_sigismember(sigset_t *set, int _sig)
+static inline int __const_sigismember(sigset_t *set, int _sig)
 {
 	unsigned long sig = _sig - 1;
 	return 1 & (set->sig[sig / _NSIG_BPW] >> (sig % _NSIG_BPW));
 }
 
-extern __inline__ int __gen_sigismember(sigset_t *set, int _sig)
+static inline int __gen_sigismember(sigset_t *set, int _sig)
 {
 	int ret;
 	__asm__("bfextu %1{%2,#1},%0"
@@ -207,7 +207,7 @@
 	 __const_sigismember(set,sig) :		\
 	 __gen_sigismember(set,sig))
 
-extern __inline__ int sigfindinword(unsigned long word)
+static inline int sigfindinword(unsigned long word)
 {
 	__asm__("bfffo %1{#0,#0},%0" : "=d"(word) : "d"(word & -word) : "cc");
 	return word ^ 31;
--- linux-2.6.0/include/asm-m68k/string.h	2002-04-04 09:50:20.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/string.h	2003-11-23 18:02:26.000000000 +0100
@@ -82,7 +82,7 @@
 
 #if 0
 #define __HAVE_ARCH_STRPBRK
-extern inline char * strpbrk(const char * cs,const char * ct)
+static inline char *strpbrk(const char *cs,const char *ct)
 {
   const char *sc1,*sc2;
   
@@ -530,7 +530,8 @@
  memcmp((cs),(ct),(n)))
 
 #define __HAVE_ARCH_MEMCHR
-extern inline void * memchr(const void * cs, int c, size_t count) {
+static inline void *memchr(const void *cs, int c, size_t count)
+{
 	/* Someone else can optimize this, I don't care - tonym@mac.linux-m68k.org */
 	unsigned char *ret = (unsigned char *)cs;
 	for(;count>0;count--,ret++)
--- linux-2.6.0/include/asm-m68k/sun3_pgtable.h	2003-07-29 18:19:21.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/sun3_pgtable.h	2003-11-23 18:03:26.000000000 +0100
@@ -103,22 +103,27 @@
  */
 #define mk_pte(page, pgprot) pfn_pte(page_to_pfn(page), (pgprot))
 
-extern inline pte_t pte_modify (pte_t pte, pgprot_t newprot)
-{ pte_val(pte) = (pte_val(pte) & SUN3_PAGE_CHG_MASK) | pgprot_val(newprot); return pte; }
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+	pte_val(pte) = (pte_val(pte) & SUN3_PAGE_CHG_MASK) | pgprot_val(newprot);
+	return pte;
+}
 
 #define pmd_set(pmdp,ptep) do {} while (0)
 
-extern inline void pgd_set(pgd_t * pgdp, pmd_t * pmdp)
-{ pgd_val(*pgdp) = virt_to_phys(pmdp); }
+static inline void pgd_set(pgd_t *pgdp, pmd_t *pmdp)
+{
+	pgd_val(*pgdp) = virt_to_phys(pmdp);
+}
 
 #define __pte_page(pte) \
 ((unsigned long) __va ((pte_val (pte) & SUN3_PAGE_PGNUM_MASK) << PAGE_SHIFT))
 #define __pmd_page(pmd) \
 ((unsigned long) __va (pmd_val (pmd) & PAGE_MASK))
 
-extern inline int pte_none (pte_t pte) { return !pte_val (pte); }
-extern inline int pte_present (pte_t pte) { return pte_val (pte) & SUN3_PAGE_VALID; }
-extern inline void pte_clear (pte_t *ptep) { pte_val (*ptep) = 0; }
+static inline int pte_none (pte_t pte) { return !pte_val (pte); }
+static inline int pte_present (pte_t pte) { return pte_val (pte) & SUN3_PAGE_VALID; }
+static inline void pte_clear (pte_t *ptep) { pte_val (*ptep) = 0; }
 
 #define pte_pfn(pte)            (pte_val(pte) & SUN3_PAGE_PGNUM_MASK)
 #define pfn_pte(pfn, pgprot) \
@@ -128,20 +133,20 @@
 #define pmd_page(pmd)		(mem_map+((__pmd_page(pmd) - PAGE_OFFSET) >> PAGE_SHIFT))
 
 
-extern inline int pmd_none2 (pmd_t *pmd) { return !pmd_val (*pmd); }
+static inline int pmd_none2 (pmd_t *pmd) { return !pmd_val (*pmd); }
 #define pmd_none(pmd) pmd_none2(&(pmd))
-//extern inline int pmd_bad (pmd_t pmd) { return (pmd_val (pmd) & SUN3_PMD_MASK) != SUN3_PMD_MAGIC; }
-extern inline int pmd_bad2 (pmd_t *pmd) { return 0; }
+//static inline int pmd_bad (pmd_t pmd) { return (pmd_val (pmd) & SUN3_PMD_MASK) != SUN3_PMD_MAGIC; }
+static inline int pmd_bad2 (pmd_t *pmd) { return 0; }
 #define pmd_bad(pmd) pmd_bad2(&(pmd))
-extern inline int pmd_present2 (pmd_t *pmd) { return pmd_val (*pmd) & SUN3_PMD_VALID; }
+static inline int pmd_present2 (pmd_t *pmd) { return pmd_val (*pmd) & SUN3_PMD_VALID; }
 /* #define pmd_present(pmd) pmd_present2(&(pmd)) */
 #define pmd_present(pmd) (!pmd_none2(&(pmd)))
-extern inline void pmd_clear (pmd_t *pmdp) { pmd_val (*pmdp) = 0; }
+static inline void pmd_clear (pmd_t *pmdp) { pmd_val (*pmdp) = 0; }
 
-extern inline int pgd_none (pgd_t pgd) { return 0; }
-extern inline int pgd_bad (pgd_t pgd) { return 0; }
-extern inline int pgd_present (pgd_t pgd) { return 1; }
-extern inline void pgd_clear (pgd_t *pgdp) {}
+static inline int pgd_none (pgd_t pgd) { return 0; }
+static inline int pgd_bad (pgd_t pgd) { return 0; }
+static inline int pgd_present (pgd_t pgd) { return 1; }
+static inline void pgd_clear (pgd_t *pgdp) {}
 
 
 #define pte_ERROR(e) \
@@ -157,28 +162,28 @@
  * Undefined behaviour if not...
  * [we have the full set here even if they don't change from m68k]
  */
-extern inline int pte_read(pte_t pte)		{ return 1; }
-extern inline int pte_write(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_WRITEABLE; }
-extern inline int pte_exec(pte_t pte)		{ return 1; }
-extern inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_MODIFIED; }
-extern inline int pte_young(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_ACCESSED; }
-extern inline int pte_file(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_ACCESSED; }
-
-extern inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_WRITEABLE; return pte; }
-extern inline pte_t pte_rdprotect(pte_t pte)	{ return pte; }
-extern inline pte_t pte_exprotect(pte_t pte)	{ return pte; }
-extern inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_MODIFIED; return pte; }
-extern inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_ACCESSED; return pte; }
-extern inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_WRITEABLE; return pte; }
-extern inline pte_t pte_mkread(pte_t pte)	{ return pte; }
-extern inline pte_t pte_mkexec(pte_t pte)	{ return pte; }
-extern inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_MODIFIED; return pte; }
-extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_ACCESSED; return pte; }
-extern inline pte_t pte_mknocache(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_NOCACHE; return pte; }
+static inline int pte_read(pte_t pte)		{ return 1; }
+static inline int pte_write(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_WRITEABLE; }
+static inline int pte_exec(pte_t pte)		{ return 1; }
+static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_MODIFIED; }
+static inline int pte_young(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_ACCESSED; }
+static inline int pte_file(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_ACCESSED; }
+
+static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_WRITEABLE; return pte; }
+static inline pte_t pte_rdprotect(pte_t pte)	{ return pte; }
+static inline pte_t pte_exprotect(pte_t pte)	{ return pte; }
+static inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_MODIFIED; return pte; }
+static inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_ACCESSED; return pte; }
+static inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_WRITEABLE; return pte; }
+static inline pte_t pte_mkread(pte_t pte)	{ return pte; }
+static inline pte_t pte_mkexec(pte_t pte)	{ return pte; }
+static inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_MODIFIED; return pte; }
+static inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_ACCESSED; return pte; }
+static inline pte_t pte_mknocache(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_NOCACHE; return pte; }
 // use this version when caches work...
-//extern inline pte_t pte_mkcache(pte_t pte)	{ pte_val(pte) &= SUN3_PAGE_NOCACHE; return pte; }
+//static inline pte_t pte_mkcache(pte_t pte)	{ pte_val(pte) &= SUN3_PAGE_NOCACHE; return pte; }
 // until then, use:
-extern inline pte_t pte_mkcache(pte_t pte)	{ return pte; }
+static inline pte_t pte_mkcache(pte_t pte)	{ return pte; }
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t kernel_pg_dir[PTRS_PER_PGD];
@@ -193,7 +198,7 @@
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
 /* Find an entry in the second-level pagetable. */
-extern inline pmd_t *pmd_offset (pgd_t *pgd, unsigned long address)
+static inline pmd_t *pmd_offset (pgd_t *pgd, unsigned long address)
 {
 	return (pmd_t *) pgd;
 }
--- linux-2.6.0/include/asm-m68k/sun3mmu.h	2002-11-05 10:10:13.000000000 +0100
+++ linux-m68k-2.6.0/include/asm-m68k/sun3mmu.h	2003-11-23 18:03:50.000000000 +0100
@@ -69,7 +69,7 @@
 #ifndef __ASSEMBLY__
 
 /* Read bus error status register (implicitly clearing it). */
-extern __inline__ unsigned char sun3_get_buserr (void)
+static inline unsigned char sun3_get_buserr(void)
 {
 	unsigned char sfc, c;
 
@@ -82,7 +82,7 @@
 }
 
 /* Read segmap from hardware MMU. */
-extern __inline__ unsigned long sun3_get_segmap (unsigned long addr)
+static inline unsigned long sun3_get_segmap(unsigned long addr)
 {
         register unsigned long entry;
         unsigned char c, sfc;
@@ -97,7 +97,7 @@
 }
 
 /* Write segmap to hardware MMU. */
-extern __inline__ void sun3_put_segmap (unsigned long addr, unsigned long entry)
+static inline void sun3_put_segmap(unsigned long addr, unsigned long entry)
 {
         unsigned char sfc;
 
@@ -110,7 +110,7 @@
 }
 
 /* Read PTE from hardware MMU. */
-extern __inline__ unsigned long sun3_get_pte (unsigned long addr)
+static inline unsigned long sun3_get_pte(unsigned long addr)
 {
         register unsigned long entry;
         unsigned char sfc;
@@ -124,7 +124,7 @@
 }
 
 /* Write PTE to hardware MMU. */
-extern __inline__ void sun3_put_pte (unsigned long addr, unsigned long entry)
+static inline void sun3_put_pte(unsigned long addr, unsigned long entry)
 {
         unsigned char sfc;
 
@@ -137,7 +137,7 @@
 }
 
 /* get current context */
-extern __inline__ unsigned char sun3_get_context(void)
+static inline unsigned char sun3_get_context(void)
 {
 	unsigned char sfc, c;
 
@@ -150,7 +150,7 @@
 }
 
 /* set alternate context */
-extern __inline__ void sun3_put_context(unsigned char c)
+static inline void sun3_put_context(unsigned char c)
 {
 	unsigned char dfc;
 	GET_DFC(dfc);
--- linux-2.6.0/include/asm-m68k/tlbflush.h	2002-07-25 12:54:07.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/tlbflush.h	2003-11-23 18:04:00.000000000 +0100
@@ -87,7 +87,7 @@
 	flush_tlb_all();
 }
 
-extern inline void flush_tlb_pgtables(struct mm_struct *mm,
+static inline void flush_tlb_pgtables(struct mm_struct *mm,
 				      unsigned long start, unsigned long end)
 {
 }
@@ -214,7 +214,7 @@
 	sun3_put_segmap (addr & ~(SUN3_PMEG_SIZE - 1), SUN3_INVALID_PMEG);
 }
 
-extern inline void flush_tlb_pgtables(struct mm_struct *mm,
+static inline void flush_tlb_pgtables(struct mm_struct *mm,
 				      unsigned long start, unsigned long end)
 {
 }
--- linux-2.6.0/include/asm-m68k/uaccess.h	2003-01-17 12:09:37.000000000 +0100
+++ linux-m68k-2.6.0/include/asm-m68k/uaccess.h	2003-11-23 18:04:08.000000000 +0100
@@ -14,7 +14,7 @@
 /* We let the MMU do all checking */
 #define access_ok(type,addr,size) 1
 
-extern inline int verify_area(int type, const void * addr, unsigned long size)
+static inline int verify_area(int type, const void *addr, unsigned long size)
 {
 	return access_ok(type,addr,size)?0:-EFAULT;
 }
--- linux-2.6.0/include/asm-m68k/virtconvert.h	2002-11-05 10:10:14.000000000 +0100
+++ linux-m68k-2.6.0/include/asm-m68k/virtconvert.h	2003-11-23 18:04:13.000000000 +0100
@@ -22,12 +22,12 @@
 extern unsigned long mm_vtop(unsigned long addr) __attribute__ ((const));
 extern unsigned long mm_ptov(unsigned long addr) __attribute__ ((const));
 #else
-extern inline unsigned long mm_vtop(unsigned long vaddr)
+static inline unsigned long mm_vtop(unsigned long vaddr)
 {
 	return __pa(vaddr);
 }
 
-extern inline unsigned long mm_ptov(unsigned long paddr)
+static inline unsigned long mm_ptov(unsigned long paddr)
 {
 	return (unsigned long)__va(paddr);
 }
--- linux-2.6.0/include/asm-m68k/zorro.h	2003-09-27 16:36:17.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/zorro.h	2003-11-23 18:04:54.000000000 +0100
@@ -15,25 +15,25 @@
 #define z_memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define z_memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
-extern inline void *z_remap_nocache_ser(unsigned long physaddr, 
-					  unsigned long size)
+static inline void *z_remap_nocache_ser(unsigned long physaddr,
+					unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
 }
 
-extern inline void *z_remap_nocache_nonser(unsigned long physaddr, 
-					     unsigned long size)
+static inline void *z_remap_nocache_nonser(unsigned long physaddr,
+					   unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_NONSER);
 }
 
-extern inline void *z_remap_writethrough(unsigned long physaddr,
-					   unsigned long size)
+static inline void *z_remap_writethrough(unsigned long physaddr,
+					 unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
 }
-extern inline void *z_remap_fullcache(unsigned long physaddr,
-					unsigned long size)
+static inline void *z_remap_fullcache(unsigned long physaddr,
+				      unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
