Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbUKCXFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbUKCXFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbUKCXCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:02:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:11734 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261954AbUKCXAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:00:55 -0500
Date: Wed, 3 Nov 2004 15:04:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, nathanl@austin.ibm.com, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 mmu_context_init needs to run earlier
Message-Id: <20041103150438.05d6c913.akpm@osdl.org>
In-Reply-To: <16775.5912.788675.644838@cargo.ozlabs.ibm.com>
References: <16775.5912.788675.644838@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> This patch is from Nathan Lynch <nathanl@austin.ibm.com>.
> 
> This patch changes mmu_context_init to be called as a core_initcall
> rather than an arch_initcall, since mmu_context_init needs to run
> before we try to run any userspace processes, and arch_initcall was
> found to be too late.
> 

This all seemed to peter out.  Did we end up with a more convincing patch?

> 
> diff -puN arch/ppc64/mm/init.c~ppc64-make-mmu_context_init-core_initcall arch/ppc64/mm/init.c
> --- linux-2.6.10-rc1-bk11/arch/ppc64/mm/init.c~ppc64-make-mmu_context_init-core_initcall	2004-11-01 19:51:46.000000000 -0600
> +++ linux-2.6.10-rc1-bk11-nathanl/arch/ppc64/mm/init.c	2004-11-01 19:53:24.000000000 -0600
> @@ -529,7 +529,7 @@ static int __init mmu_context_init(void)
>  
>  	return 0;
>  }
> -arch_initcall(mmu_context_init);
> +core_initcall(mmu_context_init);
>  
>  /*
>   * Do very early mm setup.
