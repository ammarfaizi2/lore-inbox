Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264520AbTLGUzr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbTLGUye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:54:34 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:57939 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S264524AbTLGUxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:53:52 -0500
Date: Sun, 7 Dec 2003 21:49:38 +0100
Message-Id: <200312072049.hB7KncHH000684@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 126] M68k symbol exports
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Export missing symbols (from Matthias Urlichs in 2.6.0)

--- linux-2.4.23/arch/m68k/kernel/m68k_ksyms.c	Tue Aug 26 12:22:40 2003
+++ linux-m68k-2.4.23/arch/m68k/kernel/m68k_ksyms.c	Mon Oct 20 22:09:23 2003
@@ -12,6 +12,7 @@
 #include <asm/setup.h>
 #include <asm/machdep.h>
 #include <asm/pgalloc.h>
+#include <asm/pgtable.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
@@ -19,6 +20,7 @@
 #include <asm/hardirq.h>
 #include <asm/softirq.h>
 #include <asm/rtc.h>
+#include <asm/hwtest.h>
 
 asmlinkage long long __ashldi3 (long long, int);
 asmlinkage long long __ashrdi3 (long long, int);
@@ -47,6 +49,9 @@
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(kernel_set_cachemode);
+#ifndef mm_cachebits
+EXPORT_SYMBOL(mm_cachebits);
+#endif
 #endif /* !CONFIG_SUN3 */
 EXPORT_SYMBOL(flush_icache_user_range);
 EXPORT_SYMBOL(m68k_debug_device);
@@ -66,6 +71,8 @@
 #ifdef CONFIG_VME
 EXPORT_SYMBOL(vme_brdtype);
 #endif
+EXPORT_SYMBOL(hwreg_present);
+EXPORT_SYMBOL(hwreg_write);
 
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy);
--- linux-2.4.23/arch/m68k/mac/mac_ksyms.c	Sat Sep  4 22:06:41 1999
+++ linux-m68k-2.4.23/arch/m68k/mac/mac_ksyms.c	Mon Oct 20 22:00:05 2003
@@ -6,3 +6,4 @@
 extern int via_alt_mapping;
 
 EXPORT_SYMBOL(via_alt_mapping);
+EXPORT_SYMBOL(macintosh_config);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
