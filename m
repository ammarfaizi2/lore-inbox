Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbWACXad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWACXad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbWACX35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:29:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34456 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965096AbWACX3V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:29:21 -0500
To: torvalds@osdl.org
Subject: [PATCH 35/41] m68k: Moved initialisation of conswitchp from subarches to global arch setup
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1Etvai-0003PJ-PJ@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:29:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kars de Jong <jongk@linux-m68k.org>
Date: 1135272955 -0500

Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/amiga/config.c  |    3 ---
 arch/m68k/apollo/config.c |    3 ---
 arch/m68k/atari/config.c  |    3 ---
 arch/m68k/hp300/config.c  |    3 ---
 arch/m68k/kernel/setup.c  |    4 ++++
 arch/m68k/mac/config.c    |    3 ---
 arch/m68k/q40/config.c    |    3 ---
 arch/m68k/sun3/config.c   |    3 ---
 arch/m68k/sun3x/config.c  |    4 ----
 9 files changed, 4 insertions(+), 25 deletions(-)

31f02d1f0abb0a189090968d7ae398d3a2066b71
diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index da24476..8eadde9 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -431,9 +431,6 @@ void __init config_amiga(void)
   mach_floppy_setup    = amiga_floppy_setup;
 #endif
   mach_reset           = amiga_reset;
-#ifdef CONFIG_DUMMY_CONSOLE
-  conswitchp           = &dummy_con;
-#endif
 #if defined(CONFIG_INPUT_M68K_BEEP) || defined(CONFIG_INPUT_M68K_BEEP_MODULE)
   mach_beep            = amiga_mksound;
 #endif
diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index 2649294..d401962 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -176,9 +176,6 @@ void config_apollo(void) {
 	mach_set_clock_mmss  = dn_dummy_set_clock_mmss; /* */
 	mach_process_int     = dn_process_int;
 	mach_reset	     = dn_dummy_reset;  /* */
-#ifdef CONFIG_DUMMY_CONSOLE
-        conswitchp           = &dummy_con;
-#endif
 #ifdef CONFIG_HEARTBEAT
 	mach_heartbeat = dn_heartbeat;
 #endif
diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index 9261d2d..f6d266b 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -247,9 +247,6 @@ void __init config_atari(void)
 #ifdef CONFIG_ATARI_FLOPPY
     mach_floppy_setup	 = atari_floppy_setup;
 #endif
-#ifdef CONFIG_DUMMY_CONSOLE
-    conswitchp	         = &dummy_con;
-#endif
     mach_max_dma_address = 0xffffff;
 #if defined(CONFIG_INPUT_M68K_BEEP) || defined(CONFIG_INPUT_M68K_BEEP_MODULE)
     mach_beep          = atari_mksound;
diff --git a/arch/m68k/hp300/config.c b/arch/m68k/hp300/config.c
index a0b854f..6d129ee 100644
--- a/arch/m68k/hp300/config.c
+++ b/arch/m68k/hp300/config.c
@@ -261,9 +261,6 @@ void __init config_hp300(void)
 #ifdef CONFIG_HEARTBEAT
 	mach_heartbeat       = hp300_pulse;
 #endif
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp	     = &dummy_con;
-#endif
 	mach_max_dma_address = 0xffffffff;
 
 	if (hp300_model >= HP_330 && hp300_model <= HP_433S && hp300_model != HP_350) {
diff --git a/arch/m68k/kernel/setup.c b/arch/m68k/kernel/setup.c
index c4d4d05..583526f 100644
--- a/arch/m68k/kernel/setup.c
+++ b/arch/m68k/kernel/setup.c
@@ -282,6 +282,10 @@ void __init setup_arch(char **cmdline_p)
 	    }
 	}
 
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+
 	switch (m68k_machtype) {
 #ifdef CONFIG_AMIGA
 	    case MACH_AMIGA:
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index cd19cbb..14f8d3f 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -212,9 +212,6 @@ void __init config_mac(void)
 	mach_reset           = mac_reset;
 	mach_halt            = mac_poweroff;
 	mach_power_off       = mac_poweroff;
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp	         = &dummy_con;
-#endif
 	mach_max_dma_address = 0xffffffff;
 #if 0
 	mach_debug_init	 = mac_debug_init;
diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index 02b626b..67e88a4 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -194,9 +194,6 @@ void __init config_q40(void)
     mach_heartbeat = q40_heartbeat;
 #endif
     mach_halt = q40_halt;
-#ifdef CONFIG_DUMMY_CONSOLE
-    conswitchp = &dummy_con;
-#endif
 
     /* disable a few things that SMSQ might have left enabled */
     q40_disable_irqs();
diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
index 77d05bc..f1ca0df 100644
--- a/arch/m68k/sun3/config.c
+++ b/arch/m68k/sun3/config.c
@@ -160,9 +160,6 @@ void __init config_sun3(void)
 	mach_hwclk           =  sun3_hwclk;
 	mach_halt	     =  sun3_halt;
 	mach_get_hardware_list = sun3_get_hardware_list;
-#if defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp	     = &dummy_con;
-#endif
 
 	memory_start = ((((int)&_end) + 0x2000) & ~0x1fff);
 // PROM seems to want the last couple of physical pages. --m
diff --git a/arch/m68k/sun3x/config.c b/arch/m68k/sun3x/config.c
index 0ef547f..0920f5d 100644
--- a/arch/m68k/sun3x/config.c
+++ b/arch/m68k/sun3x/config.c
@@ -71,10 +71,6 @@ void __init config_sun3x(void)
 	mach_get_model       = sun3_get_model;
 	mach_get_hardware_list = sun3x_get_hardware_list;
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp	     = &dummy_con;
-#endif
-
 	sun3_intreg = (unsigned char *)SUN3X_INTREG;
 
 	/* only the serial console is known to work anyway... */
-- 
0.99.9.GIT

