Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWBJQHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWBJQHp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWBJQHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:07:45 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:53936 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932109AbWBJQHe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:07:34 -0500
Date: Fri, 10 Feb 2006 11:07:34 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8] Notifier chain update: Remaining changes for new API
Message-ID: <Pine.LNX.4.44L0.0602101106590.5227-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Notifier chain re-implementation (as639b): Change the remaining places
that refer to functions from the old API over to the new API.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Chandra Seetharaman <sekharan@us.ibm.com>

Index: l2616/arch/arm/mach-omap1/board-netstar.c
===================================================================
--- l2616.orig/arch/arm/mach-omap1/board-netstar.c
+++ l2616/arch/arm/mach-omap1/board-netstar.c
@@ -140,7 +140,7 @@ static int __init netstar_late_init(void
 	/* TODO: Setup front panel switch here */
 
 	/* Setup panic notifier */
-	notifier_chain_register(&panic_notifier_list, &panic_block);
+	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
 	return 0;
 }
Index: l2616/arch/arm/mach-omap1/board-voiceblue.c
===================================================================
--- l2616.orig/arch/arm/mach-omap1/board-voiceblue.c
+++ l2616/arch/arm/mach-omap1/board-voiceblue.c
@@ -234,7 +234,7 @@ static struct notifier_block panic_block
 static int __init voiceblue_setup(void)
 {
 	/* Setup panic notifier */
-	notifier_chain_register(&panic_notifier_list, &panic_block);
+	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
 	return 0;
 }
Index: l2616/arch/mips/lasat/setup.c
===================================================================
--- l2616.orig/arch/mips/lasat/setup.c
+++ l2616/arch/mips/lasat/setup.c
@@ -165,7 +165,8 @@ void __init plat_setup(void)
 
 	/* Set up panic notifier */
 	for (i = 0; i < sizeof(lasat_panic_block) / sizeof(struct notifier_block); i++)
-		notifier_chain_register(&panic_notifier_list, &lasat_panic_block[i]);
+		atomic_notifier_chain_register(&panic_notifier_list,
+				&lasat_panic_block[i]);
 
 	lasat_reboot_setup();
 
Index: l2616/arch/mips/sgi-ip22/ip22-reset.c
===================================================================
--- l2616.orig/arch/mips/sgi-ip22/ip22-reset.c
+++ l2616/arch/mips/sgi-ip22/ip22-reset.c
@@ -239,7 +239,7 @@ static int __init reboot_setup(void)
 	request_irq(SGI_PANEL_IRQ, panel_int, 0, "Front Panel", NULL);
 	init_timer(&blink_timer);
 	blink_timer.function = blink_timeout;
-	notifier_chain_register(&panic_notifier_list, &panic_block);
+	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
 	return 0;
 }
