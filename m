Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWEXOFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWEXOFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 10:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWEXOFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 10:05:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46346 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750804AbWEXOFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 10:05:53 -0400
Date: Thu, 18 May 2006 19:17:00 +0000
From: Pavel Machek <pavel@suse.cz>
To: Don Zickus <dzickus@redhat.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] Allow users to force a panic on NMI
Message-ID: <20060518191700.GC5846@ucw.cz>
References: <20060511214933.GU16561@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060511214933.GU16561@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> To quote Alan Cox:
> 
> The default Linux behaviour on an NMI of either memory or unknown is to
> continue operation. For many environments such as scientific computing
> it is preferable that the box is taken out and the error dealt with than
> an uncorrected parity/ECC error get propogated.

> This is just a refreshed post of Alan's original patch
> <http://www.ussg.iu.edu/hypermail/linux/kernel/0510.2/1208.html>, with
> hopes this time it sticks. :)
> 
> It applies cleanly on top of my other nmi patches.  

> Index: linux-don/arch/i386/kernel/traps.c
> ===================================================================
> --- linux-don.orig/arch/i386/kernel/traps.c
> +++ linux-don/arch/i386/kernel/traps.c
> @@ -602,6 +602,8 @@ static void mem_parity_error(unsigned ch
>  			"to continue\n");
>  	printk(KERN_EMERG "You probably have a hardware problem with your RAM "
>  			"chips\n");
> +	if (panic_on_unrecovered_nmi)
> +                panic("NMI: Not continuing");
>  
>  	/* Clear and disable the memory parity error line. */
>  	clear_mem_error(reason);
> @@ -637,6 +639,10 @@ static void unknown_nmi_error(unsigned c
>  		reason, smp_processor_id());
>  	printk("Dazed and confused, but trying to continue\n");

'Trying to contninue'

>  	printk("Do you have a strange power saving mode enabled?\n");
> +
> +	if (panic_on_unrecovered_nmi)
> +                panic("NMI: Not continuing");
> +

'not really'. Move printks around so it makes sense...

> Index: linux-don/arch/x86_64/kernel/traps.c
> ===================================================================
> --- linux-don.orig/arch/x86_64/kernel/traps.c
> +++ linux-don/arch/x86_64/kernel/traps.c
> @@ -608,6 +608,8 @@ mem_parity_error(unsigned char reason, s
>  {
>  	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
>  	printk("You probably have a hardware problem with your RAM chips\n");
> +	if (panic_on_unrecovered_nmi)
> +               panic("NMI: Not continuing");
>  
>  	/* Clear and disable the memory parity error line. */

same here.

> @@ -633,6 +635,10 @@ unknown_nmi_error(unsigned char reason, 
>  {	printk("Uhhuh. NMI received for unknown reason %02x.\n", reason);
>  	printk("Dazed and confused, but trying to continue\n");
>  	printk("Do you have a strange power saving mode enabled?\n");
> +
> +	if (panic_on_unrecovered_nmi)
> +                panic("NMI: Not continuing");
> +
>  }
>  

and here.

-- 
Thanks for all the (sleeping) penguins.
