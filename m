Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274011AbRISGXp>; Wed, 19 Sep 2001 02:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274009AbRISGXf>; Wed, 19 Sep 2001 02:23:35 -0400
Received: from rj.sgi.com ([204.94.215.100]:4331 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S274010AbRISGXY>;
	Wed, 19 Sep 2001 02:23:24 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] 2.4.10-pre12 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 19 Sep 2001 16:22:39 +1000
Message-ID: <20464.1000880559@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysrq.c has incorrect definition of wakeup_bdflush().  nmi.c is missing
definition of show_registers().

Index: 10-pre12.1/drivers/char/sysrq.c
--- 10-pre12.1/drivers/char/sysrq.c Wed, 19 Sep 2001 14:59:20 +1000 kaos (linux-2.4/a/c/50_sysrq.c 1.2.2.2 644)
+++ 10-pre12.1(w)/drivers/char/sysrq.c Wed, 19 Sep 2001 16:09:28 +1000 kaos (linux-2.4/a/c/50_sysrq.c 1.2.2.2 644)
@@ -32,7 +32,6 @@
 
 #include <asm/ptrace.h>
 
-extern void wakeup_bdflush(int);
 extern void reset_vc(unsigned int);
 extern struct list_head super_blocks;
 
@@ -221,7 +220,7 @@ void do_emergency_sync(void) {
 static void sysrq_handle_sync(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	emergency_sync_scheduled = EMERG_SYNC;
-	wakeup_bdflush(0);
+	wakeup_bdflush();
 }
 static struct sysrq_key_op sysrq_sync_op = {
 	handler:	sysrq_handle_sync,
@@ -232,7 +231,7 @@ static struct sysrq_key_op sysrq_sync_op
 static void sysrq_handle_mountro(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	emergency_sync_scheduled = EMERG_REMOUNT;
-	wakeup_bdflush(0);
+	wakeup_bdflush();
 }
 static struct sysrq_key_op sysrq_mountro_op = {
 	handler:	sysrq_handle_mountro,
Index: 10-pre12.1/arch/i386/kernel/nmi.c
--- 10-pre12.1/arch/i386/kernel/nmi.c Wed, 19 Sep 2001 14:59:20 +1000 kaos (linux-2.4/o/f/18_nmi.c 1.1 644)
+++ 10-pre12.1(w)/arch/i386/kernel/nmi.c Wed, 19 Sep 2001 16:08:33 +1000 kaos (linux-2.4/o/f/18_nmi.c 1.1 644)
@@ -27,6 +27,7 @@
 unsigned int nmi_watchdog = NMI_NONE;
 static unsigned int nmi_hz = HZ;
 unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
+extern void show_registers(struct pt_regs *regs);
 
 #define K7_EVNTSEL_ENABLE	(1 << 22)
 #define K7_EVNTSEL_INT		(1 << 20)

