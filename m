Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbUKQKcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbUKQKcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 05:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbUKQKcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 05:32:19 -0500
Received: from mail.renesas.com ([202.234.163.13]:4285 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261945AbUKQKZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 05:25:27 -0500
Date: Wed, 17 Nov 2004 19:25:14 +0900 (JST)
Message-Id: <20041117.192514.295395978.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc2-bk1] m32r: io_xxxxx.c cleanups
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just cleanups for arch/m32r/kernel/io*.c.
- Fix ugly indentation.
- Change __inline__ to inline.
- Remove RCS ID strings.

Regards,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 io_m32700ut.c |  147 +++++++++++++++++++++++++++----------------------
 io_mappi.c    |  172 +++++++++++++++++++++++++++++++---------------------------
 io_mappi2.c   |  134 +++++++++++++++++++++++++--------------------
 io_oaks32r.c  |   66 ++++++++++++----------
 io_opsput.c   |  131 ++++++++++++++++++++++++--------------------
 io_usrv.c     |    6 +-
 6 files changed, 364 insertions(+), 292 deletions(-)


diff -ruNp a/arch/m32r/kernel/io_m32700ut.c b/arch/m32r/kernel/io_m32700ut.c
--- a/arch/m32r/kernel/io_m32700ut.c	2004-11-17 10:32:49.000000000 +0900
+++ b/arch/m32r/kernel/io_m32700ut.c	2004-11-17 19:18:57.000000000 +0900
@@ -9,7 +9,6 @@
  *  This file is subject to the terms and conditions of the GNU General
  *  Public License.  See the file "COPYING" in the main directory of this
  *  archive for more details.
- *
  */
 
 #include <linux/config.h>
@@ -32,16 +31,16 @@ extern void pcc_iowrite_byte(int, unsign
 extern void pcc_iowrite_word(int, unsigned long, void *, size_t, size_t, int);
 #endif /* CONFIG_PCMCIA && CONFIG_M32R_CFC */
 
-#define PORT2ADDR(port)	     _port2addr(port)
-#define PORT2ADDR_USB(port)  _port2addr_usb(port)
+#define PORT2ADDR(port)		_port2addr(port)
+#define PORT2ADDR_USB(port)	_port2addr_usb(port)
 
-static __inline__ void *_port2addr(unsigned long port)
+static inline void *_port2addr(unsigned long port)
 {
 	return (void *)(port + NONCACHE_OFFSET);
 }
 
 #if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-static __inline__ void *__port2addr_ata(unsigned long port)
+static inline void *__port2addr_ata(unsigned long port)
 {
 	static int	dummy_reg;
 
@@ -67,16 +66,16 @@ static __inline__ void *__port2addr_ata(
  */
 #define LAN_IOSTART	0x300
 #define LAN_IOEND	0x320
-static __inline__ void *_port2addr_ne(unsigned long port)
+static inline void *_port2addr_ne(unsigned long port)
 {
 	return (void *)(port + NONCACHE_OFFSET + 0x10000000);
 }
-static __inline__ void *_port2addr_usb(unsigned long port)
+static inline void *_port2addr_usb(unsigned long port)
 {
-  return (void *)((port & 0x0f) + NONCACHE_OFFSET + 0x10303000);
+	return (void *)((port & 0x0f) + NONCACHE_OFFSET + 0x10303000);
 }
 
-static __inline__ void delay(void)
+static inline void delay(void)
 {
 	__asm__ __volatile__ ("push r0; \n\t pop r0;" : : :"memory");
 }
@@ -87,29 +86,30 @@ static __inline__ void delay(void)
 
 #define PORT2ADDR_NE(port)  _port2addr_ne(port)
 
-static __inline__ unsigned char _ne_inb(void *portp)
+static inline unsigned char _ne_inb(void *portp)
 {
 	return *(volatile unsigned char *)portp;
 }
 
-static __inline__ unsigned short _ne_inw(void *portp)
+static inline unsigned short _ne_inw(void *portp)
 {
 	return (unsigned short)le16_to_cpu(*(volatile unsigned short *)portp);
 }
 
-static __inline__ void _ne_insb(void *portp, void * addr, unsigned long count)
+static inline void _ne_insb(void *portp, void *addr, unsigned long count)
 {
 	unsigned char *buf = (unsigned char *)addr;
 
-	while (count--) *buf++ = _ne_inb(portp);
+	while (count--)
+		*buf++ = _ne_inb(portp);
 }
 
-static __inline__ void _ne_outb(unsigned char b, void *portp)
+static inline void _ne_outb(unsigned char b, void *portp)
 {
 	*(volatile unsigned char *)portp = b;
 }
 
-static __inline__ void _ne_outw(unsigned short w, void *portp)
+static inline void _ne_outw(unsigned short w, void *portp)
 {
 	*(volatile unsigned short *)portp = cpu_to_le16(w);
 }
@@ -126,9 +126,9 @@ unsigned char _inb(unsigned long port)
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned char b;
-	   pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
-	   return b;
+		unsigned char b;
+		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
+		return b;
 	} else
 #endif
 
@@ -146,13 +146,13 @@ unsigned short _inw(unsigned long port)
 #endif
 #if defined(CONFIG_USB)
 	else if(port >= 0x340 && port < 0x3a0)
-	  return *(volatile unsigned short *)PORT2ADDR_USB(port);
+		return *(volatile unsigned short *)PORT2ADDR_USB(port);
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned short w;
-	   pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
-	   return w;
+		unsigned short w;
+		pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
+		return w;
 	} else
 #endif
 	return *(volatile unsigned short *)PORT2ADDR(port);
@@ -162,9 +162,9 @@ unsigned long _inl(unsigned long port)
 {
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned long l;
-	   pcc_ioread_word(0, port, &l, sizeof(l), 1, 0);
-	   return l;
+		unsigned long l;
+		pcc_ioread_word(0, port, &l, sizeof(l), 1, 0);
+		return l;
 	} else
 #endif
 	return *(volatile unsigned long *)PORT2ADDR(port);
@@ -184,9 +184,9 @@ unsigned char _inb_p(unsigned long port)
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned char b;
-	   pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
-	   return b;
+		unsigned char b;
+		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
+		return b;
 	} else
 #endif
 		v = *(volatile unsigned char *)PORT2ADDR(port);
@@ -208,15 +208,15 @@ unsigned short _inw_p(unsigned long port
 	} else
 #endif
 #if defined(CONFIG_USB)
-	  if(port >= 0x340 && port < 0x3a0)
-	    return *(volatile unsigned short *)PORT2ADDR_USB(port);
+	if(port >= 0x340 && port < 0x3a0)
+		return *(volatile unsigned short *)PORT2ADDR_USB(port);
 	else
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned short w;
-	   pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
-	   return w;
+		unsigned short w;
+		pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
+		return w;
 	} else
 #endif
 		v = *(volatile unsigned short *)PORT2ADDR(port);
@@ -246,7 +246,7 @@ void _outb(unsigned char b, unsigned lon
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
+		pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
 	} else
 #endif
 		*(volatile unsigned char *)PORT2ADDR(port) = b;
