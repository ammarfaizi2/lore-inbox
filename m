Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTIVTVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263297AbTIVTVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:21:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:4304 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263295AbTIVTVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:21:10 -0400
Date: Mon, 22 Sep 2003 12:14:12 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] use "normalized" syntax for lgdt/lidt
Message-Id: <20030922121412.387ef46d.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
Generates same code, but uses asm syntax that matches other
locations in arch/i386/.

Please apply.

--
~Randy


patch_name:	lxdt_norm.patch
patch_version:	2003-09-22.12:21:55
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	use common (normalized) asm syntax for lidt/lgdt,
		specifying that the operand is an input value
		instead of output;
product:	Linux
product_versions: 2.6.0-922
diffstat:	=
 arch/i386/kernel/cpu/common.c |    4 ++--
 arch/i386/kernel/traps.c      |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -Naurp ./arch/i386/kernel/cpu/common.c~lxdt ./arch/i386/kernel/cpu/common.c
--- ./arch/i386/kernel/cpu/common.c~lxdt	2003-09-22 08:45:09.000000000 -0700
+++ ./arch/i386/kernel/cpu/common.c	2003-09-22 12:05:57.000000000 -0700
@@ -493,8 +493,8 @@ void __init cpu_init (void)
 	 */
 	memcpy(thread->tls_array, cpu_gdt_table[cpu], GDT_ENTRY_TLS_ENTRIES * 8);
 
-	__asm__ __volatile__("lgdt %0": "=m" (cpu_gdt_descr[cpu]));
-	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
+	__asm__ __volatile__("lgdt %0" : : "m" (cpu_gdt_descr[cpu]));
+	__asm__ __volatile__("lidt %0" : : "m" (idt_descr));
 
 	/*
 	 * Delete NT
diff -Naurp ./arch/i386/kernel/traps.c~lxdt ./arch/i386/kernel/traps.c
--- ./arch/i386/kernel/traps.c~lxdt	2003-09-22 08:45:12.000000000 -0700
+++ ./arch/i386/kernel/traps.c	2003-09-22 12:04:17.000000000 -0700
@@ -783,7 +783,7 @@ void __init trap_init_f00f_bug(void)
 	 * it uses the read-only mapped virtual address.
 	 */
 	idt_descr.address = fix_to_virt(FIX_F00F_IDT);
-	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
+	__asm__ __volatile__("lidt %0" : : "m" (idt_descr));
 }
 #endif
 
