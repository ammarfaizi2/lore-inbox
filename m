Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSKMUfC>; Wed, 13 Nov 2002 15:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbSKMUfC>; Wed, 13 Nov 2002 15:35:02 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:13471 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S262506AbSKMUfB>;
	Wed, 13 Nov 2002 15:35:01 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Pavel Machek <pavel@ucw.cz>
Date: Wed, 13 Nov 2002 21:41:43 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: swsusp for 2.5.47 [not for inclusion]
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <76C83295DE1@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Nov 02 at 22:51, Pavel Machek wrote:

> This is patch I'm using. With this swsusp in 2.5.47 should work.
> 
> --- clean/arch/i386/kernel/Makefile 2002-11-12 18:40:26.000000000 +0100
> +++ linux-swsusp/arch/i386/kernel/Makefile  2002-11-12 22:22:53.000000000 +0100
> @@ -24,7 +24,7 @@
>  obj-$(CONFIG_X86_MPPARSE)  += mpparse.o
>  obj-$(CONFIG_X86_LOCAL_APIC)   += apic.o nmi.o
>  obj-$(CONFIG_X86_IO_APIC)  += io_apic.o
> -obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
> +obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o suspend_asm.o
>  obj-$(CONFIG_X86_NUMAQ)        += numaq.o
>  obj-$(CONFIG_PROFILING)        += profile.o
>  obj-$(CONFIG_EDD)              += edd.o

With 2.5.47-bk-current, your patch is apparently included.

I had to modify this Makefile (in 2.5.47-bk) to include suspend.o 
unconditionally because of saved_* is declared here, and they are 
needed by ACPI. Of course, it is also possible to do

obj-$(CONFIG_ACPI_SLEEP) += acpi_wakeup.o suspend.o

instead of linking suspend.o unconditionally, but I did not tested it.
                                    Best regards,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