@@ -264,12 +264,12 @@ void _outw(unsigned short w, unsigned lo
 #endif
 #if defined(CONFIG_USB)
 	if(port >= 0x340 && port < 0x3a0)
-	  *(volatile unsigned short *)PORT2ADDR_USB(port) = w;
+		*(volatile unsigned short *)PORT2ADDR_USB(port) = w;
 	else
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
+		pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
 	} else
 #endif
 		*(volatile unsigned short *)PORT2ADDR(port) = w;
@@ -279,7 +279,7 @@ void _outl(unsigned long l, unsigned lon
 {
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_word(0, port, &l, sizeof(l), 1, 0);
+		pcc_iowrite_word(0, port, &l, sizeof(l), 1, 0);
 	} else
 #endif
 	*(volatile unsigned long *)PORT2ADDR(port) = l;
@@ -297,7 +297,7 @@ void _outb_p(unsigned char b, unsigned l
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
+		pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
 	} else
 #endif
 		*(volatile unsigned char *)PORT2ADDR(port) = b;
@@ -316,13 +316,13 @@ void _outw_p(unsigned short w, unsigned 
 	} else
 #endif
 #if defined(CONFIG_USB)
-	  if(port >= 0x340 && port < 0x3a0)
-	    *(volatile unsigned short *)PORT2ADDR_USB(port) = w;
+	if(port >= 0x340 && port < 0x3a0)
+		*(volatile unsigned short *)PORT2ADDR_USB(port) = w;
 	else
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
+		pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
 	} else
 #endif
 		*(volatile unsigned short *)PORT2ADDR(port) = w;
@@ -336,7 +336,7 @@ void _outl_p(unsigned long l, unsigned l
 	delay();
 }
 
-void _insb(unsigned int port, void * addr, unsigned long count)
+void _insb(unsigned int port, void *addr, unsigned long count)
 {
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_insb(PORT2ADDR_NE(port), addr, count);
@@ -344,22 +344,25 @@ void _insb(unsigned int port, void * add
 	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		unsigned char *buf = addr;
 		unsigned char *portp = __port2addr_ata(port);
-		while(count--) *buf++ = *(volatile unsigned char *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned char *)portp;
 	}
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	  else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_ioread_byte(0, port, (void *)addr, sizeof(unsigned char), count, 1);
+	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		pcc_ioread_byte(0, port, (void *)addr, sizeof(unsigned char),
+				count, 1);
 	}
 #endif
 	else {
 		unsigned char *buf = addr;
 		unsigned char *portp = PORT2ADDR(port);
-		while(count--) *buf++ = *(volatile unsigned char *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned char *)portp;
 	}
 }
 
-void _insw(unsigned int port, void * addr, unsigned long count)
+void _insw(unsigned int port, void *addr, unsigned long count)
 {
 	unsigned short *buf = addr;
 	unsigned short *portp;
@@ -370,55 +373,64 @@ void _insw(unsigned int port, void * add
 		 * from the DATA_REG. Do not swap the data.
 		 */
 		portp = PORT2ADDR_NE(port);
-		while (count--) *buf++ = *(volatile unsigned short *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned short *)portp;
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_ioread_word(9, port, (void *)addr, sizeof(unsigned short), count, 1);
+		pcc_ioread_word(9, port, (void *)addr, sizeof(unsigned short),
+				count, 1);
 #endif
 #if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		portp = __port2addr_ata(port);
-		while (count--) *buf++ = *(volatile unsigned short *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned short *)portp;
 #endif
 	} else {
 		portp = PORT2ADDR(port);
-		while (count--) *buf++ = *(volatile unsigned short *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned short *)portp;
 	}
 }
 
-void _insl(unsigned int port, void * addr, unsigned long count)
+void _insl(unsigned int port, void *addr, unsigned long count)
 {
 	unsigned long *buf = addr;
 	unsigned long *portp;
 
 	portp = PORT2ADDR(port);
-	while (count--) *buf++ = *(volatile unsigned long *)portp;
+	while (count--)
+		*buf++ = *(volatile unsigned long *)portp;
 }
 
-void _outsb(unsigned int port, const void * addr, unsigned long count)
+void _outsb(unsigned int port, const void *addr, unsigned long count)
 {
 	const unsigned char *buf = addr;
 	unsigned char *portp;
 
 	if (port >= LAN_IOSTART && port < LAN_IOEND) {
 		portp = PORT2ADDR_NE(port);
-		while (count--) _ne_outb(*buf++, portp);
+		while (count--)
+			_ne_outb(*buf++, portp);
 #if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		portp = __port2addr_ata(port);
-		while(count--) *(volatile unsigned char *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned char *)portp = *buf++;
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_byte(0, port, (void *)addr, sizeof(unsigned char), count, 1);
+		pcc_iowrite_byte(0, port, (void *)addr, sizeof(unsigned char),
+				 count, 1);
 #endif
 	} else {
 		portp = PORT2ADDR(port);
-		while(count--) *(volatile unsigned char *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned char *)portp = *buf++;
 	}
 }
 
-void _outsw(unsigned int port, const void * addr, unsigned long count)
+void _outsw(unsigned int port, const void *addr, unsigned long count)
 {
 	const unsigned short *buf = addr;
 	unsigned short *portp;
@@ -429,27 +441,32 @@ void _outsw(unsigned int port, const voi
 		 * into the DATA_REG. Do not swap the data.
 		 */
 		portp = PORT2ADDR_NE(port);
-		while(count--) *(volatile unsigned short *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned short *)portp = *buf++;
 #if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		portp = __port2addr_ata(port);
-		while(count--) *(volatile unsigned short *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned short *)portp = *buf++;
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_word(9, port, (void *)addr, sizeof(unsigned short), count, 1);
+		pcc_iowrite_word(9, port, (void *)addr, sizeof(unsigned short),
+				 count, 1);
 #endif
 	} else {
 		portp = PORT2ADDR(port);
-		while(count--) *(volatile unsigned short *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned short *)portp = *buf++;
 	}
 }
 
-void _outsl(unsigned int port, const void * addr, unsigned long count)
+void _outsl(unsigned int port, const void *addr, unsigned long count)
 {
 	const unsigned long *buf = addr;
 	unsigned char *portp;
 
 	portp = PORT2ADDR(port);
-	while(count--) *(volatile unsigned long *)portp = *buf++;
+	while (count--)
+		*(volatile unsigned long *)portp = *buf++;
 }
diff -ruNp a/arch/m32r/kernel/io_mappi.c b/arch/m32r/kernel/io_mappi.c
--- a/arch/m32r/kernel/io_mappi.c	2004-11-15 12:16:47.000000000 +0900
+++ b/arch/m32r/kernel/io_mappi.c	2004-11-17 19:16:18.000000000 +0900
@@ -7,8 +7,6 @@
  *                            Hitoshi Yamamoto
  */
 
-/* $Id: io_mappi.c,v 1.9 2003/12/02 07:18:08 fujiwara Exp $ */
-
 #include <linux/config.h>
 #include <asm/m32r.h>
 #include <asm/page.h>
