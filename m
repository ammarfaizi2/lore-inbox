Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbSKOWuU>; Fri, 15 Nov 2002 17:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbSKOWuU>; Fri, 15 Nov 2002 17:50:20 -0500
Received: from mail1.csc.albany.edu ([169.226.1.133]:36284 "EHLO
	smtp.albany.edu") by vger.kernel.org with ESMTP id <S266859AbSKOWuS> convert rfc822-to-8bit;
	Fri, 15 Nov 2002 17:50:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Justin A <ja6447@albany.edu>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.47-ac4 panic on boot.
Date: Fri, 15 Nov 2002 17:59:14 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200211150059.51743.ja6447@albany.edu> <200211151712.11347.ja6447@albany.edu> <3DD5723E.CED7AE1A@digeo.com>
In-Reply-To: <3DD5723E.CED7AE1A@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211151759.14830.ja6447@albany.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok..that worked:

for future reference...what is the important part of the oops so I don't have 
to type the useless parts?

I'm guessing just the Call Trace, which is:

pnpbios_set_resources+0x7c/0x90
pnp_activate_dev+0xe6/0x114
pnp_device_probe+0x33/0xc4
bus_match+0x37/0x5c
driver_attach+0x44/0x74
bus_add_driver+0x60/0x80
driver_register+0x69/0x84
pnp_register_driver+0x29/0x48
init+0x0/0x13c
init+0x1a/0x13c
init+0x0/0x13c
kernel_thread_helper+0x5/0xc
-- 
-Justin

On Friday 15 November 2002 05:16 pm, Andrew Morton wrote:
> Justin A wrote:
> > .config crashes, it oopses as soon as pnp starts, then 2 seconds later
> > the previous oops comes up and it panics.
>
> Irritating when it does that.  Here's a little patch which should
> stop the machine dead after the first ooops, prevent stuff from
> scrolling off the screen.
>
> This, with the missing touch_nmi_watchdog() would be a handy
> kernel boot option, perhaps.
>
>
> --- 25/arch/i386/kernel/traps.c~noscroll	Tue Nov 12 13:13:24 2002
> +++ 25-akpm/arch/i386/kernel/traps.c	Tue Nov 12 13:14:16 2002
> @@ -84,7 +84,7 @@ asmlinkage void alignment_check(void);
>  asmlinkage void spurious_interrupt_bug(void);
>  asmlinkage void machine_check(void);
>
> -static int kstack_depth_to_print = 24;
> +static int kstack_depth_to_print = 10;
>
>
>  /*
> @@ -246,6 +246,9 @@ bad:
>  			printk("%02x ", c);
>  		}
>  	}
> +	local_irq_disable();
> +	for ( ; ; )
> +		;
>  	printk("\n");
>  }
>
>
> _


