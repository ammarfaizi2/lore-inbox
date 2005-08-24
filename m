Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbVHXOOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVHXOOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 10:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbVHXOOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 10:14:35 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:59387 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1751007AbVHXOOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 10:14:34 -0400
Date: Wed, 24 Aug 2005 23:14:26 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: fix build warnings
Message-Id: <20050824231426.7bca2171.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050822213021.1beda4d5.akpm@osdl.org>
References: <20050822213021.1beda4d5.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has fixed the following warnings.

arch/mips/kernel/genex.S:250:5: warning: "CONFIG_64BIT" is not defined
arch/mips/math-emu/cp1emu.c:1128:5: warning: "__mips64" is not defined
arch/mips/math-emu/cp1emu.c:1206:5: warning: "__mips64" is not defined
arch/mips/math-emu/cp1emu.c:1270:5: warning: "__mips64" is not defined
arch/mips/math-emu/cp1emu.c:323:5: warning: "__mips64" is not defined
arch/mips/math-emu/cp1emu.c:808:5: warning: "__mips64" is not defined
arch/mips/math-emu/cp1emu.c:953:5: warning: "__mips64" is not defined
arch/mips/mm/tlbex.c:519:5: warning: "CONFIG_64BIT" is not defined
include/asm/reg.h:73:5: warning: "CONFIG_64BIT" is not defined

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff mm2-orig/arch/mips/kernel/genex.S mm2/arch/mips/kernel/genex.S
--- mm2-orig/arch/mips/kernel/genex.S	2005-08-24 23:04:03.000000000 +0900
+++ mm2/arch/mips/kernel/genex.S	2005-08-24 22:31:00.000000000 +0900
@@ -244,10 +244,10 @@
 	   start with an n and gas will believe \n is ok ...  */
 	.macro	__BUILD_verbose	nexception
 	LONG_L	a1, PT_EPC(sp)
-#if CONFIG_32BIT
+#ifdef CONFIG_32BIT
 	PRINT("Got \nexception at %08lx\012")
 #endif
-#if CONFIG_64BIT
+#ifdef CONFIG_64BIT
 	PRINT("Got \nexception at %016lx\012")
 #endif
 	.endm
diff -urN -X dontdiff mm2-orig/arch/mips/math-emu/cp1emu.c mm2/arch/mips/math-emu/cp1emu.c
--- mm2-orig/arch/mips/math-emu/cp1emu.c	2005-08-08 03:18:56.000000000 +0900
+++ mm2/arch/mips/math-emu/cp1emu.c	2005-08-24 22:50:55.000000000 +0900
@@ -320,7 +320,7 @@
 	case cop1_op:
 		switch (MIPSInst_RS(ir)) {
 
-#if __mips64 && !defined(SINGLE_ONLY_FPU)
+#if defined(__mips64) && !defined(SINGLE_ONLY_FPU)
 		case dmfc_op:
 			/* copregister fs -> gpr[rt] */
 			if (MIPSInst_RT(ir) != 0) {
@@ -805,7 +805,7 @@
 		ieee754dp d;
 		ieee754sp s;
 		int w;
-#if __mips64
+#ifdef __mips64
 		s64 l;
 #endif
 	} rv;			/* resulting value */
@@ -950,7 +950,7 @@
 		}
 #endif /* __mips >= 2 */
 
-#if __mips64 && !defined(SINGLE_ONLY_FPU)
+#if defined(__mips64) && !defined(SINGLE_ONLY_FPU)
 		case fcvtl_op:{
 			ieee754sp fs;
 
@@ -1125,7 +1125,7 @@
 		}
 #endif
 
-#if __mips64 && !defined(SINGLE_ONLY_FPU)
+#if defined(__mips64) && !defined(SINGLE_ONLY_FPU)
 		case fcvtl_op:{
 			ieee754dp fs;
 
@@ -1203,7 +1203,7 @@
 		break;
 	}
 
-#if __mips64 && !defined(SINGLE_ONLY_FPU)
+#if defined(__mips64) && !defined(SINGLE_ONLY_FPU)
 	case l_fmt:{
 		switch (MIPSInst_FUNC(ir)) {
 		case fcvts_op:
@@ -1267,7 +1267,7 @@
 	case w_fmt:
 		SITOREG(rv.w, MIPSInst_FD(ir));
 		break;
-#if __mips64 && !defined(SINGLE_ONLY_FPU)
+#if defined(__mips64) && !defined(SINGLE_ONLY_FPU)
 	case l_fmt:
 		DITOREG(rv.l, MIPSInst_FD(ir));
 		break;
diff -urN -X dontdiff mm2-orig/arch/mips/mm/tlbex.c mm2/arch/mips/mm/tlbex.c
--- mm2-orig/arch/mips/mm/tlbex.c	2005-08-24 23:04:03.000000000 +0900
+++ mm2/arch/mips/mm/tlbex.c	2005-08-24 22:32:48.000000000 +0900
@@ -516,7 +516,7 @@
 
 static __init void i_LA_mostly(u32 **buf, unsigned int rs, long addr)
 {
-#if CONFIG_64BIT
+#ifdef CONFIG_64BIT
 	if (!in_compat_space_p(addr)) {
 		i_lui(buf, rs, rel_highest(addr));
 		if (rel_higher(addr))
diff -urN -X dontdiff mm2-orig/include/asm-mips/reg.h mm2/include/asm-mips/reg.h
--- mm2-orig/include/asm-mips/reg.h	2005-08-24 23:04:07.000000000 +0900
+++ mm2/include/asm-mips/reg.h	2005-08-24 22:30:38.000000000 +0900
@@ -70,7 +70,7 @@
 
 #endif
 
-#if CONFIG_64BIT
+#ifdef CONFIG_64BIT
 
 #define EF_R0			 0
 #define EF_R1			 1