@@ -31,17 +29,17 @@ extern void pcc_iowrite(int, unsigned lo
 
 #define PORT2ADDR(port)  _port2addr(port)
 
-static __inline__ void *_port2addr(unsigned long port)
+static inline void *_port2addr(unsigned long port)
 {
 	return (void *)(port + NONCACHE_OFFSET);
 }
 
-static __inline__ void *_port2addr_ne(unsigned long port)
+static inline void *_port2addr_ne(unsigned long port)
 {
 	return (void *)((port<<1) + NONCACHE_OFFSET + 0x0C000000);
 }
 
-static __inline__ void delay(void)
+static inline void delay(void)
 {
 	__asm__ __volatile__ ("push r0; \n\t pop r0;" : : :"memory");
 }
@@ -52,12 +50,12 @@ static __inline__ void delay(void)
 
 #define PORT2ADDR_NE(port)  _port2addr_ne(port)
 
-static __inline__ unsigned char _ne_inb(void *portp)
+static inline unsigned char _ne_inb(void *portp)
 {
 	return (unsigned char) *(volatile unsigned short *)portp;
 }
 
-static __inline__ unsigned short _ne_inw(void *portp)
+static inline unsigned short _ne_inw(void *portp)
 {
 	unsigned short tmp;
 
@@ -65,12 +63,12 @@ static __inline__ unsigned short _ne_inw
 	return le16_to_cpu(tmp);
 }
 
-static __inline__ void _ne_outb(unsigned char b, void *portp)
+static inline void _ne_outb(unsigned char b, void *portp)
 {
 	*(volatile unsigned short *)portp = (unsigned short)b;
 }
 
-static __inline__ void _ne_outw(unsigned short w, void *portp)
+static inline void _ne_outw(unsigned short w, void *portp)
 {
 	*(volatile unsigned short *)portp = cpu_to_le16(w);
 }
@@ -82,13 +80,13 @@ unsigned char _inb(unsigned long port)
 	else
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
         if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned char b;
-	   pcc_ioread(0, port, &b, sizeof(b), 1, 0);
-	   return b;
-	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-	  unsigned char b;
-	   pcc_ioread(1, port, &b, sizeof(b), 1, 0);
-	   return b;
+		unsigned char b;
+		pcc_ioread(0, port, &b, sizeof(b), 1, 0);
+		return b;
+	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
+		unsigned char b;
+		pcc_ioread(1, port, &b, sizeof(b), 1, 0);
+		return b;
 	} else
 #endif
 
@@ -102,13 +100,13 @@ unsigned short _inw(unsigned long port)
 	else
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned short w;
-	   pcc_ioread(0, port, &w, sizeof(w), 1, 0);
-	   return w;
-	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-	   unsigned short w;
-	   pcc_ioread(1, port, &w, sizeof(w), 1, 0);
-	   return w;
+		unsigned short w;
+		pcc_ioread(0, port, &w, sizeof(w), 1, 0);
+		return w;
+	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
+		unsigned short w;
+		pcc_ioread(1, port, &w, sizeof(w), 1, 0);
+		return w;
 	} else
 #endif
 	return *(volatile unsigned short *)PORT2ADDR(port);
@@ -118,13 +116,13 @@ unsigned long _inl(unsigned long port)
 {
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned long l;
-	   pcc_ioread(0, port, &l, sizeof(l), 1, 0);
-	   return l;
-	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-	   unsigned short l;
-	   pcc_ioread(1, port, &l, sizeof(l), 1, 0);
-	   return l;
+		unsigned long l;
+		pcc_ioread(0, port, &l, sizeof(l), 1, 0);
+		return l;
+	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
+		unsigned short l;
+		pcc_ioread(1, port, &l, sizeof(l), 1, 0);
+		return l;
 	} else
 #endif
 	return *(volatile unsigned long *)PORT2ADDR(port);
@@ -139,13 +137,13 @@ unsigned char _inb_p(unsigned long port)
 	else
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned char b;
-	   pcc_ioread(0, port, &b, sizeof(b), 1, 0);
-	   return b;
-	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-	  unsigned char b;
-	   pcc_ioread(1, port, &b, sizeof(b), 1, 0);
-	   return b;
+		unsigned char b;
+		pcc_ioread(0, port, &b, sizeof(b), 1, 0);
+		return b;
+	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
+		unsigned char b;
+		pcc_ioread(1, port, &b, sizeof(b), 1, 0);
+		return b;
 	} else
 #endif
 		v = *(volatile unsigned char *)PORT2ADDR(port);
@@ -163,13 +161,13 @@ unsigned short _inw_p(unsigned long port
 	else
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned short w;
-	   pcc_ioread(0, port, &w, sizeof(w), 1, 0);
-	   return w;
-	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-	   unsigned short w;
-	   pcc_ioread(1, port, &w, sizeof(w), 1, 0);
-	   return w;
+		unsigned short w;
+		pcc_ioread(0, port, &w, sizeof(w), 1, 0);
+		return w;
+	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
+		unsigned short w;
+		pcc_ioread(1, port, &w, sizeof(w), 1, 0);
+		return w;
 	} else
 #endif
 		v = *(volatile unsigned short *)PORT2ADDR(port);
@@ -194,9 +192,9 @@ void _outb(unsigned char b, unsigned lon
 	else
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite(0, port, &b, sizeof(b), 1, 0);
+		pcc_iowrite(0, port, &b, sizeof(b), 1, 0);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-	   pcc_iowrite(1, port, &b, sizeof(b), 1, 0);
+		pcc_iowrite(1, port, &b, sizeof(b), 1, 0);
 	} else
 #endif
 		*(volatile unsigned char *)PORT2ADDR(port) = b;
@@ -209,9 +207,9 @@ void _outw(unsigned short w, unsigned lo
 	else
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite(0, port, &w, sizeof(w), 1, 0);
+		pcc_iowrite(0, port, &w, sizeof(w), 1, 0);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-	   pcc_iowrite(1, port, &w, sizeof(w), 1, 0);
+		pcc_iowrite(1, port, &w, sizeof(w), 1, 0);
 	} else
 #endif
 		*(volatile unsigned short *)PORT2ADDR(port) = w;
