Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbUBUOQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 09:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbUBUOQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 09:16:29 -0500
Received: from gprs154-206.eurotel.cz ([160.218.154.206]:63616 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261559AbUBUOQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 09:16:19 -0500
Date: Sat, 21 Feb 2004 15:16:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: kernel/microcode.c error from new 64bit code
Message-ID: <20040221141608.GB310@elf.ucw.cz>
References: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net> <Pine.LNX.4.58.0402181502260.18038@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402181502260.18038@home.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In the mad rush to put in Intel 64 bit support, did anyone make sure and not
> > break the 32 bit build?
> 
> Heh. Somebody has the driver enabled ;).
> 
> How about this patch?
> 
> 		Linus
> 
> ---
> ===== arch/i386/kernel/microcode.c 1.24 vs edited =====
> --- 1.24/arch/i386/kernel/microcode.c	Tue Feb 17 18:14:37 2004
> +++ edited/arch/i386/kernel/microcode.c	Wed Feb 18 15:05:38 2004
> @@ -371,8 +371,9 @@
>  	spin_lock_irqsave(&microcode_update_lock, flags);          
>  
>  	/* write microcode via MSR 0x79 */
> -	wrmsr(MSR_IA32_UCODE_WRITE, (u64)(uci->mc->bits), 
> -	      (u64)(uci->mc->bits) >> 32);
> +	wrmsr(MSR_IA32_UCODE_WRITE,
> +		(unsigned long) uci->mc->bits, 
> +		(unsigned long) uci->mc->bits >> 16 >> 16);
				             ~~~~~~~~~~~~

I see what you are doing, but this is evil. At least comment /* ">> 32"
is undefined on i386 */ ?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
