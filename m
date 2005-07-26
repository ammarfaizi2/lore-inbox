Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVGZRi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVGZRi4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVGZRiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:38:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21895 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261962AbVGZRgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:36:38 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/23] Don't export machine_restart, machine_halt, or
 machine_power_off.
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
	<m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:36:01 -0600
In-Reply-To: <m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 11:32:34 -0600")
Message-ID: <m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


machine_restart, machine_halt and machine_power_off are machine
specific hooks deep into the reboot logic, that modules
have no business messing with.  Usually code should be calling
kernel_restart, kernel_halt, kernel_power_off, or
emergency_restart. So don't export machine_restart,
machine_halt, and machine_power_off so we can catch buggy users.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/alpha/kernel/process.c            |    3 ---
 arch/arm/kernel/process.c              |    4 ----
 arch/arm26/kernel/process.c            |    5 -----
 arch/cris/kernel/process.c             |    6 ------
 arch/h8300/kernel/process.c            |    6 ------
 arch/i386/kernel/reboot.c              |    5 -----
 arch/i386/mach-visws/reboot.c          |    5 -----
 arch/i386/mach-voyager/voyager_basic.c |    5 -----
 arch/ia64/kernel/process.c             |    5 -----
 arch/m32r/kernel/process.c             |    6 ------
 arch/m68k/kernel/process.c             |    6 ------
 arch/m68knommu/kernel/process.c        |    6 ------
 arch/mips/kernel/reset.c               |    5 -----
 arch/parisc/kernel/process.c           |    6 ------
 arch/ppc/kernel/setup.c                |    6 ------
 arch/ppc64/kernel/setup.c              |    3 ---
 arch/s390/kernel/setup.c               |    6 ------
 arch/sh/kernel/process.c               |    6 ------
 arch/sparc/kernel/process.c            |    6 ------
 arch/sparc64/kernel/power.c            |    2 --
 arch/sparc64/kernel/process.c          |    4 ----
 arch/um/kernel/reboot.c                |    6 ------
 arch/v850/kernel/anna.c                |    6 ------
 arch/v850/kernel/as85ep1.c             |    6 ------
 arch/v850/kernel/fpga85e2c.c           |    6 ------
 arch/v850/kernel/rte_cb.c              |    6 ------
 arch/v850/kernel/sim.c                 |    6 ------
 arch/v850/kernel/sim85e2.c             |    5 -----
 arch/x86_64/kernel/reboot.c            |    5 -----
 29 files changed, 0 insertions(+), 152 deletions(-)

ddf8bd62b8e8ce33ff2b55fd047106bd38eed486
diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -165,7 +165,6 @@ machine_restart(char *restart_cmd)
 	common_shutdown(LINUX_REBOOT_CMD_RESTART, restart_cmd);
 }
 
-EXPORT_SYMBOL(machine_restart);
 
 void
 machine_halt(void)
@@ -173,7 +172,6 @@ machine_halt(void)
 	common_shutdown(LINUX_REBOOT_CMD_HALT, NULL);
 }
 
-EXPORT_SYMBOL(machine_halt);
 
 void
 machine_power_off(void)
@@ -181,7 +179,6 @@ machine_power_off(void)
 	common_shutdown(LINUX_REBOOT_CMD_POWER_OFF, NULL);
 }
 
-EXPORT_SYMBOL(machine_power_off);
 
 /* Used by sysrq-p, among others.  I don't believe r9-r15 are ever
    saved in the context it's used.  */
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -131,7 +131,6 @@ void machine_halt(void)
 {
 }
 
-EXPORT_SYMBOL(machine_halt);
 
 void machine_power_off(void)
 {
@@ -139,7 +138,6 @@ void machine_power_off(void)
 		pm_power_off();
 }
 
