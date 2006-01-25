Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWAYLcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWAYLcI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 06:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWAYLcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 06:32:07 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:42138 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751139AbWAYLcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 06:32:01 -0500
Date: Wed, 25 Jan 2006 20:32:06 +0900
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-ID: <20060125113206.GD18584@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125112625.GA18584@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o generic {,test_and_}{set,clear,change}_bit() (atomic bitops)

This patch introduces the C-language equivalents of the functions below:
void set_bit(int nr, volatile unsigned long *addr);
void clear_bit(int nr, volatile unsigned long *addr);
void change_bit(int nr, volatile unsigned long *addr);
int test_and_set_bit(int nr, volatile unsigned long *addr);
int test_and_clear_bit(int nr, volatile unsigned long *addr);
int test_and_change_bit(int nr, volatile unsigned long *addr);

HAVE_ARCH_ATOMIC_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/asm-powerpc/bitops.h
include/asm-parisc/bitops.h
include/asm-parisc/atomic.h

o generic __{,test_and_}{set,clear,change}_bit() and test_bit()

This patch introduces the C-language equivalents of the functions below:
void __set_bit(int nr, volatile unsigned long *addr);
void __clear_bit(int nr, volatile unsigned long *addr);
void __change_bit(int nr, volatile unsigned long *addr);
int __test_and_set_bit(int nr, volatile unsigned long *addr);
int __test_and_clear_bit(int nr, volatile unsigned long *addr);
int __test_and_change_bit(int nr, volatile unsigned long *addr);
int test_bit(int nr, const volatile unsigned long *addr);

HAVE_ARCH_NON_ATOMIC_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
asm-powerpc/bitops.h

o generic __ffs()

This patch introduces the C-language equivalent of the function:
unsigned long __ffs(unsigned long word);

HAVE_ARCH___FFS_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/asm-sparc64/bitops.h

o generic ffz()

This patch introduces the C-language equivalent of the function:
unsigned long ffz(unsigned long word);

HAVE_ARCH_FFZ_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/asm-sparc64/bitops.h

o generic fls()

This patch introduces the C-language equivalent of the function:
int fls(int x);

HAVE_ARCH_FLS_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/linux/bitops.h

o generic fls64()

This patch introduces the C-language equivalent of the function:
int fls64(__u64 x);

HAVE_ARCH_FLS64_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/linux/bitops.h

o generic find_{next,first}{,_zero}_bit()

This patch introduces the C-language equivalents of the functions below:

unsigned logn find_next_bit(const unsigned long *addr, unsigned long size,
			    unsigned long offset);
unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
				 unsigned long offset);
unsigned long find_first_zero_bit(const unsigned long *addr,
				  unsigned long size);
unsigned long find_first_bit(const unsigned long *addr, unsigned long size);

HAVE_ARCH_FIND_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
arch/powerpc/lib/bitops.c

==== KERNEL

o generic sched_find_first_bit()

This patch introduces the C-language equivalent of the function:
int sched_find_first_bit(const unsigned long *b);

HAVE_ARCH_SCHED_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/asm-powerpc/bitops.h

o generic ffs()

This patch introduces the C-language equivalent of the function:
int ffs(int x);

HAVE_ARCH_FFS_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/linux/bitops.h

o generic hweight{32,16,8}()

This patch introduces the C-language equivalents of the functions below:
unsigned int hweight32(unsigned int w);
unsigned int hweight16(unsigned int w);
unsigned int hweight8(unsigned int w);

HAVE_ARCH_HWEIGHT_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/linux/bitops.h

o generic hweight64()

This patch introduces the C-language equivalent of the function:
unsigned long hweight64(__u64 w);

HAVE_ARCH_HWEIGHT64_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/linux/bitops.h

o generic ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()

This patch introduces the C-language equivalents of the functions below:

int ext2_set_bit(int nr, volatile unsigned long *addr);
int ext2_clear_bit(int nr, volatile unsigned long *addr);
int ext2_test_bit(int nr, const volatile unsigned long *addr);
unsigned long ext2_find_first_zero_bit(const unsigned long *addr,
				       unsigned long size);

HAVE_ARCH_EXT2_NON_ATOMIC_BITOPS is defined when the architecture has its own
version of these functions.

unsinged long ext2_find_next_zero_bit(const unsigned long *addr,
				      unsigned long size);

This code largely copied from:
include/asm-powerpc/bitops.h
include/asm-parisc/bitops.h

o generic ext2_{set,clear}_bit_atomic()

