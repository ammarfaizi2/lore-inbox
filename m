Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314405AbSDRS2u>; Thu, 18 Apr 2002 14:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314407AbSDRS2t>; Thu, 18 Apr 2002 14:28:49 -0400
Received: from imladris.infradead.org ([194.205.184.45]:28946 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314405AbSDRS2r>; Thu, 18 Apr 2002 14:28:47 -0400
Date: Thu, 18 Apr 2002 19:28:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patricia Gaughen <gone@us.ibm.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modularization of mem_init() for 2.4.19pre7
Message-ID: <20020418192829.A14979@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patricia Gaughen <gone@us.ibm.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
In-Reply-To: <200204181817.g3IIHMM02913@w-gaughen.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 11:17:22AM -0700, Patricia Gaughen wrote:
> -void __init mem_init(void)
> +void __init init_one_highpage(struct page *page, int pfn, int bad_ppro)
> +{
> +	if (!page_is_ram(pfn)) {
> +		SetPageReserved(page);
> +		return;
> +	}
> +	
> +	if (bad_ppro && page_kills_ppro(pfn))
> +	{
> +		SetPageReserved(page);
> +		return;
> +	}

I'd suggest to stay with one coding style.  Prefferedly that would be
the one in Documentation/CodingStyle.

> +
> +	reservedpages = 0;
> +	for (pfn = 0; pfn < max_low_pfn; pfn++)
> +		/*
> +		 * Only count reserved RAM pages
> +		 */
> +		if (page_is_ram(pfn) && PageReserved(mem_map+pfn))
> +			reservedpages++;

Adding braces around this hughe loop body would make it a little
more readable..

Besides these minor style nitpicks the pages look good to me.

BTW: Where is the NUMA code that builds ontop of this?

	Christoph

