Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVCXVkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVCXVkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVCXVkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:40:09 -0500
Received: from fire.osdl.org ([65.172.181.4]:57069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261719AbVCXVj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:39:56 -0500
Date: Thu, 24 Mar 2005 13:39:54 -0800
From: cliff white <cliffw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm2 - ppc32 build fails.
Message-ID: <20050324133954.6d947350@es175>
In-Reply-To: <20050324122808.72f622cd.akpm@osdl.org>
References: <20050324110233.55b5053a@es175>
	<20050324122808.72f622cd.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 12:28:08 -0800
Andrew Morton <akpm@osdl.org> wrote:

> cliff white <cliffw@osdl.org> wrote:
> >
> > 
> > Error message:
> > 
> >   CC      arch/ppc/kernel/setup.o
> > In file included from arch/ppc/kernel/setup.c:43:
> > include/asm/ppc_sys.h:29:2: #error "need definition of ppc_sys_devices"
> > In file included from arch/ppc/kernel/setup.c:43:
> > include/asm/ppc_sys.h:61: warning: parameter has incomplete type
> > include/asm/ppc_sys.h:64: warning: parameter has incomplete type
> 
> This should fix it.

Fixes that problem, now i hit the kernel OOPS at drm initalization. 
Thought i saw a patch somewhere already for that...
cliffw

> 
> 
> From: Kumar Gala <galak@freescale.com>
> 
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  25-akpm/arch/ppc/kernel/setup.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff -puN arch/ppc/kernel/setup.c~ppc32-report-chipset-version-in-common-proc-cpuinfo-handling-fix arch/ppc/kernel/setup.c
> --- 25/arch/ppc/kernel/setup.c~ppc32-report-chipset-version-in-common-proc-cpuinfo-handling-fix	2005-03-24 12:27:39.000000000 -0800
> +++ 25-akpm/arch/ppc/kernel/setup.c	2005-03-24 12:27:39.000000000 -0800
> @@ -40,7 +40,10 @@
>  #include <asm/nvram.h>
>  #include <asm/xmon.h>
>  #include <asm/ocp.h>
> +
> +#if defined(CONFIG_85xx) || defined(CONFIG_83xx)
>  #include <asm/ppc_sys.h>
> +#endif
>  
>  #if defined CONFIG_KGDB
>  #include <asm/kgdb.h>
> @@ -247,7 +250,7 @@ int show_cpuinfo(struct seq_file *m, voi
>  	seq_printf(m, "bogomips\t: %lu.%02lu\n",
>  		   lpj / (500000/HZ), (lpj / (5000/HZ)) % 100);
>  
> -#if defined (CONFIG_85xx) || defined (CONFIG_83xx)
> +#if defined(CONFIG_85xx) || defined(CONFIG_83xx)
>  	if (cur_ppc_sys_spec->ppc_sys_name)
>  		seq_printf(m, "chipset\t\t: %s\n",
>  			cur_ppc_sys_spec->ppc_sys_name);
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
"Ive always gone through periods where I bolt upright at four in the morning; 
now at least theres a reason." -Michael Feldman
