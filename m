Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267668AbTBRGFO>; Tue, 18 Feb 2003 01:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267675AbTBRGFN>; Tue, 18 Feb 2003 01:05:13 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:62888 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267668AbTBRGFM>; Tue, 18 Feb 2003 01:05:12 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Fix up some left-over sig->sighand issues on the v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030218061507.05B333728@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 18 Feb 2003 15:15:07 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.62-uc0.orig/arch/v850/kernel/init_task.c linux-2.5.62-uc0/arch/v850/kernel/init_task.c
--- linux-2.5.62-uc0.orig/arch/v850/kernel/init_task.c	2002-11-05 11:25:22.000000000 +0900
+++ linux-2.5.62-uc0/arch/v850/kernel/init_task.c	2003-02-18 11:41:09.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/init_task.c -- Initial task/thread structures
  *
- *  Copyright (C) 2002  NEC Corporation
- *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2002,03  NEC Electronics Corporation
+ *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -21,6 +21,7 @@
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS (init_signals);
+static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM (init_mm);
 
 /*
diff -ruN -X../cludes linux-2.5.62-uc0.orig/arch/v850/kernel/signal.c linux-2.5.62-uc0/arch/v850/kernel/signal.c
--- linux-2.5.62-uc0.orig/arch/v850/kernel/signal.c	2003-02-17 10:14:03.000000000 +0900
+++ linux-2.5.62-uc0/arch/v850/kernel/signal.c	2003-02-18 11:41:09.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/signal.c -- Signal handling
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *  Copyright (C) 1999,2000,2002  Niibe Yutaka & Kaz Kojima
  *  Copyright (C) 1991,1992  Linus Torvalds
  *
@@ -434,7 +434,7 @@
 handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
 	struct pt_regs * regs)
 {
-	struct k_sigaction *ka = &current->sig->action[sig-1];
+	struct k_sigaction *ka = &current->sighand->action[sig-1];
 
 	/* Are we from a system call? */
 	if (PT_REGS_SYSCALL (regs)) {
