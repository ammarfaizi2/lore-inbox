Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWHTUnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWHTUnf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 16:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWHTUnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 16:43:35 -0400
Received: from 1wt.eu ([62.212.114.60]:60176 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751280AbWHTUne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 16:43:34 -0400
Date: Sun, 20 Aug 2006 22:43:28 +0200
From: Willy Tarreau <w@1wt.eu>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2.4.34-pre1] gcc4 fix for UP sparc64
Message-ID: <20060820204328.GV602@1wt.eu>
References: <200608202018.k7KKIAl4006428@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608202018.k7KKIAl4006428@harpo.it.uu.se>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 10:18:10PM +0200, Mikael Pettersson wrote:
> This patch fixes an invalid-lvalue error when compiling a
> 2.4.34-pre1 kernel on sparc64 with gcc-4.1.1. The kernel
> must be configured with CONFIG_SMP=n for the error to trigger.

It's a fact that I only checked with SMP.

> (I didn't save the error message, sorry.)

No problem, it's self explained.

> A kernel compiled with gcc-4.1.1 boots fine on my Ultra5
> and can rebuild itself, and generally seems no less solid
> than the 2.4.33 I compiled with gcc-3.4.6.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Thanks Mikael,

I'm queueing it in my gcc4 tree.
Davem CC'd.

Willy

> --- linux-2.4.34-pre1/arch/sparc64/mm/init.c.~1~	2004-11-17 18:36:41.000000000 +0100
> +++ linux-2.4.34-pre1/arch/sparc64/mm/init.c	2006-08-20 20:52:20.000000000 +0200
> @@ -95,7 +95,7 @@ int do_check_pgt_cache(int low, int high
>                                  if (page2)
>                                          page2->next_hash = page->next_hash;
>                                  else
> -                                        (struct page *)pgd_quicklist = page->next_hash;
> +                                        pgd_quicklist = (unsigned long *)page->next_hash;
>                                  page->next_hash = NULL;
>                                  page->pprev_hash = NULL;
>                                  pgd_cache_size -= 2;

