Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279301AbRJWHMC>; Tue, 23 Oct 2001 03:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279300AbRJWHLn>; Tue, 23 Oct 2001 03:11:43 -0400
Received: from mail.nexus.co.sz ([196.28.7.66]:54533 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S279302AbRJWHLg>; Tue, 23 Oct 2001 03:11:36 -0400
Date: Tue, 23 Oct 2001 09:03:29 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Assembly code cleanups for gcc3.x
Message-ID: <20011023085941.T69645-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch to remove warnings about string literals from
include/asm-i386/floppy.h/checksum.h. whilst compiling under gcc
3.x. Compiled under 2.4.12/-acX

Regards,
	Zwane Mwaikambo

diff -ur linux-2.4.12.orig/include/asm-i386/checksum.h linux-2.4.12/include/asm-i386/checksum.h
--- linux-2.4.12.orig/include/asm-i386/checksum.h	Thu Jul 26 22:41:22 2001
+++ linux-2.4.12/include/asm-i386/checksum.h	Tue Oct 23 06:26:47 2001
@@ -69,25 +69,25 @@
 					  unsigned int ihl) {
 	unsigned int sum;

-	__asm__ __volatile__("
-	    movl (%1), %0
-	    subl $4, %2
-	    jbe 2f
-	    addl 4(%1), %0
-	    adcl 8(%1), %0
-	    adcl 12(%1), %0
-1:	    adcl 16(%1), %0
-	    lea 4(%1), %1
-	    decl %2
-	    jne	1b
-	    adcl $0, %0
-	    movl %0, %2
-	    shrl $16, %0
-	    addw %w2, %w0
-	    adcl $0, %0
-	    notl %0
-2:
-	    "
+	__asm__ __volatile__(
+	    "movl (%1), %0\n\t"
+	    "subl $4, %2\n\t"
+	    "jbe 2f\n\t"
+	    "addl 4(%1), %0\n\t"
+	    "adcl 8(%1), %0\n\t"
+	    "adcl 12(%1), %0\n\t"
+"1:	     adcl 16(%1), %0\n\t"
+	    "lea 4(%1), %1\n\t"
+	    "decl %2\n\t"
+	    "jne 1b\n\t"
+	    "adcl $0, %0\n\t"
+	    "movl %0, %2\n\t"
+	    "shrl $16, %0\n\t"
+	    "addw %w2, %w0\n\t"
+	    "adcl $0, %0\n\t"
+	    "notl %0\n\t"
+"2:"
+
 	/* Since the input registers which are loaded with iph and ipl
 	   are modified, we must also specify them as outputs, or gcc
 	   will assume they contain their original values. */
@@ -102,10 +102,9 @@

 static inline unsigned int csum_fold(unsigned int sum)
 {
-	__asm__("
-		addl %1, %0
-		adcl $0xffff, %0
-		"
+	__asm__(
+		"addl %1, %0\n\t"
+		"adcl $0xffff, %0"
 		: "=r" (sum)
 		: "r" (sum << 16), "0" (sum & 0xffff0000)
 	);
@@ -118,12 +117,11 @@
 						   unsigned short proto,
 						   unsigned int sum)
 {
-    __asm__("
-	addl %1, %0
-	adcl %2, %0
-	adcl %3, %0
-	adcl $0, %0
-	"
+    __asm__(
+	"addl %1, %0\n\t"
+	"adcl %2, %0\n\t"
+	"adcl %3, %0\n\t"
+	"adcl $0, %0"
 	: "=r" (sum)
 	: "g" (daddr), "g"(saddr), "g"((ntohs(len)<<16)+proto*256), "0"(sum));
     return sum;
@@ -158,19 +156,18 @@
 						     unsigned short proto,
 						     unsigned int sum)
 {
-	__asm__("
-		addl 0(%1), %0
-		adcl 4(%1), %0
-		adcl 8(%1), %0
-		adcl 12(%1), %0
-		adcl 0(%2), %0
-		adcl 4(%2), %0
-		adcl 8(%2), %0
-		adcl 12(%2), %0
-		adcl %3, %0
-		adcl %4, %0
-		adcl $0, %0
-		"
+	__asm__(
+		"addl 0(%1), %0\n\t"
+		"adcl 4(%1), %0\n\t"
+		"adcl 8(%1), %0\n\t"
+		"adcl 12(%1), %0\n\t"
+		"adcl 0(%2), %0\n\t"
+		"adcl 4(%2), %0\n\t"
+		"adcl 8(%2), %0\n\t"
+		"adcl 12(%2), %0\n\t"
+		"adcl %3, %0\n\t"
+		"adcl %4, %0\n\t"
+		"adcl $0, %0"
 		: "=&r" (sum)
 		: "r" (saddr), "r" (daddr),
 		  "r"(htonl(len)), "r"(htonl(proto)), "0"(sum));
diff -ur linux-2.4.12.orig/include/asm-i386/floppy.h linux-2.4.12/include/asm-i386/floppy.h
--- linux-2.4.12.orig/include/asm-i386/floppy.h	Thu Oct 11 08:44:34 2001
+++ linux-2.4.12/include/asm-i386/floppy.h	Tue Oct 23 06:26:54 2001
@@ -75,28 +75,28 @@

 #ifndef NO_FLOPPY_ASSEMBLER
 	__asm__ (
-       "testl %1,%1
-	je 3f
-1:	inb %w4,%b0
-	andb $160,%b0
-	cmpb $160,%b0
-	jne 2f
-	incw %w4
-	testl %3,%3
-	jne 4f
-	inb %w4,%b0
-	movb %0,(%2)
-	jmp 5f
-4:     	movb (%2),%0
-	outb %b0,%w4
-5:	decw %w4
-	outb %0,$0x80
-	decl %1
-	incl %2
-	testl %1,%1
-	jne 1b
-3:	inb %w4,%b0
-2:	"
+	"testl %1,%1\n\t"
+	"je 3f\n\t"
+"1:	inb %w4,%b0\n\t"
+	"andb $160,%b0\n\t"
+	"cmpb $160,%b0\n\t"
+	"jne 2f\n\t"
+	"incw %w4\n\t"
+	"testl %3,%3\n\t"
+	"jne 4f\n\t"
+	"inb %w4,%b0\n\t"
+	"movb %0,(%2)\n\t"
+	"jmp 5f\n\t"
+"4:    	movb (%2),%0\n\t"
+	"outb %b0,%w4\n\t"
+"5:	decw %w4\n\t"
+	"outb %0,$0x80\n\t"
+	"decl %1\n\t"
+	"incl %2\n\t"
+	"testl %1,%1\n\t"
+	"jne 1b\n\t"
+"3:	inb %w4,%b0\n\t"
+"2:"
        : "=a" ((char) st),
        "=c" ((long) virtual_dma_count),
        "=S" ((long) virtual_dma_addr)

