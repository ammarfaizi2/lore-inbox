Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVAPIEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVAPIEo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 03:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbVAPIEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 03:04:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21775 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262453AbVAPIDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 03:03:38 -0500
Date: Sun, 16 Jan 2005 09:03:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386/kernel/i387.c: misc cleanups
Message-ID: <20050116080330.GD4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following cleanups:
- make a needlessly global variable static
- #if 0 four unused global functions


diffstat output:
 arch/i386/kernel/i387.c |    8 +++++++-
 include/asm-i386/i387.h |    6 ------
 2 files changed, 7 insertions(+), 7 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-full/include/asm-i386/i387.h.old	2005-01-16 04:32:43.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-i386/i387.h	2005-01-16 04:34:41.000000000 +0100
@@ -17,7 +17,6 @@
 #include <asm/sigcontext.h>
 #include <asm/user.h>
 
-extern unsigned long mxcsr_feature_mask;
 extern void mxcsr_feature_mask_init(void);
 extern void init_fpu(struct task_struct *);
 /*
@@ -86,13 +85,8 @@
  */
 extern unsigned short get_fpu_cwd( struct task_struct *tsk );
 extern unsigned short get_fpu_swd( struct task_struct *tsk );
-extern unsigned short get_fpu_twd( struct task_struct *tsk );
 extern unsigned short get_fpu_mxcsr( struct task_struct *tsk );
 
-extern void set_fpu_cwd( struct task_struct *tsk, unsigned short cwd );
-extern void set_fpu_swd( struct task_struct *tsk, unsigned short swd );
-extern void set_fpu_twd( struct task_struct *tsk, unsigned short twd );
-
 /*
  * Signal frame handlers...
  */
--- linux-2.6.11-rc1-mm1-full/arch/i386/kernel/i387.c.old	2005-01-16 04:33:07.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/kernel/i387.c	2005-01-16 04:35:11.000000000 +0100
@@ -24,7 +24,7 @@
 #define HAVE_HWFP 1
 #endif
 
-unsigned long mxcsr_feature_mask = 0xffffffff;
+static unsigned long mxcsr_feature_mask = 0xffffffff;
 
 void mxcsr_feature_mask_init(void)
 {
@@ -175,6 +175,7 @@
 	}
 }
 
+#if 0
 unsigned short get_fpu_twd( struct task_struct *tsk )
 {
 	if ( cpu_has_fxsr ) {
@@ -183,6 +184,7 @@
 		return (unsigned short)tsk->thread.i387.fsave.twd;
 	}
 }
+#endif  /*  0  */
 
 unsigned short get_fpu_mxcsr( struct task_struct *tsk )
 {
@@ -193,6 +195,8 @@
 	}
 }
 
+#if 0
+
 void set_fpu_cwd( struct task_struct *tsk, unsigned short cwd )
 {
 	if ( cpu_has_fxsr ) {
@@ -220,6 +224,8 @@
 	}
 }
 
+#endif  /*  0  */
+
 /*
  * FXSR floating point environment conversions.
  */