This patch introduces the C-language equivalents of the functions below:
int ext2_set_bit_atomic(int nr, volatile unsigned long *addr);
int ext2_clear_bit_atomic(int nr, volatile unsigned long *addr);

HAVE_ARCH_EXT2_ATOMIC_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/asm-sparc/bitops.h

o generic minix_{test,set,test_and_clear,test,find_first_zero}_bit()

This patch introduces the C-language equivalents of the functions below:

HAVE_ARCH_MINIX_BITOPS is defined when the architecture has its own
version of these functions.

int minix_test_and_set_bit(int nr, volatile unsigned long *addr);
int minix_set_bit(int nr, volatile unsigned long *addr);
int minix_test_and_clear_bit(int nr, volatile unsigned long *addr);
int minix_test_bit(int nr, const volatile unsigned long *addr);
unsigned long minix_find_first_zero_bit(const unsigned long *addr,
					unsigned long size);

This code largely copied from:
include/asm-sparc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
---
 bitops.h |  677 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 641 insertions(+), 36 deletions(-)

Index: work/include/asm-generic/bitops.h
===================================================================
--- work.orig/include/asm-generic/bitops.h	2006-01-25 19:14:27.000000000 +0900
+++ work/include/asm-generic/bitops.h	2006-01-25 19:32:48.000000000 +0900
@@ -1,81 +1,686 @@
 #ifndef _ASM_GENERIC_BITOPS_H_
 #define _ASM_GENERIC_BITOPS_H_
 
+#include <asm/types.h>
+
+#define BITOP_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
+#define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
+#define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
+
+#ifndef HAVE_ARCH_ATOMIC_BITOPS
+
+#ifdef CONFIG_SMP
+#include <asm/spinlock.h>
+#include <asm/cache.h>		/* we use L1_CACHE_BYTES */
+
+/* Use an array of spinlocks for our atomic_ts.
+ * Hash function to index into a different SPINLOCK.
+ * Since "a" is usually an address, use one spinlock per cacheline.
+ */
+#  define ATOMIC_HASH_SIZE 4
+#  define ATOMIC_HASH(a) (&(__atomic_hash[ (((unsigned long) a)/L1_CACHE_BYTES) & (ATOMIC_HASH_SIZE-1) ]))
+
+extern raw_spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned;
+
+/* Can't use raw_spin_lock_irq because of #include problems, so
+ * this is the substitute */
+#define _atomic_spin_lock_irqsave(l,f) do {	\
+	raw_spinlock_t *s = ATOMIC_HASH(l);	\
+	local_irq_save(f);			\
+	__raw_spin_lock(s);			\
+} while(0)
+
+#define _atomic_spin_unlock_irqrestore(l,f) do {	\
+	raw_spinlock_t *s = ATOMIC_HASH(l);		\
+	__raw_spin_unlock(s);				\
+	local_irq_restore(f);				\
+} while(0)
+
+
+#else
+#  define _atomic_spin_lock_irqsave(l,f) do { local_irq_save(f); } while (0)
+#  define _atomic_spin_unlock_irqrestore(l,f) do { local_irq_restore(f); } while (0)
+#endif
+
 /*
  * For the benefit of those who are trying to port Linux to another
  * architecture, here are some C-language equivalents.  You should
  * recode these in the native assembly language, if at all possible.
- * To guarantee atomicity, these routines call cli() and sti() to
- * disable interrupts while they operate.  (You have to provide inline
- * routines to cli() and sti().)
  *
- * Also note, these routines assume that you have 32 bit longs.
- * You will have to change this if you are trying to port Linux to the
- * Alpha architecture or to a Cray.  :-)
- * 
  * C language equivalents written by Theodore Ts'o, 9/26/92
  */
 
