Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWIXIkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWIXIkR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 04:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWIXIkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 04:40:17 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:20973 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1751591AbWIXIkP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 04:40:15 -0400
Date: Sun, 24 Sep 2006 10:40:04 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] remove SYSRQ_KEY and related defines from ppc/sh/h8300
Message-ID: <20060924084004.GA8536@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove unused global SYSRQ_KEY from ppc and powerpc
Remove unused define SYSRQ_KEY from sh/sh64 and h8300
Remove unused pckbd_sysrq_xlate and kbd_sysrq_xlate usage

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/kernel/setup_32.c    |    4 ----
 arch/powerpc/kernel/setup_64.c    |    5 -----
 arch/ppc/kernel/setup.c           |    4 ----
 include/asm-h8300/keyboard.h      |    8 --------
 include/asm-sh/ec3104/keyboard.h  |    2 --
 include/asm-sh/mpc1211/keyboard.h |    4 ----
 include/asm-sh64/keyboard.h       |    4 ----
 7 files changed, 31 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/setup_32.c
+++ linux-2.6/arch/powerpc/kernel/setup_32.c
@@ -67,10 +67,6 @@ int have_of = 1;
 dev_t boot_dev;
 #endif /* CONFIG_PPC_MULTIPLATFORM */
 
-#ifdef CONFIG_MAGIC_SYSRQ
-unsigned long SYSRQ_KEY = 0x54;
-#endif /* CONFIG_MAGIC_SYSRQ */
-
 #ifdef CONFIG_VGA_CONSOLE
 unsigned long vgacon_remap_base;
 #endif
Index: linux-2.6/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/setup_64.c
+++ linux-2.6/arch/powerpc/kernel/setup_64.c
@@ -93,11 +93,6 @@ int dcache_bsize;
 int icache_bsize;
 int ucache_bsize;
 
-#ifdef CONFIG_MAGIC_SYSRQ
-unsigned long SYSRQ_KEY;
-#endif /* CONFIG_MAGIC_SYSRQ */
-
-
 #ifdef CONFIG_SMP
 
 static int smt_enabled_cmdline;
Index: linux-2.6/arch/ppc/kernel/setup.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/setup.c
+++ linux-2.6/arch/ppc/kernel/setup.c
@@ -86,10 +86,6 @@ int ppc_do_canonicalize_irqs;
 EXPORT_SYMBOL(ppc_do_canonicalize_irqs);
 #endif
 
-#ifdef CONFIG_MAGIC_SYSRQ
-unsigned long SYSRQ_KEY = 0x54;
-#endif /* CONFIG_MAGIC_SYSRQ */
-
 #ifdef CONFIG_VGA_CONSOLE
 unsigned long vgacon_remap_base;
 #endif
Index: linux-2.6/include/asm-h8300/keyboard.h
===================================================================
--- linux-2.6.orig/include/asm-h8300/keyboard.h
+++ linux-2.6/include/asm-h8300/keyboard.h
@@ -18,14 +18,6 @@
 #define kbd_enable_irq(x...)	do {;} while (0)
 #define kbd_disable_irq(x...)	do {;} while (0)
 
-
-/* needed if MAGIC_SYSRQ is enabled for serial console */
-#ifndef SYSRQ_KEY
-#define SYSRQ_KEY		((unsigned char)(-1))
-#define kbd_sysrq_xlate         ((unsigned char *)NULL)
-#endif
-
-
 #endif  /* _H8300_KEYBOARD_H */
 
 
Index: linux-2.6/include/asm-sh/ec3104/keyboard.h
===================================================================
--- linux-2.6.orig/include/asm-sh/ec3104/keyboard.h
+++ linux-2.6/include/asm-sh/ec3104/keyboard.h
@@ -6,8 +6,6 @@ extern char ec3104_kbd_unexpected_up(uns
 extern void ec3104_kbd_leds(unsigned char);
 extern void ec3104_kbd_init_hw(void);
 
-#define SYSRQ_KEY 0x54
-
 #define kbd_sysrq_xlate ec3104_kbd_sysrq_xlate
 #define kbd_setkeycode ec3104_kbd_setkeycode
 #define kbd_getkeycode ec3104_kbd_getkeycode
Index: linux-2.6/include/asm-sh/mpc1211/keyboard.h
===================================================================
--- linux-2.6.orig/include/asm-sh/mpc1211/keyboard.h
+++ linux-2.6/include/asm-sh/mpc1211/keyboard.h
@@ -24,7 +24,6 @@ extern void pckbd_leds(unsigned char led
 extern void pckbd_init_hw(void);
 extern int pckbd_pm_resume(struct pm_dev *, pm_request_t, void *);
 extern pm_callback pm_kbd_request_override;
-extern unsigned char pckbd_sysrq_xlate[128];
 
 #define kbd_setkeycode		pckbd_setkeycode
 #define kbd_getkeycode		pckbd_getkeycode
@@ -32,9 +31,6 @@ extern unsigned char pckbd_sysrq_xlate[1
 #define kbd_unexpected_up	pckbd_unexpected_up
 #define kbd_leds		pckbd_leds
 #define kbd_init_hw		pckbd_init_hw
-#define kbd_sysrq_xlate		pckbd_sysrq_xlate
-
-#define SYSRQ_KEY 0x54
 
 /* resource allocation */
 #define kbd_request_region()
Index: linux-2.6/include/asm-sh64/keyboard.h
===================================================================
--- linux-2.6.orig/include/asm-sh64/keyboard.h
+++ linux-2.6/include/asm-sh64/keyboard.h
@@ -30,7 +30,6 @@ extern int pckbd_translate(unsigned char
 extern char pckbd_unexpected_up(unsigned char keycode);
 extern void pckbd_leds(unsigned char leds);
 extern void pckbd_init_hw(void);
-extern unsigned char pckbd_sysrq_xlate[128];
 
 #define kbd_setkeycode		pckbd_setkeycode
 #define kbd_getkeycode		pckbd_getkeycode
@@ -38,9 +37,6 @@ extern unsigned char pckbd_sysrq_xlate[1
 #define kbd_unexpected_up	pckbd_unexpected_up
 #define kbd_leds		pckbd_leds
 #define kbd_init_hw		pckbd_init_hw
-#define kbd_sysrq_xlate		pckbd_sysrq_xlate
-
-#define SYSRQ_KEY 0x54
 
 /* resource allocation */
 #define kbd_request_region()
