Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262408AbTCWEAG>; Sat, 22 Mar 2003 23:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbTCWEAG>; Sat, 22 Mar 2003 23:00:06 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:32008 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262408AbTCWEAC>;
	Sat, 22 Mar 2003 23:00:02 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "dose" <dose@infernum.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20 unresolved symbols with K7/3DNOW 
In-reply-to: Your message of "Sun, 23 Mar 2003 04:49:35 BST."
             <002101c2f0ef$38f6e5f0$0200000a@hrurusat> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Mar 2003 15:10:57 +1100
Message-ID: <9174.1048392657@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Mar 2003 04:49:35 +0100, 
"dose" <dose@infernum.com> wrote:
>This one seems to have been around for quite a while (2.4.0-textX ?)...when
>compiling with CONFIG_MK7=y ("Athlon/Duron/K7" as Processor family) a lot of
>modules aren't able to resolve the symbol _mmx_memcpy. This is caused by
>CONFIG_X86_USE_3DNOW=y and the problem lies in a wrong symbol export in
>arch/i386/kernel/i386_ksyms.c - I wonder why this still hasn't been fixed as
>it doesn't seem like a hard thing to do for someone who's into kernel
>patching...being new to that, it took me about 3 hours.
>
>diff -urN linux-2.4.20/arch/i386/kernel/i386_ksyms.c.orig
>linux-2.4.20/arch/i386/kernel/i386_ksyms.c
>--- linux-2.4.20/arch/i386/kernel/i386_ksyms.c.orig     Sun Mar 23 04:24:06
>2003
>+++ linux-2.4.20/arch/i386/kernel/i386_ksyms.c  Sun Mar 23 04:24:18 2003
>@@ -120,7 +120,7 @@
> #endif
>
> #ifdef CONFIG_X86_USE_3DNOW
>-EXPORT_SYMBOL(_mmx_memcpy);
>+EXPORT_SYMBOL_NOVERS(_mmx_memcpy);
> EXPORT_SYMBOL(mmx_clear_page);
> EXPORT_SYMBOL(mmx_copy_page);
> #endif

2.4 has a broken build system.  With CONFIG_MODVERSIONS=y, you must
make mrproper when changing any config option that changes the list of
exported symbols.  Adding _NOVERS is just papering over the cracks in
the kernel build system, the only time _NOVERS should be used is when
the exported symbol is in ASM code and not in C.