-EXPORT_SYMBOL(machine_power_off);
 
 void machine_restart(char * __unused)
 {
@@ -169,8 +167,6 @@ void machine_restart(char * __unused)
 	while (1);
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void __show_regs(struct pt_regs *regs)
 {
 	unsigned long flags = condition_codes(regs);
diff --git a/arch/arm26/kernel/process.c b/arch/arm26/kernel/process.c
--- a/arch/arm26/kernel/process.c
+++ b/arch/arm26/kernel/process.c
@@ -103,9 +103,6 @@ void machine_power_off(void)
 {
 }
 
-EXPORT_SYMBOL(machine_halt);
-EXPORT_SYMBOL(machine_power_off);
-
 void machine_restart(char * __unused)
 {
 	/*
@@ -136,8 +133,6 @@ void machine_restart(char * __unused)
 	while (1);
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void show_regs(struct pt_regs * regs)
 {
 	unsigned long flags;
diff --git a/arch/cris/kernel/process.c b/arch/cris/kernel/process.c
--- a/arch/cris/kernel/process.c
+++ b/arch/cris/kernel/process.c
@@ -214,8 +214,6 @@ void machine_restart(char *cmd)
 	hard_reset_now();
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 /*
  * Similar to machine_power_off, but don't shut off power.  Add code
  * here to freeze the system for e.g. post-mortem debug purpose when
@@ -226,16 +224,12 @@ void machine_halt(void)
 {
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 /* If or when software power-off is implemented, add code here.  */
 
 void machine_power_off(void)
 {
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 /*
  * When a process does an "exec", machine state like FPU and debug
  * registers need to be reset.  This is a hook function for that.
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -90,8 +90,6 @@ void machine_restart(char * __unused)
 	__asm__("jmp @@0"); 
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_halt(void)
 {
 	local_irq_disable();
@@ -99,8 +97,6 @@ void machine_halt(void)
 	for (;;);
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_power_off(void)
 {
 	local_irq_disable();
@@ -108,8 +104,6 @@ void machine_power_off(void)
 	for (;;);
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 void show_regs(struct pt_regs * regs)
 {
 	printk("\nPC: %08lx  Status: %02x",
diff --git a/arch/i386/kernel/reboot.c b/arch/i386/kernel/reboot.c
--- a/arch/i386/kernel/reboot.c
+++ b/arch/i386/kernel/reboot.c
@@ -337,14 +337,10 @@ void machine_restart(char * __unused)
 	machine_real_restart(jump_to_bios, sizeof(jump_to_bios));
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_halt(void)
 {
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_power_off(void)
 {
 	lapic_shutdown();
@@ -355,5 +351,4 @@ void machine_power_off(void)
 		pm_power_off();
 }
 
-EXPORT_SYMBOL(machine_power_off);
 
diff --git a/arch/i386/mach-visws/reboot.c b/arch/i386/mach-visws/reboot.c
--- a/arch/i386/mach-visws/reboot.c
+++ b/arch/i386/mach-visws/reboot.c
@@ -22,8 +22,6 @@ void machine_restart(char * __unused)
 	outb(PIIX4_RESET_VAL, PIIX4_RESET_PORT);
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_power_off(void)
 {
 	unsigned short pm_status;
@@ -43,10 +41,7 @@ void machine_power_off(void)
 	outl(PIIX_SPECIAL_STOP, 0xCFC);
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 void machine_halt(void)
 {
 }
 
-EXPORT_SYMBOL(machine_halt);
diff --git a/arch/i386/mach-voyager/voyager_basic.c b/arch/i386/mach-voyager/voyager_basic.c
--- a/arch/i386/mach-voyager/voyager_basic.c
+++ b/arch/i386/mach-voyager/voyager_basic.c
@@ -278,8 +278,6 @@ machine_restart(char *cmd)
 	}
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void
 mca_nmi_hook(void)
 {
@@ -315,12 +313,9 @@ machine_halt(void)
 	machine_power_off();
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
 }
 
-EXPORT_SYMBOL(machine_power_off);
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -807,16 +807,12 @@ machine_restart (char *restart_cmd)
 	(*efi.reset_system)(EFI_RESET_WARM, 0, 0, NULL);
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void
 machine_halt (void)
 {
 	cpu_halt();
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void
 machine_power_off (void)
 {
@@ -825,4 +821,3 @@ machine_power_off (void)
 	machine_halt();
 }
 
-EXPORT_SYMBOL(machine_power_off);
diff --git a/arch/m32r/kernel/process.c b/arch/m32r/kernel/process.c
--- a/arch/m32r/kernel/process.c
+++ b/arch/m32r/kernel/process.c
@@ -115,8 +115,6 @@ void machine_restart(char *__unused)
 		cpu_relax();
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_halt(void)
 {
 	printk("Please push reset button!\n");
@@ -124,15 +122,11 @@ void machine_halt(void)
 		cpu_relax();
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_power_off(void)
 {
 	/* M32R_FIXME */
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 static int __init idle_setup (char *str)
 {
 	if (!strncmp(str, "poll", 4)) {
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -113,8 +113,6 @@ void machine_restart(char * __unused)
 	for (;;);
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_halt(void)
 {
 	if (mach_halt)
@@ -122,8 +120,6 @@ void machine_halt(void)
 	for (;;);
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_power_off(void)
 {
 	if (mach_power_off)
@@ -131,8 +127,6 @@ void machine_power_off(void)
 	for (;;);
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 void show_regs(struct pt_regs * regs)
 {
 	printk("\n");
diff --git a/arch/m68knommu/kernel/process.c b/arch/m68knommu/kernel/process.c
--- a/arch/m68knommu/kernel/process.c
+++ b/arch/m68knommu/kernel/process.c
@@ -80,8 +80,6 @@ void machine_restart(char * __unused)
 	for (;;);
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_halt(void)
 {
 	if (mach_halt)
@@ -89,8 +87,6 @@ void machine_halt(void)
 	for (;;);
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_power_off(void)
 {
 	if (mach_power_off)
@@ -98,8 +94,6 @@ void machine_power_off(void)
 	for (;;);
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 void show_regs(struct pt_regs * regs)
 {
 	printk(KERN_NOTICE "\n");
diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -26,18 +26,13 @@ void machine_restart(char *command)
 	_machine_restart(command);
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_halt(void)
 {
 	_machine_halt();
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_power_off(void)
 {
 	_machine_power_off();
 }
 
-EXPORT_SYMBOL(machine_power_off);
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -150,8 +150,6 @@ void machine_restart(char *cmd)
 
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_halt(void)
 {
 	/*
@@ -160,8 +158,6 @@ void machine_halt(void)
 	*/
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 
 /*
  * This routine is called from sys_reboot to actually turn off the
@@ -187,8 +183,6 @@ void machine_power_off(void)
 	       KERN_EMERG "Please power this system off now.");
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 
 /*
  * Create a kernel thread
diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -121,8 +121,6 @@ void machine_restart(char *cmd)
 	ppc_md.restart(cmd);
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_power_off(void)
 {
 #ifdef CONFIG_NVRAM
@@ -131,8 +129,6 @@ void machine_power_off(void)
 	ppc_md.power_off();
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 void machine_halt(void)
 {
 #ifdef CONFIG_NVRAM
@@ -141,8 +137,6 @@ void machine_halt(void)
 	ppc_md.halt();
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void (*pm_power_off)(void) = machine_power_off;
 
 #ifdef CONFIG_TAU
diff --git a/arch/ppc64/kernel/setup.c b/arch/ppc64/kernel/setup.c
--- a/arch/ppc64/kernel/setup.c
+++ b/arch/ppc64/kernel/setup.c
@@ -694,7 +694,6 @@ void machine_restart(char *cmd)
 	local_irq_disable();
 	while (1) ;
 }
-EXPORT_SYMBOL(machine_restart);
 
 void machine_power_off(void)
 {
@@ -707,7 +706,6 @@ void machine_power_off(void)
 	local_irq_disable();
 	while (1) ;
 }
-EXPORT_SYMBOL(machine_power_off);
 
 void machine_halt(void)
 {
@@ -720,7 +718,6 @@ void machine_halt(void)
 	local_irq_disable();
 	while (1) ;
 }
-EXPORT_SYMBOL(machine_halt);
 
 static int ppc64_panic_event(struct notifier_block *this,
                              unsigned long event, void *ptr)
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -299,24 +299,18 @@ void machine_restart(char *command)
 	_machine_restart(command);
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_halt(void)
 {
 	console_unblank();
 	_machine_halt();
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_power_off(void)
 {
 	console_unblank();
 	_machine_power_off();
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 static void __init
 add_memory_hole(unsigned long start, unsigned long end)
 {
diff --git a/arch/sh/kernel/process.c b/arch/sh/kernel/process.c
--- a/arch/sh/kernel/process.c
+++ b/arch/sh/kernel/process.c
@@ -80,8 +80,6 @@ void machine_restart(char * __unused)
 		     "mov.l @%1, %0" : : "r" (0x10000000), "r" (0x80000001));
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_halt(void)
 {
 #if defined(CONFIG_SH_HS7751RVOIP)
@@ -96,8 +94,6 @@ void machine_halt(void)
 		cpu_sleep();
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_power_off(void)
 {
 #if defined(CONFIG_SH_HS7751RVOIP)
@@ -110,8 +106,6 @@ void machine_power_off(void)
 #endif
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 void show_regs(struct pt_regs * regs)
 {
 	printk("\n");
diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
--- a/arch/sparc/kernel/process.c
+++ b/arch/sparc/kernel/process.c
@@ -158,8 +158,6 @@ void machine_halt(void)
 	panic("Halt failed!");
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_restart(char * cmd)
 {
 	char *p;
@@ -180,8 +178,6 @@ void machine_restart(char * cmd)
 	panic("Reboot failed!");
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_power_off(void)
 {
 #ifdef CONFIG_SUN_AUXIO
@@ -191,8 +187,6 @@ void machine_power_off(void)
 	machine_halt();
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 static DEFINE_SPINLOCK(sparc_backtrace_lock);
 
 void __show_backtrace(unsigned long fp)
diff --git a/arch/sparc64/kernel/power.c b/arch/sparc64/kernel/power.c
--- a/arch/sparc64/kernel/power.c
+++ b/arch/sparc64/kernel/power.c
@@ -69,8 +69,6 @@ void machine_power_off(void)
 	machine_halt();
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 #ifdef CONFIG_PCI
 static int powerd(void *__unused)
 {
diff --git a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
--- a/arch/sparc64/kernel/process.c
+++ b/arch/sparc64/kernel/process.c
@@ -124,8 +124,6 @@ void machine_halt(void)
 	panic("Halt failed!");
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_alt_power_off(void)
 {
 	if (!serial_console && prom_palette)
@@ -154,8 +152,6 @@ void machine_restart(char * cmd)
 	panic("Reboot failed!");
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 static void show_regwindow32(struct pt_regs *regs)
 {
 	struct reg_window32 __user *rw;
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -49,23 +49,17 @@ void machine_restart(char * __unused)
 	CHOOSE_MODE(reboot_tt(), reboot_skas());
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_power_off(void)
 {
         uml_cleanup();
 	CHOOSE_MODE(halt_tt(), halt_skas());
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 void machine_halt(void)
 {
 	machine_power_off();
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff --git a/arch/v850/kernel/anna.c b/arch/v850/kernel/anna.c
--- a/arch/v850/kernel/anna.c
+++ b/arch/v850/kernel/anna.c
@@ -132,8 +132,6 @@ void machine_restart (char *__unused)
 	asm ("jmp r0"); /* Jump to the reset vector.  */
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_halt (void)
 {
 #ifdef CONFIG_RESET_GUARD
@@ -145,15 +143,11 @@ void machine_halt (void)
 		asm ("halt; nop; nop; nop; nop; nop");
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_power_off (void)
 {
 	machine_halt ();
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 /* Called before configuring an on-chip UART.  */
 void anna_uart_pre_configure (unsigned chan, unsigned cflags, unsigned baud)
 {
diff --git a/arch/v850/kernel/as85ep1.c b/arch/v850/kernel/as85ep1.c
--- a/arch/v850/kernel/as85ep1.c
+++ b/arch/v850/kernel/as85ep1.c
@@ -160,8 +160,6 @@ void machine_restart (char *__unused)
 	asm ("jmp r0"); /* Jump to the reset vector.  */
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_halt (void)
 {
 #ifdef CONFIG_RESET_GUARD
@@ -173,15 +171,11 @@ void machine_halt (void)
 		asm ("halt; nop; nop; nop; nop; nop");
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_power_off (void)
 {
 	machine_halt ();
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 /* Called before configuring an on-chip UART.  */
 void as85ep1_uart_pre_configure (unsigned chan, unsigned cflags, unsigned baud)
 {
diff --git a/arch/v850/kernel/fpga85e2c.c b/arch/v850/kernel/fpga85e2c.c
--- a/arch/v850/kernel/fpga85e2c.c
+++ b/arch/v850/kernel/fpga85e2c.c
@@ -121,22 +121,16 @@ void machine_halt (void)
 	}
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_restart (char *__unused)
 {
 	machine_halt ();
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_power_off (void)
 {
 	machine_halt ();
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 
 /* Interrupts */
 
diff --git a/arch/v850/kernel/rte_cb.c b/arch/v850/kernel/rte_cb.c
--- a/arch/v850/kernel/rte_cb.c
+++ b/arch/v850/kernel/rte_cb.c
@@ -67,8 +67,6 @@ void machine_restart (char *__unused)
 	asm ("jmp r0"); /* Jump to the reset vector.  */
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 /* This says `HALt.' in LEDese.  */
 static unsigned char halt_leds_msg[] = { 0x76, 0x77, 0x38, 0xF8 };
 
@@ -89,15 +87,11 @@ void machine_halt (void)
 		asm ("halt; nop; nop; nop; nop; nop");
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_power_off (void)
 {
 	machine_halt ();
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 
 /* Animated LED display for timer tick.  */
 
diff --git a/arch/v850/kernel/sim.c b/arch/v850/kernel/sim.c
--- a/arch/v850/kernel/sim.c
+++ b/arch/v850/kernel/sim.c
@@ -104,24 +104,18 @@ void machine_restart (char *__unused)
 	V850_SIM_SYSCALL (exit, 0);
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_halt (void)
 {
 	V850_SIM_SYSCALL (write, 1, "HALT\n", 5);
 	V850_SIM_SYSCALL (exit, 0);
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_power_off (void)
 {
 	V850_SIM_SYSCALL (write, 1, "POWER OFF\n", 10);
 	V850_SIM_SYSCALL (exit, 0);
 }
 
-EXPORT_SYMBOL(machine_power_off);
-
 
 /* Load data from a file called NAME into ram.  The address and length
    of the data image are returned in ADDR and LEN.  */
diff --git a/arch/v850/kernel/sim85e2.c b/arch/v850/kernel/sim85e2.c
--- a/arch/v850/kernel/sim85e2.c
+++ b/arch/v850/kernel/sim85e2.c
@@ -184,18 +184,13 @@ void machine_halt (void)
 	for (;;) {}
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_restart (char *__unused)
 {
 	machine_halt ();
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_power_off (void)
 {
 	machine_halt ();
 }
 
-EXPORT_SYMBOL(machine_power_off);
diff --git a/arch/x86_64/kernel/reboot.c b/arch/x86_64/kernel/reboot.c
--- a/arch/x86_64/kernel/reboot.c
+++ b/arch/x86_64/kernel/reboot.c
@@ -150,18 +150,13 @@ void machine_restart(char * __unused)
 	}      
 }
 
-EXPORT_SYMBOL(machine_restart);
-
 void machine_halt(void)
 {
 }
 
-EXPORT_SYMBOL(machine_halt);
-
 void machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
 }
 
-EXPORT_SYMBOL(machine_power_off);
