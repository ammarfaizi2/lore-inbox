Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWJVVQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWJVVQK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 17:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWJVVQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 17:16:09 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:25769 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750749AbWJVVQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 17:16:08 -0400
Date: Sun, 22 Oct 2006 17:16:05 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Amit Choudhary <amit2030@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.19-rc2] mm/slab.c: check kmalloc() return value.
Message-ID: <20061022211605.GA19617@filer.fsl.cs.sunysb.edu>
References: <20061022133751.5f1d8281.amit2030@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061022133751.5f1d8281.amit2030@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 01:37:51PM -0700, Amit Choudhary wrote:
> Description: Check the return value of kmalloc() in function setup_cpu_cache(), in file mm/slab.c.
> 
> Signed-off-by: Amit Choudhary <amit2030@gmail.com>
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 84c631f..613ae61 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2021,6 +2021,7 @@ static int setup_cpu_cache(struct kmem_c
>  	} else {
>  		cachep->array[smp_processor_id()] =
>  			kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
> +		BUG_ON(!cachep->array[smp_processor_id()]);
>  
>  		if (g_cpucache_up == PARTIAL_AC) {
>  			set_up_list3s(cachep, SIZE_L3);

Any reason to BUG instead of trying to return as gracefully as possible?

Josef "Jeff" Sipek.

-- 
My public GPG key can be found at
http://www.josefsipek.net/gpg/public-0xC7958FFE.txt
