Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265389AbSJRXmn>; Fri, 18 Oct 2002 19:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265397AbSJRXmm>; Fri, 18 Oct 2002 19:42:42 -0400
Received: from fmr01.intel.com ([192.55.52.18]:18670 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265389AbSJRXmj>;
	Fri, 18 Oct 2002 19:42:39 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000E6ADE5B@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: [PATCH] fixes for building kernel using Intel compiler
Date: Fri, 18 Oct 2002 16:48:34 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C27700.DF4E6F40"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C27700.DF4E6F40
Content-Type: text/plain;
	charset="iso-8859-1"

Hi Linus,

Attached is the patch that resolves some of the redundant code and casting
that are required to build the Linux kernel usning Intel compiler. We would
like to get this patch incorporated to allow the kernel built with Intel
Compiler.

Thanks,
Jun Nakajima

============================================================================
=================diff -ur linux-2.5.43.orig/arch/i386/kernel/ioport.c
linux-2.5.43/arch/i386/kern
el/ioport.c
--- linux-2.5.43.orig/arch/i386/kernel/ioport.c Fri Oct 18 15:19:35 2002
+++ linux-2.5.43/arch/i386/kernel/ioport.c      Fri Oct 18 16:10:13 2002
@@ -108,9 +108,8 @@
  * code.
  */

-asmlinkage int sys_iopl(unsigned long unused)
+asmlinkage int sys_iopl(struct pt_regs * regs)
 {
-       struct pt_regs * regs = (struct pt_regs *) &unused;
        unsigned int level = regs->ebx;
        unsigned int old = (regs->eflags >> 12) & 3;

diff -ur linux-2.5.43.orig/drivers/net/wireless/airo.c
linux-2.5.43/drivers/net/
wireless/airo.c
--- linux-2.5.43.orig/drivers/net/wireless/airo.c       Fri Oct 18 15:19:35
2002
+++ linux-2.5.43/drivers/net/wireless/airo.c    Fri Oct 18 15:28:06 2002
@@ -97,12 +97,12 @@
    infront of the label, that statistic will not be included in the list
    of statistics in the /proc filesystem */

-#define IGNLABEL 0&(int)
+#define IGNLABEL (0,)
 static char *statsLabels[] = {
        "RxOverrun",
-       IGNLABEL "RxPlcpCrcErr",
-       IGNLABEL "RxPlcpFormatErr",
-       IGNLABEL "RxPlcpLengthErr",
+       IGNLABEL /* "RxPlcpCrcErr", */
+       IGNLABEL /* "RxPlcpFormatErr", */
+       IGNLABEL /* "RxPlcpLengthErr", */
        "RxMacCrcErr",
        "RxMacCrcOk",
        "RxWepErr",
@@ -146,15 +146,15 @@
        "HostRxBc",
        "HostRxUc",
        "HostRxDiscard",
-       IGNLABEL "HmacTxMc",
-       IGNLABEL "HmacTxBc",
-       IGNLABEL "HmacTxUc",
-       IGNLABEL "HmacTxFail",
-       IGNLABEL "HmacRxMc",
-       IGNLABEL "HmacRxBc",
-       IGNLABEL "HmacRxUc",
-       IGNLABEL "HmacRxDiscard",
-       IGNLABEL "HmacRxAccepted",
+       IGNLABEL /* "HmacTxMc", */
+       IGNLABEL /* "HmacTxBc", */
+       IGNLABEL /* "HmacTxUc", */
+       IGNLABEL /* "HmacTxFail", */
+       IGNLABEL /* "HmacRxMc", */
+       IGNLABEL /* "HmacRxBc", */
+       IGNLABEL /* "HmacRxUc", */
+       IGNLABEL /* "HmacRxDiscard", */
+       IGNLABEL /* "HmacRxAccepted", */
        "SsidMismatch",
        "ApMismatch",
        "RatesMismatch",
@@ -162,26 +162,26 @@
        "AuthTimeout",
        "AssocReject",
        "AssocTimeout",
-       IGNLABEL "ReasonOutsideTable",
-       IGNLABEL "ReasonStatus1",
-       IGNLABEL "ReasonStatus2",
-       IGNLABEL "ReasonStatus3",
-       IGNLABEL "ReasonStatus4",
-       IGNLABEL "ReasonStatus5",
-       IGNLABEL "ReasonStatus6",
-       IGNLABEL "ReasonStatus7",
-       IGNLABEL "ReasonStatus8",
-       IGNLABEL "ReasonStatus9",
-       IGNLABEL "ReasonStatus10",
-       IGNLABEL "ReasonStatus11",
-       IGNLABEL "ReasonStatus12",
-       IGNLABEL "ReasonStatus13",
-       IGNLABEL "ReasonStatus14",
-       IGNLABEL "ReasonStatus15",
-       IGNLABEL "ReasonStatus16",
-       IGNLABEL "ReasonStatus17",
-       IGNLABEL "ReasonStatus18",
-       IGNLABEL "ReasonStatus19",
+       IGNLABEL /* "ReasonOutsideTable", */
+       IGNLABEL /* "ReasonStatus1", */
+       IGNLABEL /* "ReasonStatus2", */
+       IGNLABEL /* "ReasonStatus3", */
+       IGNLABEL /* "ReasonStatus4", */
+       IGNLABEL /* "ReasonStatus5", */
+       IGNLABEL /* "ReasonStatus6", */
+       IGNLABEL /* "ReasonStatus7", */
+       IGNLABEL /* "ReasonStatus8", */
+       IGNLABEL /* "ReasonStatus9", */
+       IGNLABEL /* "ReasonStatus10", */
+       IGNLABEL /* "ReasonStatus11", */
+       IGNLABEL /* "ReasonStatus12", */
+       IGNLABEL /* "ReasonStatus13", */
+       IGNLABEL /* "ReasonStatus14", */
+       IGNLABEL /* "ReasonStatus15", */
+       IGNLABEL /* "ReasonStatus16", */
+       IGNLABEL /* "ReasonStatus17", */
+       IGNLABEL /* "ReasonStatus18", */
+       IGNLABEL /* "ReasonStatus19", */
        "RxMan",
        "TxMan",
        "RxRefresh",
diff -ur linux-2.5.43.orig/include/asm-i386/bugs.h
linux-2.5.43/include/asm-i386
/bugs.h
--- linux-2.5.43.orig/include/asm-i386/bugs.h   Fri Sep 27 14:49:09 2002
+++ linux-2.5.43/include/asm-i386/bugs.h        Fri Oct 18 16:11:56 2002
@@ -76,14 +76,6 @@
                return;
        }

-/* Enable FXSR and company _before_ testing for FP problems. */
-       /*
-        * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
-        */
-       if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
-               extern void __buggy_fxsr_alignment(void);
-               __buggy_fxsr_alignment();
-       }
        if (cpu_has_fxsr) {
                printk(KERN_INFO "Enabling fast FPU save and restore... ");
                set_in_cr4(X86_CR4_OSFXSR);
diff -ur linux-2.5.43.orig/include/linux/mtd/compatmac.h
linux-2.5.43/include/li
nux/mtd/compatmac.h
--- linux-2.5.43.orig/include/linux/mtd/compatmac.h     Fri Sep 27 14:50:29
2002
+++ linux-2.5.43/include/linux/mtd/compatmac.h  Fri Oct 18 15:28:06 2002
@@ -193,6 +193,7 @@
 #define spin_lock_bh(lock) do {start_bh_atomic();spin_lock(lock);} while(0)
 #define spin_unlock_bh(lock) do {spin_unlock(lock);end_bh_atomic();}
while(0)
 #else
+#include <linux/interrupt.h>
 #include <asm/softirq.h>
 #include <linux/spinlock.h>
 #endif
diff -ur linux-2.5.43.orig/kernel/module.c linux-2.5.43/kernel/module.c
--- linux-2.5.43.orig/kernel/module.c   Fri Sep 27 14:49:13 2002
+++ linux-2.5.43/kernel/module.c        Fri Oct 18 15:28:06 2002
@@ -425,11 +425,11 @@
                printk(KERN_ERR "init_module: mod->deps out of bounds.\n");
                goto err2;
        }
-       if (mod->init && !mod_bound(mod->init, 0, mod)) {
+       if (mod->init && !mod_bound((unsigned long)mod->init, 0, mod)) {
                printk(KERN_ERR "init_module: mod->init out of bounds.\n");
                goto err2;
        }
-       if (mod->cleanup && !mod_bound(mod->cleanup, 0, mod)) {
+       if (mod->cleanup && !mod_bound((unsigned long)mod->cleanup, 0, mod))
{
                printk(KERN_ERR "init_module: mod->cleanup out of
bounds.\n");
                goto err2;
        }
@@ -449,7 +449,7 @@
                goto err2;
        }
        if (mod_member_present(mod, can_unload)
-           && mod->can_unload && !mod_bound(mod->can_unload, 0, mod)) {
+           && mod->can_unload && !mod_bound((unsigned long)mod->can_unload,
0,
mod)) {
              printk(KERN_ERR "init_module: mod->can_unload out of
bounds.\n")
;
                goto err2;
        }



------_=_NextPart_000_01C27700.DF4E6F40
Content-Type: application/octet-stream;
	name="icc-build-2.5.43.ZIP"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="icc-build-2.5.43.ZIP"

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

------_=_NextPart_000_01C27700.DF4E6F40--
