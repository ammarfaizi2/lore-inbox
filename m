Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267964AbTBMFFg>; Thu, 13 Feb 2003 00:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267965AbTBMFFg>; Thu, 13 Feb 2003 00:05:36 -0500
Received: from dp.samba.org ([66.70.73.150]:63910 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267964AbTBMFFe>;
	Thu, 13 Feb 2003 00:05:34 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
       ak@suse.de
Subject: Re: Kill SHOUTING in kernel/io_apic.c 
In-reply-to: Your message of "Mon, 10 Feb 2003 17:37:26 BST."
             <20030210163726.GA1115@elf.ucw.cz> 
Date: Thu, 13 Feb 2003 13:58:29 +1100
Message-Id: <20030213051525.0F7682C04B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030210163726.GA1115@elf.ucw.cz> you write:
> Hi!
> 
> That source is shouting WAY TOO MUCH. Please apply,

Either you can make unexpected_IO_APIC static, or your patch missed a
caller.

In fact, grep reveals the former.  x86_64, too.

> 								Pavel
> 
> --- clean/arch/i386/kernel/io_apic.c	2003-01-17 23:13:33.000000000 +0100
> +++ linux-swsusp/arch/i386/kernel/io_apic.c	2003-01-19 19:46:51.000000000 +
0100
> @@ -824,7 +824,7 @@
>  	enable_8259A_irq(0);
>  }
>  
> -void __init UNEXPECTED_IO_APIC(void)
> +void __init unexpected_IO_APIC(void)
>  {
>  	printk(KERN_WARNING " WARNING: unexpected IO-APIC, please mail\n");
>  	printk(KERN_WARNING "          to linux-smp@vger.kernel.org\n");
> @@ -865,7 +865,7 @@
>  	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", reg_00.delivery_t
ype);
>  	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.LTS);
>  	if (reg_00.__reserved_0 || reg_00.__reserved_1 || reg_00.__reserved_2)
> -		UNEXPECTED_IO_APIC();
> +		unexpected_IO_APIC();
>  
>  	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
>  	printk(KERN_DEBUG ".......     : max redirection entries: %04X\n", reg_
01.entries);
> @@ -877,7 +877,7 @@
>  		(reg_01.entries != 0x2E) &&
>  		(reg_01.entries != 0x3F)
>  	)
> -		UNEXPECTED_IO_APIC();
> +		unexpected_IO_APIC();
>  
>  	printk(KERN_DEBUG ".......     : PRQ implemented: %X\n", reg_01.PRQ);
>  	printk(KERN_DEBUG ".......     : IO APIC version: %04X\n", reg_01.versi
on);
> @@ -887,15 +887,15 @@
>  		(reg_01.version != 0x13) && /* Xeon IO-APICs */
>  		(reg_01.version != 0x20)    /* Intel P64H (82806 AA) */
>  	)
> -		UNEXPECTED_IO_APIC();
> +		unexpected_IO_APIC();
>  	if (reg_01.__reserved_1 || reg_01.__reserved_2)
> -		UNEXPECTED_IO_APIC();
> +		unexpected_IO_APIC();
>  
>  	if (reg_01.version >= 0x10) {
>  		printk(KERN_DEBUG ".... register #02: %08X\n", *(int *)&reg_02)
;
>  		printk(KERN_DEBUG ".......     : arbitration: %02X\n", reg_02.a
rbitration);
>  		if (reg_02.__reserved_1 || reg_02.__reserved_2)
> -			UNEXPECTED_IO_APIC();
> +			unexpected_IO_APIC();
>  	}
>  
>  	printk(KERN_DEBUG ".... IRQ redirection table:\n");
> 
> -- 
> Worst form of spam? Adding advertisment signatures ala sourceforge.net.
> What goes next? Inserting advertisment *into* email?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
