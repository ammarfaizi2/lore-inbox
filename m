Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbSLOKpp>; Sun, 15 Dec 2002 05:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbSLOKpp>; Sun, 15 Dec 2002 05:45:45 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:58428 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266323AbSLOKpm>; Sun, 15 Dec 2002 05:45:42 -0500
Message-ID: <3DFC5EBA.4FE45141@cinet.co.jp>
Date: Sun, 15 Dec 2002 19:51:38 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.50-ac1-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (2/21)
References: <3DFC50E9.656B96D0@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------EC69716DD8BF71B21C234E40"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EC69716DD8BF71B21C234E40
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

This is re-send. Sorry, I forgot attachment.

NEC PC-9800 subarchitecture support patch for 2.5.50-ac1 (2/21)
This is updates for include/asm-i386/gdc.h.
Killed warning from gcc-3.2.

diffstat:
 include/asm-i386/gdc.h |  144 ++++++++++++++++++++++++++-----------------------
 1 files changed, 79 insertions(+), 65 deletions(-)


Regards,
Osamu Tomita
--------------EC69716DD8BF71B21C234E40
Content-Type: text/plain; charset=iso-2022-jp;
 name="gdc_h-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gdc_h-update.patch"

diff -Nru linux-2.5.50-ac1/include/asm-i386/gdc.h.old linux-2.5.50-ac1/include/asm-i386/gdc.h
--- linux-2.5.50-ac1/include/asm-i386/gdc.h.old	2002-12-11 13:10:08.000000000 +0900
+++ linux-2.5.50-ac1/include/asm-i386/gdc.h	2002-12-11 17:26:46.000000000 +0900
@@ -55,26 +55,29 @@
 _scr_memsetw(u16 *s, u16 c, unsigned int count)
 {
 #ifdef CONFIG_GDC_32BITACCESS
-	__asm__ __volatile__ ("shr%L1 %1
-	jz 2f
-" /*	cld	kernel code now assumes DF = 0 any time */ "\
-	test%L0 %3,%0
-	jz 1f
-	stos%W2
-	dec%L1 %1
-1:	shr%L1 %1
-	rep
-	stos%L2
-	jnc 2f
-	stos%W2
-	rep
-	stos%W2
-2:"
+	__asm__ __volatile__ (
+	"shr%L1 %1\n\t"
+	"jz 2f\n\t"
+ /*	"cld\n\t"	kernel code now assumes DF = 0 any time */
+	"test%L0 %3,%0\n\t"
+	"jz 1f\n\t"
+	"stos%W2\n\t"
+	"dec%L1 %1\n"
+"1:	shr%L1 %1\n\t"
+	"rep\n\t"
+	"stos%L2\n\t"
+	"jnc 2f\n\t"
+	"stos%W2\n\t"
+	"rep\n\t"
+	"stos%W2\n"
+"2:"
 			      : "=D"(s), "=c"(count)
 			      : "a"((((u32) c) << 16) | c), "g"(2),
 			        "0"(s), "1"(count));
 #else
-	__asm__ __volatile__ ("rep\n\tstosw"
+	__asm__ __volatile__ (
+	"rep\n\t"
+	"stosw"
 			      : "=D"(s), "=c"(count)
 			      : "0"(s), "1"(count / 2), "a"(c));
 #endif	
@@ -92,23 +95,26 @@
 _scr_memcpyw(u16 *d, u16 *s, unsigned int count)
 {
 #if 1 /* def CONFIG_GDC_32BITACCESS */
-	__asm__ __volatile__ ("shr%L2 %2
-	jz 2f
-" /*	cld	*/ "\
-	test%L0 %3,%0
-	jz 1f
-	movs%W0
-	dec%L2 %2
-1:	shr%L2 %2
-	rep
-	movs%L0
-	jnc 2f
-	movs%W0
-2:"
+	__asm__ __volatile__ (
+	"shr%L2 %2\n\t"
+	"jz 2f\n\t"
+ /*	"cld\n\t"	*/
+	"test%L0 %3,%0\n\t"
+	"jz 1f\n\t"
+	"movs%W0\n\t"
+	"dec%L2 %2\n"
+"1:	shr%L2 %2\n\t"
+	"rep\n\t"
+	"movs%L0\n\t"
+	"jnc 2f\n\t"
+	"movs%W0\n"
+"2:"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "g"(2), "0"(d), "1"(s), "2"(count));
 #else
-	__asm__ __volatile__ ("rep\n\tmovsw"
+	__asm__ __volatile__ (
+	"rep\n\t"
+	"movsw"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "0"(d), "1"(s), "2"(count / 2));
 #endif
@@ -126,30 +132,35 @@
 #if 1 /* def CONFIG_GDC_32BITACCESS */
 	u16 tmp;
 
-	__asm__ __volatile__ ("shr%L3 %3
-	jz 2f
-	std
-	lea%L1 -4(%1,%3,2),%1
-	lea%L2 -4(%2,%3,2),%2
-	test%L1 %4,%1
-	jz 1f
-	mov%W0 2(%2),%0
-	sub%L2 %4,%2
-	dec%L3 %3
-	mov%W0 %0,2(%1)
-	sub%L1 %4,%1
-1:	shr%L3 %3
-	rep
-	movs%L0
-	jnc 3f
-	mov%W0 2(%2),%0
-	mov%W0 %0,2(%1)
-3:	cld
-2:"
+	__asm__ __volatile__ (
+	"shr%L3 %3\n\t"
+	"jz 2f\n\t"
+	"std\n\t"
+	"lea%L1 -4(%1,%3,2),%1\n\t"
+	"lea%L2 -4(%2,%3,2),%2\n\t"
+	"test%L1 %4,%1\n\t"
+	"jz 1f\n\t"
+	"mov%W0 2(%2),%0\n\t"
+	"sub%L2 %4,%2\n\t"
+	"dec%L3 %3\n\t"
+	"mov%W0 %0,2(%1)\n\t"
+	"sub%L1 %4,%1\n"
+"1:	shr%L3 %3\n\t"
+	"rep\n\t"
+	"movs%L0\n\t"
+	"jnc 3f\n\t"
+	"mov%W0 2(%2),%0\n\t"
+	"mov%W0 %0,2(%1)\n"
+"3:	cld\n"
+"2:"
 			      : "=r"(tmp), "=D"(d), "=S"(s), "=c"(count)
 			      : "g"(2), "1"(d), "2"(s), "3"(count));
 #else
-	__asm__ __volatile__ ("std\n\trep\n\tmovsw\n\tcld"
+	__asm__ __volatile__ (
+	"std\n\t"
+	"rep\n\t"
+	"movsw\n\t"
+	"cld"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "0"((void *) d + count - 2),
 			        "1"((void *) s + count - 2), "2"(count / 2));
@@ -179,23 +190,26 @@
 #ifdef CONFIG_GDC_32BITACCESS
 	/* VRAM is quite slow, so we align source pointer (%esi)
 	   to double-word alignment. */
-	__asm__ __volatile__ ("shr%L2 %2
-	jz 2f
-" /*	cld	*/ "\
-	test%L0 %3,%0
-	jz 1f
-	movs%W0
-	dec%L2 %2
-1:	shr%L2 %2
-	rep
-	movs%L0
-	jnc 2f
-	movs%W0
-2:"
+	__asm__ __volatile__ (
+	"shr%L2 %2\n\t"
+	"jz 2f\n\t"
+ /*	"cld\n\t"	*/
+	"test%L0 %3,%0\n\t"
+	"jz 1f\n\t"
+	"movs%W0\n\t"
+	"dec%L2 %2\n"
+"1:	shr%L2 %2\n\t"
+	"rep\n\t"
+	"movs%L0\n\t"
+	"jnc 2f\n\t"
+	"movs%W0\n"
+"2:"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "g"(2), "0"(d), "1"(s), "2"(count));
 #else
-	__asm__ __volatile__ ("rep\n\tmovsw"
+	__asm__ __volatile__ (
+	"rep\n\t"
+	"movsw"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "0"(d), "1"(s), "2"(count / 2));
 #endif

--------------EC69716DD8BF71B21C234E40--