@@ -221,9 +219,9 @@ void _outl(unsigned long l, unsigned lon
 {
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite(0, port, &l, sizeof(l), 1, 0);
+		pcc_iowrite(0, port, &l, sizeof(l), 1, 0);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-	   pcc_iowrite(1, port, &l, sizeof(l), 1, 0);
+		pcc_iowrite(1, port, &l, sizeof(l), 1, 0);
 	} else
 #endif
 	*(volatile unsigned long *)PORT2ADDR(port) = l;
@@ -236,9 +234,9 @@ void _outb_p(unsigned char b, unsigned l
 	else
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite(0, port, &b, sizeof(b), 1, 0);
+		pcc_iowrite(0, port, &b, sizeof(b), 1, 0);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-	   pcc_iowrite(1, port, &b, sizeof(b), 1, 0);
+		pcc_iowrite(1, port, &b, sizeof(b), 1, 0);
 	} else
 #endif
 		*(volatile unsigned char *)PORT2ADDR(port) = b;
@@ -253,9 +251,9 @@ void _outw_p(unsigned short w, unsigned 
 	else
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite(0, port, &w, sizeof(w), 1, 0);
+		pcc_iowrite(0, port, &w, sizeof(w), 1, 0);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-	   pcc_iowrite(1, port, &w, sizeof(w), 1, 0);
+		pcc_iowrite(1, port, &w, sizeof(w), 1, 0);
 	} else
 #endif
 		*(volatile unsigned short *)PORT2ADDR(port) = w;
@@ -269,100 +267,118 @@ void _outl_p(unsigned long l, unsigned l
 	delay();
 }
 
-void _insb(unsigned int port, void * addr, unsigned long count)
+void _insb(unsigned int port, void *addr, unsigned long count)
 {
 	unsigned short *buf = addr;
 	unsigned short *portp;
 
 	if (port >= 0x300 && port < 0x320){
 		portp = PORT2ADDR_NE(port);
-		while(count--) *buf++ = *(volatile unsigned char *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned char *)portp;
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_ioread(0, port, (void *)addr, sizeof(unsigned char), count, 1);
+		pcc_ioread(0, port, (void *)addr, sizeof(unsigned char),
+			   count, 1);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-	   pcc_ioread(1, port, (void *)addr, sizeof(unsigned char), count, 1);
+		pcc_ioread(1, port, (void *)addr, sizeof(unsigned char),
+			   count, 1);
 #endif
 	} else {
 		portp = PORT2ADDR(port);
-		while(count--) *buf++ = *(volatile unsigned char *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned char *)portp;
 	}
 }
 
-void _insw(unsigned int port, void * addr, unsigned long count)
+void _insw(unsigned int port, void *addr, unsigned long count)
 {
 	unsigned short *buf = addr;
 	unsigned short *portp;
 
 	if (port >= 0x300 && port < 0x320) {
 		portp = PORT2ADDR_NE(port);
-		while (count--) *buf++ = _ne_inw(portp);
+		while (count--)
+			*buf++ = _ne_inw(portp);
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_ioread(0, port, (void *)addr, sizeof(unsigned short), count, 1);
+		pcc_ioread(0, port, (void *)addr, sizeof(unsigned short),
+			   count, 1);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-	   pcc_ioread(1, port, (void *)addr, sizeof(unsigned short), count, 1);
+		pcc_ioread(1, port, (void *)addr, sizeof(unsigned short),
+			   count, 1);
 #endif
 	} else {
 		portp = PORT2ADDR(port);
-		while (count--) *buf++ = *(volatile unsigned short *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned short *)portp;
 	}
 }
 
-void _insl(unsigned int port, void * addr, unsigned long count)
+void _insl(unsigned int port, void *addr, unsigned long count)
 {
 	unsigned long *buf = addr;
 	unsigned long *portp;
 
 	portp = PORT2ADDR(port);
-	while (count--) *buf++ = *(volatile unsigned long *)portp;
+	while (count--)
+		*buf++ = *(volatile unsigned long *)portp;
 }
 
-void _outsb(unsigned int port, const void * addr, unsigned long count)
+void _outsb(unsigned int port, const void *addr, unsigned long count)
 {
 	const unsigned char *buf = addr;
 	unsigned char *portp;
 
 	if (port >= 0x300 && port < 0x320) {
 		portp = PORT2ADDR_NE(port);
-		while (count--) _ne_outb(*buf++, portp);
+		while (count--)
+			_ne_outb(*buf++, portp);
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite(0, port, (void *)addr, sizeof(unsigned char), count, 1);
+		pcc_iowrite(0, port, (void *)addr, sizeof(unsigned char),
+			    count, 1);
 	} else if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-	   pcc_iowrite(1, port, (void *)addr, sizeof(unsigned char), count, 1);
+		pcc_iowrite(1, port, (void *)addr, sizeof(unsigned char),
+			    count, 1);
 #endif
 	} else {
 		portp = PORT2ADDR(port);
-		while(count--) *(volatile unsigned char *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned char *)portp = *buf++;
 	}
 }
 
-void _outsw(unsigned int port, const void * addr, unsigned long count)
+void _outsw(unsigned int port, const void *addr, unsigned long count)
 {
 	const unsigned short *buf = addr;
 	unsigned short *portp;
 
 	if (port >= 0x300 && port < 0x320) {
 		portp = PORT2ADDR_NE(port);
-		while (count--) _ne_outw(*buf++, portp);
+		while (count--)
+			_ne_outw(*buf++, portp);
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite(0, port, (void *)addr, sizeof(unsigned short), count, 1);
+		pcc_iowrite(0, port, (void *)addr, sizeof(unsigned short),
+			    count, 1);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-	   pcc_iowrite(1, port, (void *)addr, sizeof(unsigned short), count, 1);
+		pcc_iowrite(1, port, (void *)addr, sizeof(unsigned short),
+			    count, 1);
 #endif
 	} else {
 		portp = PORT2ADDR(port);
-		while(count--) *(volatile unsigned short *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned short *)portp = *buf++;
 	}
 }
 
-void _outsl(unsigned int port, const void * addr, unsigned long count)
+void _outsl(unsigned int port, const void *addr, unsigned long count)
 {
 	const unsigned long *buf = addr;
 	unsigned char *portp;
 
 	portp = PORT2ADDR(port);
-	while(count--) *(volatile unsigned long *)portp = *buf++;
+	while (count--)
+		*(volatile unsigned long *)portp = *buf++;
 }
diff -ruNp a/arch/m32r/kernel/io_mappi2.c b/arch/m32r/kernel/io_mappi2.c
--- a/arch/m32r/kernel/io_mappi2.c	2004-11-17 10:32:49.000000000 +0900
+++ b/arch/m32r/kernel/io_mappi2.c	2004-11-17 19:16:18.000000000 +0900
@@ -4,11 +4,9 @@
  *  Typical I/O routines for Mappi2 board.
  *
  *  Copyright (c) 2001-2003  Hiroyuki Kondo, Hirokazu Takata,
- *                            Hitoshi Yamamoto, Mamoru Sakugawa
+ *                           Hitoshi Yamamoto, Mamoru Sakugawa
  */
 
-/* $Id:$ */
-
 #include <linux/config.h>
 #include <asm/m32r.h>
 #include <asm/page.h>
