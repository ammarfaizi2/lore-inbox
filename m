Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270989AbTGVSqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270992AbTGVSqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:46:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:30179 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270989AbTGVSp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:45:57 -0400
Date: Tue, 22 Jul 2003 11:58:23 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: asm (lidt) question
Message-Id: <20030722115823.4b34f9ce.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.55.0307221021130.1372@bigblue.dev.mcafeelabs.com>
References: <20030717152819.66cfdbaf.rddunlap@osdl.org>
	<Pine.LNX.4.55.0307171535020.4845@bigblue.dev.mcafeelabs.com>
	<Pine.LNX.4.55.0307171615580.4845@bigblue.dev.mcafeelabs.com>
	<20030722172722.GC3267@mail.jlokier.co.uk>
	<Pine.LNX.4.55.0307221021130.1372@bigblue.dev.mcafeelabs.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jul 2003 10:31:37 -0700 (PDT) Davide Libenzi <davidel@xmailserver.org> wrote:

| On Tue, 22 Jul 2003, Jamie Lokier wrote:
| 
| > Davide Libenzi wrote:
| > > IMHO, since "var" is really an output parameter.
| >
| > "var" is read, not written.
| > I think you are confusing "lidt" with "sidt".
| 
| Actually I don't even know what I was confusing, since L and S are not
| there for nothing ;) And yes, the form with =m as input parameter should
| be corrected, even if it generates the same code.

Yes, less confusion is better, so here's a patch to use the
same reasonable syntax in all places.

Look OK?  Generates the same code, as Davide pointed out.

--
~Randy


patch_name:	lidt_norm.patch
patch_version:	2003-07-22.11:47:21
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	normalize lidt/lgdt syntax usage
product:	Linux
product_versions: 2.6.0-test1
diffstat:	=
 arch/i386/kernel/cpu/common.c |    4 ++--
 arch/i386/kernel/traps.c      |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)


diff -Naur ./arch/i386/kernel/cpu/common.c~lidt ./arch/i386/kernel/cpu/common.c
--- ./arch/i386/kernel/cpu/common.c~lidt	2003-07-13 20:29:29.000000000 -0700
+++ ./arch/i386/kernel/cpu/common.c	2003-07-22 11:41:05.000000000 -0700
@@ -480,8 +480,8 @@
 	 */
 	memcpy(thread->tls_array, cpu_gdt_table[cpu], GDT_ENTRY_TLS_ENTRIES * 8);
 
-	__asm__ __volatile__("lgdt %0": "=m" (cpu_gdt_descr[cpu]));
-	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
+	__asm__ __volatile__("lgdt %0": :"m" (cpu_gdt_descr[cpu]));
+	__asm__ __volatile__("lidt %0": :"m" (idt_descr));
 
 	/*
 	 * Delete NT
diff -Naur ./arch/i386/kernel/traps.c~lidt ./arch/i386/kernel/traps.c
--- ./arch/i386/kernel/traps.c~lidt	2003-07-13 20:31:20.000000000 -0700
+++ ./arch/i386/kernel/traps.c	2003-07-22 11:39:31.000000000 -0700
@@ -780,7 +780,7 @@
 	 * it uses the read-only mapped virtual address.
 	 */
 	idt_descr.address = fix_to_virt(FIX_F00F_IDT);
-	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
+	__asm__ __volatile__("lidt %0": :"m" (idt_descr));
 }
 #endif
 

