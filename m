Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbTJYUKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 16:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbTJYUKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 16:10:25 -0400
Received: from gprs198-24.eurotel.cz ([160.218.198.24]:40577 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262790AbTJYUKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 16:10:19 -0400
Date: Sat, 25 Oct 2003 22:10:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH 2.4.23-pre8]  Remove broken prefetching in free_one_pgd()
Message-ID: <20031025201010.GC505@elf.ucw.cz>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0F36E6@scsmsx401.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0F36E6@scsmsx401.sc.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch was accepted into 2.5.55, attributed to "davej@uk".

Dave Jones?n

> This code will prefetch from beyond the end of the page table
> being cleared ... which is clearly a bad thing if the page table
> in question is allocated from the last page of memory (or precedes
> a hole on a discontig mem system).

Prefetching random addresses should be safe... Well for 2.4 we
probably want to play it safe and kill it, but I guess quite a few
pieces rely on prefretch(NULL) doing nothing...


> diff -ru linux-2.4.23-pre8/mm/memory.c fix/mm/memory.c
> --- linux-2.4.23-pre8/mm/memory.c	Fri Oct 24 13:37:23 2003
> +++ fix/mm/memory.c	Fri Oct 24 13:40:47 2003
> @@ -120,10 +120,8 @@
>  	}
>  	pmd = pmd_offset(dir, 0);
>  	pgd_clear(dir);
> -	for (j = 0; j < PTRS_PER_PMD ; j++) {
> -		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
> +	for (j = 0; j < PTRS_PER_PMD ; j++)
>  		free_one_pmd(pmd+j);
> -	}
>  	pmd_free(pmd);
>  }


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
