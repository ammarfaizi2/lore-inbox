Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285615AbRLGW0H>; Fri, 7 Dec 2001 17:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285616AbRLGWZx>; Fri, 7 Dec 2001 17:25:53 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:54796 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S285615AbRLGWZm>; Fri, 7 Dec 2001 17:25:42 -0500
Date: Fri, 7 Dec 2001 19:09:03 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: David Mosberger <davidm@hpl.hp.com>
Cc: Andrew Morton <akpm@zip.com.au>, j-nomura@ce.jp.nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
In-Reply-To: <15377.16385.380923.588249@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.21.0112071906430.22884-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Dec 2001, David Mosberger wrote:

> >>>>> On Fri, 7 Dec 2001 18:47:11 -0200 (BRST), Marcelo Tosatti <marcelo@conectiva.com.br> said:
> 
>   Marcelo> On Fri, 7 Dec 2001, David Mosberger wrote:
> 
>   >> >>>>> On Fri, 7 Dec 2001 16:52:07 -0200 (BRST), Marcelo Tosatti
>   >> <marcelo@conectiva.com.br> said:
>   >> 
>   Marcelo> I'm really not willing to apply this kludge...
>   >>  Do you agree that it should always be safe to call printk() from
>   >> C code?
> 
>   Marcelo> No if you can't access the console to print the message :)
> 
> Let me quote the first few lines of the Linux kernel:
> 
> 	----
> 	asmlinkage void __init start_kernel(void)
> 	{
> 		char * command_line;
> 		unsigned long mempages;
> 		extern char saved_command_line[];
> 	/*
> 	 * Interrupts are still disabled. Do necessary setups, then
> 	 * enable them
> 	 */
> 		lock_kernel();
> 		printk(linux_banner);
> 	----
> 
> You still think it doesn't make sense?

Ok, it does. However, this still does not make me change my mind.

>   Marcelo> Its just that I would prefer to see the thing fixed in
>   Marcelo> arch-dependant code instead special casing core code.
> 
> Only architecture specific problems should be fixed with architecture
> specific code.
> 
> I'm not entirely sure whether this particular problem is architecture
> specific.  Perhaps it is and, if so, I'm certainly happy to fix it in
> the ia64 specific code. However, are you really 100% certain that on
> x86 there are no console drivers which in some fashion depend on
> cpu_init() having completed execution?  Note that the x86 version of
> cpu_init() also has printk()s.  If you're not certain of this, the AP
> startup problem could occur on x86, too.  I haven't looked at all the
> other platforms, but I suspect similar things will be true, there.

Prove, please. If you show me it can also happen on other architectures,
I'll be glad to apply the patch.

