Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbULAWe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbULAWe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbULAWe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:34:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:40135 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261472AbULAWd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:33:28 -0500
Date: Wed, 1 Dec 2004 14:20:37 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: minyard@mvista.com
Subject: [PATCH] panic_timeout: move to kernel.h
Message-Id: <20041201142037.12afaf12.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Move 'panic_timeout' to linux/kernel.h.

ipmi_watchdog.c wanted to know why panic_timeout isn't
in some header file.  However, ipmi_watchdog.c doesn't
even use it, so that reference was deleted.
Other references now use kernel.h instead of
straight extern int.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 arch/mips/ddb5xxx/ddb5074/setup.c   |    2 --
 arch/mips/ddb5xxx/ddb5476/setup.c   |    2 --
 arch/mips/ddb5xxx/ddb5477/setup.c   |    2 --
 arch/mips/jmr3927/rbhma3100/setup.c |    1 -
 arch/mips/sibyte/swarm/setup.c      |    3 +--
 arch/ppc/kernel/setup.c             |    2 +-
 arch/ppc64/kernel/iSeries_pci.c     |    2 --
 arch/ppc64/kernel/setup.c           |    2 +-
 arch/v850/kernel/fpga85e2c.c        |    1 -
 arch/v850/kernel/sim85e2.c          |    2 --
 drivers/char/ipmi/ipmi_watchdog.c   |    2 --
 include/linux/kernel.h              |    1 +
 kernel/sysctl.c                     |    1 -
 13 files changed, 4 insertions(+), 19 deletions(-)

diff -Naurp ./drivers/char/ipmi/ipmi_watchdog.c~panic_header ./drivers/char/ipmi/ipmi_watchdog.c
--- ./drivers/char/ipmi/ipmi_watchdog.c~panic_header	2004-12-01 14:01:25.335766864 -0800
+++ ./drivers/char/ipmi/ipmi_watchdog.c	2004-12-01 14:01:45.581689016 -0800
@@ -890,8 +890,6 @@ static struct notifier_block wdog_reboot
 	0
 };
 
-extern int panic_timeout; /* Why isn't this defined anywhere? */
-
 static int wdog_panic_handler(struct notifier_block *this,
 			      unsigned long         event,
 			      void                  *unused)
