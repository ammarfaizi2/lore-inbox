Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVHFBNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVHFBNa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 21:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVHFBNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 21:13:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46270 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262176AbVHFBNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 21:13:11 -0400
Date: Fri, 5 Aug 2005 18:13:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pavel@suse.cz, pratap@vmware.com,
       Riley@Williams.Name
Subject: Re: [PATCH 1/1] i386 Encapsulate copying of pgd entries
Message-ID: <20050806011301.GD7991@shell0.pdx.osdl.net>
References: <200508060026.j760Q6FT025108@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508060026.j760Q6FT025108@zach-dev.vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* zach@vmware.com (zach@vmware.com) wrote:
> +	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
>  	if (PTRS_PER_PMD == 1)
>  		spin_lock_irqsave(&pgd_lock, flags);
>  
> -	memcpy((pgd_t *)pgd + USER_PTRS_PER_PGD,
> +	clone_pgd_range((pgd_t *)pgd + USER_PTRS_PER_PGD,
>  			swapper_pg_dir + USER_PTRS_PER_PGD,
> -			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> -
> +			KERNEL_PGD_PTRS);
>  	if (PTRS_PER_PMD > 1)
>  		return;
>  
>  	pgd_list_add(pgd);
>  	spin_unlock_irqrestore(&pgd_lock, flags);
> -	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));

Why memset was never done on PAE?

thanks,
-chris
