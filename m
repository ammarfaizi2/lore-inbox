Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVDSJ4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVDSJ4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 05:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVDSJ4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 05:56:04 -0400
Received: from relay.rost.ru ([80.254.111.11]:13466 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S261437AbVDSJzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 05:55:51 -0400
Date: Tue, 19 Apr 2005 13:55:43 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: cleanup boot_cpu_logical_apicid variables
Message-ID: <20050419095543.GA10555@pazke>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20050415143529.GC5456@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050415143529.GC5456@stusta.de>
X-Uname: Linux 2.6.12-rc2-mm1-pazke i686
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 105, 04 15, 2005 at 04:35:29PM +0200, Adrian Bunk wrote:
> There are currently two different boot_cpu_logical_apicid variables:
> - a global one in mpparse.c
> - a static one in smpboot.c
> 
> Of these two, only the one in smpboot.c might be used (through 
> boot_cpu_apicid).
> 
> This patch therefore removes the one in mpparse.c .
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Looks good. For the visws part:

Signed-off-by: Andrey Panin <pazke@donpac.ru>

> ---
> 
>  arch/i386/kernel/mpparse.c     |    2 --
>  arch/i386/mach-visws/mpparse.c |    5 +----
>  2 files changed, 1 insertion(+), 6 deletions(-)
> 
> --- linux-2.6.12-rc2-mm3-full/arch/i386/kernel/mpparse.c.old	2005-04-15 14:21:41.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/arch/i386/kernel/mpparse.c	2005-04-15 14:22:00.000000000 +0200
> @@ -67,7 +67,6 @@
>  
>  /* Processor that is doing the boot up */
>  unsigned int boot_cpu_physical_apicid = -1U;
> -unsigned int boot_cpu_logical_apicid = -1U;
>  /* Internal processor count */
>  static unsigned int __initdata num_processors;
>  
> @@ -180,7 +179,6 @@
>  	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
>  		Dprintk("    Bootup CPU\n");
>  		boot_cpu_physical_apicid = m->mpc_apicid;
> -		boot_cpu_logical_apicid = apicid;
>  	}
>  
>  	if (num_processors >= NR_CPUS) {
> --- linux-2.6.12-rc2-mm3-full/arch/i386/mach-visws/mpparse.c.old	2005-04-15 14:22:10.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/arch/i386/mach-visws/mpparse.c	2005-04-15 14:22:27.000000000 +0200
> @@ -23,7 +23,6 @@
>  
>  /* Processor that is doing the boot up */
>  unsigned int boot_cpu_physical_apicid = -1U;
> -unsigned int boot_cpu_logical_apicid = -1U;
>  
>  /* Bitmask of physically existing CPUs */
>  physid_mask_t phys_cpu_present_map;
> @@ -52,10 +51,8 @@
>  		(m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
>  		m->mpc_apicver);
>  
> -	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
> +	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR)
>  		boot_cpu_physical_apicid = m->mpc_apicid;
> -		boot_cpu_logical_apicid = logical_apicid;
> -	}
>  
>  	ver = m->mpc_apicver;
>  	if ((ver >= 0x14 && m->mpc_apicid >= 0xff) || m->mpc_apicid >= 0xf) {
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net
