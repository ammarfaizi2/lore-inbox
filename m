Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUKQDnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUKQDnA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 22:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbUKQDm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 22:42:59 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:41090 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262194AbUKQDm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 22:42:57 -0500
Message-ID: <419AC8BD.40302@yahoo.com.au>
Date: Wed, 17 Nov 2004 14:42:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, dhowells@redhat.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Making compound pages mandatory
References: <2315.1100630906@redhat.com>	<Pine.LNX.4.58.0411161746110.2222@ppc970.osdl.org> <20041116182841.4ff7f2e5.akpm@osdl.org> <419AC1C6.4050403@yahoo.com.au> <419AC3E7.9010904@yahoo.com.au> <419AC783.5040909@yahoo.com.au>
In-Reply-To: <419AC783.5040909@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> -static inline void get_page(struct page *page)
> -{
> -	atomic_inc(&page->_count);
> -}
> -
> +void put_compound_page(struct page *page);
>  static inline void put_page(struct page *page)
>  {
> +	if (unlikely(PageCompound(page)))
> +		put_compound_page(page);
===>		return;
===>	}
>  	if (!PageReserved(page) && put_page_testzero(page))
>  		__page_cache_release(page);
>  }

... and that's something close to what it should look like.
Sorry, not having a good day today :\

Ignoring me might be the best option.