@@ -33,7 +31,7 @@ extern void pcc_iowrite_word(int, unsign
 #define PORT2ADDR_NE(port)   _port2addr_ne(port)
 #define PORT2ADDR_USB(port)  _port2addr_usb(port)
 
-static __inline__ void *_port2addr(unsigned long port)
+static inline void *_port2addr(unsigned long port)
 {
 	return (void *)(port + NONCACHE_OFFSET);
 }
@@ -42,7 +40,7 @@ static __inline__ void *_port2addr(unsig
 #define LAN_IOEND	0x320
 
 #if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-static __inline__ void *__port2addr_ata(unsigned long port)
+static inline void *__port2addr_ata(unsigned long port)
 {
 	static int	dummy_reg;
 
@@ -62,21 +60,21 @@ static __inline__ void *__port2addr_ata(
 #endif
 
 #ifdef CONFIG_CHIP_OPSP
-static __inline__ void *_port2addr_ne(unsigned long port)
+static inline void *_port2addr_ne(unsigned long port)
 {
 	return (void *)(port + NONCACHE_OFFSET + 0x10000000);
 }
 #else
-static __inline__ void *_port2addr_ne(unsigned long port)
+static inline void *_port2addr_ne(unsigned long port)
 {
 	return (void *)(port + NONCACHE_OFFSET + 0x04000000);
 }
 #endif
-static __inline__ void *_port2addr_usb(unsigned long port)
+static inline void *_port2addr_usb(unsigned long port)
 {
 	return (void *)(port + NONCACHE_OFFSET + 0x14000000);
 }
-static __inline__ void delay(void)
+static inline void delay(void)
 {
 	__asm__ __volatile__ ("push r0; \n\t pop r0;" : : :"memory");
 }
@@ -85,29 +83,30 @@ static __inline__ void delay(void)
  * NIC I/O function
  */
 
-static __inline__ unsigned char _ne_inb(void *portp)
+static inline unsigned char _ne_inb(void *portp)
 {
 	return (unsigned char) *(volatile unsigned char *)portp;
 }
 
-static __inline__ unsigned short _ne_inw(void *portp)
+static inline unsigned short _ne_inw(void *portp)
 {
 	return (unsigned short)le16_to_cpu(*(volatile unsigned short *)portp);
 }
 
-static __inline__ void _ne_insb(void *portp, void * addr, unsigned long count)
+static inline void _ne_insb(void *portp, void * addr, unsigned long count)
 {
 	unsigned char *buf = addr;
 
-	while (count--) *buf++ = *(volatile unsigned char *)portp;
+	while (count--)
+		*buf++ = *(volatile unsigned char *)portp;
 }
 
-static __inline__ void _ne_outb(unsigned char b, void *portp)
+static inline void _ne_outb(unsigned char b, void *portp)
 {
 	*(volatile unsigned char *)portp = (unsigned char)b;
 }
 
-static __inline__ void _ne_outw(unsigned short w, void *portp)
+static inline void _ne_outw(unsigned short w, void *portp)
 {
 	*(volatile unsigned short *)portp = cpu_to_le16(w);
 }
@@ -123,9 +122,9 @@ unsigned char _inb(unsigned long port)
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned char b;
-	   pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
-	   return b;
+		unsigned char b;
+		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
+		return b;
 	} else
 #endif
 
@@ -143,14 +142,14 @@ unsigned short _inw(unsigned long port)
 #endif
 #if defined(CONFIG_USB)
 	else if (port >= 0x340 && port < 0x3a0)
-	  return *(volatile unsigned short *)PORT2ADDR_USB(port);
+		return *(volatile unsigned short *)PORT2ADDR_USB(port);
 #endif
 
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	  else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned short w;
-	   pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
-	   return w;
+	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		unsigned short w;
+		pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
+		return w;
 	} else
 #endif
 	return *(volatile unsigned short *)PORT2ADDR(port);
@@ -160,9 +159,9 @@ unsigned long _inl(unsigned long port)
 {
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned long l;
-	   pcc_ioread_word(0, port, &l, sizeof(l), 1, 0);
-	   return l;
+		unsigned long l;
+		pcc_ioread_word(0, port, &l, sizeof(l), 1, 0);
+		return l;
 	} else
 #endif
 	return *(volatile unsigned long *)PORT2ADDR(port);
@@ -182,9 +181,9 @@ unsigned char _inb_p(unsigned long port)
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned char b;
-	   pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
-	   return b;
+		unsigned char b;
+		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
+		return b;
 	} else
 #endif
 		v = *(volatile unsigned char *)PORT2ADDR(port);
@@ -206,15 +205,15 @@ unsigned short _inw_p(unsigned long port
 	} else
 #endif
 #if defined(CONFIG_USB)
-	  if (port >= 0x340 && port < 0x3a0)
+	if (port >= 0x340 && port < 0x3a0)
 		v = *(volatile unsigned short *)PORT2ADDR_USB(port);
-	  else
+	else
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned short w;
-	   pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
-	   return w;
+		unsigned short w;
+		pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
+		return w;
 	} else
 #endif
 		v = *(volatile unsigned short *)PORT2ADDR(port);
@@ -244,7 +243,7 @@ void _outb(unsigned char b, unsigned lon
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
+		pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
 	} else
 #endif
 		*(volatile unsigned char *)PORT2ADDR(port) = b;
@@ -261,13 +260,13 @@ void _outw(unsigned short w, unsigned lo
 	} else
 #endif
 #if defined(CONFIG_USB)
-	  if (port >= 0x340 && port < 0x3a0)
-	    *(volatile unsigned short *)PORT2ADDR_USB(port) = w;
+	if (port >= 0x340 && port < 0x3a0)
+		*(volatile unsigned short *)PORT2ADDR_USB(port) = w;
 	else
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
+		pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
 	} else
 #endif
 		*(volatile unsigned short *)PORT2ADDR(port) = w;
@@ -277,7 +276,7 @@ void _outl(unsigned long l, unsigned lon
 {
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_word(0, port, &l, sizeof(l), 1, 0);
+		pcc_iowrite_word(0, port, &l, sizeof(l), 1, 0);
 	} else
 #endif
 	*(volatile unsigned long *)PORT2ADDR(port) = l;
@@ -295,7 +294,7 @@ void _outb_p(unsigned char b, unsigned l
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
+		pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
 	} else
 #endif
 		*(volatile unsigned char *)PORT2ADDR(port) = b;
@@ -320,7 +319,7 @@ void _outw_p(unsigned short w, unsigned 
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
+		pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
 	} else
 #endif
 		*(volatile unsigned short *)PORT2ADDR(port) = w;
@@ -342,18 +341,21 @@ void _insb(unsigned int port, void * add
 	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		unsigned char *buf = addr;
 		unsigned char *portp = __port2addr_ata(port);
-		while(count--) *buf++ = *(volatile unsigned char *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned char *)portp;
 	}
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	  else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_ioread_byte(0, port, (void *)addr, sizeof(unsigned char), count, 1);
+	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		pcc_ioread_byte(0, port, (void *)addr, sizeof(unsigned char),
+				count, 1);
 	}
 #endif
 	else {
 		unsigned char *buf = addr;
 		unsigned char *portp = PORT2ADDR(port);
-		while(count--) *buf++ = *(volatile unsigned char *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned char *)portp;
 	}
 }
 
@@ -364,19 +366,23 @@ void _insw(unsigned int port, void * add
 
 	if (port >= LAN_IOSTART && port < LAN_IOEND) {
 		portp = PORT2ADDR_NE(port);
-		while (count--) *buf++ = *(volatile unsigned short *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned short *)portp;
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_ioread_word(9, port, (void *)addr, sizeof(unsigned short), count, 1);
+		pcc_ioread_word(9, port, (void *)addr, sizeof(unsigned short),
+				count, 1);
 #endif
 #if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		portp = __port2addr_ata(port);
-		while (count--) *buf++ = *(volatile unsigned short *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned short *)portp;
 #endif
 	} else {
 		portp = PORT2ADDR(port);
-		while (count--) *buf++ = *(volatile unsigned short *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned short *)portp;
 	}
 }
 
