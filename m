Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUBWFN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 00:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbUBWFN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 00:13:58 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:60665 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261802AbUBWFNk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 00:13:40 -0500
Message-ID: <40398BFE.1040300@austin.ibm.com>
Date: Sun, 22 Feb 2004 23:13:34 -0600
From: Mike Strosaker <strosake@austin.ibm.com>
Reply-To: strosake@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] arch-specific callout in panic()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, All:

There are some ppc64-specific actions that should be taken upon a
kernel panic.  Rather than adding a new #ifdef in panic(), it seems to
me that it would be worthwhile to add a single callout, and move the
arch-specific code out to the arch subtrees.  Does this seem reasonable,
or should another #ifdef be added in panic() to perform the ppc64-
specific actions?

Please cc me on any replies.

Thanks,
Mike

diff -Nru a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
--- a/arch/alpha/kernel/process.c	Sun Feb 22 22:31:11 2004
+++ b/arch/alpha/kernel/process.c	Sun Feb 22 22:31:11 2004
@@ -183,6 +183,13 @@

  EXPORT_SYMBOL(machine_power_off);

+void
+machine_panic(void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  /* Used by sysrq-p, among others.  I don't believe r9-r15 are ever
     saved in the context it's used.  */

diff -Nru a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
--- a/arch/arm/kernel/process.c	Sun Feb 22 22:31:11 2004
+++ b/arch/arm/kernel/process.c	Sun Feb 22 22:31:11 2004
@@ -163,6 +163,12 @@

  EXPORT_SYMBOL(machine_restart);

+void machine_panic(void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  void show_regs(struct pt_regs * regs)
  {
  	unsigned long flags;
diff -Nru a/arch/arm26/kernel/process.c b/arch/arm26/kernel/process.c
--- a/arch/arm26/kernel/process.c	Sun Feb 22 22:31:11 2004
+++ b/arch/arm26/kernel/process.c	Sun Feb 22 22:31:11 2004
@@ -163,6 +163,12 @@

  EXPORT_SYMBOL(machine_restart);

+void machine_panic(void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  void show_regs(struct pt_regs * regs)
  {
  	unsigned long flags;
diff -Nru a/arch/cris/kernel/process.c b/arch/cris/kernel/process.c
--- a/arch/cris/kernel/process.c	Sun Feb 22 22:31:11 2004
+++ b/arch/cris/kernel/process.c	Sun Feb 22 22:31:11 2004
@@ -222,6 +222,12 @@

  EXPORT_SYMBOL(machine_power_off);

+void machine_panic(void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  /*
   * When a process does an "exec", machine state like FPU and debug
   * registers need to be reset.  This is a hook function for that.
diff -Nru a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
--- a/arch/h8300/kernel/process.c	Sun Feb 22 22:31:11 2004
+++ b/arch/h8300/kernel/process.c	Sun Feb 22 22:31:11 2004
@@ -110,6 +110,12 @@

  EXPORT_SYMBOL(machine_power_off);

+void machine_panic(void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  void show_regs(struct pt_regs * regs)
  {
  	printk("\n");
diff -Nru a/arch/i386/kernel/reboot.c b/arch/i386/kernel/reboot.c
--- a/arch/i386/kernel/reboot.c	Sun Feb 22 22:31:11 2004
+++ b/arch/i386/kernel/reboot.c	Sun Feb 22 22:31:11 2004
@@ -303,3 +303,10 @@

  EXPORT_SYMBOL(machine_power_off);

+void machine_panic(void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
+
diff -Nru a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
--- a/arch/ia64/kernel/process.c	Sun Feb 22 22:31:11 2004
+++ b/arch/ia64/kernel/process.c	Sun Feb 22 22:31:11 2004
@@ -713,3 +713,10 @@
  }

  EXPORT_SYMBOL(machine_power_off);
+
+void
+machine_panic (void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
diff -Nru a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
--- a/arch/m68k/kernel/process.c	Sun Feb 22 22:31:11 2004
+++ b/arch/m68k/kernel/process.c	Sun Feb 22 22:31:11 2004
@@ -135,6 +135,12 @@

  EXPORT_SYMBOL(machine_power_off);

+void machine_panic(void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  void show_regs(struct pt_regs * regs)
  {
  	printk("\n");
diff -Nru a/arch/m68knommu/kernel/process.c b/arch/m68knommu/kernel/process.c
--- a/arch/m68knommu/kernel/process.c	Sun Feb 22 22:31:11 2004
+++ b/arch/m68knommu/kernel/process.c	Sun Feb 22 22:31:11 2004
@@ -93,6 +93,12 @@

  EXPORT_SYMBOL(machine_power_off);

+void machine_panic(void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  void show_regs(struct pt_regs * regs)
  {
  	printk("\n");
diff -Nru a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
--- a/arch/mips/kernel/reset.c	Sun Feb 22 22:31:11 2004
+++ b/arch/mips/kernel/reset.c	Sun Feb 22 22:31:11 2004
@@ -41,3 +41,9 @@
  }

  EXPORT_SYMBOL(machine_power_off);
+
+void machine_panic(void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
diff -Nru a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
--- a/arch/parisc/kernel/process.c	Sun Feb 22 22:31:11 2004
+++ b/arch/parisc/kernel/process.c	Sun Feb 22 22:31:11 2004
@@ -161,6 +161,12 @@

  EXPORT_SYMBOL(machine_halt);

+void machine_panic(void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+

  /*
   * This routine is called from sys_reboot to actually turn off the
diff -Nru a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c	Sun Feb 22 22:31:11 2004
+++ b/arch/ppc/kernel/setup.c	Sun Feb 22 22:31:11 2004
@@ -140,6 +140,12 @@

  EXPORT_SYMBOL(machine_halt);

+void machine_panic(void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  void (*pm_power_off)(void) = machine_power_off;

  #ifdef CONFIG_TAU
diff -Nru a/arch/ppc64/kernel/chrp_setup.c b/arch/ppc64/kernel/chrp_setup.c
--- a/arch/ppc64/kernel/chrp_setup.c	Sun Feb 22 22:31:11 2004
+++ b/arch/ppc64/kernel/chrp_setup.c	Sun Feb 22 22:31:11 2004
@@ -271,6 +271,7 @@
  	ppc_md.restart        = rtas_restart;
  	ppc_md.power_off      = rtas_power_off;
  	ppc_md.halt           = rtas_halt;
+	ppc_md.panic          = rtas_os_term;

  	ppc_md.get_boot_time  = pSeries_get_boot_time;
  	ppc_md.get_rtc_time   = pSeries_get_rtc_time;
diff -Nru a/arch/ppc64/kernel/iSeries_setup.c b/arch/ppc64/kernel/iSeries_setup.c
--- a/arch/ppc64/kernel/iSeries_setup.c	Sun Feb 22 22:31:11 2004
+++ b/arch/ppc64/kernel/iSeries_setup.c	Sun Feb 22 22:31:11 2004
@@ -324,6 +324,7 @@
  	ppc_md.restart = iSeries_restart;
  	ppc_md.power_off = iSeries_power_off;
  	ppc_md.halt = iSeries_halt;
+	ppc_md.panic = iSeries_panic;

  	ppc_md.get_boot_time = iSeries_get_boot_time;
  	ppc_md.set_rtc_time = iSeries_set_rtc_time;
@@ -791,6 +792,13 @@
  void iSeries_halt(void)
  {
  	mf_powerOff();
+}
+
+/*
+ * Document and implement me.
+ */
+void iSeries_panic(void)
+{
  }

  /* JDH Hack */
diff -Nru a/arch/ppc64/kernel/rtas.c b/arch/ppc64/kernel/rtas.c
--- a/arch/ppc64/kernel/rtas.c	Sun Feb 22 22:31:11 2004
+++ b/arch/ppc64/kernel/rtas.c	Sun Feb 22 22:31:11 2004
@@ -386,6 +386,17 @@
          rtas_power_off();
  }

+void
+rtas_os_term(void)
+{
+	long status;
+	char *str = "OS panic";
+
+	status = rtas_call(rtas_token("ibm,os-term"), 1, 1, NULL, __pa(str));
+	if (status != 0)
+		printk(KERN_EMERG "ibm,os-term call failed %d\n", status);
+}
+
  unsigned long rtas_rmo_buf = 0;

  asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
diff -Nru a/arch/ppc64/kernel/setup.c b/arch/ppc64/kernel/setup.c
--- a/arch/ppc64/kernel/setup.c	Sun Feb 22 22:31:11 2004
+++ b/arch/ppc64/kernel/setup.c	Sun Feb 22 22:31:11 2004
@@ -315,6 +315,13 @@

  EXPORT_SYMBOL(machine_halt);

+void machine_panic(void)
+{
+	ppc_md.panic();
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  unsigned long ppc_proc_freq;
  unsigned long ppc_tb_freq;

@@ -611,8 +618,10 @@
  	dcache_bsize = systemcfg->dCacheL1LineSize;
  	icache_bsize = systemcfg->iCacheL1LineSize;

-	/* reboot on panic */
+	/* reboot on panic
  	panic_timeout = 180;
+	*/
+	panic_timeout = 0;

  	init_mm.start_code = PAGE_OFFSET;
  	init_mm.end_code = (unsigned long) _etext;
diff -Nru a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
--- a/arch/s390/kernel/setup.c	Sun Feb 22 22:31:11 2004
+++ b/arch/s390/kernel/setup.c	Sun Feb 22 22:31:11 2004
@@ -53,6 +53,7 @@
  unsigned int console_irq = -1;
  unsigned long memory_size = 0;
  unsigned long machine_flags = 0;
+unsigned long panic_caller = 0;
  struct { unsigned long addr, size, type; } memory_chunk[16] = { { 0 } };
  #define CHUNK_READ_WRITE 0
  #define CHUNK_READ_ONLY 1
@@ -310,6 +311,13 @@
  }

  EXPORT_SYMBOL(machine_power_off);
+
+void machine_panic(void)
+{
+	disabled_wait(panic_caller);
+}
+
+EXPORT_SYMBOL(machine_panic);

  /*
   * Setup function called from init/main.c just after the banner
diff -Nru a/arch/sh/kernel/process.c b/arch/sh/kernel/process.c
--- a/arch/sh/kernel/process.c	Sun Feb 22 22:31:11 2004
+++ b/arch/sh/kernel/process.c	Sun Feb 22 22:31:11 2004
@@ -85,6 +85,12 @@

  EXPORT_SYMBOL(machine_power_off);

+void machine_panic(void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  void show_regs(struct pt_regs * regs)
  {
  	printk("\n");
diff -Nru a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
--- a/arch/sparc/kernel/process.c	Sun Feb 22 22:31:11 2004
+++ b/arch/sparc/kernel/process.c	Sun Feb 22 22:31:11 2004
@@ -195,6 +195,16 @@

  EXPORT_SYMBOL(machine_power_off);

+void machine_panic(void)
+{
+	extern int stop_a_enabled;
+	/* Make sure the user can actually press L1-A */
+	stop_a_enabled = 1;
+	printk(KERN_EMERG "Press L1-A to return to the boot prom\n");
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  static spinlock_t sparc_backtrace_lock = SPIN_LOCK_UNLOCKED;

  void __show_backtrace(unsigned long fp)
diff -Nru a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
--- a/arch/sparc64/kernel/process.c	Sun Feb 22 22:31:11 2004
+++ b/arch/sparc64/kernel/process.c	Sun Feb 22 22:31:11 2004
@@ -158,6 +158,16 @@

  EXPORT_SYMBOL(machine_restart);

+void machine_panic(void)
+{
+	extern int stop_a_enabled;
+	/* Make sure the user can actually press L1-A */
+	stop_a_enabled = 1;
+	printk(KERN_EMERG "Press L1-A to return to the boot prom\n");
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  static void show_regwindow32(struct pt_regs *regs)
  {
  	struct reg_window32 *rw;
diff -Nru a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
--- a/arch/um/kernel/reboot.c	Sun Feb 22 22:31:11 2004
+++ b/arch/um/kernel/reboot.c	Sun Feb 22 22:31:11 2004
@@ -65,6 +65,12 @@

  EXPORT_SYMBOL(machine_halt);

+void machine_panic(void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  /*
   * Overrides for Emacs so that we follow Linus's tabbing style.
   * Emacs will notice this stuff at the end of the file and automatically
diff -Nru a/arch/v850/kernel/anna.c b/arch/v850/kernel/anna.c
--- a/arch/v850/kernel/anna.c	Sun Feb 22 22:31:11 2004
+++ b/arch/v850/kernel/anna.c	Sun Feb 22 22:31:11 2004
@@ -154,6 +154,12 @@

  EXPORT_SYMBOL(machine_power_off);

+void machine_panic (void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  /* Called before configuring an on-chip UART.  */
  void anna_uart_pre_configure (unsigned chan, unsigned cflags, unsigned baud)
  {
diff -Nru a/arch/v850/kernel/as85ep1.c b/arch/v850/kernel/as85ep1.c
--- a/arch/v850/kernel/as85ep1.c	Sun Feb 22 22:31:11 2004
+++ b/arch/v850/kernel/as85ep1.c	Sun Feb 22 22:31:11 2004
@@ -182,6 +182,12 @@

  EXPORT_SYMBOL(machine_power_off);

+void machine_panic (void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  /* Called before configuring an on-chip UART.  */
  void as85ep1_uart_pre_configure (unsigned chan, unsigned cflags, unsigned baud)
  {
diff -Nru a/arch/v850/kernel/fpga85e2c.c b/arch/v850/kernel/fpga85e2c.c
--- a/arch/v850/kernel/fpga85e2c.c	Sun Feb 22 22:31:11 2004
+++ b/arch/v850/kernel/fpga85e2c.c	Sun Feb 22 22:31:11 2004
@@ -138,6 +138,12 @@

  EXPORT_SYMBOL(machine_power_off);

+void machine_panic (void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  
  /* Interrupts */

diff -Nru a/arch/v850/kernel/rte_cb.c b/arch/v850/kernel/rte_cb.c
--- a/arch/v850/kernel/rte_cb.c	Sun Feb 22 22:31:11 2004
+++ b/arch/v850/kernel/rte_cb.c	Sun Feb 22 22:31:11 2004
@@ -98,6 +98,12 @@

  EXPORT_SYMBOL(machine_power_off);

+void machine_panic (void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  
  /* Animated LED display for timer tick.  */

diff -Nru a/arch/v850/kernel/sim.c b/arch/v850/kernel/sim.c
--- a/arch/v850/kernel/sim.c	Sun Feb 22 22:31:11 2004
+++ b/arch/v850/kernel/sim.c	Sun Feb 22 22:31:11 2004
@@ -122,6 +122,12 @@

  EXPORT_SYMBOL(machine_power_off);

+void machine_panic (void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
+
  
  /* Load data from a file called NAME into ram.  The address and length
     of the data image are returned in ADDR and LEN.  */
diff -Nru a/arch/v850/kernel/sim85e2.c b/arch/v850/kernel/sim85e2.c
--- a/arch/v850/kernel/sim85e2.c	Sun Feb 22 22:31:11 2004
+++ b/arch/v850/kernel/sim85e2.c	Sun Feb 22 22:31:11 2004
@@ -201,3 +201,9 @@
  }

  EXPORT_SYMBOL(machine_power_off);
+
+void machine_panic (void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
diff -Nru a/arch/x86_64/kernel/reboot.c b/arch/x86_64/kernel/reboot.c
--- a/arch/x86_64/kernel/reboot.c	Sun Feb 22 22:31:11 2004
+++ b/arch/x86_64/kernel/reboot.c	Sun Feb 22 22:31:11 2004
@@ -185,3 +185,9 @@
  }

  EXPORT_SYMBOL(machine_power_off);
+
+void machine_panic(void)
+{
+}
+
+EXPORT_SYMBOL(machine_panic);
diff -Nru a/include/asm-ppc64/machdep.h b/include/asm-ppc64/machdep.h
--- a/include/asm-ppc64/machdep.h	Sun Feb 22 22:31:11 2004
+++ b/include/asm-ppc64/machdep.h	Sun Feb 22 22:31:11 2004
@@ -78,6 +78,7 @@
  	void		(*restart)(char *cmd);
  	void		(*power_off)(void);
  	void		(*halt)(void);
+	void		(*panic)(void);

  	int		(*set_rtc_time)(struct rtc_time *);
  	void		(*get_rtc_time)(struct rtc_time *);
diff -Nru a/include/asm-ppc64/rtas.h b/include/asm-ppc64/rtas.h
--- a/include/asm-ppc64/rtas.h	Sun Feb 22 22:31:11 2004
+++ b/include/asm-ppc64/rtas.h	Sun Feb 22 22:31:11 2004
@@ -175,6 +175,7 @@
  extern void rtas_restart(char *cmd);
  extern void rtas_power_off(void);
  extern void rtas_halt(void);
+extern void rtas_os_term(void);
  extern int rtas_get_sensor(int sensor, int index, int *state);
  extern int rtas_get_power_level(int powerdomain, int *level);
  extern int rtas_set_indicator(int indicator, int index, int new_value);
diff -Nru a/include/linux/reboot.h b/include/linux/reboot.h
--- a/include/linux/reboot.h	Sun Feb 22 22:31:11 2004
+++ b/include/linux/reboot.h	Sun Feb 22 22:31:11 2004
@@ -48,6 +48,7 @@
  extern void machine_restart(char *cmd);
  extern void machine_halt(void);
  extern void machine_power_off(void);
+extern void machine_panic(void);

  #endif

diff -Nru a/kernel/panic.c b/kernel/panic.c
--- a/kernel/panic.c	Sun Feb 22 22:31:11 2004
+++ b/kernel/panic.c	Sun Feb 22 22:31:11 2004
@@ -53,7 +53,8 @@
  	static char buf[1024];
  	va_list args;
  #if defined(CONFIG_ARCH_S390)
-        unsigned long caller = (unsigned long) __builtin_return_address(0);
+	extern unsigned long panic_caller;
+        panic_caller = (unsigned long) __builtin_return_address(0);
  #endif

  	bust_spinlocks(1);
@@ -94,17 +95,12 @@
  		 */
  		machine_restart(NULL);
  	}
-#ifdef __sparc__
-	{
-		extern int stop_a_enabled;
-		/* Make sure the user can actually press L1-A */
-		stop_a_enabled = 1;
-		printk(KERN_EMERG "Press L1-A to return to the boot prom\n");
-	}
-#endif
-#if defined(CONFIG_ARCH_S390)
-        disabled_wait(caller);
-#endif
+
+	/*
+	 * Machine specific callout; might not return
+	 */
+	machine_panic();
+
  	local_irq_enable();
  	for (;;)
  		;