diff -Naurp ./arch/ppc/kernel/setup.c~panic_header ./arch/ppc/kernel/setup.c
--- ./arch/ppc/kernel/setup.c~panic_header	2004-12-01 13:32:26.690081184 -0800
+++ ./arch/ppc/kernel/setup.c	2004-12-01 13:46:37.051806552 -0800
@@ -7,6 +7,7 @@
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/initrd.h>
@@ -681,7 +682,6 @@ arch_initcall(ppc_init);
 /* Warning, IO base is not yet inited */
 void __init setup_arch(char **cmdline_p)
 {
-	extern int panic_timeout;
 	extern char *klimit;
 	extern void do_init_bootmem(void);
 
diff -Naurp ./arch/mips/jmr3927/rbhma3100/setup.c~panic_header ./arch/mips/jmr3927/rbhma3100/setup.c
--- ./arch/mips/jmr3927/rbhma3100/setup.c~panic_header	2004-10-18 14:55:07.000000000 -0700
+++ ./arch/mips/jmr3927/rbhma3100/setup.c	2004-12-01 13:47:15.246000152 -0800
@@ -200,7 +200,6 @@ extern struct resource pci_mem_resource;
 
 static void __init jmr3927_setup(void)
 {
-	extern int panic_timeout;
 	char *argptr;
 
 	irq_setup = jmr3927_irq_setup;
diff -Naurp ./arch/mips/ddb5xxx/ddb5477/setup.c~panic_header ./arch/mips/ddb5xxx/ddb5477/setup.c
--- ./arch/mips/ddb5xxx/ddb5477/setup.c~panic_header	2004-10-18 14:55:06.000000000 -0700
+++ ./arch/mips/ddb5xxx/ddb5477/setup.c	2004-12-01 13:47:52.091398800 -0800
@@ -173,8 +173,6 @@ extern struct pci_controller ddb5477_io_
 
 static int  ddb5477_setup(void)
 {
-	extern int panic_timeout;
-
 	/* initialize board - we don't trust the loader */
         ddb5477_board_init();
 
diff -Naurp ./arch/mips/ddb5xxx/ddb5074/setup.c~panic_header ./arch/mips/ddb5xxx/ddb5074/setup.c
--- ./arch/mips/ddb5xxx/ddb5074/setup.c~panic_header	2004-10-18 14:54:54.000000000 -0700
+++ ./arch/mips/ddb5xxx/ddb5074/setup.c	2004-12-01 13:48:44.071496624 -0800
@@ -94,8 +94,6 @@ static void __init ddb_time_init(void)
 
 static void __init ddb5074_setup(void)
 {
-	extern int panic_timeout;
-
 	irq_setup = ddb_irq_setup;
 	set_io_port_base(NILE4_PCI_IO_BASE);
 	isa_slot_offset = NILE4_PCI_MEM_BASE;
diff -Naurp ./arch/mips/ddb5xxx/ddb5476/setup.c~panic_header ./arch/mips/ddb5xxx/ddb5476/setup.c
--- ./arch/mips/ddb5xxx/ddb5476/setup.c~panic_header	2004-10-18 14:54:38.000000000 -0700
+++ ./arch/mips/ddb5xxx/ddb5476/setup.c	2004-12-01 13:49:10.745441568 -0800
@@ -134,8 +134,6 @@ extern void (*irq_setup)(void);
 
 static void __init ddb5476_setup(void)
 {
-	extern int panic_timeout;
-
 	irq_setup = ddb5476_irq_setup;
 	set_io_port_base(KSEG1ADDR(DDB_PCI_IO_BASE));
 
diff -Naurp ./arch/mips/sibyte/swarm/setup.c~panic_header ./arch/mips/sibyte/swarm/setup.c
--- ./arch/mips/sibyte/swarm/setup.c~panic_header	2004-10-18 14:54:08.000000000 -0700
+++ ./arch/mips/sibyte/swarm/setup.c	2004-12-01 13:49:54.564780016 -0800
@@ -26,6 +26,7 @@
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -83,8 +84,6 @@ int swarm_be_handler(struct pt_regs *reg
 
 static int __init swarm_setup(void)
 {
-	extern int panic_timeout;
-
 	sb1250_setup();
 
 	panic_timeout = 5;  /* For debug.  */
diff -Naurp ./arch/ppc64/kernel/setup.c~panic_header ./arch/ppc64/kernel/setup.c
--- ./arch/ppc64/kernel/setup.c~panic_header	2004-12-01 13:32:37.223479864 -0800
+++ ./arch/ppc64/kernel/setup.c	2004-12-01 13:50:52.477975872 -0800
@@ -17,6 +17,7 @@
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/initrd.h>
@@ -988,7 +989,6 @@ static void __init emergency_stack_init(
  */
 void __init setup_arch(char **cmdline_p)
 {
-	extern int panic_timeout;
 	extern void do_init_bootmem(void);
 
 	ppc64_boot_msg(0x12, "Setup Arch");
diff -Naurp ./arch/ppc64/kernel/iSeries_pci.c~panic_header ./arch/ppc64/kernel/iSeries_pci.c
--- ./arch/ppc64/kernel/iSeries_pci.c~panic_header	2004-12-01 13:32:37.214481232 -0800
+++ ./arch/ppc64/kernel/iSeries_pci.c	2004-12-01 13:51:23.775217968 -0800
@@ -48,8 +48,6 @@
 
 #include "pci.h"
 
-extern int panic_timeout;
-
 extern unsigned long io_page_mask;
 
 /*
diff -Naurp ./arch/v850/kernel/sim85e2.c~panic_header ./arch/v850/kernel/sim85e2.c
--- ./arch/v850/kernel/sim85e2.c~panic_header	2004-10-18 14:54:31.000000000 -0700
+++ ./arch/v850/kernel/sim85e2.c	2004-12-01 13:53:20.115531552 -0800
@@ -65,8 +65,6 @@ extern void memcons_setup (void);
 
 void EARLY_INIT_SECTION_ATTR mach_early_init (void)
 {
-	extern int panic_timeout;
-
 	/* The sim85e2 simulator tracks `undefined' values, so to make
 	   debugging easier, we begin by zeroing out all otherwise
 	   undefined registers.  This is not strictly necessary.
diff -Naurp ./arch/v850/kernel/fpga85e2c.c~panic_header ./arch/v850/kernel/fpga85e2c.c
--- ./arch/v850/kernel/fpga85e2c.c~panic_header	2004-12-01 13:32:26.852056560 -0800
+++ ./arch/v850/kernel/fpga85e2c.c	2004-12-01 13:53:45.223714528 -0800
@@ -42,7 +42,6 @@ void __init mach_early_init (void)
 	int i;
 	const u32 *src;
 	register u32 *dst asm ("ep");
-	extern int panic_timeout;
 	extern u32 _intv_end, _intv_load_start;
 
 	/* Set bus sizes: CS0 32-bit, CS1 16-bit, CS7 8-bit,
diff -Naurp ./include/linux/kernel.h~panic_header ./include/linux/kernel.h
--- ./include/linux/kernel.h~panic_header	2004-12-01 13:32:30.515499632 -0800
+++ ./include/linux/kernel.h	2004-12-01 13:38:12.059577040 -0800
@@ -134,6 +134,7 @@ static inline void console_verbose(void)
 
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
+extern int panic_timeout;
 extern int panic_on_oops;
 extern int tainted;
 extern const char *print_tainted(void);
diff -Naurp ./kernel/sysctl.c~panic_header ./kernel/sysctl.c
--- ./kernel/sysctl.c~panic_header	2004-12-01 13:32:30.638480936 -0800
+++ ./kernel/sysctl.c	2004-12-01 13:54:56.707847288 -0800
@@ -52,7 +52,6 @@
 #if defined(CONFIG_SYSCTL)
 
 /* External variables not in a header file. */
-extern int panic_timeout;
 extern int C_A_D;
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;



---
