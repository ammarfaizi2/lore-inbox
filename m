Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268015AbTBMKZv>; Thu, 13 Feb 2003 05:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268016AbTBMKZv>; Thu, 13 Feb 2003 05:25:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7440 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268015AbTBMKZu>; Thu, 13 Feb 2003 05:25:50 -0500
Date: Thu, 13 Feb 2003 11:35:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
       ak@suse.de
Subject: Re: Kill SHOUTING in kernel/io_apic.c
Message-ID: <20030213103539.GD14151@atrey.karlin.mff.cuni.cz>
References: <20030210163726.GA1115@elf.ucw.cz> <20030213051525.0F7682C04B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030213051525.0F7682C04B@lists.samba.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That source is shouting WAY TOO MUCH. Please apply,
> 
> Either you can make unexpected_IO_APIC static, or your patch missed a
> caller.
> 
> In fact, grep reveals the former.  x86_64, too.

Here's updated patch. (I guess x86_64 will want to sync after linus
applies that...)

--- clean/arch/i386/kernel/io_apic.c	2003-01-17 23:13:33.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/io_apic.c	2003-01-19 19:46:51.000000000 +0100
@@ -824,7 +824,7 @@
 	enable_8259A_irq(0);
 }
 
-void __init UNEXPECTED_IO_APIC(void)
+static void __init unexpected_IO_APIC(void)
 {
 	printk(KERN_WARNING " WARNING: unexpected IO-APIC, please mail\n");
 	printk(KERN_WARNING "          to linux-smp@vger.kernel.org\n");
@@ -865,7 +865,7 @@
 	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", reg_00.delivery_type);
 	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.LTS);
 	if (reg_00.__reserved_0 || reg_00.__reserved_1 || reg_00.__reserved_2)
-		UNEXPECTED_IO_APIC();
+		unexpected_IO_APIC();
 
 	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
 	printk(KERN_DEBUG ".......     : max redirection entries: %04X\n", reg_01.entries);
@@ -877,7 +877,7 @@
 		(reg_01.entries != 0x2E) &&
 		(reg_01.entries != 0x3F)
 	)
-		UNEXPECTED_IO_APIC();
+		unexpected_IO_APIC();
 
 	printk(KERN_DEBUG ".......     : PRQ implemented: %X\n", reg_01.PRQ);
 	printk(KERN_DEBUG ".......     : IO APIC version: %04X\n", reg_01.version);
@@ -887,15 +887,15 @@
 		(reg_01.version != 0x13) && /* Xeon IO-APICs */
 		(reg_01.version != 0x20)    /* Intel P64H (82806 AA) */
 	)
-		UNEXPECTED_IO_APIC();
+		unexpected_IO_APIC();
 	if (reg_01.__reserved_1 || reg_01.__reserved_2)
-		UNEXPECTED_IO_APIC();
+		unexpected_IO_APIC();
 
 	if (reg_01.version >= 0x10) {
 		printk(KERN_DEBUG ".... register #02: %08X\n", *(int *)&reg_02);
 		printk(KERN_DEBUG ".......     : arbitration: %02X\n", reg_02.arbitration);
 		if (reg_02.__reserved_1 || reg_02.__reserved_2)
-			UNEXPECTED_IO_APIC();
+			unexpected_IO_APIC();
 	}
 
 	printk(KERN_DEBUG ".... IRQ redirection table:\n");


-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
