Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWCUVor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWCUVor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWCUVor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:44:47 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:41892 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750764AbWCUVoq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:44:46 -0500
Subject: Re: [PATCH][5/8] proc: export mlocked pages info through
	"/proc/meminfo: Wired"
From: Dave Hansen <haveblue@us.ibm.com>
To: Stone Wang <pwstone@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>
References: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 13:43:12 -0800
Message-Id: <1142977393.10906.204.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 08:37 -0500, Stone Wang wrote:
> --- linux-2.6.15.orig/include/linux/mm.h        2006-01-02 22:21:10.000000000 -0500
> +++ linux-2.6.15/include/linux/mm.h     2006-03-07 01:49:12.000000000 -0500
> @@ -218,6 +221,10 @@
>         unsigned long flags;            /* Atomic flags, some possibly
>                                          * updated asynchronously */
>         atomic_t _count;                /* Usage count, see below. */
> +       unsigned short wired_count; /* Count of wirings of the page.
> +                                        * If not zero,the page would be SetPageWired,
> +                                        * and put on Wired list of the zone.
> +                                        */
>         atomic_t _mapcount;             /* Count of ptes mapped in mms,
>                                          * to show when page is mapped
>                                          * & limit reverse map searches. 

We're usually pretty picky about adding stuff to 'struct page'.  It
_just_ fits inside a cacheline on most 32-bit architectures.  

Can this wired_count not be derived at runtime?  It seems like it would
be possible to run through all VMAs mapping the page, and determining
how many of them are VM_LOCKED.  Would that be too slow?

Also, does it matter how many times it is locked, or just that
_somebody_ has it locked?  

-- Dave

