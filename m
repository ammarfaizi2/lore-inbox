Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVAaXrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVAaXrv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVAaXpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:45:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5382 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261462AbVAaXme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:42:34 -0500
Date: Tue, 1 Feb 2005 00:42:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386/math-emu/: misc cleanups
Message-ID: <20050131234231.GT21437@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- #if 0 unused code

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/math-emu/errors.c       |    2 ++
 arch/i386/math-emu/fpu_aux.c      |    2 +-
 arch/i386/math-emu/fpu_proto.h    |    2 --
 arch/i386/math-emu/load_store.c   |    2 +-
 arch/i386/math-emu/reg_constant.c |   10 ++++++----
 arch/i386/math-emu/reg_constant.h |    6 ------
 6 files changed, 10 insertions(+), 14 deletions(-)

This patch was already sent on:
- 16 Jan 2005

--- linux-2.6.11-rc1-mm1-full/arch/i386/math-emu/fpu_proto.h.old	2005-01-16 05:43:39.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/math-emu/fpu_proto.h	2005-01-16 05:44:22.000000000 +0100
@@ -2,7 +2,6 @@
 #define _FPU_PROTO_H
 
 /* errors.c */
-extern void Un_impl(void);
 extern void FPU_illegal(void);
 extern void FPU_printall(void);
 asmlinkage void FPU_exception(int n);
@@ -41,7 +40,6 @@
 extern void fdivrp(void);
 extern void fdivp_(void);
 /* fpu_aux.c */
-extern void fclex(void);
 extern void finit(void);
 extern void finit_(void);
 extern void fstsw_(void);
--- linux-2.6.11-rc1-mm1-full/arch/i386/math-emu/errors.c.old	2005-01-16 05:43:53.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/math-emu/errors.c	2005-01-16 05:44:07.000000000 +0100
@@ -34,6 +34,7 @@
 /* */
 
 
+#if 0
 void Un_impl(void)
 {
   u_char byte1, FPU_modrm;
@@ -69,6 +70,7 @@
   EXCEPTION(EX_Invalid);
 
 }
+#endif  /*  0  */
 
 
 /*
--- linux-2.6.11-rc1-mm1-full/arch/i386/math-emu/fpu_aux.c.old	2005-01-16 05:44:30.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/math-emu/fpu_aux.c	2005-01-16 05:44:35.000000000 +0100
@@ -21,7 +21,7 @@
 {
 }
 
-void fclex(void)
+static void fclex(void)
 {
   partial_status &= ~(SW_Backward|SW_Summary|SW_Stack_Fault|SW_Precision|
 		   SW_Underflow|SW_Overflow|SW_Zero_Div|SW_Denorm_Op|
--- linux-2.6.11-rc1-mm1-full/arch/i386/math-emu/load_store.c.old	2005-01-16 05:44:50.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/math-emu/load_store.c	2005-01-16 05:45:08.000000000 +0100
@@ -53,7 +53,7 @@
   14, 0, 94, 10,  2, 10,  2,  8
 };
 
-u_char const data_sizes_32[32] = {
+static u_char const data_sizes_32[32] = {
   4,  4,  8,  2,  0,  0,  0,  0,
   4,  4,  8,  2,  4,  4,  8,  2,
   28, 0,108, 10,  2, 10,  0,  8,  
--- linux-2.6.11-rc1-mm1-full/arch/i386/math-emu/reg_constant.h.old	2005-01-16 05:45:27.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/math-emu/reg_constant.h	2005-01-16 05:47:03.000000000 +0100
@@ -12,16 +12,10 @@
 #include "fpu_emu.h"
 
 extern FPU_REG const CONST_1;
-extern FPU_REG const CONST_2;
-extern FPU_REG const CONST_HALF;
-extern FPU_REG const CONST_L2T;
-extern FPU_REG const CONST_L2E;
 extern FPU_REG const CONST_PI;
 extern FPU_REG const CONST_PI2;
 extern FPU_REG const CONST_PI2extra;
 extern FPU_REG const CONST_PI4;
-extern FPU_REG const CONST_LG2;
-extern FPU_REG const CONST_LN2;
 extern FPU_REG const CONST_Z;
 extern FPU_REG const CONST_PINF;
 extern FPU_REG const CONST_INF;
--- linux-2.6.11-rc1-mm1-full/arch/i386/math-emu/reg_constant.c.old	2005-01-16 05:45:41.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/math-emu/reg_constant.c	2005-01-16 05:47:20.000000000 +0100
@@ -21,15 +21,17 @@
                             ((EXTENDED_Ebias+(e)) | ((SIGN_##s != 0)*0x8000)) }
 
 FPU_REG const CONST_1    = MAKE_REG(POS, 0, 0x00000000, 0x80000000);
+#if 0
 FPU_REG const CONST_2    = MAKE_REG(POS, 1, 0x00000000, 0x80000000);
 FPU_REG const CONST_HALF = MAKE_REG(POS, -1, 0x00000000, 0x80000000);
-FPU_REG const CONST_L2T  = MAKE_REG(POS, 1, 0xcd1b8afe, 0xd49a784b);
-FPU_REG const CONST_L2E  = MAKE_REG(POS, 0, 0x5c17f0bc, 0xb8aa3b29);
+#endif  /*  0  */
+static FPU_REG const CONST_L2T  = MAKE_REG(POS, 1, 0xcd1b8afe, 0xd49a784b);
+static FPU_REG const CONST_L2E  = MAKE_REG(POS, 0, 0x5c17f0bc, 0xb8aa3b29);
 FPU_REG const CONST_PI   = MAKE_REG(POS, 1, 0x2168c235, 0xc90fdaa2);
 FPU_REG const CONST_PI2  = MAKE_REG(POS, 0, 0x2168c235, 0xc90fdaa2);
 FPU_REG const CONST_PI4  = MAKE_REG(POS, -1, 0x2168c235, 0xc90fdaa2);
-FPU_REG const CONST_LG2  = MAKE_REG(POS, -2, 0xfbcff799, 0x9a209a84);
-FPU_REG const CONST_LN2  = MAKE_REG(POS, -1, 0xd1cf79ac, 0xb17217f7);
+static FPU_REG const CONST_LG2  = MAKE_REG(POS, -2, 0xfbcff799, 0x9a209a84);
+static FPU_REG const CONST_LN2  = MAKE_REG(POS, -1, 0xd1cf79ac, 0xb17217f7);
 
 /* Extra bits to take pi/2 to more than 128 bits precision. */
 FPU_REG const CONST_PI2extra = MAKE_REG(NEG, -66,

