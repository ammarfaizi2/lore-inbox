Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTENWlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbTENWlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:41:16 -0400
Received: from smtp-out3.iol.cz ([194.228.2.91]:39144 "EHLO smtp-out3.iol.cz")
	by vger.kernel.org with ESMTP id S263126AbTENWlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:41:14 -0400
Date: Thu, 15 May 2003 00:51:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adrian Bunk <bunk@fs.tum.de>, mikpe@csd.uu.ee
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm5: CONFIG_ACPI_SLEEP compile error
Message-ID: <20030514225157.GA13427@elf.ucw.cz>
References: <20030514012947.46b011ff.akpm@digeo.com> <20030514214536.GK1346@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514214536.GK1346@fs.tum.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Mikpe, is this your diff? 

revision 1.16
date: 2003/05/11 18:58:48;  author: mikpe;  state: Exp;  lines: +2 -4
restore sysenter MSRs at APM resume

I do not know why you changed it (it has certainly nothing to do with
APM resume)... Please revert it.

								Pavel

Index: suspend.c
===================================================================
RCS file:
/home/pavel/sf/bitbucket/bkcvs/linux-2.5/arch/i386/kernel/suspend.c,v
retrieving revision 1.15
retrieving revision 1.16
diff -u -r1.15 -r1.16
--- suspend.c   8 Apr 2003 16:46:44 -0000       1.15
+++ suspend.c   11 May 2003 18:58:48 -0000      1.16
@@ -27,9 +27,7 @@
 #include <asm/tlbflush.h>

 static struct saved_context saved_context;
-unsigned long saved_context_eax, saved_context_ebx,
saved_context_ecx, saved_context_edx;
-unsigned long saved_context_esp, saved_context_ebp,
saved_context_esi, saved_context_edi;
-unsigned long saved_context_eflags;
+static void fix_processor_context(void);

 extern void enable_sep_cpu(void *);

@@ -107,7 +105,7 @@
        do_fpu_end();
 }

-void fix_processor_context(void)
+static void fix_processor_context(void)
 {
        int cpu = smp_processor_id();
        struct tss_struct * t = init_tss + cpu;



> It seems the following problem comes from Linus' tree:
> 
> <--  snip  -->
> 
> ...
> ... --end-group  -o .tmp_vmlinux1
> arch/i386/kernel/built-in.o(.data+0x1fae): In function `do_suspend_lowlevel':
> : undefined reference to `saved_context_esp'
> arch/i386/kernel/built-in.o(.data+0x1fb3): In function `do_suspend_lowlevel':
> : undefined reference to `saved_context_eax'
> arch/i386/kernel/built-in.o(.data+0x1fb9): In function `do_suspend_lowlevel':
> : undefined reference to `saved_context_ebx'
> ...
> make: *** [.tmp_vmlinux1] Error 1
> 


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
