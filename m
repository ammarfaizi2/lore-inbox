Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbWJCEjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbWJCEjd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 00:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbWJCEjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 00:39:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:29867 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965155AbWJCEjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 00:39:32 -0400
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
	i386
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Judith Lebzelter <judith@osdl.org>, linuxppc-dev@ozlabs.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20061003012241.GF3278@stusta.de>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
	 <20061002234428.GE3278@stusta.de>  <20061003012241.GF3278@stusta.de>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 14:37:25 +1000
Message-Id: <1159850245.5482.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You might want to convince Andrew accepting my patch to make 
> > virt_to_bus/bus_to_virt give compile warnings on i386 for making
> > people more aware of this problem...
> >...

Andrew, is there any reason not to take that patch ?

> <--  snip  -->
> 
> 
> virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
> on i386.
> 
> Without such warnings people will never update their code and fix 
> the errors in PPC64 builds.
> 
> And yes, some of the drivers affected are maintained.
> 
> This also catches accidential additions of users for these functions 
> like a usage of bus_to_virt() in the infiniband code that was added in 
> 2.6.17-rc1 (already removed).
> 
> This patch increases the number of warnings shown during builds, but it 
> seems worth including it at least in -mm for making people aware of this 
> issue.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 7 Jul 2006
> - 26 Jun 2006
> - 27 Apr 2006
> - 19 Apr 2006
> - 6 Jan 2006
> - 13 Dec 2005
> - 23 Nov 2005
> - 18 Nov 2005
> - 12 Nov 2005
> 
> --- linux-2.6.14-mm2-full/include/asm-i386/io.h.old	2005-11-12 01:44:38.000000000 +0100
> +++ linux-2.6.14-mm2-full/include/asm-i386/io.h	2005-11-12 01:45:58.000000000 +0100
> @@ -144,8 +144,14 @@
>   *
>   * Allow them on x86 for legacy drivers, though.
>   */
> -#define virt_to_bus virt_to_phys
> -#define bus_to_virt phys_to_virt
> +static inline unsigned long __deprecated virt_to_bus(volatile void * address)
> +{
> +	return __pa(address);
> +}
> +static inline void * __deprecated bus_to_virt(unsigned long address)
> +{
> +	return __va(address);
> +}
>  
>  /*
>   * readX/writeX() are used to access memory mapped devices. On some
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

