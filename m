Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278783AbRJVUEu>; Mon, 22 Oct 2001 16:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278855AbRJVUEl>; Mon, 22 Oct 2001 16:04:41 -0400
Received: from oss.sgi.com ([216.32.174.27]:49559 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S278783AbRJVUEg>;
	Mon, 22 Oct 2001 16:04:36 -0400
Date: Mon, 22 Oct 2001 13:05:10 -0700
From: John Hawkes <hawkes@oss.sgi.com>
Message-Id: <200110222005.f9MK5AJ15012@oss.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] gcc 3.0.1 warnings about multi-line literals
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch eliminates gcc 3.0.1 warnings, "multi-line string literals are
deprecated", in two include/asm-i386 files.  Patches cleanly for at least
2.4.10 and 2.4.12, and tested in 2.4.10.

John Hawkes
hawkes@sgi.com


diff -X /build4/hawkes/Build/ignore.dirs -Naur linux-2.4.12/include/asm-i386/checksum.h linux-2.4.12-3.0.1/include/asm-i386/checksum.h
--- linux-2.4.12/include/asm-i386/checksum.h	Thu Jul 26 13:41:22 2001
+++ linux-2.4.12-3.0.1/include/asm-i386/checksum.h	Mon Oct 22 10:40:14 2001
@@ -69,25 +69,24 @@
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
+	    "movl (%1), %0 \n\t" \
+	    "subl $4, %2 \n\t" \
+	    "jbe 2f \n\t" \
+	    "addl 4(%1), %0 \n\t" \
+	    "adcl 8(%1), %0 \n\t" \
+	    "adcl 12(%1), %0 \n\t" \
+	    "1:\t adcl 16(%1), %0 \n\t" \
+	    "lea 4(%1), %1 \n\t" \
+	    "decl %2 \n\t" \
+	    "jne 1b \n\t" \
+	    "adcl $0, %0 \n\t" \
+	    "movl %0, %2 \n\t" \
+	    "shrl $16, %0 \n\t" \
+	    "addw %w2, %w0 \n\t" \
+	    "adcl $0, %0 \n\t" \
+	    "notl %0 \n\t" \
+	    "2: "
 	/* Since the input registers which are loaded with iph and ipl
 	   are modified, we must also specify them as outputs, or gcc
 	   will assume they contain their original values. */
@@ -102,10 +101,8 @@
 
 static inline unsigned int csum_fold(unsigned int sum)
 {
-	__asm__("
-		addl %1, %0
-		adcl $0xffff, %0
-		"
+	__asm__("addl %1, %0 \n\t" \
+		"adcl $0xffff, %0 \n\t"
 		: "=r" (sum)
 		: "r" (sum << 16), "0" (sum & 0xffff0000)
 	);
@@ -118,12 +115,11 @@
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
+	"addl %1, %0 \n\t" \
+	"adcl %2, %0 \n\t" \
+	"adcl %3, %0 \n\t" \
+	"adcl $0, %0 \n\t"
 	: "=r" (sum)
 	: "g" (daddr), "g"(saddr), "g"((ntohs(len)<<16)+proto*256), "0"(sum));
     return sum;
@@ -158,19 +154,17 @@
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
+	__asm__("addl 0(%1), %0 \n\t" \
+		"adcl 4(%1), %0 \n\t" \
+		"adcl 8(%1), %0 \n\t" \
+		"adcl 12(%1), %0 \n\t" \
+		"adcl 0(%2), %0 \n\t" \
+		"adcl 4(%2), %0 \n\t" \
+		"adcl 8(%2), %0 \n\t" \
+		"adcl 12(%2), %0 \n\t" \
+		"adcl %3, %0 \n\t" \
+		"adcl %4, %0 \n\t" \
+		"adcl $0, %0 \n\t"
 		: "=&r" (sum)
 		: "r" (saddr), "r" (daddr), 
 		  "r"(htonl(len)), "r"(htonl(proto)), "0"(sum));
diff -X /build4/hawkes/Build/ignore.dirs -Naur linux-2.4.12/include/asm-i386/floppy.h linux-2.4.12-3.0.1/include/asm-i386/floppy.h
--- linux-2.4.12/include/asm-i386/floppy.h	Wed Oct 10 23:44:34 2001
+++ linux-2.4.12-3.0.1/include/asm-i386/floppy.h	Mon Oct 22 10:44:36 2001
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
+	"testl %1,%1 \n\t" \
+	"je 3f \n\t" \
+	"1:\t inb %w4,%b0 \n\t" \
+	"andb $160,%b0 \n\t" \
+	"cmpb $160,%b0 \n\t" \
+	"jne 2f \n\t" \
+	"incw %w4 \n\t" \
+	"testl %3,%3 \n\t" \
+	"jne 4f \n\t" \
+	"inb %w4,%b0 \n\t" \
+	"movb %0,(%2) \n\t" \
+	"jmp 5f \n\t" \
+	"4:\t movb (%2),%0 \n\t" \
+	"outb %b0,%w4 \n\t" \
+	"5:\t decw %w4 \n\t" \
+	"outb %0,$0x80 \n\t" \
+	"decl %1 \n\t" \
+	"incl %2 \n\t" \
+	"testl %1,%1 \n\t" \
+	"jne 1b \n\t" \
+	"3:\t inb %w4,%b0 \n\t" \
+	"2:\n\t"
        : "=a" ((char) st), 
        "=c" ((long) virtual_dma_count), 
        "=S" ((long) virtual_dma_addr)
