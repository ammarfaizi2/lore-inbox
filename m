Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWDEDe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWDEDe5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 23:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWDEDe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 23:34:57 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37250 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751084AbWDEDe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 23:34:57 -0400
Subject: [PATCH] trivial: fix paniced->panicked typos
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 04 Apr 2006 23:34:53 -0400
Message-Id: <1144208095.8122.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a testament to the utter simplicity and logic of the English
language ;-), I found a single correct use - in kernel/panic.c - and
10-15 incorrect ones.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

diff -Nru linux-2.6.16/Documentation/kdump/gdbmacros.txt linux-2.6.16-trivial/Documentation/kdump/gdbmacros.txt
--- linux-2.6.16/Documentation/kdump/gdbmacros.txt	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.16-trivial/Documentation/kdump/gdbmacros.txt	2006-04-04 22:39:53.000000000 -0400
@@ -175,7 +175,7 @@
 document trapinfo
 	Run info threads and lookup pid of thread #1
 	'trapinfo <pid>' will tell you by which trap & possibly
-	addresthe kernel paniced.
+	address the kernel panicked.
 end
 
 
diff -Nru linux-2.6.16/arch/i386/kernel/crash.c linux-2.6.16-trivial/arch/i386/kernel/crash.c
--- linux-2.6.16/arch/i386/kernel/crash.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.16-trivial/arch/i386/kernel/crash.c	2006-04-04 22:40:05.000000000 -0400
@@ -162,7 +162,7 @@
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	/* This function is only called after the system
-	 * has paniced or is otherwise in a critical state.
+	 * has panicked or is otherwise in a critical state.
 	 * The minimum amount of code to allow a kexec'd kernel
 	 * to run successfully needs to happen here.
 	 *
diff -Nru linux-2.6.16/arch/mips/sgi-ip22/ip22-reset.c linux-2.6.16-trivial/arch/mips/sgi-ip22/ip22-reset.c
--- linux-2.6.16/arch/mips/sgi-ip22/ip22-reset.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.16-trivial/arch/mips/sgi-ip22/ip22-reset.c	2006-04-04 22:56:15.000000000 -0400
@@ -34,7 +34,7 @@
 #define POWERDOWN_TIMEOUT	120
 
 /*
- * Blink frequency during reboot grace period and when paniced.
+ * Blink frequency during reboot grace period and when panicked.
  */
 #define POWERDOWN_FREQ		(HZ / 4)
 #define PANIC_FREQ		(HZ / 8)
diff -Nru linux-2.6.16/arch/mips/sgi-ip32/ip32-reset.c linux-2.6.16-trivial/arch/mips/sgi-ip32/ip32-reset.c
--- linux-2.6.16/arch/mips/sgi-ip32/ip32-reset.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.16-trivial/arch/mips/sgi-ip32/ip32-reset.c	2006-04-04 22:40:18.000000000 -0400
@@ -28,13 +28,13 @@
 
 #define POWERDOWN_TIMEOUT	120
 /*
- * Blink frequency during reboot grace period and when paniced.
+ * Blink frequency during reboot grace period and when panicked.
  */
 #define POWERDOWN_FREQ		(HZ / 4)
 #define PANIC_FREQ		(HZ / 8)
 
 static struct timer_list power_timer, blink_timer, debounce_timer;
-static int has_paniced, shuting_down;
+static int has_panicked, shuting_down;
 
 static void ip32_machine_restart(char *command) __attribute__((noreturn));
 static void ip32_machine_halt(void) __attribute__((noreturn));
@@ -109,7 +109,7 @@
 	}
 	CMOS_WRITE(reg_a & ~DS_REGA_DV0, RTC_REG_A);
 
-	if (has_paniced)
+	if (has_panicked)
 		ip32_machine_restart(NULL);
 
 	enable_irq(MACEISA_RTC_IRQ);
@@ -117,7 +117,7 @@
 
 static inline void ip32_power_button(void)
 {
-	if (has_paniced)
+	if (has_panicked)
 		return;
 
 	if (shuting_down || kill_proc(1, SIGINT, 1)) {
@@ -161,9 +161,9 @@
 {
 	unsigned long led;
 
-	if (has_paniced)
+	if (has_panicked)
 		return NOTIFY_DONE;
-	has_paniced = 1;
+	has_panicked = 1;
 
 	/* turn off the green LED */
 	led = mace->perif.ctrl.misc | MACEISA_LED_GREEN;
diff -Nru linux-2.6.16/arch/powerpc/kernel/crash.c linux-2.6.16-trivial/arch/powerpc/kernel/crash.c
--- linux-2.6.16/arch/powerpc/kernel/crash.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.16-trivial/arch/powerpc/kernel/crash.c	2006-04-04 22:40:27.000000000 -0400
@@ -176,7 +176,7 @@
 {
 	/*
 	 * This function is only called after the system
-	 * has paniced or is otherwise in a critical state.
+	 * has panicked or is otherwise in a critical state.
 	 * The minimum amount of code to allow a kexec'd kernel
 	 * to run successfully needs to happen here.
 	 *
diff -Nru linux-2.6.16/arch/x86_64/kernel/crash.c linux-2.6.16-trivial/arch/x86_64/kernel/crash.c
--- linux-2.6.16/arch/x86_64/kernel/crash.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.16-trivial/arch/x86_64/kernel/crash.c	2006-04-04 22:40:42.000000000 -0400
@@ -161,7 +161,7 @@
 {
 	/*
 	 * This function is only called after the system
-	 * has paniced or is otherwise in a critical state.
+	 * has panicked or is otherwise in a critical state.
 	 * The minimum amount of code to allow a kexec'd kernel
 	 * to run successfully needs to happen here.
 	 *
diff -Nru linux-2.6.16/arch/x86_64/kernel/smp.c linux-2.6.16-trivial/arch/x86_64/kernel/smp.c
--- linux-2.6.16/arch/x86_64/kernel/smp.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.16-trivial/arch/x86_64/kernel/smp.c	2006-04-04 22:40:54.000000000 -0400
@@ -470,7 +470,7 @@
 		return;
 	/* Don't deadlock on the call lock in panic */
 	if (!spin_trylock(&call_lock)) {
-		/* ignore locking because we have paniced anyways */
+		/* ignore locking because we have panicked anyways */
 		nolock = 1;
 	}
 	__smp_call_function(smp_really_stop_cpu, NULL, 0, 0);
diff -Nru linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c linux-2.6.16-trivial/drivers/char/ipmi/ipmi_msghandler.c
--- linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.16-trivial/drivers/char/ipmi/ipmi_msghandler.c	2006-04-04 22:41:08.000000000 -0400
@@ -3156,7 +3156,7 @@
 }
 #endif /* CONFIG_IPMI_PANIC_EVENT */
 
-static int has_paniced = 0;
+static int has_panicked = 0;
 
 static int panic_event(struct notifier_block *this,
 		       unsigned long         event,
@@ -3165,9 +3165,9 @@
 	int        i;
 	ipmi_smi_t intf;
 
-	if (has_paniced)
+	if (has_panicked)
 		return NOTIFY_DONE;
-	has_paniced = 1;
+	has_panicked = 1;
 
 	/* For every registered interface, set it to run to completion. */
 	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {


