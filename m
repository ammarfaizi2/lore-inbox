Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbUDMI7Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbUDMI5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:57:07 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:29982 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S263376AbUDMIrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:47:04 -0400
Date: Tue, 13 Apr 2004 10:38:14 +0200
Message-Id: <200404130838.i3D8cEEY018479@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 433] m68k I/O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m68k: Use explicit-sized types for I/O accesses

--- linux-2.6.5-rc3/include/asm-m68k/io.h	2004-02-08 10:19:55.000000000 +0100
+++ linux-m68k-2.6.5-rc3/include/asm-m68k/io.h	2004-04-04 10:50:00.000000000 +0200
@@ -120,66 +120,66 @@
  * be compiled in so the case statement will be optimised away
  */
 
-static inline unsigned char *isa_itb(long addr)
+static inline u8 *isa_itb(long addr)
 {
   switch(ISA_TYPE)
     {
 #ifdef CONFIG_Q40
-    case Q40_ISA: return (unsigned char *)Q40_ISA_IO_B(addr);
+    case Q40_ISA: return (u8 *)Q40_ISA_IO_B(addr);
 #endif
 #ifdef CONFIG_GG2
-    case GG2_ISA: return (unsigned char *)GG2_ISA_IO_B(addr);
+    case GG2_ISA: return (u8 *)GG2_ISA_IO_B(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
-    case AG_ISA: return (unsigned char *)AG_ISA_IO_B(addr);
+    case AG_ISA: return (u8 *)AG_ISA_IO_B(addr);
 #endif
     default: return 0; /* avoid warnings, just in case */
     }
 }
-static inline unsigned short *isa_itw(long addr)
+static inline u16 *isa_itw(long addr)
 {
   switch(ISA_TYPE)
     {
 #ifdef CONFIG_Q40
-    case Q40_ISA: return (unsigned short *)Q40_ISA_IO_W(addr);
+    case Q40_ISA: return (u16 *)Q40_ISA_IO_W(addr);
 #endif
 #ifdef CONFIG_GG2
-    case GG2_ISA: return (unsigned short *)GG2_ISA_IO_W(addr);
+    case GG2_ISA: return (u16 *)GG2_ISA_IO_W(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
-    case AG_ISA: return (unsigned short *)AG_ISA_IO_W(addr);
+    case AG_ISA: return (u16 *)AG_ISA_IO_W(addr);
 #endif
     default: return 0; /* avoid warnings, just in case */
     }
 }
-static inline unsigned char *isa_mtb(long addr)
+static inline u8 *isa_mtb(long addr)
 {
   switch(ISA_TYPE)
     {
 #ifdef CONFIG_Q40
-    case Q40_ISA: return (unsigned char *)Q40_ISA_MEM_B(addr);
+    case Q40_ISA: return (u8 *)Q40_ISA_MEM_B(addr);
 #endif
 #ifdef CONFIG_GG2
-    case GG2_ISA: return (unsigned char *)GG2_ISA_MEM_B(addr);
+    case GG2_ISA: return (u8 *)GG2_ISA_MEM_B(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
-    case AG_ISA: return (unsigned char *)addr;
+    case AG_ISA: return (u8 *)addr;
 #endif
     default: return 0; /* avoid warnings, just in case */
     }
 }
-static inline unsigned short *isa_mtw(long addr)
+static inline u16 *isa_mtw(long addr)
 {
   switch(ISA_TYPE)
     {
 #ifdef CONFIG_Q40
-    case Q40_ISA: return (unsigned short *)Q40_ISA_MEM_W(addr);
+    case Q40_ISA: return (u16 *)Q40_ISA_MEM_W(addr);
 #endif
 #ifdef CONFIG_GG2
-    case GG2_ISA: return (unsigned short *)GG2_ISA_MEM_W(addr);
+    case GG2_ISA: return (u16 *)GG2_ISA_MEM_W(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
-    case AG_ISA: return (unsigned short *)addr;
+    case AG_ISA: return (u16 *)addr;
 #endif
     default: return 0; /* avoid warnings, just in case */
     }
@@ -213,7 +213,7 @@
     }
 }
 
-#define isa_inb_p(p)      ({unsigned char v=isa_inb(p);isa_delay();v;})
+#define isa_inb_p(p)      ({u8 v=isa_inb(p);isa_delay();v;})
 #define isa_outb_p(v,p)   ({isa_outb((v),(p));isa_delay();})
 
 #define isa_insb(port, buf, nr) raw_insb(isa_itb(port), (buf), (nr))
--- linux-2.6.5-rc3/include/asm-m68k/raw_io.h	2003-05-09 11:04:08.000000000 +0200
+++ linux-m68k-2.6.5-rc3/include/asm-m68k/raw_io.h	2004-03-31 12:56:56.000000000 +0200
@@ -10,6 +10,8 @@
 
 #ifdef __KERNEL__
 
+#include <asm/types.h>
+
 
 /* Values for nocacheflag and cmode */
 #define IOMAP_FULL_CACHING		0
@@ -28,21 +30,21 @@
  * two accesses to memory, which may be undesirable for some devices.
  */
 #define in_8(addr) \
-    ({ unsigned char __v = (*(volatile unsigned char *) (addr)); __v; })
+    ({ u8 __v = (*(volatile u8 *) (addr)); __v; })
 #define in_be16(addr) \
-    ({ unsigned short __v = (*(volatile unsigned short *) (addr)); __v; })
+    ({ u16 __v = (*(volatile u16 *) (addr)); __v; })
 #define in_be32(addr) \
-    ({ unsigned int __v = (*(volatile unsigned int *) (addr)); __v; })
+    ({ u32 __v = (*(volatile u32 *) (addr)); __v; })
 #define in_le16(addr) \
-    ({ unsigned short __v = le16_to_cpu(*(volatile unsigned short *) (addr)); __v; })
+    ({ u16 __v = le16_to_cpu(*(volatile u16 *) (addr)); __v; })
 #define in_le32(addr) \
-    ({ unsigned int __v = le32_to_cpu(*(volatile unsigned int *) (addr)); __v; })
+    ({ u32 __v = le32_to_cpu(*(volatile u32 *) (addr)); __v; })
 
-#define out_8(addr,b) (void)((*(volatile unsigned char *) (addr)) = (b))
-#define out_be16(addr,w) (void)((*(volatile unsigned short *) (addr)) = (w))
-#define out_be32(addr,l) (void)((*(volatile unsigned int *) (addr)) = (l))
-#define out_le16(addr,w) (void)((*(volatile unsigned short *) (addr)) = cpu_to_le16(w))
-#define out_le32(addr,l) (void)((*(volatile unsigned int *) (addr)) = cpu_to_le32(l))
+#define out_8(addr,b) (void)((*(volatile u8 *) (addr)) = (b))
+#define out_be16(addr,w) (void)((*(volatile u16 *) (addr)) = (w))
+#define out_be32(addr,l) (void)((*(volatile u32 *) (addr)) = (l))
+#define out_le16(addr,w) (void)((*(volatile u16 *) (addr)) = cpu_to_le16(w))
+#define out_le32(addr,l) (void)((*(volatile u32 *) (addr)) = cpu_to_le32(l))
 
 #define raw_inb in_8
 #define raw_inw in_be16
@@ -52,8 +54,7 @@
 #define raw_outw(val,port) out_be16((port),(val))
 #define raw_outl(val,port) out_be32((port),(val))
 
-static inline void raw_insb(volatile unsigned char *port, unsigned char *buf,
-			    unsigned int len)
+static inline void raw_insb(volatile u8 *port, u8 *buf, unsigned int len)
 {
 	unsigned int i;
 
@@ -61,8 +62,8 @@
 		*buf++ = in_8(port);
 }
 
-static inline void raw_outsb(volatile unsigned char *port,
-			     const unsigned char *buf, unsigned int len)
+static inline void raw_outsb(volatile u8 *port, const u8 *buf,
+			     unsigned int len)
 {
 	unsigned int i;
 
@@ -70,8 +71,7 @@
 		out_8(port, *buf++);
 }
 
-static inline void raw_insw(volatile unsigned short *port, unsigned short *buf,
-			    unsigned int nr)
+static inline void raw_insw(volatile u16 *port, u16 *buf, unsigned int nr)
 {
 	unsigned int tmp;
 
@@ -110,8 +110,8 @@
 	}
 }
 
-static inline void raw_outsw(volatile unsigned short *port,
-			     const unsigned short *buf, unsigned int nr)
+static inline void raw_outsw(volatile u16 *port, const u16 *buf,
+			     unsigned int nr)
 {
 	unsigned int tmp;
 
@@ -150,8 +150,7 @@
 	}
 }
 
-static inline void raw_insl(volatile unsigned int *port, unsigned int *buf,
-			    unsigned int nr)
+static inline void raw_insl(volatile u32 *port, u32 *buf, unsigned int nr)
 {
 	unsigned int tmp;
 
@@ -190,8 +189,8 @@
 	}
 }
 
-static inline void raw_outsl(volatile unsigned int *port,
-			     const unsigned int *buf, unsigned int nr)
+static inline void raw_outsl(volatile u32 *port, const u32 *buf,
+			     unsigned int nr)
 {
 	unsigned int tmp;
 
@@ -231,8 +230,8 @@
 }
 
 
-static inline void raw_insw_swapw(volatile unsigned short *port,
-				  unsigned short *buf, unsigned int nr)
+static inline void raw_insw_swapw(volatile u16 *port, u16 *buf,
+				  unsigned int nr)
 {
     if ((nr) % 8)
 	__asm__ __volatile__
@@ -284,8 +283,8 @@
 		: "d0", "a0", "a1", "d6");
 }
 
-static inline void raw_outsw_swapw(volatile unsigned short *port,
-				   const unsigned short *buf, unsigned int nr)
+static inline void raw_outsw_swapw(volatile u16 *port, const u16 *buf,
+				   unsigned int nr)
 {
     if ((nr) % 8)
 	__asm__ __volatile__


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
