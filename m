Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264532AbTLGVVX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTLGU4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:56:40 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:20284 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S264535AbTLGUzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:55:41 -0500
Date: Sun, 7 Dec 2003 21:51:27 +0100
Message-Id: <200312072051.hB7KpRXg000753@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 137] Amiga debug fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga: Fix `debug=mem' (record all kernel messages in ChipRAM): virt_to_phys()
no longer works for Zorro II memory space, we must use ZTWO_PADDR()

--- linux-2.4.23/arch/m68k/amiga/config.c	2003-04-06 10:28:29.000000000 +0200
+++ linux-m68k-2.4.23/arch/m68k/amiga/config.c	2003-11-08 19:20:04.000000000 +0100
@@ -877,7 +877,7 @@
     savekmsg = amiga_chip_alloc_res(SAVEKMSG_MAXMEM, &debug_res);
     savekmsg->magic1 = SAVEKMSG_MAGIC1;
     savekmsg->magic2 = SAVEKMSG_MAGIC2;
-    savekmsg->magicptr = virt_to_phys(savekmsg);
+    savekmsg->magicptr = ZTWO_PADDR(savekmsg);
     savekmsg->size = 0;
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
