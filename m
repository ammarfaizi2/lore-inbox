Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319491AbSH3IWa>; Fri, 30 Aug 2002 04:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319493AbSH3IWa>; Fri, 30 Aug 2002 04:22:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:52391 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319491AbSH3IW3>;
	Fri, 30 Aug 2002 04:22:29 -0400
Date: Fri, 30 Aug 2002 10:30:14 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [patch] TLS boot-initialization bugfix on SMP, 2.5.32-BK
Message-ID: <Pine.LNX.4.44.0208301027060.9437-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached (tested) patch fixes a bad TLS initialization bug found by
Andi Kleen. x86/SMP only worked due to luck.

	Ingo

--- linux/arch/i386/kernel/cpu/common.c.orig	Fri Aug 30 10:26:55 2002
+++ linux/arch/i386/kernel/cpu/common.c	Fri Aug 30 10:27:08 2002
@@ -454,7 +454,7 @@
 	/*
 	 * Set up the per-thread TLS descriptor cache:
 	 */
-	memcpy(thread->tls_array, cpu_gdt_table[cpu], GDT_ENTRY_TLS_MAX * 8);
+	memcpy(thread->tls_array, cpu_gdt_table[cpu], GDT_ENTRY_TLS_ENTRIES * 8);
 
 	__asm__ __volatile__("lgdt %0": "=m" (cpu_gdt_descr[cpu]));
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));

