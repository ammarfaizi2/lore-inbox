Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314815AbSD2Gn4>; Mon, 29 Apr 2002 02:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314818AbSD2Gnz>; Mon, 29 Apr 2002 02:43:55 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:53754 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S314815AbSD2Gnx>; Mon, 29 Apr 2002 02:43:53 -0400
Message-ID: <3CCCEB0A.8090703@didntduck.org>
Date: Mon, 29 Apr 2002 02:41:14 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Subject: [PATCH] Removing SYMBOL_NAME part 6
Content-Type: multipart/mixed;
 boundary="------------080607000309070703080307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080607000309070703080307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Last remaining instances removed.

-- 

						Brian Gerst

--------------080607000309070703080307
Content-Type: text/plain;
 name="symbol_name-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="symbol_name-6"

diff -urN linux-2.5.11/drivers/pnp/pnpbios_core.c linux/drivers/pnp/pnpbios_core.c
--- linux-2.5.11/drivers/pnp/pnpbios_core.c	Mon Apr 22 19:17:23 2002
+++ linux/drivers/pnp/pnpbios_core.c	Mon Apr 29 02:31:05 2002
@@ -113,12 +113,12 @@
 __asm__(
 	".text			\n"
 	__ALIGN_STR "\n"
-	SYMBOL_NAME_STR(pnp_bios_callfunc) ":\n"
+	"pnp_bios_callfunc:\n"
 	"	pushl %edx	\n"
 	"	pushl %ecx	\n"
 	"	pushl %ebx	\n"
 	"	pushl %eax	\n"
-	"	lcallw " SYMBOL_NAME_STR(pnp_bios_callpoint) "\n"
+	"	lcallw pnp_bios_callpoint\n"
 	"	addl $16, %esp	\n"
 	"	lret		\n"
 	".previous		\n"
diff -urN linux-2.5.11/drivers/scsi/seagate.c linux/drivers/scsi/seagate.c
--- linux-2.5.11/drivers/scsi/seagate.c	Thu Mar  7 21:18:29 2002
+++ linux/drivers/scsi/seagate.c	Mon Apr 29 02:31:05 2002
@@ -1285,8 +1285,8 @@
 							/* Test for any data here at all. */
 							"orl %%ecx, %%ecx\n\t"
 							"jz 2f\n\t" "cld\n\t"
-/*                    "movl " SYMBOL_NAME_STR(st0x_cr_sr) ", %%ebx\n\t"  */
-/*                    "movl " SYMBOL_NAME_STR(st0x_dr) ", %%edi\n\t"  */
+/*                    "movl st0x_cr_sr, %%ebx\n\t"  */
+/*                    "movl st0x_dr, %%edi\n\t"  */
 							"1:\t"
 							"movb (%%ebx), %%al\n\t"
 							/* Test for BSY */
@@ -1461,8 +1461,8 @@
 							/* Test for room to read */
 							"orl %%ecx, %%ecx\n\t"
 							"jz 2f\n\t" "cld\n\t"
-/*                "movl " SYMBOL_NAME_STR(st0x_cr_sr) ", %%esi\n\t"  */
-/*                "movl " SYMBOL_NAME_STR(st0x_dr) ", %%ebx\n\t"  */
+/*                "movl st0x_cr_sr, %%esi\n\t"  */
+/*                "movl st0x_dr, %%ebx\n\t"  */
 							"1:\t"
 							"movb (%%esi), %%al\n\t"
 							/* Test for BSY */
diff -urN linux-2.5.11/include/linux/linkage.h linux/include/linux/linkage.h
--- linux-2.5.11/include/linux/linkage.h	Thu Mar  7 21:18:06 2002
+++ linux/include/linux/linkage.h	Mon Apr 29 02:31:05 2002
@@ -17,14 +17,6 @@
 #define asmlinkage CPP_ASMLINKAGE
 #endif
 
-#define SYMBOL_NAME_STR(X) #X
-#define SYMBOL_NAME(X) X
-#ifdef __STDC__
-#define SYMBOL_NAME_LABEL(X) X##:
-#else
-#define SYMBOL_NAME_LABEL(X) X/**/:
-#endif
-
 #ifdef __arm__
 #define __ALIGN .align 0
 #define __ALIGN_STR ".align 0"
@@ -54,9 +46,9 @@
 #define ALIGN_STR __ALIGN_STR
 
 #define ENTRY(name) \
-  .globl SYMBOL_NAME(name); \
+  .globl name; \
   ALIGN; \
-  SYMBOL_NAME_LABEL(name)
+  name:
 
 #endif
 
diff -urN linux-2.5.11/include/net/profile.h linux/include/net/profile.h
--- linux-2.5.11/include/net/profile.h	Sat Apr 27 12:20:02 2002
+++ linux/include/net/profile.h	Mon Apr 29 02:33:44 2002
@@ -44,7 +44,7 @@
 			      "sbbl %3,%1\n\t" 
 			      "addl %4,%0\n\t" 
 			      "adcl %5,%1\n\t" 
-			      "subl " SYMBOL_NAME_STR(net_profile_adjust) "+4,%0\n\t" 
+			      "subl net_profile_adjust+4,%0\n\t" 
 			      "sbbl $0,%1\n\t" 
 			      : "=r" (acc->tv_usec), "=r" (acc->tv_sec)
 			      : "g" (entered->tv_usec), "g" (entered->tv_sec),
diff -urN linux-2.5.11/sound/oss/vidc_fill.S linux/sound/oss/vidc_fill.S
--- linux-2.5.11/sound/oss/vidc_fill.S	Thu Mar  7 21:18:55 2002
+++ linux/sound/oss/vidc_fill.S	Mon Apr 29 02:31:05 2002
@@ -20,7 +20,7 @@
 ENTRY(vidc_fill_1x8_u)
 		mov	ip, #0xff00
 1:		cmp	r0, r1
-		bge	SYMBOL_NAME(vidc_clear)
+		bge	vidc_clear
 		ldrb	r4, [r0], #1
 		eor	r4, r4, #0x80
 		and	r4, ip, r4, lsl #8
@@ -33,7 +33,7 @@
 ENTRY(vidc_fill_2x8_u)
 		mov	ip, #0xff00
 1:		cmp	r0, r1
-		bge	SYMBOL_NAME(vidc_clear)
+		bge	vidc_clear
 		ldr	r4, [r0], #2
 		and	r5, r4, ip
 		and	r4, ip, r4, lsl #8
@@ -47,7 +47,7 @@
 ENTRY(vidc_fill_1x8_s)
 		mov	ip, #0xff00
 1:		cmp	r0, r1
-		bge	SYMBOL_NAME(vidc_clear)
+		bge	vidc_clear
 		ldrb	r4, [r0], #1
 		and	r4, ip, r4, lsl #8
 		orr	r4, r4, r4, lsl #16
@@ -59,7 +59,7 @@
 ENTRY(vidc_fill_2x8_s)
 		mov	ip, #0xff00
 1:		cmp	r0, r1
-		bge	SYMBOL_NAME(vidc_clear)
+		bge	vidc_clear
 		ldr	r4, [r0], #2
 		and	r5, r4, ip
 		and	r4, ip, r4, lsl #8
@@ -74,7 +74,7 @@
 		mov	ip, #0xff00
 		orr	ip, ip, ip, lsr #8
 1:		cmp	r0, r1
-		bge	SYMBOL_NAME(vidc_clear)
+		bge	vidc_clear
 		ldr	r5, [r0], #2
 		and	r4, r5, ip
 		orr	r4, r4, r4, lsl #16
@@ -92,7 +92,7 @@
 		mov	ip, #0xff00
 		orr	ip, ip, ip, lsr #8
 1:		cmp	r0, r1
-		bge	SYMBOL_NAME(vidc_clear)
+		bge	vidc_clear
 		ldr	r4, [r0], #4
 		str	r4, [r2], #4
 		cmp	r0, r1
@@ -136,10 +136,10 @@
 
 ENTRY(vidc_sound_dma_irq)
 		stmfd	sp!, {r4 - r8, lr}
-		ldr	r8, =SYMBOL_NAME(dma_start)
+		ldr	r8, =dma_start
 		ldmia	r8, {r0, r1, r2, r3, r4, r5}
 		teq	r1, #0
-		adreq	r4, SYMBOL_NAME(vidc_fill_noaudio)
+		adreq	r4, vidc_fill_noaudio
 		moveq	r7, #1 << 31
 		movne	r7, #0
 		mov	ip, #IOMD_BASE & 0xff000000
@@ -193,26 +193,26 @@
 		mov	pc, lr
 
 		.data
-		.globl	SYMBOL_NAME(dma_interrupt)
-SYMBOL_NAME(dma_interrupt):
+		.globl	dma_interrupt
+dma_interrupt:
 		.long	0				@ r3
-		.globl	SYMBOL_NAME(dma_pbuf)
-SYMBOL_NAME(dma_pbuf):
+		.globl	dma_pbuf
+dma_pbuf:
 		.long	0				@ r4
 		.long	0				@ r5
-		.globl	SYMBOL_NAME(dma_start)
-SYMBOL_NAME(dma_start):
+		.globl	dma_start
+dma_start:
 		.long	0				@ r0
-		.globl	SYMBOL_NAME(dma_count)
-SYMBOL_NAME(dma_count):
+		.globl	dma_count
+dma_count:
 		.long	0				@ r1
-		.globl	SYMBOL_NAME(dma_buf)
-SYMBOL_NAME(dma_buf):
+		.globl	dma_buf
+dma_buf:
 		.long	0				@ r2
 		.long	0				@ r3
-		.globl	SYMBOL_NAME(vidc_filler)
-SYMBOL_NAME(vidc_filler):
-		.long	SYMBOL_NAME(vidc_fill_noaudio)	@ r4
-		.globl	SYMBOL_NAME(dma_bufsize)
-SYMBOL_NAME(dma_bufsize):
+		.globl	vidc_filler
+vidc_filler:
+		.long	vidc_fill_noaudio		@ r4
+		.globl	dma_bufsize
+dma_bufsize:
 		.long	0x1000				@ r5

--------------080607000309070703080307--

