Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265390AbSJaULL>; Thu, 31 Oct 2002 15:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265391AbSJaULL>; Thu, 31 Oct 2002 15:11:11 -0500
Received: from momus.sc.intel.com ([143.183.152.8]:26580 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S265390AbSJaULI>; Thu, 31 Oct 2002 15:11:08 -0500
Message-ID: <F2DBA543B89AD51184B600508B68D4000EFF45BD@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: [PATCH] fixes for building kernel 2.5.45 using Intel compiler (Ta
	ke 2)
Date: Thu, 31 Oct 2002 12:16:47 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is take 2 of the updated patch against 2.5.45. I'm asking the compiler 
team if someone can answer your question:

> Considering that Intel largely wrote iBCS2, I guess some Intel person can 
> know what the standard was ;)

I like Alan's idea: IGNLABEL("HmacRxAccepted")

Jun Nakajima

diff -ur linux-2.5.45.orig/arch/i386/kernel/ioport.c
linux-2.5.45/arch/i386/kernel/ioport.c
--- linux-2.5.45.orig/arch/i386/kernel/ioport.c	Sun Oct 20 12:30:45 2002
+++ linux-2.5.45/arch/i386/kernel/ioport.c	Thu Oct 31 09:36:42 2002
@@ -110,7 +110,7 @@
 
 asmlinkage int sys_iopl(unsigned long unused)
 {
-	struct pt_regs * regs = (struct pt_regs *) &unused;
+	volatile struct pt_regs * regs = (struct pt_regs *) &unused;
 	unsigned int level = regs->ebx;
 	unsigned int old = (regs->eflags >> 12) & 3;
 
diff -ur linux-2.5.45.orig/drivers/net/wireless/airo.c
linux-2.5.45/drivers/net/wireless/airo.c
--- linux-2.5.45.orig/drivers/net/wireless/airo.c	Sun Oct 20 12:30:45
2002
+++ linux-2.5.45/drivers/net/wireless/airo.c	Thu Oct 31 11:42:46 2002
@@ -97,12 +97,12 @@
    infront of the label, that statistic will not be included in the list
    of statistics in the /proc filesystem */
 
-#define IGNLABEL 0&(int)
+#define IGNLABEL(comment) 0
 static char *statsLabels[] = {
 	"RxOverrun",
-	IGNLABEL "RxPlcpCrcErr",
-	IGNLABEL "RxPlcpFormatErr",
-	IGNLABEL "RxPlcpLengthErr",
+	IGNLABEL("RxPlcpCrcErr"),
+	IGNLABEL("RxPlcpFormatErr"),
+	IGNLABEL("RxPlcpLengthErr"),
 	"RxMacCrcErr",
 	"RxMacCrcOk",
 	"RxWepErr",
@@ -146,15 +146,15 @@
 	"HostRxBc",
 	"HostRxUc",
 	"HostRxDiscard",
-	IGNLABEL "HmacTxMc",
-	IGNLABEL "HmacTxBc",
-	IGNLABEL "HmacTxUc",
-	IGNLABEL "HmacTxFail",
-	IGNLABEL "HmacRxMc",
-	IGNLABEL "HmacRxBc",
-	IGNLABEL "HmacRxUc",
-	IGNLABEL "HmacRxDiscard",
-	IGNLABEL "HmacRxAccepted",
+	IGNLABEL("HmacTxMc"),
+	IGNLABEL("HmacTxBc"),
+	IGNLABEL("HmacTxUc"),
+	IGNLABEL("HmacTxFail"),
+	IGNLABEL("HmacRxMc"),
+	IGNLABEL("HmacRxBc"),
+	IGNLABEL("HmacRxUc"),
+	IGNLABEL("HmacRxDiscard"),
+	IGNLABEL("HmacRxAccepted"),
 	"SsidMismatch",
 	"ApMismatch",
 	"RatesMismatch",
@@ -162,26 +162,26 @@
 	"AuthTimeout",
 	"AssocReject",
 	"AssocTimeout",
-	IGNLABEL "ReasonOutsideTable",
-	IGNLABEL "ReasonStatus1",
-	IGNLABEL "ReasonStatus2",
-	IGNLABEL "ReasonStatus3",
-	IGNLABEL "ReasonStatus4",
-	IGNLABEL "ReasonStatus5",
-	IGNLABEL "ReasonStatus6",
-	IGNLABEL "ReasonStatus7",
-	IGNLABEL "ReasonStatus8",
-	IGNLABEL "ReasonStatus9",
-	IGNLABEL "ReasonStatus10",
-	IGNLABEL "ReasonStatus11",
-	IGNLABEL "ReasonStatus12",
-	IGNLABEL "ReasonStatus13",
-	IGNLABEL "ReasonStatus14",
-	IGNLABEL "ReasonStatus15",
-	IGNLABEL "ReasonStatus16",
-	IGNLABEL "ReasonStatus17",
-	IGNLABEL "ReasonStatus18",
-	IGNLABEL "ReasonStatus19",
+	IGNLABEL("ReasonOutsideTable"),
+	IGNLABEL("ReasonStatus1"),
+	IGNLABEL("ReasonStatus2"),
+	IGNLABEL("ReasonStatus3"),
+	IGNLABEL("ReasonStatus4"),
+	IGNLABEL("ReasonStatus5"),
+	IGNLABEL("ReasonStatus6"),
+	IGNLABEL("ReasonStatus7"),
+	IGNLABEL("ReasonStatus8"),
+	IGNLABEL("ReasonStatus9"),
+	IGNLABEL("ReasonStatus10"),
+	IGNLABEL("ReasonStatus11"),
+	IGNLABEL("ReasonStatus12"),
+	IGNLABEL("ReasonStatus13"),
+	IGNLABEL("ReasonStatus14"),
+	IGNLABEL("ReasonStatus15"),
+	IGNLABEL("ReasonStatus16"),
+	IGNLABEL("ReasonStatus17"),
+	IGNLABEL("ReasonStatus18"),
+	IGNLABEL("ReasonStatus19"),
 	"RxMan",
 	"TxMan",
 	"RxRefresh",
diff -ur linux-2.5.45.orig/include/linux/mtd/compatmac.h
linux-2.5.45/include/linux/mtd/compatmac.h
--- linux-2.5.45.orig/include/linux/mtd/compatmac.h	Fri Sep 27 14:50:29
2002
+++ linux-2.5.45/include/linux/mtd/compatmac.h	Thu Oct 31 09:36:42 2002
@@ -193,6 +193,7 @@
 #define spin_lock_bh(lock) do {start_bh_atomic();spin_lock(lock);} while(0)
 #define spin_unlock_bh(lock) do {spin_unlock(lock);end_bh_atomic();}
while(0)
 #else
+#include <linux/interrupt.h>
 #include <asm/softirq.h>
 #include <linux/spinlock.h>
 #endif
diff -ur linux-2.5.45.orig/kernel/module.c linux-2.5.45/kernel/module.c
--- linux-2.5.45.orig/kernel/module.c	Thu Oct 31 09:29:07 2002
+++ linux-2.5.45/kernel/module.c	Thu Oct 31 09:36:42 2002
@@ -425,11 +425,11 @@
 		printk(KERN_ERR "init_module: mod->deps out of bounds.\n");
 		goto err2;
 	}
-	if (mod->init && !mod_bound(mod->init, 0, mod)) {
+	if (mod->init && !mod_bound((unsigned long)mod->init, 0, mod)) {
 		printk(KERN_ERR "init_module: mod->init out of bounds.\n");
 		goto err2;
 	}
-	if (mod->cleanup && !mod_bound(mod->cleanup, 0, mod)) {
+	if (mod->cleanup && !mod_bound((unsigned long)mod->cleanup, 0, mod))
{
 		printk(KERN_ERR "init_module: mod->cleanup out of
bounds.\n");
 		goto err2;
 	}
@@ -449,7 +449,7 @@
 		goto err2;
 	}
 	if (mod_member_present(mod, can_unload)
-	    && mod->can_unload && !mod_bound(mod->can_unload, 0, mod)) {
+	    && mod->can_unload && !mod_bound((unsigned long)mod->can_unload,
0, mod)) {
 		printk(KERN_ERR "init_module: mod->can_unload out of
bounds.\n");
 		goto err2;
 	}