-extern __inline__ int set_bit(int nr,long * addr)
+static __inline__ void set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(p, flags);
+	*p  |= mask;
+	_atomic_spin_unlock_irqrestore(p, flags);
+}
+
+static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(p, flags);
+	*p &= ~mask;
+	_atomic_spin_unlock_irqrestore(p, flags);
+}
+
+static __inline__ void change_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(p, flags);
+	*p ^= mask;
+	_atomic_spin_unlock_irqrestore(p, flags);
+}
+
+static __inline__ int test_and_set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old;
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(p, flags);
+	old = *p;
+	*p = old | mask;
+	_atomic_spin_unlock_irqrestore(p, flags);
+
+	return (old & mask) != 0;
+}
+
+static __inline__ int test_and_clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old;
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(p, flags);
+	old = *p;
+	*p = old & ~mask;
+	_atomic_spin_unlock_irqrestore(p, flags);
+
+	return (old & mask) != 0;
+}
+
+static __inline__ int test_and_change_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old;
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(p, flags);
+	old = *p;
+	*p = old ^ mask;
+	_atomic_spin_unlock_irqrestore(p, flags);
+
+	return (old & mask) != 0;
+}
+
+#endif /* HAVE_ARCH_ATOMIC_BITOPS */
+
+#ifndef HAVE_ARCH_NON_ATOMIC_BITOPS
+
+static __inline__ void __set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+
+	*p  |= mask;
+}
+
+static __inline__ void __clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+
+	*p &= ~mask;
+}
+
+static __inline__ void __change_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+
+	*p ^= mask;
+}
+
+static __inline__ int __test_and_set_bit(int nr, volatile unsigned long *addr)
 {
-	int	mask, retval;
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old = *p;
 
-	addr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	cli();
-	retval = (mask & *addr) != 0;
-	*addr |= mask;
-	sti();
-	return retval;
+	*p = old | mask;
+	return (old & mask) != 0;
 }
 
-extern __inline__ int clear_bit(int nr, long * addr)
+static __inline__ int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
-	int	mask, retval;
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old = *p;
 
-	addr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	cli();
-	retval = (mask & *addr) != 0;
-	*addr &= ~mask;
-	sti();
-	return retval;
+	*p = old & ~mask;
+	return (old & mask) != 0;
 }
 
-extern __inline__ int test_bit(int nr, const unsigned long * addr)
+static __inline__ int __test_and_change_bit(int nr,
+					    volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old = *p;
+
+	*p = old ^ mask;
+	return (old & mask) != 0;
+}
+
+static __inline__ int test_bit(int nr, __const__ volatile unsigned long *addr)
+{
+	return 1UL & (addr[BITOP_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
+}
+
+#endif /* HAVE_ARCH_NON_ATOMIC_BITOPS */
+
+#ifndef HAVE_ARCH___FFS_BITOPS
+
+/**
+ * __ffs - find first bit in word.
+ * @word: The word to search
+ *
+ * Returns 0..BITS_PER_LONG-1
+ * Undefined if no bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __ffs(unsigned long word)
 {
-	int	mask;
+	int b = 0, s;
 
-	addr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	return ((mask & *addr) != 0);
+#if BITS_PER_LONG == 32
+	s = 16; if (word << 16 != 0) s = 0; b += s; word >>= s;
+	s =  8; if (word << 24 != 0) s = 0; b += s; word >>= s;
+	s =  4; if (word << 28 != 0) s = 0; b += s; word >>= s;
+	s =  2; if (word << 30 != 0) s = 0; b += s; word >>= s;
+	s =  1; if (word << 31 != 0) s = 0; b += s;
+
+	return b;
+#elif BITS_PER_LONG == 64
+	s = 32; if (word << 32 != 0) s = 0; b += s; word >>= s;
+	s = 16; if (word << 48 != 0) s = 0; b += s; word >>= s;
+	s =  8; if (word << 56 != 0) s = 0; b += s; word >>= s;
+	s =  4; if (word << 60 != 0) s = 0; b += s; word >>= s;
+	s =  2; if (word << 62 != 0) s = 0; b += s; word >>= s;
+	s =  1; if (word << 63 != 0) s = 0; b += s;
+
+	return b;
+#else
+#error BITS_PER_LONG not defined
+#endif
 }
 
+#endif /* HAVE_ARCH___FFS_BITOPS */
+
+#ifndef HAVE_ARCH_FFZ_BITOPS
+
+/* Undefined if no bit is zero. */
+#define ffz(x)	__ffs(~x)
+
+#endif /* HAVE_ARCH_FFZ_BITOPS */
+
+#ifndef HAVE_ARCH_FLS_BITOPS
+
 /*
  * fls: find last bit set.
  */
 
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
+static __inline__ int fls(int x)
+{
+	int r = 32;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff0000u)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xff000000u)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xf0000000u)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xc0000000u)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000u)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+
+#endif /* HAVE_ARCH_FLS_BITOPS */
+
+#ifndef HAVE_ARCH_FLS64_BITOPS
+
+static inline int fls64(__u64 x)
+{
+	__u32 h = x >> 32;
+	if (h)
+		return fls(x) + 32;
+	return fls(x);
+}
+
+#endif /* HAVE_ARCH_FLS64_BITOPS */
+
+#ifndef HAVE_ARCH_FIND_BITOPS
+
+/**
+ * find_next_bit - find the next set bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The maximum size to search
+ */
+static inline unsigned long find_next_bit(const unsigned long *addr,
+				unsigned long size, unsigned long offset)
+{
+	const unsigned long *p = addr + BITOP_WORD(offset);
+	unsigned long result = offset & ~(BITS_PER_LONG-1);
+	unsigned long tmp;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset %= BITS_PER_LONG;
+	if (offset) {
+		tmp = *(p++);
+		tmp &= (~0UL << offset);
+		if (size < BITS_PER_LONG)
+			goto found_first;
+		if (tmp)
+			goto found_middle;
+		size -= BITS_PER_LONG;
+		result += BITS_PER_LONG;
+	}
+	while (size & ~(BITS_PER_LONG-1)) {
+		if ((tmp = *(p++)))
+			goto found_middle;
+		result += BITS_PER_LONG;
+		size -= BITS_PER_LONG;
+	}
+	if (!size)
+		return result;
+	tmp = *p;
+
+found_first:
+	tmp &= (~0UL >> (BITS_PER_LONG - size));
+	if (tmp == 0UL)		/* Are any bits set? */
+		return result + size;	/* Nope. */
+found_middle:
+	return result + __ffs(tmp);
+}
+
+/*
+ * This implementation of find_{first,next}_zero_bit was stolen from
+ * Linus' asm-alpha/bitops.h.
+ */
+static inline unsigned long find_next_zero_bit(const unsigned long *addr,
+				unsigned long size, unsigned long offset)
+{
+	const unsigned long *p = addr + BITOP_WORD(offset);
+	unsigned long result = offset & ~(BITS_PER_LONG-1);
+	unsigned long tmp;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset %= BITS_PER_LONG;
+	if (offset) {
+		tmp = *(p++);
+		tmp |= ~0UL >> (BITS_PER_LONG - offset);
+		if (size < BITS_PER_LONG)
+			goto found_first;
+		if (~tmp)
+			goto found_middle;
+		size -= BITS_PER_LONG;
+		result += BITS_PER_LONG;
+	}
+	while (size & ~(BITS_PER_LONG-1)) {
+		if (~(tmp = *(p++)))
+			goto found_middle;
+		result += BITS_PER_LONG;
+		size -= BITS_PER_LONG;
+	}
+	if (!size)
+		return result;
+	tmp = *p;
+
+found_first:
+	tmp |= ~0UL << size;
+	if (tmp == ~0UL)	/* Are any bits zero? */
+		return result + size;	/* Nope. */
+found_middle:
+	return result + ffz(tmp);
+}
+
+#define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
+#define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
+
+#endif /* HAVE_ARCH_FIND_BITOPS */
 
 #ifdef __KERNEL__
 
