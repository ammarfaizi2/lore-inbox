Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUDMI7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUDMI5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:57:33 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:10260 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S263371AbUDMIqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:46:47 -0400
Date: Tue, 13 Apr 2004 10:38:19 +0200
Message-Id: <200404130838.i3D8cJHx018503@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 438] m68k show_interrupts bug
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Make sure machine-specific interrupts are always printed (bug introduced
by show_interrupts() conversion)

--- linux-2.6.5/arch/m68k/kernel/ints.c	2004-04-05 10:41:52.000000000 +0200
+++ linux-m68k-2.6.5/arch/m68k/kernel/ints.c	2004-04-11 12:53:06.000000000 +0200
@@ -262,8 +262,8 @@
 	int i = *(loff_t *) v;
 
 	/* autovector interrupts */
-	if (mach_default_handler) {
-		if (i < SYS_IRQS) {
+	if (i < SYS_IRQS) {
+		if (mach_default_handler) {
 			seq_printf(p, "auto %2d: %10u ", i,
 			               i ? kstat_cpu(0).irqs[i] : num_spurious);
 			seq_puts(p, "  ");

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
