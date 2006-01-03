Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbWACX3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbWACX3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWACX3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:29:43 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35480 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965099AbWACX3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:29:31 -0500
To: torvalds@osdl.org
Subject: [PATCH 37/41] m68k: fix use of void foo(void) asm("bar") in traps.c
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1Etvas-0003Pg-Q0@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:29:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135320468 -0500

with gcc4 these have file scope, so having them different in different
blocks doesn't work anymore

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/kernel/traps.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

ba18f4ce0d3a21f7e8e4137c4073a3b9ef15b87a
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index deb36e8..cdf58fb 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -169,25 +169,25 @@ void __init trap_init (void)
 
 	if (CPU_IS_060 && !FPU_IS_EMU) {
 		/* set up IFPSP entry points */
-		asmlinkage void snan_vec(void) asm ("_060_fpsp_snan");
-		asmlinkage void operr_vec(void) asm ("_060_fpsp_operr");
-		asmlinkage void ovfl_vec(void) asm ("_060_fpsp_ovfl");
-		asmlinkage void unfl_vec(void) asm ("_060_fpsp_unfl");
-		asmlinkage void dz_vec(void) asm ("_060_fpsp_dz");
-		asmlinkage void inex_vec(void) asm ("_060_fpsp_inex");
-		asmlinkage void fline_vec(void) asm ("_060_fpsp_fline");
-		asmlinkage void unsupp_vec(void) asm ("_060_fpsp_unsupp");
-		asmlinkage void effadd_vec(void) asm ("_060_fpsp_effadd");
-
-		vectors[VEC_FPNAN] = snan_vec;
-		vectors[VEC_FPOE] = operr_vec;
-		vectors[VEC_FPOVER] = ovfl_vec;
-		vectors[VEC_FPUNDER] = unfl_vec;
-		vectors[VEC_FPDIVZ] = dz_vec;
-		vectors[VEC_FPIR] = inex_vec;
-		vectors[VEC_LINE11] = fline_vec;
-		vectors[VEC_FPUNSUP] = unsupp_vec;
-		vectors[VEC_UNIMPEA] = effadd_vec;
+		asmlinkage void snan_vec6(void) asm ("_060_fpsp_snan");
+		asmlinkage void operr_vec6(void) asm ("_060_fpsp_operr");
+		asmlinkage void ovfl_vec6(void) asm ("_060_fpsp_ovfl");
+		asmlinkage void unfl_vec6(void) asm ("_060_fpsp_unfl");
+		asmlinkage void dz_vec6(void) asm ("_060_fpsp_dz");
+		asmlinkage void inex_vec6(void) asm ("_060_fpsp_inex");
+		asmlinkage void fline_vec6(void) asm ("_060_fpsp_fline");
+		asmlinkage void unsupp_vec6(void) asm ("_060_fpsp_unsupp");
+		asmlinkage void effadd_vec6(void) asm ("_060_fpsp_effadd");
+
+		vectors[VEC_FPNAN] = snan_vec6;
+		vectors[VEC_FPOE] = operr_vec6;
+		vectors[VEC_FPOVER] = ovfl_vec6;
+		vectors[VEC_FPUNDER] = unfl_vec6;
+		vectors[VEC_FPDIVZ] = dz_vec6;
+		vectors[VEC_FPIR] = inex_vec6;
+		vectors[VEC_LINE11] = fline_vec6;
+		vectors[VEC_FPUNSUP] = unsupp_vec6;
+		vectors[VEC_UNIMPEA] = effadd_vec6;
 	}
 
         /* if running on an amiga, make the NMI interrupt do nothing */
-- 
0.99.9.GIT

