Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277437AbRJEQLm>; Fri, 5 Oct 2001 12:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277436AbRJEQLc>; Fri, 5 Oct 2001 12:11:32 -0400
Received: from smtp.mediascape.net ([212.105.192.20]:43783 "EHLO
	smtp.mediascape.net") by vger.kernel.org with ESMTP
	id <S277471AbRJEQLN>; Fri, 5 Oct 2001 12:11:13 -0400
Message-ID: <3BBDDB58.850F966@mediascape.de>
Date: Fri, 05 Oct 2001 18:10:00 +0200
From: Olaf Zaplinski <o.zaplinski@mediascape.de>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FIX] Compiler error on linux-2.4.11-pre4/arch/i386/kernel/mpparse.c
In-Reply-To: <20011005172652.C3260@walker.iti.informatik.tu-darmstadt.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Matthias Hahn wrote:
> 
> Hello LKML!
> 
> patch-2.4.11-pre4 adds the following lines to include/acm-i386/smp.h:90
> +#ifndef clustered_apic_mode
> + #ifdef CONFIG_MULTIQUAD
> +  #define clustered_apic_mode (1)
> +  #define esr_disable (1)
> + #else /* !CONFIG_MULTIQUAD */
> +  #define clustered_apic_mode (0)
> +  #define esr_disable (0)
> + #endif /* CONFIG_MULTIQUAD */
> +#endif
> 
> which don't get included when compiling for non-SMP. Move those lines up
> before
> line 37 with "#ifdef CONFIG_SMP" and compiling should work again.

No, this does not help... :-(

gcc -D__KERNEL__ -I/usr/src/linux-2.4.11-pre4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o io_apic.o io_apic.c
io_apic.c: In function `setup_IO_APIC_irqs':
io_apic.c:601: `INT_DELIVERY_MODE' undeclared (first use in this function)
io_apic.c:601: (Each undeclared identifier is reported only once
io_apic.c:601: for each function it appears in.)
io_apic.c: In function `setup_ExtINT_IRQ0_pin':
io_apic.c:675: `INT_DELIVERY_MODE' undeclared (first use in this function)
make[1]: *** [io_apic.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.11-pre4/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2


Olaf
