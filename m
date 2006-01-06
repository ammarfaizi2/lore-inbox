Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752550AbWAFU1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbWAFU1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbWAFU1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:27:09 -0500
Received: from mx.pathscale.com ([64.160.42.68]:58759 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752544AbWAFU1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:27:06 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 3] Add __raw_memcpy_toio32 to each arch
X-Mercurial-Node: 9e06b832c26c23ba3d1393489f3ab3043053e0f6
Message-Id: <9e06b832c26c23ba3d13.1136579196@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1136579193@eng-12.pathscale.com>
Date: Fri,  6 Jan 2006 12:26:36 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most arches use the <asm-generic/raw_memcpy_toio32.h> routine, while
x86_64 uses memcpy32, which is substantially faster, even on a bus
that is substantially slower than the CPU.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 33790477a163 -r 9e06b832c26c include/asm-alpha/io.h
--- a/include/asm-alpha/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-alpha/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -504,6 +504,8 @@
 extern void memcpy_toio(volatile void __iomem *, const void *, long);
 extern void _memset_c_io(volatile void __iomem *, unsigned long, long);
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 static inline void memset_io(volatile void __iomem *addr, u8 c, long len)
 {
 	_memset_c_io(addr, 0x0101010101010101UL * c, len);
diff -r 33790477a163 -r 9e06b832c26c include/asm-arm/io.h
--- a/include/asm-arm/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-arm/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -184,6 +184,8 @@
 #define memset_io(c,v,l)	_memset_io(__mem_pci(c),(v),(l))
 #define memcpy_fromio(a,c,l)	_memcpy_fromio((a),__mem_pci(c),(l))
 #define memcpy_toio(c,a,l)	_memcpy_toio(__mem_pci(c),(a),(l))
+
+#include <asm-generic/raw_memcpy_toio32.h>
 
 #define eth_io_copy_and_sum(s,c,l,b) \
 				eth_copy_and_sum((s),__mem_pci(c),(l),(b))
diff -r 33790477a163 -r 9e06b832c26c include/asm-cris/io.h
--- a/include/asm-cris/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-cris/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -121,6 +121,8 @@
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 /*
  * Again, CRIS does not require mem IO specific function.
  */
diff -r 33790477a163 -r 9e06b832c26c include/asm-frv/io.h
--- a/include/asm-frv/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-frv/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -124,6 +124,8 @@
 	memcpy((void __force *) dst, src, count);
 }
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 static inline uint8_t inb(unsigned long addr)
 {
 	return __builtin_read8((void *)addr);
diff -r 33790477a163 -r 9e06b832c26c include/asm-h8300/io.h
--- a/include/asm-h8300/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-h8300/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -209,6 +209,8 @@
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 #define mmiowb()
 
 #define inb(addr)    ((h8300_buswidth(addr))?readw((addr) & ~1) & 0xff:readb(addr))
diff -r 33790477a163 -r 9e06b832c26c include/asm-i386/io.h
--- a/include/asm-i386/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-i386/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -203,6 +203,8 @@
 {
 	__memcpy((void __force *) dst, src, count);
 }
+
+#include <asm-generic/raw_memcpy_toio32.h>
 
 /*
  * ISA space is 'always mapped' on a typical x86 system, no need to
diff -r 33790477a163 -r 9e06b832c26c include/asm-ia64/io.h
--- a/include/asm-ia64/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-ia64/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -443,6 +443,8 @@
 extern void memcpy_toio(volatile void __iomem *dst, const void *src, long n);
 extern void memset_io(volatile void __iomem *s, int c, long n);
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 #define dma_cache_inv(_start,_size)             do { } while (0)
 #define dma_cache_wback(_start,_size)           do { } while (0)
 #define dma_cache_wback_inv(_start,_size)       do { } while (0)
diff -r 33790477a163 -r 9e06b832c26c include/asm-m32r/io.h
--- a/include/asm-m32r/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-m32r/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -216,6 +216,8 @@
 	memcpy((void __force *) dst, src, count);
 }
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff -r 33790477a163 -r 9e06b832c26c include/asm-m68knommu/io.h
--- a/include/asm-m68knommu/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-m68knommu/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -113,6 +113,8 @@
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 #define inb(addr)    readb(addr)
 #define inw(addr)    readw(addr)
 #define inl(addr)    readl(addr)
diff -r 33790477a163 -r 9e06b832c26c include/asm-mips/io.h
--- a/include/asm-mips/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-mips/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -534,6 +534,8 @@
 	memcpy((void __force *) dst, src, count);
 }
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 /*
  * Memory Mapped I/O
  */
diff -r 33790477a163 -r 9e06b832c26c include/asm-parisc/io.h
--- a/include/asm-parisc/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-parisc/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -294,6 +294,8 @@
 void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
 void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 /* Support old drivers which don't ioremap.
  * NB this interface is scheduled to disappear in 2.5
  */
diff -r 33790477a163 -r 9e06b832c26c include/asm-powerpc/io.h
--- a/include/asm-powerpc/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-powerpc/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -63,6 +63,8 @@
 #define memcpy_fromio(a,b,c)	iSeries_memcpy_fromio((a), (b), (c))
 #define memcpy_toio(a,b,c)	iSeries_memcpy_toio((a), (b), (c))
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 #define inb(addr)		readb(((void __iomem *)(long)(addr)))
 #define inw(addr)		readw(((void __iomem *)(long)(addr)))
 #define inl(addr)		readl(((void __iomem *)(long)(addr)))
diff -r 33790477a163 -r 9e06b832c26c include/asm-ppc/io.h
--- a/include/asm-ppc/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-ppc/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -367,6 +367,8 @@
 }
 #endif
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 #define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void __force *)(void __iomem *)(b),(c),(d))
 
 /*
diff -r 33790477a163 -r 9e06b832c26c include/asm-s390/io.h
--- a/include/asm-s390/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-s390/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -99,6 +99,8 @@
 #define memcpy_fromio(a,b,c)    memcpy((a),__io_virt(b),(c))
 #define memcpy_toio(a,b,c)      memcpy(__io_virt(a),(b),(c))
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 #define inb_p(addr) readb(addr)
 #define inb(addr) readb(addr)
 
diff -r 33790477a163 -r 9e06b832c26c include/asm-sh/io.h
--- a/include/asm-sh/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-sh/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -177,6 +177,8 @@
 extern void memcpy_toio(unsigned long, const void *, unsigned long);
 extern void memset_io(unsigned long, int, unsigned long);
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 /* SuperH on-chip I/O functions */
 static __inline__ unsigned char ctrl_inb(unsigned long addr)
 {
diff -r 33790477a163 -r 9e06b832c26c include/asm-sh64/io.h
--- a/include/asm-sh64/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-sh64/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -125,6 +125,8 @@
 
 void memcpy_toio(void __iomem *to, const void *from, long count);
 void memcpy_fromio(void *to, void __iomem *from, long count);
+
+#include <asm-generic/raw_memcpy_toio32.h>
 
 #define mmiowb()
 
diff -r 33790477a163 -r 9e06b832c26c include/asm-sparc/io.h
--- a/include/asm-sparc/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-sparc/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -239,6 +239,8 @@
 
 #define memcpy_toio(d,s,sz)	_memcpy_toio(d,s,sz)
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 #ifdef __KERNEL__
 
 /*
diff -r 33790477a163 -r 9e06b832c26c include/asm-sparc64/io.h
--- a/include/asm-sparc64/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-sparc64/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -440,6 +440,8 @@
 
 #define memcpy_toio(d,s,sz)	_memcpy_toio(d,s,sz)
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 static inline int check_signature(void __iomem *io_addr,
 				  const unsigned char *signature,
 				  int length)
diff -r 33790477a163 -r 9e06b832c26c include/asm-v850/io.h
--- a/include/asm-v850/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-v850/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -130,6 +130,8 @@
 #define memcpy_fromio(dst, src, len) memcpy (dst, (void *)src, len)
 #define memcpy_toio(dst, src, len) memcpy ((void *)dst, src, len)
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff -r 33790477a163 -r 9e06b832c26c include/asm-x86_64/io.h
--- a/include/asm-x86_64/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-x86_64/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -252,6 +252,13 @@
 	__memcpy_toio((unsigned long)to,from,len);
 }
 
+#include <asm/string.h>
+
+static inline void __raw_memcpy_toio32(void __iomem *dst, const void *src, size_t count)
+{
+	memcpy32((void __force *) dst, src, count);
+}
+
 void memset_io(volatile void __iomem *a, int b, size_t c);
 
 /*
diff -r 33790477a163 -r 9e06b832c26c include/asm-xtensa/io.h
--- a/include/asm-xtensa/io.h	Fri Jan  6 12:25:02 2006 -0800
+++ b/include/asm-xtensa/io.h	Fri Jan  6 12:25:04 2006 -0800
@@ -159,6 +159,8 @@
 #define memcpy_fromio(a,b,c)   memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)      memcpy((void *)(a),(b),(c))
 
+#include <asm-generic/raw_memcpy_toio32.h>
+
 /* At this point the Xtensa doesn't provide byte swap instructions */
 
 #ifdef __XTENSA_EB__
