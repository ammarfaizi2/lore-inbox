Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUAAUuh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbUAAUt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:49:29 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:22348 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S264919AbUAAUDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:37 -0500
Date: Thu, 1 Jan 2004 21:03:34 +0100
Message-Id: <200401012003.i01K3YrW031920@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 381] M68k thread
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Don't forget to initialize the thread_info member in INIT_THREAD() (from
Roman Zippel)

--- linux-2.6.0/include/asm-m68k/processor.h	2003-09-28 09:57:11.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/processor.h	2003-11-23 15:56:44.000000000 +0100
@@ -85,10 +85,11 @@
 	struct thread_info info;
 };
 
-#define INIT_THREAD  {						\
-	ksp: sizeof(init_stack) + (unsigned long) init_stack,	\
-	sr: PS_S, 						\
-	fs: __KERNEL_DS,					\
+#define INIT_THREAD  {							\
+	ksp:	sizeof(init_stack) + (unsigned long) init_stack,	\
+	sr:	PS_S,							\
+	fs:	__KERNEL_DS,						\
+	info:	INIT_THREAD_INFO(init_task)				\
 }
 
 /*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
