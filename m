Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268517AbTCAG6g>; Sat, 1 Mar 2003 01:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbTCAG6g>; Sat, 1 Mar 2003 01:58:36 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:38488
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268517AbTCAG6f>; Sat, 1 Mar 2003 01:58:35 -0500
Date: Sat, 1 Mar 2003 02:06:57 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] rename vector to irq
Message-ID: <Pine.LNX.4.50.0303010202050.2365-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Variable renaming may be generally frowned upon, but i think the variable 
name 'vector' really confuses things at this specific code location seeing 
as it's not actually a vector as referred to for the IDT. With the 
idt_descr and irq_entries_start being really closely knit it can really 
confuse someone new to the code.

Index: linux-2.5.62-lse/arch/i386/kernel/entry.S
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/arch/i386/kernel/entry.S,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 entry.S
--- linux-2.5.62-lse/arch/i386/kernel/entry.S	18 Feb 2003 00:16:06 -0000	1.1.1.1
+++ linux-2.5.62-lse/arch/i386/kernel/entry.S	1 Mar 2003 06:58:39 -0000
@@ -376,16 +376,16 @@
 ENTRY(interrupt)
 .text
 
-vector=0
+irq=0
 ENTRY(irq_entries_start)
 .rept NR_IRQS
 	ALIGN
-1:	pushl $vector-256
+1:	pushl $irq-256
 	jmp common_interrupt
 .data
 	.long 1b
 .text
-vector=vector+1
+irq=irq+1
 .endr
 
 	ALIGN
