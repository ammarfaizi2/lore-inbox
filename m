Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWAJT4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWAJT4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWAJTzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:55:46 -0500
Received: from mx.pathscale.com ([64.160.42.68]:59562 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932540AbWAJTzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:55:42 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 3] Add __raw_memcpy_toio32 to each arch
X-Mercurial-Node: 5673a186625f62491f33033e278576eb0d5f2b5d
Message-Id: <5673a186625f62491f33.1136922839@serpentine.internal.keyresearch.com>
In-Reply-To: <patchbomb.1136922836@serpentine.internal.keyresearch.com>
Date: Tue, 10 Jan 2006 11:53:59 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, ak@suse.de,
       rdreier@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most arches use the generic routine.  x86_64 uses memcpy32 instead;
this is substantially faster, even over a bus that is much slower than
the CPU.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r b4863171295f -r 5673a186625f arch/alpha/Kconfig
--- a/arch/alpha/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/alpha/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -42,6 +42,10 @@
 	default y
 
 config GENERIC_IRQ_PROBE
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f arch/arm/Kconfig
--- a/arch/arm/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/arm/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -59,6 +59,10 @@
 
 config GENERIC_BUST_SPINLOCK
 	bool
+
+config GENERIC_RAW_MEMCPY_IO
+	bool
+	default y
 
 config ARCH_MAY_HAVE_PC_FDC
 	bool
diff -r b4863171295f -r 5673a186625f arch/arm26/Kconfig
--- a/arch/arm26/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/arm26/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -33,6 +33,10 @@
 config FORCE_MAX_ZONEORDER
         int
         default 9
+
+config GENERIC_RAW_MEMCPY_IO
+	bool
+	default y
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
diff -r b4863171295f -r 5673a186625f arch/cris/Kconfig
--- a/arch/cris/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/cris/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -17,6 +17,10 @@
 	bool
 
 config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f arch/frv/Kconfig
--- a/arch/frv/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/frv/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -24,6 +24,10 @@
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default n
+
+config GENERIC_RAW_MEMCPY_IO
+	bool
+	default y
 
 config GENERIC_HARDIRQS
 	bool
diff -r b4863171295f -r 5673a186625f arch/h8300/Kconfig
--- a/arch/h8300/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/h8300/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -30,6 +30,10 @@
 	default n
 
 config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f arch/i386/Kconfig
--- a/arch/i386/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/i386/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -34,6 +34,10 @@
 	default y
 
 config GENERIC_IOMAP
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f arch/ia64/Kconfig
--- a/arch/ia64/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/ia64/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -47,6 +47,10 @@
 	default y
 
 config GENERIC_IOMAP
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f arch/m32r/Kconfig
--- a/arch/m32r/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/m32r/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -25,6 +25,10 @@
 	default y
 
 config GENERIC_IRQ_PROBE
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f arch/m68k/Kconfig
--- a/arch/m68k/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/m68k/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -18,6 +18,10 @@
 	bool
 
 config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f arch/m68knommu/Kconfig
--- a/arch/m68knommu/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/m68knommu/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -26,6 +26,10 @@
 	default n
 
 config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f arch/mips/Kconfig
--- a/arch/mips/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/mips/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -800,6 +800,10 @@
 	bool
 
 config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f arch/parisc/Kconfig
--- a/arch/parisc/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/parisc/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -37,6 +37,10 @@
 
 config GENERIC_IRQ_PROBE
 	def_bool y
+
+config GENERIC_RAW_MEMCPY_IO
+	bool
+	default y
 
 # unless you want to implement ACPI on PA-RISC ... ;-)
 config PM
diff -r b4863171295f -r 5673a186625f arch/powerpc/Kconfig
--- a/arch/powerpc/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/powerpc/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -38,6 +38,10 @@
 	default y
 
 config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/ppc/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -16,6 +16,10 @@
 	bool
 
 config RWSEM_XCHGADD_ALGORITHM
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f arch/s390/Kconfig
--- a/arch/s390/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/s390/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -20,6 +20,10 @@
 
 config GENERIC_BUST_SPINLOCK
 	bool
+
+config GENERIC_RAW_MEMCPY_IO
+	bool
+	default y
 
 mainmenu "Linux Kernel Configuration"
 
diff -r b4863171295f -r 5673a186625f arch/sh/Kconfig
--- a/arch/sh/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/sh/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -30,6 +30,10 @@
 	default y
 
 config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f arch/sh64/Kconfig
--- a/arch/sh64/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/sh64/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -34,6 +34,10 @@
 
 config GENERIC_ISA_DMA
 	bool
+
+config GENERIC_RAW_MEMCPY_IO
+	bool
+	default y
 
 source init/Kconfig
 
