Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUHITkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUHITkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266893AbUHITkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:40:05 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7143 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266891AbUHITh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:37:56 -0400
Date: Mon, 9 Aug 2004 21:37:48 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc3-mm2 inlining failures.
Message-ID: <20040809193748.GV26174@fs.tum.de>
References: <20040809183201.GC19195@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809183201.GC19195@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 07:32:01PM +0100, Dave Jones wrote:
> arch/i386/mach-generic/summit.c: In function `send_IPI_all':
> include/asm/mach-summit/mach_ipi.h:4: sorry, unimplemented: inlining failed in call to 'send_IPI_mask_sequence': function body not available
> arch/i386/mach-generic/summit.c:8: sorry, unimplemented: called from here
> make[1]: *** [arch/i386/mach-generic/summit.o] Error 1
> make: *** [arch/i386/mach-generic] Error 2
>...
> gcc version 3.4.1 20040714 (Red Hat 3.4.1-7)
> 
> 
> --- linux-2.6.7/include/asm/mach-summit/mach_ipi.h~	2004-08-09 19:30:02.639882888 +0100
> +++ linux-2.6.7/include/asm/mach-summit/mach_ipi.h	2004-08-09 19:30:07.432154352 +0100
> @@ -1,7 +1,7 @@
>  #ifndef __ASM_MACH_IPI_H
>  #define __ASM_MACH_IPI_H
>  
> -inline void send_IPI_mask_sequence(cpumask_t mask, int vector);
> +void send_IPI_mask_sequence(cpumask_t mask, int vector);
>  
>  static inline void send_IPI_mask(cpumask_t mask, int vector)
>  {
>...

I assume removing the inline from the actual function in 
arch/i386/kernel/smp.c is also required for correctness?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

