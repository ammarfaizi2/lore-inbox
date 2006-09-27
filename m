Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030872AbWI0VVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030872AbWI0VVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030871AbWI0VVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:21:47 -0400
Received: from nwd2mail10.analog.com ([137.71.25.55]:20877 "EHLO
	nwd2mail10.analog.com") by vger.kernel.org with ESMTP
	id S1030870AbWI0VVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:21:45 -0400
X-IronPort-AV: i="4.09,226,1157342400"; 
   d="scan'208"; a="12236083:sNHT21747460"
Message-Id: <6.1.1.1.0.20060927170244.01ed18d0@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Wed, 27 Sep 2006 17:22:04 -0400
To: Arnd Bergmann <arnd@arndb.de>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: luke Yang <luke.adi@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd wrote:
>Am Wednesday 27 September 2006 19:19 schrieb Robin Getz:
> > OK - I was just doing the similar thing to what already exists in
> > ./asm-blackfin/system.h
> >
> > #define local_irq_enable() do {         \
> >          __asm__ __volatile__ (          \
> >                  "sti %0;"               \
> >                  ::"d"(irq_flags));      \ } while (0)
> >
> > which could be simplified to:
> >
> > #define local_irq_enable() __asm__ __volatile__ ("sti %0;"
> > ::"d"(irq_flags));
>
>Actually, this one is slightly broken, because of the ';' at the end of 
>the macro (think of "if(x) local_irq_enable(); else somthing_else()").

Ok - the extra ; is a typo in the email - not anything that I was proposing 
as a submission. What you are pointing out is to be _really_ careful when 
doing macros.

I was trying to say was that we are just doing what everyone else seems to 
be doing (which doesn't make it correct or the proper thing to do).

Systems that use macros:
./asm-alpha/system.h:#define local_irq_enable()
./asm-arm26/system.h:#define local_irq_enable()
./asm-arm/system.h:#define local_irq_enable()
./asm-blackfin/system.h:#define local_irq_enable()
./asm-frv/system.h:#define local_irq_enable()
./asm-h8300/system.h:#define local_irq_enable()
./asm-i386/system.h:#define local_irq_enable()
./asm-ia64/system.h:#define local_irq_enable()
./asm-m32r/system.h:#define local_irq_enable()
./asm-m68knommu/system.h:#define local_irq_enable()
./asm-m68k/system.h:#define local_irq_enable()
./asm-parisc/system.h:#define local_irq_enable()
./asm-s390/system.h:#define local_irq_enable()
./asm-sparc64/system.h:#define local_irq_enable()
./asm/system.h:#define local_irq_enable()
./asm-v850/system.h:#define local_irq_enable()
./asm-x86_64/system.h:#define local_irq_enable()
./asm-x86_64/system.h:#define local_irq_enable()

Systems that use static inline:
./asm-m32r/system.h:static inline void local_irq_enable(void)
./asm-sh64/system.h:static __inline__ void local_irq_enable(void)
./asm-sh/system.h:static __inline__ void local_irq_enable(void)
./asm-xtensa/system.h:static inline void local_irq_enable(void)

With the "optimizations" that gcc4 is making with inline being only a 
"suggestion", I think I would prefer to stick with the macro, unless there 
is violent opposition.

As Mike pointed out - we are sheep - we just do what the majority (18/22) 
of other people do.

-Robin