Index: l2616/arch/mips/sgi-ip32/ip32-reset.c
===================================================================
--- l2616.orig/arch/mips/sgi-ip32/ip32-reset.c
+++ l2616/arch/mips/sgi-ip32/ip32-reset.c
@@ -192,7 +192,7 @@ static __init int ip32_reboot_setup(void
 
 	init_timer(&blink_timer);
 	blink_timer.function = blink_timeout;
-	notifier_chain_register(&panic_notifier_list, &panic_block);
+	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
 	request_irq(MACEISA_RTC_IRQ, ip32_rtc_int, 0, "rtc", NULL);
 
Index: l2616/arch/parisc/kernel/pdc_chassis.c
===================================================================
--- l2616.orig/arch/parisc/kernel/pdc_chassis.c
+++ l2616/arch/parisc/kernel/pdc_chassis.c
@@ -150,7 +150,8 @@ void __init parisc_pdc_chassis_init(void
 
 		if (handle) {
 			/* initialize panic notifier chain */
-			notifier_chain_register(&panic_notifier_list, &pdc_chassis_panic_block);
+			atomic_notifier_chain_register(&panic_notifier_list,
+					&pdc_chassis_panic_block);
 
 			/* initialize reboot notifier chain */
 			register_reboot_notifier(&pdc_chassis_reboot_block);
Index: l2616/arch/powerpc/kernel/setup_64.c
===================================================================
--- l2616.orig/arch/powerpc/kernel/setup_64.c
+++ l2616/arch/powerpc/kernel/setup_64.c
@@ -578,7 +578,8 @@ void __init setup_arch(char **cmdline_p)
 	panic_timeout = 180;
 
 	if (ppc_md.panic)
-		notifier_chain_register(&panic_notifier_list, &ppc64_panic_block);
+		atomic_notifier_chain_register(&panic_notifier_list,
+				&ppc64_panic_block);
 
 	init_mm.start_code = PAGE_OFFSET;
 	init_mm.end_code = (unsigned long) _etext;
Index: l2616/arch/ppc/platforms/prep_setup.c
===================================================================
--- l2616.orig/arch/ppc/platforms/prep_setup.c
+++ l2616/arch/ppc/platforms/prep_setup.c
@@ -738,7 +738,7 @@ ibm_statusled_progress(char *s, unsigned
 		hex = 0xfff;
 		if (!notifier_installed) {
 			++notifier_installed;
-			notifier_chain_register(&panic_notifier_list,
+			atomic_notifier_chain_register(&panic_notifier_list,
 						&ibm_statusled_block);
 		}
 	}
Index: l2616/arch/um/drivers/mconsole_kern.c
===================================================================
--- l2616.orig/arch/um/drivers/mconsole_kern.c
+++ l2616/arch/um/drivers/mconsole_kern.c
@@ -762,7 +762,8 @@ static struct notifier_block panic_exit_
 
 static int add_notifier(void)
 {
-	notifier_chain_register(&panic_notifier_list, &panic_exit_notifier);
+	atomic_notifier_chain_register(&panic_notifier_list,
+			&panic_exit_notifier);
 	return(0);
 }
 
Index: l2616/arch/um/kernel/um_arch.c
===================================================================
--- l2616.orig/arch/um/kernel/um_arch.c
+++ l2616/arch/um/kernel/um_arch.c
@@ -459,7 +459,8 @@ static struct notifier_block panic_exit_
 
 void __init setup_arch(char **cmdline_p)
 {
-	notifier_chain_register(&panic_notifier_list, &panic_exit_notifier);
+	atomic_notifier_chain_register(&panic_notifier_list,
+			&panic_exit_notifier);
 	paging_init();
         strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
  	*cmdline_p = command_line;
Index: l2616/arch/xtensa/platform-iss/setup.c
===================================================================
--- l2616.orig/arch/xtensa/platform-iss/setup.c
+++ l2616/arch/xtensa/platform-iss/setup.c
@@ -108,5 +108,5 @@ static struct notifier_block iss_panic_b
 
 void __init platform_setup(char **p_cmdline)
 {
-	notifier_chain_register(&panic_notifier_list, &iss_panic_block);
+	atomic_notifier_chain_register(&panic_notifier_list, &iss_panic_block);
 }
Index: l2616/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- l2616.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ l2616/drivers/char/ipmi/ipmi_msghandler.c
@@ -3220,7 +3220,7 @@ static int ipmi_init_msghandler(void)
 	ipmi_timer.expires = jiffies + IPMI_TIMEOUT_JIFFIES;
 	add_timer(&ipmi_timer);
 
-	notifier_chain_register(&panic_notifier_list, &panic_block);
+	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
 	initialized = 1;
 
@@ -3240,7 +3240,7 @@ static __exit void cleanup_ipmi(void)
 	if (!initialized)
 		return;
 
-	notifier_chain_unregister(&panic_notifier_list, &panic_block);
+	atomic_notifier_chain_unregister(&panic_notifier_list, &panic_block);
 
 	/* This can't be called if any interfaces exist, so no worry about
 	   shutting down the interfaces. */
Index: l2616/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- l2616.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ l2616/drivers/char/ipmi/ipmi_watchdog.c
@@ -1158,7 +1158,8 @@ static int __init ipmi_wdog_init(void)
 	}
 
 	register_reboot_notifier(&wdog_reboot_notifier);
-	notifier_chain_register(&panic_notifier_list, &wdog_panic_notifier);
+	atomic_notifier_chain_register(&panic_notifier_list,
+			&wdog_panic_notifier);
 
 	printk(KERN_INFO PFX "driver initialized\n");
 
@@ -1176,7 +1177,8 @@ static __exit void ipmi_unregister_watch
 		release_nmi(&ipmi_nmi_handler);
 #endif
 
-	notifier_chain_unregister(&panic_notifier_list, &wdog_panic_notifier);
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+			&wdog_panic_notifier);
 	unregister_reboot_notifier(&wdog_reboot_notifier);
 
 	if (! watchdog_user)
Index: l2616/drivers/misc/ibmasm/heartbeat.c
===================================================================
--- l2616.orig/drivers/misc/ibmasm/heartbeat.c
+++ l2616/drivers/misc/ibmasm/heartbeat.c
@@ -52,12 +52,13 @@ static struct notifier_block panic_notif
 
 void ibmasm_register_panic_notifier(void)
 {
-	notifier_chain_register(&panic_notifier_list, &panic_notifier);
+	atomic_notifier_chain_register(&panic_notifier_list, &panic_notifier);
 }
 
 void ibmasm_unregister_panic_notifier(void)
 {
-	notifier_chain_unregister(&panic_notifier_list, &panic_notifier);
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+			&panic_notifier);
 }
 
 
Index: l2616/drivers/parisc/power.c
===================================================================
--- l2616.orig/drivers/parisc/power.c
+++ l2616/drivers/parisc/power.c
@@ -251,7 +251,8 @@ static int __init power_init(void)
 	}
 
 	/* Register a call for panic conditions. */
-	notifier_chain_register(&panic_notifier_list, &parisc_panic_block);
+	atomic_notifier_chain_register(&panic_notifier_list,
+			&parisc_panic_block);
 
 	tasklet_enable(&power_tasklet);
 
@@ -264,7 +265,8 @@ static void __exit power_exit(void)
 		return;
 
 	tasklet_disable(&power_tasklet);
-	notifier_chain_unregister(&panic_notifier_list, &parisc_panic_block);
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+			&parisc_panic_block);
 	power_tasklet.func = NULL;
 	pdc_soft_power_button(0);
 }
Index: l2616/kernel/softlockup.c
===================================================================
--- l2616.orig/kernel/softlockup.c
+++ l2616/kernel/softlockup.c
@@ -144,6 +144,6 @@ __init void spawn_softlockup_task(void)
 	cpu_callback(&cpu_nfb, CPU_ONLINE, cpu);
 	register_cpu_notifier(&cpu_nfb);
 
-	notifier_chain_register(&panic_notifier_list, &panic_block);
+	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 }
 

