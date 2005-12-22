Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbVLVFAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbVLVFAB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 00:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbVLVEuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:50:11 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:22992 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965047AbVLVEtu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:49:50 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 09/36] m68k: fix macro syntax to make current binutils happy
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIOj-0004qc-HA@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:49:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1134413482 -0500

recent as(1) doesn't think that . terminates a macro name, so
getuser.l is _not_ treated as invoking getuser with .l as the
first argument.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/math-emu/fp_cond.S   |    2 +-
 arch/m68k/math-emu/fp_decode.h |    4 ++--
 arch/m68k/math-emu/fp_move.S   |   14 +++++++-------
 arch/m68k/math-emu/fp_movem.S  |   16 ++++++++--------
 arch/m68k/math-emu/fp_scan.S   |   22 +++++++++++-----------
 arch/m68k/math-emu/fp_util.S   |   16 ++++++++--------
 6 files changed, 37 insertions(+), 37 deletions(-)

3e6c27942e8eb6a6af640228e31e780bb64442cd
diff --git a/arch/m68k/math-emu/fp_cond.S b/arch/m68k/math-emu/fp_cond.S
index ddae8b1..1cddeb0 100644
--- a/arch/m68k/math-emu/fp_cond.S
+++ b/arch/m68k/math-emu/fp_cond.S
@@ -163,7 +163,7 @@ fp_absolute_long:
 
 fp_do_scc:
 	swap	%d1
-	putuser.b %d1,(%a0),fp_err_ua1,%a0
+	putuser .b,%d1,(%a0),fp_err_ua1,%a0
 	printf	PDECODE,"\n"
 	jra	fp_end
 
diff --git a/arch/m68k/math-emu/fp_decode.h b/arch/m68k/math-emu/fp_decode.h
index 759679d..a2595d9 100644
--- a/arch/m68k/math-emu/fp_decode.h
+++ b/arch/m68k/math-emu/fp_decode.h
@@ -311,7 +311,7 @@ debug	move.l	"(%sp)+,%d1"
 	btst	#2,%d2
 	jne	1f
 	printf	PDECODE,")@("
-	getuser.l (%a1),%a1,fp_err_ua1,%a1
+	getuser .l,(%a1),%a1,fp_err_ua1,%a1
 debug	jra	"2f"
 1:	printf	PDECODE,","
 2:
@@ -322,7 +322,7 @@ debug	jra	"2f"
 	btst	#2,%d2
 	jeq	1f
 	printf	PDECODE,")@("
-	getuser.l (%a1),%a1,fp_err_ua1,%a1
+	getuser .l,(%a1),%a1,fp_err_ua1,%a1
 debug	jra	"2f"
 1:	printf	PDECODE,","
 2:
diff --git a/arch/m68k/math-emu/fp_move.S b/arch/m68k/math-emu/fp_move.S
index 71bdf83..9bd0334 100644
--- a/arch/m68k/math-emu/fp_move.S
+++ b/arch/m68k/math-emu/fp_move.S
@@ -200,12 +200,12 @@ fp_putdest:
 
 fp_format_long:
 	jsr	fp_conv_ext2long
-	putuser.l %d0,(%a1),fp_err_ua1,%a1
+	putuser .l,%d0,(%a1),fp_err_ua1,%a1
 	jra	fp_finish_move
 
 fp_format_single:
 	jsr	fp_conv_ext2single
-	putuser.l %d0,(%a1),fp_err_ua1,%a1
+	putuser .l,%d0,(%a1),fp_err_ua1,%a1
 	jra	fp_finish_move
 
 fp_format_extended:
@@ -213,11 +213,11 @@ fp_format_extended:
 	lsl.w	#1,%d0
 	lsl.l	#7,%d0
 	lsl.l	#8,%d0
-	putuser.l %d0,(%a1)+,fp_err_ua1,%a1
+	putuser .l,%d0,(%a1)+,fp_err_ua1,%a1
 	move.l	(%a0)+,%d0
-	putuser.l %d0,(%a1)+,fp_err_ua1,%a1
+	putuser .l,%d0,(%a1)+,fp_err_ua1,%a1
 	move.l	(%a0),%d0
-	putuser.l %d0,(%a1),fp_err_ua1,%a1
+	putuser .l,%d0,(%a1),fp_err_ua1,%a1
 	jra	fp_finish_move
 
 fp_format_packed:
@@ -227,7 +227,7 @@ fp_format_packed:
 
 fp_format_word:
 	jsr	fp_conv_ext2short
-	putuser.w %d0,(%a1),fp_err_ua1,%a1
+	putuser .w,%d0,(%a1),fp_err_ua1,%a1
 	jra	fp_finish_move
 
 fp_format_double:
@@ -236,7 +236,7 @@ fp_format_double:
 
 fp_format_byte:
 	jsr	fp_conv_ext2byte
-	putuser.b %d0,(%a1),fp_err_ua1,%a1
+	putuser .b,%d0,(%a1),fp_err_ua1,%a1
 |	jra	fp_finish_move
 
 fp_finish_move:
