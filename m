Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264901AbUAAVGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 16:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265408AbUAAVAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 16:00:43 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:63263 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S264901AbUAAUD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:29 -0500
Date: Thu, 1 Jan 2004 21:03:26 +0100
Message-Id: <200401012003.i01K3QR9031882@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 374] Amiga debug fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga: Fix `debug=mem' (record all kernel messages in ChipRAM): virt_to_phys()
no longer works for Zorro II memory space, we must use ZTWO_PADDR()

--- linux-2.6.0/arch/m68k/amiga/config.c	2003-05-27 19:02:32.000000000 +0200
+++ linux-m68k-2.6.0/arch/m68k/amiga/config.c	2003-11-08 19:12:48.000000000 +0100
@@ -803,7 +803,7 @@
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