+#ifndef HAVE_ARCH_SCHED_BITOPS
+
+#include <linux/compiler.h>	/* unlikely() */
+
+/*
+ * Every architecture must define this function. It's the fastest
+ * way of searching a 140-bit bitmap where the first 100 bits are
+ * unlikely to be set. It's guaranteed that at least one of the 140
+ * bits is cleared.
+ */
+static inline int sched_find_first_bit(const unsigned long *b)
+{
+#if BITS_PER_LONG == 64
+	if (unlikely(b[0]))
+		return __ffs(b[0]);
+	if (unlikely(b[1]))
+		return __ffs(b[1]) + 64;
+	return __ffs(b[2]) + 128;
+#elif BITS_PER_LONG == 32
+	if (unlikely(b[0]))
+		return __ffs(b[0]);
+	if (unlikely(b[1]))
+		return __ffs(b[1]) + 32;
+	if (unlikely(b[2]))
+		return __ffs(b[2]) + 64;
+	if (b[3])
+		return __ffs(b[3]) + 96;
+	return __ffs(b[4]) + 128;
+#else
+#error BITS_PER_LONG not defined
+#endif
+}
+
+#endif /* HAVE_ARCH_SCHED_BITOPS */
+
+#ifndef HAVE_ARCH_FFS_BITOPS
+
 /*
  * ffs: find first bit set. This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
 
-#define ffs(x) generic_ffs(x)
+static inline int ffs(int x)
+{
+	int r = 1;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff)) {
+		x >>= 16;
+		r += 16;
+	}
+	if (!(x & 0xff)) {
+		x >>= 8;
+		r += 8;
+	}
+	if (!(x & 0xf)) {
+		x >>= 4;
+		r += 4;
+	}
+	if (!(x & 3)) {
+		x >>= 2;
+		r += 2;
+	}
+	if (!(x & 1)) {
+		x >>= 1;
+		r += 1;
+	}
+	return r;
+}
+
+#endif /* HAVE_ARCH_FFS_BITOPS */
+
+
+#ifndef HAVE_ARCH_HWEIGHT_BITOPS
 
 /*
  * hweightN: returns the hamming weight (i.e. the number
  * of bits set) of a N-bit word
  */
 
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+static inline unsigned int hweight32(unsigned int w)
+{
+        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
+        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
+        res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
+        res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
+        return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
+}
+
+static inline unsigned int hweight16(unsigned int w)
+{
+        unsigned int res = (w & 0x5555) + ((w >> 1) & 0x5555);
+        res = (res & 0x3333) + ((res >> 2) & 0x3333);
+        res = (res & 0x0F0F) + ((res >> 4) & 0x0F0F);
+        return (res & 0x00FF) + ((res >> 8) & 0x00FF);
+}
+
+static inline unsigned int hweight8(unsigned int w)
+{
+        unsigned int res = (w & 0x55) + ((w >> 1) & 0x55);
+        res = (res & 0x33) + ((res >> 2) & 0x33);
+        return (res & 0x0F) + ((res >> 4) & 0x0F);
+}
+
+#endif /* HAVE_ARCH_HWEIGHT_BITOPS */
+
+#ifndef HAVE_ARCH_HWEIGHT64_BITOPS
+
+static inline unsigned long hweight64(__u64 w)
+{
+#if BITS_PER_LONG < 64
+	return hweight32((unsigned int)(w >> 32)) + hweight32((unsigned int)w);
+#else
+	u64 res;
+	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);
+	res = (res & 0x3333333333333333ul) + ((res >> 2) & 0x3333333333333333ul);
+	res = (res & 0x0F0F0F0F0F0F0F0Ful) + ((res >> 4) & 0x0F0F0F0F0F0F0F0Ful);
+	res = (res & 0x00FF00FF00FF00FFul) + ((res >> 8) & 0x00FF00FF00FF00FFul);
+	res = (res & 0x0000FFFF0000FFFFul) + ((res >> 16) & 0x0000FFFF0000FFFFul);
+	return (res & 0x00000000FFFFFFFFul) + ((res >> 32) & 0x00000000FFFFFFFFul);
+#endif
+}
+
+#endif /* HAVE_ARCH_HWEIGHT64_BITOPS */
+
+#ifndef HAVE_ARCH_EXT2_NON_ATOMIC_BITOPS
+
+#include <asm/byteorder.h>
+
+#if defined(__LITTLE_ENDIAN)
+
+static __inline__ int generic_test_le_bit(unsigned long nr,
+				  __const__ unsigned long *addr)
+{
+	__const__ unsigned char	*tmp = (__const__ unsigned char *) addr;
+	return (tmp[nr >> 3] >> (nr & 7)) & 1;
+}
+
+#define generic___set_le_bit(nr, addr) __set_bit(nr, addr)
+#define generic___clear_le_bit(nr, addr) __clear_bit(nr, addr)
+
+#define generic_test_and_set_le_bit(nr, addr) test_and_set_bit(nr, addr)
+#define generic_test_and_clear_le_bit(nr, addr) test_and_clear_bit(nr, addr)
+
+#define generic___test_and_set_le_bit(nr, addr) __test_and_set_bit(nr, addr)
+#define generic___test_and_clear_le_bit(nr, addr) __test_and_clear_bit(nr, addr)
+
+#define generic_find_next_zero_le_bit(addr, size, offset) find_next_zero_bit(addr, size, offset)
+
+#elif defined(__BIG_ENDIAN)
+
+static __inline__ int generic_test_le_bit(unsigned long nr,
+				  __const__ unsigned long *addr)
+{
+	__const__ unsigned char	*tmp = (__const__ unsigned char *) addr;
+	return (tmp[nr >> 3] >> (nr & 7)) & 1;
+}
+
+#define generic___set_le_bit(nr, addr) \
+	__set_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+#define generic___clear_le_bit(nr, addr) \
+	__clear_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+
+#define generic_test_and_set_le_bit(nr, addr) \
+	test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+#define generic_test_and_clear_le_bit(nr, addr) \
+	test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+
+#define generic___test_and_set_le_bit(nr, addr) \
+	__test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+#define generic___test_and_clear_le_bit(nr, addr) \
+	__test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+
+/* include/linux/byteorder does not support "unsigned long" type */
+static inline unsigned long ext2_swabp(const unsigned long * x)
+{
+#if BITS_PER_LONG == 64
+	return (unsigned long) __swab64p((u64 *) x);
+#elif BITS_PER_LONG == 32
+	return (unsigned long) __swab32p((u32 *) x);
+#else
+#error BITS_PER_LONG not defined
+#endif
+}
+
+/* include/linux/byteorder doesn't support "unsigned long" type */
+static inline unsigned long ext2_swab(const unsigned long y)
+{
+#if BITS_PER_LONG == 64
+	return (unsigned long) __swab64((u64) y);
+#elif BITS_PER_LONG == 32
+	return (unsigned long) __swab32((u32) y);
+#else
+#error BITS_PER_LONG not defined
+#endif
+}
+
+static __inline__ unsigned long generic_find_next_zero_le_bit(const unsigned long *addr,
+				unsigned long size, unsigned long offset)
+{
+	const unsigned long *p = addr + BITOP_WORD(offset);
+	unsigned long result = offset & ~(BITS_PER_LONG - 1);
+	unsigned long tmp;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset &= (BITS_PER_LONG - 1UL);
+	if (offset) {
+		tmp = ext2_swabp(p++);
+		tmp |= (~0UL >> (BITS_PER_LONG - offset));
+		if (size < BITS_PER_LONG)
+			goto found_first;
+		if (~tmp)
+			goto found_middle;
+		size -= BITS_PER_LONG;
+		result += BITS_PER_LONG;
+	}
+
+	while (size & ~(BITS_PER_LONG - 1)) {
+		if (~(tmp = *(p++)))
+			goto found_middle_swap;
+		result += BITS_PER_LONG;
+		size -= BITS_PER_LONG;
+	}
+	if (!size)
+		return result;
+	tmp = ext2_swabp(p);
+found_first:
+	tmp |= ~0UL << size;
+	if (tmp == ~0UL)	/* Are any bits zero? */
+		return result + size; /* Nope. Skip ffz */
+found_middle:
+	return result + ffz(tmp);
+
+found_middle_swap:
+	return result + ffz(ext2_swab(tmp));
+}
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+
+#define generic_find_first_zero_le_bit(addr, size) \
+        generic_find_next_zero_le_bit((addr), (size), 0)
+
+#define ext2_set_bit(nr,addr)	\
+	generic___test_and_set_le_bit((nr),(unsigned long *)(addr))
+#define ext2_clear_bit(nr,addr)	\
+	generic___test_and_clear_le_bit((nr),(unsigned long *)(addr))
+
+#define ext2_test_bit(nr,addr)	\
+	generic_test_le_bit((nr),(unsigned long *)(addr))
+#define ext2_find_first_zero_bit(addr, size) \
+	generic_find_first_zero_le_bit((unsigned long *)(addr), (size))
+#define ext2_find_next_zero_bit(addr, size, off) \
+	generic_find_next_zero_le_bit((unsigned long *)(addr), (size), (off))
+
+#endif /* HAVE_ARCH_EXT2_NON_ATOMIC_BITOPS */
+
+#ifndef HAVE_ARCH_EXT2_ATOMIC_BITOPS
+
+#define ext2_set_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_set_bit((nr), (unsigned long *)(addr)); \
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#define ext2_clear_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_clear_bit((nr), (unsigned long *)(addr)); \
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#endif /* HAVE_ARCH_EXT2_ATOMIC_BITOPS */
+
+#ifndef HAVE_ARCH_MINIX_BITOPS
+
+#define minix_test_and_set_bit(nr,addr)	\
+	__test_and_set_bit((nr),(unsigned long *)(addr))
+#define minix_set_bit(nr,addr)		\
+	__set_bit((nr),(unsigned long *)(addr))
+#define minix_test_and_clear_bit(nr,addr) \
+	__test_and_clear_bit((nr),(unsigned long *)(addr))
+#define minix_test_bit(nr,addr)		\
+	test_bit((nr),(unsigned long *)(addr))
+#define minix_find_first_zero_bit(addr,size) \
+	find_first_zero_bit((unsigned long *)(addr),(size))
+
+#endif /* HAVE_ARCH_MINIX_BITOPS */
 
 #endif /* __KERNEL__ */
 