diff --git a/arch/m68k/math-emu/fp_movem.S b/arch/m68k/math-emu/fp_movem.S
index 8354d39..9c74134 100644
--- a/arch/m68k/math-emu/fp_movem.S
+++ b/arch/m68k/math-emu/fp_movem.S
@@ -141,14 +141,14 @@ fpr_do_movem:
 	| move register from memory into fpu
 	jra	3f
 1:	printf	PMOVEM,"(%p>%p)",2,%a0,%a1
-	getuser.l (%a0)+,%d2,fp_err_ua1,%a0
+	getuser .l,(%a0)+,%d2,fp_err_ua1,%a0
 	lsr.l	#8,%d2
 	lsr.l	#7,%d2
 	lsr.w	#1,%d2
 	move.l	%d2,(%a1)+
-	getuser.l (%a0)+,%d2,fp_err_ua1,%a0
+	getuser .l,(%a0)+,%d2,fp_err_ua1,%a0
 	move.l	%d2,(%a1)+
-	getuser.l (%a0),%d2,fp_err_ua1,%a0
+	getuser .l,(%a0),%d2,fp_err_ua1,%a0
 	move.l	%d2,(%a1)
 	subq.l	#8,%a0
 	subq.l	#8,%a1
@@ -164,11 +164,11 @@ fpr_do_movem:
 	lsl.w	#1,%d2
 	lsl.l	#7,%d2
 	lsl.l	#8,%d2
-	putuser.l %d2,(%a0)+,fp_err_ua1,%a0
+	putuser .l,%d2,(%a0)+,fp_err_ua1,%a0
 	move.l	(%a1)+,%d2
-	putuser.l %d2,(%a0)+,fp_err_ua1,%a0
+	putuser .l,%d2,(%a0)+,fp_err_ua1,%a0
 	move.l	(%a1),%d2
-	putuser.l %d2,(%a0),fp_err_ua1,%a0
+	putuser .l,%d2,(%a0),fp_err_ua1,%a0
 	subq.l	#8,%a1
 	subq.l	#8,%a0
 	add.l	%d0,%a0
@@ -325,7 +325,7 @@ fpc_do_movem:
 	| move register from memory into fpu
 	jra	3f
 1:	printf	PMOVEM,"(%p>%p)",2,%a0,%a1
-	getuser.l (%a0)+,%d0,fp_err_ua1,%a0
+	getuser .l,(%a0)+,%d0,fp_err_ua1,%a0
 	move.l	%d0,(%a1)
 2:	addq.l	#4,%a1
 3:	lsl.b	#1,%d1
@@ -336,7 +336,7 @@ fpc_do_movem:
 	| move register from fpu into memory
 1:	printf	PMOVEM,"(%p>%p)",2,%a1,%a0
 	move.l	(%a1),%d0
-	putuser.l %d0,(%a0)+,fp_err_ua1,%a0
+	putuser .l,%d0,(%a0)+,fp_err_ua1,%a0
 2:	addq.l	#4,%a1
 4:	lsl.b	#1,%d1
 	jcs	1b
diff --git a/arch/m68k/math-emu/fp_scan.S b/arch/m68k/math-emu/fp_scan.S
index e4146ed..5f49b93 100644
--- a/arch/m68k/math-emu/fp_scan.S
+++ b/arch/m68k/math-emu/fp_scan.S
@@ -64,7 +64,7 @@ fp_scan:
 | normal fpu instruction? (this excludes fsave/frestore)
 	fp_get_pc %a0
 	printf	PDECODE,"%08x: ",1,%a0
-	getuser.b (%a0),%d0,fp_err_ua1,%a0
+	getuser .b,(%a0),%d0,fp_err_ua1,%a0
 #if 1
 	cmp.b	#0xf2,%d0		| cpid = 1
 #else
@@ -72,7 +72,7 @@ fp_scan:
 #endif
 	jne	fp_nonstd
 | first two instruction words are kept in %d2
-	getuser.l (%a0)+,%d2,fp_err_ua1,%a0
+	getuser .l,(%a0)+,%d2,fp_err_ua1,%a0
 	fp_put_pc %a0
 fp_decode_cond:				| separate conditional instr
 	fp_decode_cond_instr_type
@@ -230,7 +230,7 @@ fp_immediate:
 	movel	%a0,%a1
 	clr.l	%d1
 	jra	2f
-1:	getuser.b (%a1)+,%d1,fp_err_ua1,%a1
+1:	getuser .b,(%a1)+,%d1,fp_err_ua1,%a1
 	printf	PDECODE,"%02x",1,%d1
 2:	dbra	%d0,1b
 	movem.l	(%sp)+,%d0/%d1
@@ -252,24 +252,24 @@ fp_fetchsource:
 	.long	fp_byte, fp_ill
 
 fp_long:
-	getuser.l (%a1),%d0,fp_err_ua1,%a1
+	getuser .l,(%a1),%d0,fp_err_ua1,%a1
 	jsr	fp_conv_long2ext
 	jra	fp_getdest
 
 fp_single:
