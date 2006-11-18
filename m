Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756089AbWKRAPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbWKRAPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756091AbWKRAPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:15:30 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46015 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1756089AbWKRAP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:15:28 -0500
Date: Sat, 18 Nov 2006 01:15:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, rjw@sisk.pl
Subject: Re: [PATCH 11/20] x86_64: wakeup.S Rename labels to reflect right register names
Message-ID: <20061118001507.GC9188@elf.ucw.cz>
References: <20061117223432.GA15449@in.ibm.com> <20061117224822.GL15449@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117224822.GL15449@in.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-11-17 17:48:22, Vivek Goyal wrote:
> 
> 
> o Use appropriate names for 64bit regsiters.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>

ACK.

> --- linux-2.6.19-rc6-reloc/arch/x86_64/kernel/acpi/wakeup.S~x86_64-wakeup.S-rename-registers-to-reflect-right-names	2006-11-17 00:09:29.000000000 -0500
> +++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/acpi/wakeup.S	2006-11-17 00:09:29.000000000 -0500
> @@ -211,16 +211,16 @@ wakeup_long64:
>  	movw	%ax, %es
>  	movw	%ax, %fs
>  	movw	%ax, %gs
> -	movq	saved_esp, %rsp
> +	movq	saved_rsp, %rsp
>  
>  	movw	$0x0e00 + 'x', %ds:(0xb8018)
> -	movq	saved_ebx, %rbx
> -	movq	saved_edi, %rdi
> -	movq	saved_esi, %rsi
> -	movq	saved_ebp, %rbp
> +	movq	saved_rbx, %rbx
> +	movq	saved_rdi, %rdi
> +	movq	saved_rsi, %rsi
> +	movq	saved_rbp, %rbp
>  
>  	movw	$0x0e00 + '!', %ds:(0xb801a)
> -	movq	saved_eip, %rax
> +	movq	saved_rip, %rax
>  	jmp	*%rax
>  
>  .code32
> @@ -408,13 +408,13 @@ do_suspend_lowlevel:
>  	movq %r15, saved_context_r15(%rip)
>  	pushfq ; popq saved_context_eflags(%rip)
>  
> -	movq	$.L97, saved_eip(%rip)
> +	movq	$.L97, saved_rip(%rip)
>  
> -	movq %rsp,saved_esp
> -	movq %rbp,saved_ebp
> -	movq %rbx,saved_ebx
> -	movq %rdi,saved_edi
> -	movq %rsi,saved_esi
> +	movq %rsp,saved_rsp
> +	movq %rbp,saved_rbp
> +	movq %rbx,saved_rbx
> +	movq %rdi,saved_rdi
> +	movq %rsi,saved_rsi
>  
>  	addq	$8, %rsp
>  	movl	$3, %edi
> @@ -461,12 +461,12 @@ do_suspend_lowlevel:
>  	
>  .data
>  ALIGN
> -ENTRY(saved_ebp)	.quad	0
> -ENTRY(saved_esi)	.quad	0
> -ENTRY(saved_edi)	.quad	0
> -ENTRY(saved_ebx)	.quad	0
> +ENTRY(saved_rbp)	.quad	0
> +ENTRY(saved_rsi)	.quad	0
> +ENTRY(saved_rdi)	.quad	0
> +ENTRY(saved_rbx)	.quad	0
>  
> -ENTRY(saved_eip)	.quad	0
> -ENTRY(saved_esp)	.quad	0
> +ENTRY(saved_rip)	.quad	0
> +ENTRY(saved_rsp)	.quad	0
>  
>  ENTRY(saved_magic)	.quad	0
> diff -puN include/asm-x86_64/suspend.h~x86_64-wakeup.S-rename-registers-to-reflect-right-names include/asm-x86_64/suspend.h
> --- linux-2.6.19-rc6-reloc/include/asm-x86_64/suspend.h~x86_64-wakeup.S-rename-registers-to-reflect-right-names	2006-11-17 00:09:29.000000000 -0500
> +++ linux-2.6.19-rc6-reloc-root/include/asm-x86_64/suspend.h	2006-11-17 00:09:29.000000000 -0500
> @@ -45,12 +45,12 @@ extern unsigned long saved_context_eflag
>  extern void fix_processor_context(void);
>  
>  #ifdef CONFIG_ACPI_SLEEP
> -extern unsigned long saved_eip;
> -extern unsigned long saved_esp;
> -extern unsigned long saved_ebp;
> -extern unsigned long saved_ebx;
> -extern unsigned long saved_esi;
> -extern unsigned long saved_edi;
> +extern unsigned long saved_rip;
> +extern unsigned long saved_rsp;
> +extern unsigned long saved_rbp;
> +extern unsigned long saved_rbx;
> +extern unsigned long saved_rsi;
> +extern unsigned long saved_rdi;
>  
>  /* routines for saving/restoring kernel state */
>  extern int acpi_save_state_mem(void);
> _

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
