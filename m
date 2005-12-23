Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbVLWCSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbVLWCSP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 21:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbVLWCSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 21:18:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53768 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030379AbVLWCSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 21:18:14 -0500
Date: Fri, 23 Dec 2005 03:18:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: remove incorrect dependancy on CONFIG_APM
Message-ID: <20051223021813.GH27525@stusta.de>
References: <20051220212127.GA6833@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220212127.GA6833@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 04:21:27PM -0500, Dave Jones wrote:
> 
> >From the PM_LEGACY Kconfig description..
> 
> "Support for pm_register() and friends."
> 
> Note, no mention of 'make apm stop working'.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6.14/arch/i386/Kconfig~	2005-12-20 16:19:17.000000000 -0500
> +++ linux-2.6.14/arch/i386/Kconfig	2005-12-20 16:19:21.000000000 -0500
> @@ -710,7 +710,7 @@ depends on PM && !X86_VISWS
>  
>  config APM
>  	tristate "APM (Advanced Power Management) BIOS support"
> -	depends on PM && PM_LEGACY
> +	depends on PM
>...

This doesn't compile:

<--  snip  -->

...
  CC      arch/i386/kernel/apm.o
arch/i386/kernel/apm.c: In function 'apm_init':
arch/i386/kernel/apm.c:2304: error: 'pm_active' undeclared (first use in this function)
arch/i386/kernel/apm.c:2304: error: (Each undeclared identifier is reported only once
arch/i386/kernel/apm.c:2304: error: for each function it appears in.)
arch/i386/kernel/apm.c: In function 'apm_exit':
arch/i386/kernel/apm.c:2410: error: 'pm_active' undeclared (first use in this function)
make[1]: *** [arch/i386/kernel/apm.o] Error 1

<--  snip  -->


If PM_LEGACY causes user confusion for APM users, commit 
bca73e4bf8563d83f7856164caa44d5f42e44cca should be reverted.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