-	getuser.l (%a1),%d0,fp_err_ua1,%a1
+	getuser .l,(%a1),%d0,fp_err_ua1,%a1
 	jsr	fp_conv_single2ext
 	jra	fp_getdest
 
 fp_ext:
-	getuser.l (%a1)+,%d0,fp_err_ua1,%a1
+	getuser .l,(%a1)+,%d0,fp_err_ua1,%a1
 	lsr.l	#8,%d0
 	lsr.l	#7,%d0
 	lsr.w	#1,%d0
 	move.l	%d0,(%a0)+
-	getuser.l (%a1)+,%d0,fp_err_ua1,%a1
+	getuser .l,(%a1)+,%d0,fp_err_ua1,%a1
 	move.l	%d0,(%a0)+
-	getuser.l (%a1),%d0,fp_err_ua1,%a1
+	getuser .l,(%a1),%d0,fp_err_ua1,%a1
 	move.l	%d0,(%a0)
 	subq.l	#8,%a0
 	jra	fp_getdest
@@ -279,7 +279,7 @@ fp_pack:
 	jra	fp_ill
 
 fp_word:
-	getuser.w (%a1),%d0,fp_err_ua1,%a1
+	getuser .w,(%a1),%d0,fp_err_ua1,%a1
 	ext.l	%d0
 	jsr	fp_conv_long2ext
 	jra	fp_getdest
@@ -289,7 +289,7 @@ fp_double:
 	jra	fp_getdest
 
 fp_byte:
-	getuser.b (%a1),%d0,fp_err_ua1,%a1
+	getuser .b,(%a1),%d0,fp_err_ua1,%a1
 	extb.l	%d0
 	jsr	fp_conv_long2ext
 |	jra	fp_getdest
@@ -465,7 +465,7 @@ fp_fdsub:
 
 fp_nonstd:
 	fp_get_pc %a0
-	getuser.l (%a0),%d0,fp_err_ua1,%a0
+	getuser .l,(%a0),%d0,fp_err_ua1,%a0
 	printf	,"nonstd ((%08x)=%08x)\n",2,%a0,%d0
 	moveq	#-1,%d0
 	rts
diff --git a/arch/m68k/math-emu/fp_util.S b/arch/m68k/math-emu/fp_util.S
index a9f7f01..f9f24d5 100644
--- a/arch/m68k/math-emu/fp_util.S
+++ b/arch/m68k/math-emu/fp_util.S
@@ -160,11 +160,11 @@ fp_s2e_large:
 
 fp_conv_double2ext:
 #ifdef FPU_EMU_DEBUG
-	getuser.l %a1@(0),%d0,fp_err_ua2,%a1
-	getuser.l %a1@(4),%d1,fp_err_ua2,%a1
+	getuser .l,%a1@(0),%d0,fp_err_ua2,%a1
+	getuser .l,%a1@(4),%d1,fp_err_ua2,%a1
 	printf	PCONV,"d2e: %p%p -> %p(",3,%d0,%d1,%a0
 #endif
-	getuser.l (%a1)+,%d0,fp_err_ua2,%a1
+	getuser .l,(%a1)+,%d0,fp_err_ua2,%a1
 	move.l	%d0,%d1
 	lsl.l	#8,%d0			| shift high mantissa
 	lsl.l	#3,%d0
@@ -178,7 +178,7 @@ fp_conv_double2ext:
 	add.w	#0x3fff-0x3ff,%d1	| re-bias the exponent.
 9:	move.l	%d1,(%a0)+		| fp_ext.sign, fp_ext.exp
 	move.l	%d0,(%a0)+
-	getuser.l (%a1)+,%d0,fp_err_ua2,%a1
+	getuser .l,(%a1)+,%d0,fp_err_ua2,%a1
 	move.l	%d0,%d1
 	lsl.l	#8,%d0
 	lsl.l	#3,%d0
@@ -1287,17 +1287,17 @@ fp_conv_ext2double:
 	lsr.l	#4,%d0
 	lsr.l	#8,%d0
 	or.l	%d2,%d0
-	putuser.l %d0,(%a1)+,fp_err_ua2,%a1
+	putuser .l,%d0,(%a1)+,fp_err_ua2,%a1
 	moveq	#21,%d0
 	lsl.l	%d0,%d1
 	move.l	(%a0),%d0
 	lsr.l	#4,%d0
 	lsr.l	#7,%d0
 	or.l	%d1,%d0
-	putuser.l %d0,(%a1),fp_err_ua2,%a1
+	putuser .l,%d0,(%a1),fp_err_ua2,%a1
 #ifdef FPU_EMU_DEBUG
-	getuser.l %a1@(-4),%d0,fp_err_ua2,%a1
-	getuser.l %a1@(0),%d1,fp_err_ua2,%a1
+	getuser .l,%a1@(-4),%d0,fp_err_ua2,%a1
+	getuser .l,%a1@(0),%d1,fp_err_ua2,%a1
 	printf	PCONV,"%p(%08x%08x)\n",3,%a1,%d0,%d1
 #endif
 	rts
-- 
0.99.9.GIT

