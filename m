Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVG3Kch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVG3Kch (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 06:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbVG3Kcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 06:32:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5531 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261189AbVG3KcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 06:32:18 -0400
Date: Sat, 30 Jul 2005 12:32:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name
Subject: Re: [PATCH] 2/6 i386 serialize-msr
Message-ID: <20050730103207.GD1942@elf.ucw.cz>
References: <200507300404.j6U44GSC005922@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507300404.j6U44GSC005922@zach-dev.vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> i386 arch cleanup.  Introduce the serialize macro to serialize processor state.
> Why the microcode update needs it I am not quite sure, since wrmsr() is already
> a serializing instruction, but it is a microcode update, so I will keep the
> semantic the same, since this could be a timing workaround.  As far as I can
> tell, this has always been there since the original microcode update
> source.

Can we get better name, like "serialize_cpu()"?
									Pavel

> Signed-off-by: Zachary Amsden <zach@vmware.com>
> 
> Index: linux-2.6.13/arch/i386/kernel/microcode.c
> ===================================================================
> --- linux-2.6.13.orig/arch/i386/kernel/microcode.c	2005-07-29 11:14:33.000000000 -0700
> +++ linux-2.6.13/arch/i386/kernel/microcode.c	2005-07-29 11:16:18.000000000 -0700
> @@ -164,7 +164,8 @@
>  	}
>  
>  	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
> -	__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
> +	/* XXX needed? wrmsr should serialize unless a chip bug */
> +	serialize(); 
>  	/* get the current revision from MSR 0x8B */
>  	rdmsr(MSR_IA32_UCODE_REV, val[0], uci->rev);
>  	pr_debug("microcode: collect_cpu_info : sig=0x%x, pf=0x%x, rev=0x%x\n",

-- 
teflon -- maybe it is a trademark, but it should not be.