@@ -386,7 +392,8 @@ void _insl(unsigned int port, void * add
 	unsigned long *portp;
 
 	portp = PORT2ADDR(port);
-	while (count--) *buf++ = *(volatile unsigned long *)portp;
+	while (count--)
+		*buf++ = *(volatile unsigned long *)portp;
 }
 
 void _outsb(unsigned int port, const void * addr, unsigned long count)
@@ -396,19 +403,23 @@ void _outsb(unsigned int port, const voi
 
 	if (port >= LAN_IOSTART && port < LAN_IOEND) {
 		portp = PORT2ADDR_NE(port);
-		while (count--) _ne_outb(*buf++, portp);
+		while (count--)
+			_ne_outb(*buf++, portp);
 #if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		portp = __port2addr_ata(port);
-		while(count--) *(volatile unsigned char *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned char *)portp = *buf++;
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_byte(0, port, (void *)addr, sizeof(unsigned char), count, 1);
+		pcc_iowrite_byte(0, port, (void *)addr, sizeof(unsigned char),
+				 count, 1);
 #endif
 	} else {
 		portp = PORT2ADDR(port);
-		while(count--) *(volatile unsigned char *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned char *)portp = *buf++;
 	}
 }
 
@@ -419,19 +430,23 @@ void _outsw(unsigned int port, const voi
 
 	if (port >= LAN_IOSTART && port < LAN_IOEND) {
 		portp = PORT2ADDR_NE(port);
-		while (count--) *(volatile unsigned short *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned short *)portp = *buf++;
 #if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		portp = __port2addr_ata(port);
-		while(count--) *(volatile unsigned short *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned short *)portp = *buf++;
 #endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_word(9, port, (void *)addr, sizeof(unsigned short), count, 1);
+		pcc_iowrite_word(9, port, (void *)addr, sizeof(unsigned short),
+				 count, 1);
 #endif
 	} else {
 		portp = PORT2ADDR(port);
-		while(count--) *(volatile unsigned short *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned short *)portp = *buf++;
 	}
 }
 
@@ -441,5 +456,6 @@ void _outsl(unsigned int port, const voi
 	unsigned char *portp;
 
 	portp = PORT2ADDR(port);
-	while(count--) *(volatile unsigned long *)portp = *buf++;
+	while (count--)
+		*(volatile unsigned long *)portp = *buf++;
 }
diff -ruNp a/arch/m32r/kernel/io_oaks32r.c b/arch/m32r/kernel/io_oaks32r.c
--- a/arch/m32r/kernel/io_oaks32r.c	2004-10-19 06:55:29.000000000 +0900
+++ b/arch/m32r/kernel/io_oaks32r.c	2004-11-17 19:16:18.000000000 +0900
@@ -4,11 +4,9 @@
  *  Typical I/O routines for OAKS32R board.
  *
  *  Copyright (c) 2001-2004  Hiroyuki Kondo, Hirokazu Takata,
- *                            Hitoshi Yamamoto, Mamoru Sakugawa
+ *                           Hitoshi Yamamoto, Mamoru Sakugawa
  */
 
-/* $Id$ */
-
 #include <linux/config.h>
 #include <asm/m32r.h>
 #include <asm/page.h>
@@ -16,17 +14,17 @@
 
 #define PORT2ADDR(port)  _port2addr(port)
 
-static __inline__ void *_port2addr(unsigned long port)
+static inline void *_port2addr(unsigned long port)
 {
 	return (void *)(port + NONCACHE_OFFSET);
 }
 
-static __inline__  void *_port2addr_ne(unsigned long port)
+static inline  void *_port2addr_ne(unsigned long port)
 {
 	return (void *)((port<<1) + NONCACHE_OFFSET + 0x02000000);
 }
 
-static __inline__ void delay(void)
+static inline void delay(void)
 {
 	__asm__ __volatile__ ("push r0; \n\t pop r0;" : : :"memory");
 }
@@ -37,12 +35,12 @@ static __inline__ void delay(void)
 
 #define PORT2ADDR_NE(port)  _port2addr_ne(port)
 
-static __inline__ unsigned char _ne_inb(void *portp)
+static inline unsigned char _ne_inb(void *portp)
 {
 	return *(volatile unsigned char *)(portp+1);
 }
 
-static __inline__ unsigned short _ne_inw(void *portp)
+static inline unsigned short _ne_inw(void *portp)
 {
 	unsigned short tmp;
 
@@ -51,21 +49,22 @@ static __inline__ unsigned short _ne_inw
 	return tmp;
 }
 
-static __inline__  void _ne_insb(void *portp, void * addr, unsigned long count)
+static inline  void _ne_insb(void *portp, void *addr, unsigned long count)
 {
 	unsigned char *buf = addr;
-	while (count--) *buf++ = *(volatile unsigned char *)(portp+1);
+	while (count--)
+		*buf++ = *(volatile unsigned char *)(portp+1);
 }
 
-static __inline__ void _ne_outb(unsigned char b, void *portp)
+static inline void _ne_outb(unsigned char b, void *portp)
 {
 	*(volatile unsigned char *)(portp+1) = b;
 }
 
-static __inline__ void _ne_outw(unsigned short w, void *portp)
+static inline void _ne_outw(unsigned short w, void *portp)
 {
-  *(volatile unsigned short *)portp =  (w >> 8);
-  *(volatile unsigned short *)(portp+2) =  (w & 0xff);
+	*(volatile unsigned short *)portp =  (w >> 8);
+	*(volatile unsigned short *)(portp+2) =  (w & 0xff);
 }
 
 unsigned char _inb(unsigned long port)
@@ -171,73 +170,82 @@ void _outl_p(unsigned long l, unsigned l
 	delay();
 }
 
-void _insb(unsigned int port, void * addr, unsigned long count)
+void _insb(unsigned int port, void *addr, unsigned long count)
 {
 	if (port >= 0x300 && port < 0x320)
 		_ne_insb(PORT2ADDR_NE(port), addr, count);
 	else {
 		unsigned char *buf = addr;
 		unsigned char *portp = PORT2ADDR(port);
-		while(count--) *buf++ = *(volatile unsigned char *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned char *)portp;
 	}
 }
 
-void _insw(unsigned int port, void * addr, unsigned long count)
+void _insw(unsigned int port, void *addr, unsigned long count)
 {
 	unsigned short *buf = addr;
 	unsigned short *portp;
 
 	if (port >= 0x300 && port < 0x320) {
 		portp = PORT2ADDR_NE(port);
-		while (count--) *buf++ = _ne_inw(portp);
+		while (count--)
+			*buf++ = _ne_inw(portp);
 	} else {
 		portp = PORT2ADDR(port);
-		while (count--) *buf++ = *(volatile unsigned short *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned short *)portp;
 	}
 }
 
-void _insl(unsigned int port, void * addr, unsigned long count)
+void _insl(unsigned int port, void *addr, unsigned long count)
 {
 	unsigned long *buf = addr;
 	unsigned long *portp;
 
 	portp = PORT2ADDR(port);
-	while (count--) *buf++ = *(volatile unsigned long *)portp;
+	while (count--)
+		*buf++ = *(volatile unsigned long *)portp;
 }
 
