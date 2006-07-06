Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWGFWjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWGFWjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWGFWjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:39:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:57318 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750831AbWGFWjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:39:36 -0400
Subject: Re: [PATCH 38 of 39] IB/ipath - More changes to support InfiniPath
	on PowerPC 970 systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <c22b6c244d5db77f7b1d.1151617289@eng-12.pathscale.com>
References: <c22b6c244d5db77f7b1d.1151617289@eng-12.pathscale.com>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 08:37:01 +1000
Message-Id: <1152225421.9862.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +#if defined(__powerpc__)
> +	/* There isn't a generic way to specify writethrough mappings */
> +	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
> +	pgprot_val(vma->vm_page_prot) |= _PAGE_WRITETHRU;
> +	pgprot_val(vma->vm_page_prot) &= ~_PAGE_GUARDED;
> +#endif

I don't see any case where having both NO_CACHE and WRITE_THRU can be
legal... It's one or the other.

> +/**
> + * ipath_unordered_wc - indicate whether write combining is ordered
> + *
> + * PowerPC systems (at least those in the 970 processor family)
> + * write partially filled store buffers in address order, but will write
> + * completely filled store buffers in "random" order, and therefore must
> + * have serialization for correctness with current InfiniPath chips.
> + *
> + */
> +int ipath_unordered_wc(void)
> +{
> +	return 1;
> +}

How is the above providing any kind of serialisation ?

Ben.


