Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269006AbUI2URe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269006AbUI2URe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269007AbUI2URe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:17:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:58577 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269006AbUI2UR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:17:29 -0400
Date: Wed, 29 Sep 2004 22:15:25 +0200
From: Andi Kleen <ak@suse.de>
To: Olaf Hering <olh@suse.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  allow CONFIG_NET=n on ppc64
Message-ID: <20040929201524.GA14615@wotan.suse.de>
References: <20040929200158.GA16366@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929200158.GA16366@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 10:01:58PM +0200, Olaf Hering wrote:
> 
> The attached minimal config does not compile on ppc64.
> I was able to boot the resulting binary with this patch.

I already fixed this some time ago, but the patch must have disappeared.

> diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.9-rc2/arch/ppc64/kernel/misc.S linux-2.6.9-rc2.ppc64/arch/ppc64/kernel/misc.S
> --- linux-2.6.9-rc2/arch/ppc64/kernel/misc.S	2004-09-13 07:33:23.000000000 +0200
> +++ linux-2.6.9-rc2.ppc64/arch/ppc64/kernel/misc.S	2004-09-29 21:00:44.909074755 +0200
> @@ -703,7 +703,11 @@ _GLOBAL(sys_call_table32)
>  	.llong .compat_sys_statfs
>  	.llong .compat_sys_fstatfs		/* 100 */
>  	.llong .sys_ni_syscall		/* old ioperm syscall */
> +#ifdef CONFIG_NET
>  	.llong .compat_sys_socketcall
> +#else
> +	.llong .sys_ni_syscall		/* old ioperm syscall */
> +#endif

Right fix is to declare compat_sys_socketcall as as cond_syscall() 
in sys.c

-Andi
