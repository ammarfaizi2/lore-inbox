Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314450AbSDRWWe>; Thu, 18 Apr 2002 18:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314453AbSDRWWd>; Thu, 18 Apr 2002 18:22:33 -0400
Received: from [195.39.17.254] ([195.39.17.254]:21645 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314450AbSDRWWc>;
	Thu, 18 Apr 2002 18:22:32 -0400
Date: Fri, 19 Apr 2002 00:18:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Kill unneccessary delays from swsusp
Message-ID: <20020418221858.GA18015@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch kills unneccessary delays from suspend.h. I used them for
debugging and forgot them in. Please apply,
								Pavel

--- clean.ac//include/asm-i386/suspend.h	Sun Apr  7 10:55:12 2002
+++ linux-swsusp.24/include/asm-i386/suspend.h	Fri Apr 19 00:15:41 2002
@@ -123,17 +123,13 @@
 	int nr = smp_processor_id();
 	struct tss_struct * t = &init_tss[nr];
 
-	printk("Tss desc..."); mdelay(1000);
 	set_tss_desc(nr,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
         gdt_table[__TSS(nr)].b &= 0xfffffdff;
 
-	printk("Tr..."); mdelay(1000);
 	load_TR(nr);		/* This does ltr */
 
-	printk("LDT..."); mdelay(1000);
 	load_LDT(current->active_mm);	/* This does lldt */
 
-	printk("Debug..."); mdelay(1000);
 	/*
 	 * Now maybe reload the debug registers
 	 */
@@ -154,7 +150,6 @@
 {
         /* restore FPU regs if necessary */
 	/* Do it out of line so that gcc does not move cr0 load to some stupid place */
-	printk("FPU..."); mdelay(1000);
         kernel_fpu_end();
 }
 
@@ -223,12 +218,9 @@
 	asm volatile ("lldt (%0)" :: "m" (saved_context.ldt));
 
 #if 0
-	printk("Reloading old TR..."); mdelay(1000);
-
 	asm volatile ("ltr (%0)"  :: "m" (saved_context.tr));
 #endif
 
-	printk("Calling fix_processor_context..."); mdelay(1000);
 	fix_processor_context();
 
 	/*

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
