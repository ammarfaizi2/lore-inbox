Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265488AbUAAVdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 16:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbUAAUsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:48:32 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:26438 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S264913AbUAAUDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:31 -0500
Date: Thu, 1 Jan 2004 21:03:29 +0100
Message-Id: <200401012003.i01K3Tc1031907@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 379] Amiga core C99
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga core: Use C99 struct initializers

--- linux-2.6.0/arch/m68k/amiga/chipram.c	2003-03-25 10:06:07.000000000 +0100
+++ linux-m68k-2.6.0/arch/m68k/amiga/chipram.c	2003-11-23 17:06:58.000000000 +0100
@@ -19,7 +19,9 @@
 
 unsigned long amiga_chip_size;
 
-static struct resource chipram_res = { "Chip RAM", CHIP_PHYSADDR };
+static struct resource chipram_res = {
+    .name = "Chip RAM", .start = CHIP_PHYSADDR
+};
 static unsigned long chipavail;
 
 
--- linux-2.6.0/arch/m68k/amiga/config.c	2003-11-08 19:36:09.000000000 +0100
+++ linux-m68k-2.6.0/arch/m68k/amiga/config.c	2003-11-23 17:07:47.000000000 +0100
@@ -121,14 +123,22 @@
 static struct {
     struct resource _ciab, _ciaa, _custom, _kickstart;
 } mb_resources = {
-    ._ciab =		{ "CIA B", 0x00bfd000, 0x00bfdfff },
-    ._ciaa =		{ "CIA A", 0x00bfe000, 0x00bfefff },
-    ._custom =		{ "Custom I/O", 0x00dff000, 0x00dfffff },
-    ._kickstart =	{ "Kickstart ROM", 0x00f80000, 0x00ffffff }
+    ._ciab = {
+	.name = "CIA B", .start = 0x00bfd000, .end = 0x00bfdfff
+    },
+    ._ciaa = {
+	.name = "CIA A", .start = 0x00bfe000, .end = 0x00bfefff
+    },
+    ._custom = {
+	.name = "Custom I/O", .start = 0x00dff000, .end = 0x00dfffff
+    },
+    ._kickstart = {
+	.name = "Kickstart ROM", .start = 0x00f80000, .end = 0x00ffffff
+    }
 };
 
 static struct resource rtc_resource = {
-    NULL, 0x00dc0000, 0x00dcffff
+    .start = 0x00dc0000, .end = 0x00dcffff
 };
 
 static struct resource ram_resource[NUM_MEMINFO];
@@ -495,7 +506,7 @@
 							  struct pt_regs *))
 {
 	static struct resource sched_res = {
-	    "timer", 0x00bfd400, 0x00bfd5ff,
+	    .name = "timer", .start = 0x00bfd400, .end = 0x00bfd5ff,
 	};
 	jiffy_ticks = (amiga_eclock+HZ/2)/HZ;
 
@@ -798,7 +813,7 @@
 
 static void amiga_savekmsg_init(void)
 {
-    static struct resource debug_res = { "Debug" };
+    static struct resource debug_res = { .name = "Debug" };
 
     savekmsg = amiga_chip_alloc_res(SAVEKMSG_MAXMEM, &debug_res);
     savekmsg->magic1 = SAVEKMSG_MAGIC1;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