diff -r b4863171295f -r 5673a186625f arch/sparc/Kconfig
--- a/arch/sparc/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/sparc/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -152,6 +152,10 @@
 	bool
 
 config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f arch/sparc64/Kconfig
--- a/arch/sparc64/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/sparc64/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -166,6 +166,10 @@
 	bool
 	default y
 
+config GENERIC_RAW_MEMCPY_IO
+	bool
+	default y
+
 choice
 	prompt "SPARC64 Huge TLB Page Size"
 	depends on HUGETLB_PAGE
diff -r b4863171295f -r 5673a186625f arch/v850/Kconfig
--- a/arch/v850/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/v850/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -17,6 +17,9 @@
 	bool
 	default n
 config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f arch/xtensa/Kconfig
--- a/arch/xtensa/Kconfig	Tue Jan 10 11:52:48 2006 -0800
+++ b/arch/xtensa/Kconfig	Tue Jan 10 11:52:51 2006 -0800
@@ -27,6 +27,10 @@
 	default y
 
 config GENERIC_HARDIRQS
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 
diff -r b4863171295f -r 5673a186625f include/asm-alpha/io.h
--- a/include/asm-alpha/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-alpha/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -504,6 +504,8 @@
 extern void memcpy_toio(volatile void __iomem *, const void *, long);
 extern void _memset_c_io(volatile void __iomem *, unsigned long, long);
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 static inline void memset_io(volatile void __iomem *addr, u8 c, long len)
 {
 	_memset_c_io(addr, 0x0101010101010101UL * c, len);
diff -r b4863171295f -r 5673a186625f include/asm-arm/io.h
--- a/include/asm-arm/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-arm/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -189,6 +189,8 @@
 #define memset_io(c,v,l)	_memset_io(__mem_pci(c),(v),(l))
 #define memcpy_fromio(a,c,l)	_memcpy_fromio((a),__mem_pci(c),(l))
 #define memcpy_toio(c,a,l)	_memcpy_toio(__mem_pci(c),(a),(l))
+
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
 
 #define eth_io_copy_and_sum(s,c,l,b) \
 				eth_copy_and_sum((s),__mem_pci(c),(l),(b))
diff -r b4863171295f -r 5673a186625f include/asm-cris/io.h
--- a/include/asm-cris/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-cris/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -121,6 +121,8 @@
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /*
  * Again, CRIS does not require mem IO specific function.
  */
diff -r b4863171295f -r 5673a186625f include/asm-frv/io.h
--- a/include/asm-frv/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-frv/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -127,6 +127,8 @@
 	memcpy((void __force *) dst, src, count);
 }
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 static inline uint8_t inb(unsigned long addr)
 {
 	return __builtin_read8((void *)addr);
diff -r b4863171295f -r 5673a186625f include/asm-h8300/io.h
--- a/include/asm-h8300/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-h8300/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -209,6 +209,8 @@
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 #define mmiowb()
 
 #define inb(addr)    ((h8300_buswidth(addr))?readw((addr) & ~1) & 0xff:readb(addr))
diff -r b4863171295f -r 5673a186625f include/asm-i386/io.h
--- a/include/asm-i386/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-i386/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -203,6 +203,8 @@
 {
 	__memcpy((void __force *) dst, src, count);
 }
+
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
 
 /*
  * ISA space is 'always mapped' on a typical x86 system, no need to
diff -r b4863171295f -r 5673a186625f include/asm-ia64/io.h
--- a/include/asm-ia64/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-ia64/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -444,6 +444,8 @@
 extern void memcpy_toio(volatile void __iomem *dst, const void *src, long n);
 extern void memset_io(volatile void __iomem *s, int c, long n);
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 #define dma_cache_inv(_start,_size)             do { } while (0)
 #define dma_cache_wback(_start,_size)           do { } while (0)
 #define dma_cache_wback_inv(_start,_size)       do { } while (0)
diff -r b4863171295f -r 5673a186625f include/asm-m32r/io.h
--- a/include/asm-m32r/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-m32r/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -216,6 +216,8 @@
 	memcpy((void __force *) dst, src, count);
 }
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff -r b4863171295f -r 5673a186625f include/asm-m68knommu/io.h
--- a/include/asm-m68knommu/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-m68knommu/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -113,6 +113,8 @@
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 #define inb(addr)    readb(addr)
 #define inw(addr)    readw(addr)
 #define inl(addr)    readl(addr)
diff -r b4863171295f -r 5673a186625f include/asm-mips/io.h
--- a/include/asm-mips/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-mips/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -534,6 +534,8 @@
 	memcpy((void __force *) dst, src, count);
 }
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /*
  * Memory Mapped I/O
  */
diff -r b4863171295f -r 5673a186625f include/asm-parisc/io.h
--- a/include/asm-parisc/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-parisc/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -294,6 +294,8 @@
 void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
 void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /* Support old drivers which don't ioremap.
  * NB this interface is scheduled to disappear in 2.5
  */
diff -r b4863171295f -r 5673a186625f include/asm-powerpc/io.h
--- a/include/asm-powerpc/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-powerpc/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -64,6 +64,8 @@
 #define memcpy_fromio(a,b,c)	iSeries_memcpy_fromio((a), (b), (c))
 #define memcpy_toio(a,b,c)	iSeries_memcpy_toio((a), (b), (c))
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 #define inb(addr)		readb(((void __iomem *)(long)(addr)))
 #define inw(addr)		readw(((void __iomem *)(long)(addr)))
 #define inl(addr)		readl(((void __iomem *)(long)(addr)))
diff -r b4863171295f -r 5673a186625f include/asm-ppc/io.h
--- a/include/asm-ppc/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-ppc/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -369,6 +369,8 @@
 }
 #endif
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 #define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void __force *)(void __iomem *)(b),(c),(d))
 
 /*
diff -r b4863171295f -r 5673a186625f include/asm-s390/io.h
--- a/include/asm-s390/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-s390/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -99,6 +99,8 @@
 #define memcpy_fromio(a,b,c)    memcpy((a),__io_virt(b),(c))
 #define memcpy_toio(a,b,c)      memcpy(__io_virt(a),(b),(c))
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 #define inb_p(addr) readb(addr)
 #define inb(addr) readb(addr)
 
diff -r b4863171295f -r 5673a186625f include/asm-sh/io.h
--- a/include/asm-sh/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-sh/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -177,6 +177,8 @@
 extern void memcpy_toio(unsigned long, const void *, unsigned long);
 extern void memset_io(unsigned long, int, unsigned long);
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /* SuperH on-chip I/O functions */
 static __inline__ unsigned char ctrl_inb(unsigned long addr)
 {
diff -r b4863171295f -r 5673a186625f include/asm-sh64/io.h
--- a/include/asm-sh64/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-sh64/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -125,6 +125,8 @@
 
 void memcpy_toio(void __iomem *to, const void *from, long count);
 void memcpy_fromio(void *to, void __iomem *from, long count);
+
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
 
 #define mmiowb()
 
diff -r b4863171295f -r 5673a186625f include/asm-sparc/io.h
--- a/include/asm-sparc/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-sparc/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -239,6 +239,8 @@
 
 #define memcpy_toio(d,s,sz)	_memcpy_toio(d,s,sz)
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 #ifdef __KERNEL__
 
 /*
diff -r b4863171295f -r 5673a186625f include/asm-sparc64/io.h
--- a/include/asm-sparc64/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-sparc64/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -440,6 +440,8 @@
 
 #define memcpy_toio(d,s,sz)	_memcpy_toio(d,s,sz)
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 static inline int check_signature(void __iomem *io_addr,
 				  const unsigned char *signature,
 				  int length)
diff -r b4863171295f -r 5673a186625f include/asm-v850/io.h
--- a/include/asm-v850/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-v850/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -130,6 +130,8 @@
 #define memcpy_fromio(dst, src, len) memcpy (dst, (void *)src, len)
 #define memcpy_toio(dst, src, len) memcpy ((void *)dst, src, len)
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff -r b4863171295f -r 5673a186625f include/asm-x86_64/io.h
--- a/include/asm-x86_64/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-x86_64/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -252,6 +252,14 @@
 	__memcpy_toio((unsigned long)to,from,len);
 }
 
+#include <asm/string.h>
+
+/* See lib/raw_memcpy_io.c for kernel doc. */
+static inline void __raw_memcpy_toio32(void __iomem *dst, const void *src, size_t count)
+{
+	memcpy32((void __force *) dst, src, count);
+}
+
 void memset_io(volatile void __iomem *a, int b, size_t c);
 
 /*
diff -r b4863171295f -r 5673a186625f include/asm-xtensa/io.h
--- a/include/asm-xtensa/io.h	Tue Jan 10 11:52:48 2006 -0800
+++ b/include/asm-xtensa/io.h	Tue Jan 10 11:52:51 2006 -0800
@@ -159,6 +159,8 @@
 #define memcpy_fromio(a,b,c)   memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)      memcpy((void *)(a),(b),(c))
 
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /* At this point the Xtensa doesn't provide byte swap instructions */
 
 #ifdef __XTENSA_EB__
