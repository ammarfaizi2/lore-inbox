Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbTIHHkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 03:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbTIHHkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 03:40:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4104 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262079AbTIHHkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 03:40:13 -0400
Date: Mon, 8 Sep 2003 08:40:09 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] asm-arm/tlbflush.h needs some extra headers
Message-ID: <20030908084009.A1092@flint.arm.linux.org.uk>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0309080026100.14426@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0309080026100.14426@montezuma.fsmlabs.com>; from zwane@linuxpower.ca on Mon, Sep 08, 2003 at 12:40:02AM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 12:40:02AM -0400, Zwane Mwaikambo wrote:
> I got this whilst building for an SA1100
> 
> In file included from arch/arm/kernel/setup.c:31:
> include/asm/tlbflush.h: In function `flush_tlb_mm':
> include/asm/tlbflush.h:261: warning: implicit declaration of function `ASID'
> include/asm/tlbflush.h:267: `current' undeclared (first use in this function)
> include/asm/tlbflush.h:267: (Each undeclared identifier is reported only once
> include/asm/tlbflush.h:267: for each function it appears in.)
> include/asm/tlbflush.h: In function `flush_tlb_page':
> include/asm/tlbflush.h:292: dereferencing pointer to incomplete type
> include/asm/tlbflush.h:297: dereferencing pointer to incomplete type
> include/asm/tlbflush.h:297: `current' undeclared (first use in this function)
> arch/arm/kernel/setup.c: In function `request_standard_resources':
> arch/arm/kernel/setup.c:437: `init_mm' undeclared (first use in this function)
> arch/arm/kernel/setup.c: In function `setup_arch':
> arch/arm/kernel/setup.c:690: `init_mm' undeclared (first use in this function)
> make[1]: *** [arch/arm/kernel/setup.o] Error 1

Hmm, does akpm's -mm6 patch contain any header file cleanups?  I know
this file built in Linus' bk tree last night, although this wasn't
for SA1100.

Can you check whether arch/arm/kernel/setup.c includes asm/cacheflush.h
just before asm/tlbflush.h (which is a recent fix which went into Linus'
tree recently.)

> Index: linux-2.6.0-test4-mm6-arm/include/asm-arm/tlbflush.h
> ===================================================================
> RCS file: /build/cvsroot/linux-2.6.0-test4-mm6/include/asm-arm/tlbflush.h,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 tlbflush.h
> --- linux-2.6.0-test4-mm6-arm/include/asm-arm/tlbflush.h	7 Sep 2003 20:27:38 -0000	1.1.1.1
> +++ linux-2.6.0-test4-mm6-arm/include/asm-arm/tlbflush.h	8 Sep 2003 03:34:33 -0000
> @@ -11,7 +11,9 @@
>  #define _ASMARM_TLBFLUSH_H
>  
>  #include <linux/config.h>
> +#include <linux/mm.h>
>  #include <asm/glue.h>
> +#include <asm/mmu.h>
>  
>  #define TLB_V3_PAGE	(1 << 0)
>  #define TLB_V4_U_PAGE	(1 << 1)

I certainly don't like adding linux/mm.h to tlbflush.h - that seems
like a recipe for disaster.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
