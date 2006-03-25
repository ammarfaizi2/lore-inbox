Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWCYOaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWCYOaF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 09:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWCYOaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 09:30:05 -0500
Received: from quark.didntduck.org ([69.55.226.66]:59880 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751416AbWCYOaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 09:30:01 -0500
Message-ID: <442554C0.7020007@didntduck.org>
Date: Sat, 25 Mar 2006 09:33:36 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove long dead i386 floppy asm code
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's been disabled since v2.1.88

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---

 include/asm-i386/floppy.h |   34 ----------------------------------
 1 files changed, 0 insertions(+), 34 deletions(-)

78e3b62a949a66661fab4c548e5beb2b863ed87d
diff --git a/include/asm-i386/floppy.h b/include/asm-i386/floppy.h
index 79727af..0340304 100644
--- a/include/asm-i386/floppy.h
+++ b/include/asm-i386/floppy.h
@@ -56,7 +56,6 @@ static irqreturn_t floppy_hardint(int ir
 	register unsigned char st;
 
 #undef TRACE_FLPY_INT
-#define NO_FLOPPY_ASSEMBLER
 
 #ifdef TRACE_FLPY_INT
 	static int calls=0;
@@ -71,38 +70,6 @@ static irqreturn_t floppy_hardint(int ir
 		bytes = virtual_dma_count;
 #endif
 
-#ifndef NO_FLOPPY_ASSEMBLER
-	__asm__ (
-       "testl %1,%1"
-	"je 3f"
-"1:	inb %w4,%b0"
-	"andb $160,%b0"
-	"cmpb $160,%b0"
-	"jne 2f"
-	"incw %w4"
-	"testl %3,%3"
-	"jne 4f"
-	"inb %w4,%b0"
-	"movb %0,(%2)"
-	"jmp 5f"
-"4:    	movb (%2),%0"
-	"outb %b0,%w4"
-"5:	decw %w4"
-	"outb %0,$0x80"
-	"decl %1"
-	"incl %2"
-	"testl %1,%1"
-	"jne 1b"
-"3:	inb %w4,%b0"
-"2:	"
-       : "=a" ((char) st), 
-       "=c" ((long) virtual_dma_count), 
-       "=S" ((long) virtual_dma_addr)
-       : "b" ((long) virtual_dma_mode),
-       "d" ((short) virtual_dma_port+4), 
-       "1" ((long) virtual_dma_count),
-       "2" ((long) virtual_dma_addr));
-#else	
 	{
 		register int lcount;
 		register char *lptr;
@@ -122,7 +89,6 @@ static irqreturn_t floppy_hardint(int ir
 		virtual_dma_addr = lptr;
 		st = inb(virtual_dma_port+4);
 	}
-#endif
 
 #ifdef TRACE_FLPY_INT
 	calls++;
-- 
1.2.4.g3103