-void _outsb(unsigned int port, const void * addr, unsigned long count)
+void _outsb(unsigned int port, const void *addr, unsigned long count)
 {
 	const unsigned char *buf = addr;
 	unsigned char *portp;
 
 	if (port >= 0x300 && port < 0x320) {
 		portp = PORT2ADDR_NE(port);
-		while (count--) _ne_outb(*buf++, portp);
+		while (count--)
+			_ne_outb(*buf++, portp);
 	} else {
 		portp = PORT2ADDR(port);
-		while(count--) *(volatile unsigned char *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned char *)portp = *buf++;
 	}
 }
 
-void _outsw(unsigned int port, const void * addr, unsigned long count)
+void _outsw(unsigned int port, const void *addr, unsigned long count)
 {
 	const unsigned short *buf = addr;
 	unsigned short *portp;
 
 	if (port >= 0x300 && port < 0x320) {
 		portp = PORT2ADDR_NE(port);
-		while (count--) _ne_outw(*buf++, portp);
+		while (count--)
+			_ne_outw(*buf++, portp);
 	} else {
 		portp = PORT2ADDR(port);
-		while(count--) *(volatile unsigned short *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned short *)portp = *buf++;
 	}
 }
 
-void _outsl(unsigned int port, const void * addr, unsigned long count)
+void _outsl(unsigned int port, const void *addr, unsigned long count)
 {
 	const unsigned long *buf = addr;
 	unsigned char *portp;
 
 	portp = PORT2ADDR(port);
-	while(count--) *(volatile unsigned long *)portp = *buf++;
+	while (count--)
+		*(volatile unsigned long *)portp = *buf++;
 }
diff -ruNp a/arch/m32r/kernel/io_opsput.c b/arch/m32r/kernel/io_opsput.c
--- a/arch/m32r/kernel/io_opsput.c	2004-10-19 06:54:37.000000000 +0900
+++ b/arch/m32r/kernel/io_opsput.c	2004-11-17 19:16:18.000000000 +0900
@@ -9,7 +9,6 @@
  *  This file is subject to the terms and conditions of the GNU General
  *  Public License.  See the file "COPYING" in the main directory of this
  *  archive for more details.
- *
  */
 
 #include <linux/config.h>
@@ -35,7 +34,7 @@ extern void pcc_iowrite_word(int, unsign
 #define PORT2ADDR(port)  _port2addr(port)
 #define PORT2ADDR_USB(port) _port2addr_usb(port)
 
-static __inline__ void *_port2addr(unsigned long port)
+static inline void *_port2addr(unsigned long port)
 {
 	return (void *)(port + NONCACHE_OFFSET);
 }
@@ -47,16 +46,16 @@ static __inline__ void *_port2addr(unsig
  */
 #define LAN_IOSTART	0x300
 #define LAN_IOEND	0x320
-static __inline__ void *_port2addr_ne(unsigned long port)
+static inline void *_port2addr_ne(unsigned long port)
 {
 	return (void *)(port + NONCACHE_OFFSET + 0x10000000);
 }
-static __inline__ void *_port2addr_usb(unsigned long port)
+static inline void *_port2addr_usb(unsigned long port)
 {
-  return (void *)((port & 0x0f) + NONCACHE_OFFSET + 0x10303000);
+	return (void *)((port & 0x0f) + NONCACHE_OFFSET + 0x10303000);
 }
 
-static __inline__ void delay(void)
+static inline void delay(void)
 {
 	__asm__ __volatile__ ("push r0; \n\t pop r0;" : : :"memory");
 }
@@ -67,29 +66,30 @@ static __inline__ void delay(void)
 
 #define PORT2ADDR_NE(port)  _port2addr_ne(port)
 
-static __inline__ unsigned char _ne_inb(void *portp)
+static inline unsigned char _ne_inb(void *portp)
 {
 	return *(volatile unsigned char *)portp;
 }
 
-static __inline__ unsigned short _ne_inw(void *portp)
+static inline unsigned short _ne_inw(void *portp)
 {
 	return (unsigned short)le16_to_cpu(*(volatile unsigned short *)portp);
 }
 
-static __inline__ void _ne_insb(void *portp, void * addr, unsigned long count)
+static inline void _ne_insb(void *portp, void *addr, unsigned long count)
 {
 	unsigned char *buf = (unsigned char *)addr;
 
-	while (count--) *buf++ = _ne_inb(portp);
+	while (count--)
+		*buf++ = _ne_inb(portp);
 }
 
-static __inline__ void _ne_outb(unsigned char b, void *portp)
+static inline void _ne_outb(unsigned char b, void *portp)
 {
 	*(volatile unsigned char *)portp = b;
 }
 
-static __inline__ void _ne_outw(unsigned short w, void *portp)
+static inline void _ne_outw(unsigned short w, void *portp)
 {
 	*(volatile unsigned short *)portp = cpu_to_le16(w);
 }
@@ -101,9 +101,9 @@ unsigned char _inb(unsigned long port)
 
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned char b;
-	   pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
-	   return b;
+		unsigned char b;
+		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
+		return b;
 	} else
 #endif
 
@@ -116,14 +116,14 @@ unsigned short _inw(unsigned long port)
 		return _ne_inw(PORT2ADDR_NE(port));
 #if defined(CONFIG_USB)
 	else if(port >= 0x340 && port < 0x3a0)
-	  return *(volatile unsigned short *)PORT2ADDR_USB(port);
+		return *(volatile unsigned short *)PORT2ADDR_USB(port);
 #endif
 
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	  else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned short w;
-	   pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
-	   return w;
+	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		unsigned short w;
+		pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
+		return w;
 	} else
 #endif
 	return *(volatile unsigned short *)PORT2ADDR(port);
@@ -133,9 +133,9 @@ unsigned long _inl(unsigned long port)
 {
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned long l;
-	   pcc_ioread_word(0, port, &l, sizeof(l), 1, 0);
-	   return l;
+		unsigned long l;
+		pcc_ioread_word(0, port, &l, sizeof(l), 1, 0);
+		return l;
 	} else
 #endif
 	return *(volatile unsigned long *)PORT2ADDR(port);
@@ -150,9 +150,9 @@ unsigned char _inb_p(unsigned long port)
 	else
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned char b;
-	   pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
-	   return b;
+		unsigned char b;
+		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
+		return b;
 	} else
 #endif
 		v = *(volatile unsigned char *)PORT2ADDR(port);
@@ -169,16 +169,16 @@ unsigned short _inw_p(unsigned long port
 		v = _ne_inw(PORT2ADDR_NE(port));
 	else
 #if defined(CONFIG_USB)
-	  if(port >= 0x340 && port < 0x3a0)
-	    return *(volatile unsigned short *)PORT2ADDR_USB(port);
+	if(port >= 0x340 && port < 0x3a0)
+		return *(volatile unsigned short *)PORT2ADDR_USB(port);
 	else
 #endif
 
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   unsigned short w;
-	   pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
-	   return w;
+		unsigned short w;
+		pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
+		return w;
 	} else
 #endif
 		v = *(volatile unsigned short *)PORT2ADDR(port);
