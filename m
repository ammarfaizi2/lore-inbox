Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263986AbSLWLrF>; Mon, 23 Dec 2002 06:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbSLWLrF>; Mon, 23 Dec 2002 06:47:05 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7172 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263986AbSLWLrE>;
	Mon, 23 Dec 2002 06:47:04 -0500
Date: Sat, 21 Dec 2002 13:01:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ducrot Bruno <poup@poupinou.org>
Cc: Pavel Machek <pavel@suse.cz>, "Grover, Andrew" <andrew.grover@intel.com>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] [PATCH] acpi_wakeup fixes
Message-ID: <20021221120101.GA1371@zaurus>
References: <20021217202142.GB1012@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021217202142.GB1012@poup.poupinou.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> @@ -41,7 +41,7 @@
>  	cmpl	_0x12345678, %eax
>  	jne	bogus_real_magic
>  
> -#if 1
> +#if 0
>  	lcall   _0xc000,_3
>  #endif
>  #if 0

We should make this runtime configurable...

Anyway disabling this is probably right.

> @@ -69,8 +69,12 @@
>  
>  	movl	real_save_cr0 - wakeup_code, %eax
>  	movl	%eax, %cr0
> +
> +	# flush the prefetch queue.
>  	jmp 1f
> +1:	jmp 1f
>  1:

Is this really neccessary? One jump should be
ok...

> @@ -160,11 +164,12 @@
>  	ALIGN
>  
>  
> -.org	0x2000
> +.org	0x800
>  wakeup_stack:
> -.org	0x3000
> +.org	0x900
>  ENTRY(wakeup_end)
> -.org	0x4000
> +# .org	0x1000
> +	.align 4096

Kill the comment, otherwise ok.

>  wakeup_pmode_return:
>  	movl	___KERNEL_DS, %eax


-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