@@ -203,7 +203,7 @@ void _outb(unsigned char b, unsigned lon
 	else
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
+		pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
 	} else
 #endif
 		*(volatile unsigned char *)PORT2ADDR(port) = b;
@@ -216,13 +216,13 @@ void _outw(unsigned short w, unsigned lo
 	else
 #if defined(CONFIG_USB)
 	if(port >= 0x340 && port < 0x3a0)
-	  *(volatile unsigned short *)PORT2ADDR_USB(port) = w;
+		*(volatile unsigned short *)PORT2ADDR_USB(port) = w;
 	else
 #endif
 
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
+		pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
 	} else
 #endif
 		*(volatile unsigned short *)PORT2ADDR(port) = w;
@@ -232,7 +232,7 @@ void _outl(unsigned long l, unsigned lon
 {
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_word(0, port, &l, sizeof(l), 1, 0);
+		pcc_iowrite_word(0, port, &l, sizeof(l), 1, 0);
 	} else
 #endif
 	*(volatile unsigned long *)PORT2ADDR(port) = l;
@@ -245,7 +245,7 @@ void _outb_p(unsigned char b, unsigned l
 	else
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
+		pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
 	} else
 #endif
 		*(volatile unsigned char *)PORT2ADDR(port) = b;
@@ -259,14 +259,14 @@ void _outw_p(unsigned short w, unsigned 
 		_ne_outw(w, PORT2ADDR_NE(port));
 	else
 #if defined(CONFIG_USB)
-	  if(port >= 0x340 && port < 0x3a0)
-	    *(volatile unsigned short *)PORT2ADDR_USB(port) = w;
+	if(port >= 0x340 && port < 0x3a0)
+		*(volatile unsigned short *)PORT2ADDR_USB(port) = w;
 	else
 #endif
 
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
+		pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
 	} else
 #endif
 		*(volatile unsigned short *)PORT2ADDR(port) = w;
@@ -280,23 +280,25 @@ void _outl_p(unsigned long l, unsigned l
 	delay();
 }
 
-void _insb(unsigned int port, void * addr, unsigned long count)
+void _insb(unsigned int port, void *addr, unsigned long count)
 {
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_insb(PORT2ADDR_NE(port), addr, count);
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	  else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_ioread_byte(0, port, (void *)addr, sizeof(unsigned char), count, 1);
+	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+		pcc_ioread_byte(0, port, (void *)addr, sizeof(unsigned char),
+				count, 1);
 	}
 #endif
 	else {
 		unsigned char *buf = addr;
 		unsigned char *portp = PORT2ADDR(port);
-		while(count--) *buf++ = *(volatile unsigned char *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned char *)portp;
 	}
 }
 
-void _insw(unsigned int port, void * addr, unsigned long count)
+void _insw(unsigned int port, void *addr, unsigned long count)
 {
 	unsigned short *buf = addr;
 	unsigned short *portp;
@@ -307,45 +309,52 @@ void _insw(unsigned int port, void * add
 		 * from the DATA_REG. Do not swap the data.
 		 */
 		portp = PORT2ADDR_NE(port);
-		while (count--) *buf++ = *(volatile unsigned short *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned short *)portp;
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_ioread_word(9, port, (void *)addr, sizeof(unsigned short), count, 1);
+		pcc_ioread_word(9, port, (void *)addr, sizeof(unsigned short),
+				count, 1);
 #endif
 	} else {
 		portp = PORT2ADDR(port);
-		while (count--) *buf++ = *(volatile unsigned short *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned short *)portp;
 	}
 }
 
-void _insl(unsigned int port, void * addr, unsigned long count)
+void _insl(unsigned int port, void *addr, unsigned long count)
 {
 	unsigned long *buf = addr;
 	unsigned long *portp;
 
 	portp = PORT2ADDR(port);
-	while (count--) *buf++ = *(volatile unsigned long *)portp;
+	while (count--)
+		*buf++ = *(volatile unsigned long *)portp;
 }
 
-void _outsb(unsigned int port, const void * addr, unsigned long count)
+void _outsb(unsigned int port, const void *addr, unsigned long count)
 {
 	const unsigned char *buf = addr;
 	unsigned char *portp;
 
 	if (port >= LAN_IOSTART && port < LAN_IOEND) {
 		portp = PORT2ADDR_NE(port);
-		while (count--) _ne_outb(*buf++, portp);
+		while (count--)
+			_ne_outb(*buf++, portp);
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_byte(0, port, (void *)addr, sizeof(unsigned char), count, 1);
+		pcc_iowrite_byte(0, port, (void *)addr, sizeof(unsigned char),
+				 count, 1);
 #endif
 	} else {
 		portp = PORT2ADDR(port);
-		while(count--) *(volatile unsigned char *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned char *)portp = *buf++;
 	}
 }
 
-void _outsw(unsigned int port, const void * addr, unsigned long count)
+void _outsw(unsigned int port, const void *addr, unsigned long count)
 {
 	const unsigned short *buf = addr;
 	unsigned short *portp;
@@ -356,22 +365,26 @@ void _outsw(unsigned int port, const voi
 		 * into the DATA_REG. Do not swap the data.
 		 */
 		portp = PORT2ADDR_NE(port);
-		while(count--) *(volatile unsigned short *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned short *)portp = *buf++;
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-	   pcc_iowrite_word(9, port, (void *)addr, sizeof(unsigned short), count, 1);
+		pcc_iowrite_word(9, port, (void *)addr, sizeof(unsigned short),
+				 count, 1);
 #endif
 	} else {
 		portp = PORT2ADDR(port);
-		while(count--) *(volatile unsigned short *)portp = *buf++;
+		while (count--)
+			*(volatile unsigned short *)portp = *buf++;
 	}
 }
 
-void _outsl(unsigned int port, const void * addr, unsigned long count)
+void _outsl(unsigned int port, const void *addr, unsigned long count)
 {
 	const unsigned long *buf = addr;
 	unsigned char *portp;
 
 	portp = PORT2ADDR(port);
-	while(count--) *(volatile unsigned long *)portp = *buf++;
+	while (count--)
+		*(volatile unsigned long *)portp = *buf++;
 }
diff -ruNp a/arch/m32r/kernel/io_usrv.c b/arch/m32r/kernel/io_usrv.c
--- a/arch/m32r/kernel/io_usrv.c	2004-10-19 06:55:06.000000000 +0900
+++ b/arch/m32r/kernel/io_usrv.c	2004-11-17 19:16:18.000000000 +0900
@@ -178,7 +178,8 @@ void _insb(unsigned int port, void * add
 	else {
 		unsigned char *buf = addr;
 		unsigned char *portp = PORT2ADDR(port);
-		while(count--) *buf++ = *(volatile unsigned char *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned char *)portp;
 	}
 }
 
@@ -192,7 +193,8 @@ void _insw(unsigned int port, void * add
 			1);
 	else {
 		portp = PORT2ADDR(port);
-		while (count--) *buf++ = *(volatile unsigned short *)portp;
+		while (count--)
+			*buf++ = *(volatile unsigned short *)portp;
 	}
 }
 

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

