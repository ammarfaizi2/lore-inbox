Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317767AbSHSEUa>; Mon, 19 Aug 2002 00:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317793AbSHSEUa>; Mon, 19 Aug 2002 00:20:30 -0400
Received: from dp.samba.org ([66.70.73.150]:8375 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S317767AbSHSEU3>;
	Mon, 19 Aug 2002 00:20:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Gilad Ben-Yossef <gilad@benyossef.com>, torvalds@transmeta.com
To: Marcelo <marcelo@conectiva.com.br>
Cc: The Usual Suspects <linux-kernel@vger.kernel.org>,
       Patch Trivia <trivial@rustcorp.com.au>
Subject: Re: [PATCH] Add PAGE_CACHE_PAGES 
In-reply-to: Your message of "15 Aug 2002 23:33:00 +0300."
             <1029443580.2508.18.camel@gby.benyossef.com> 
Date: Mon, 19 Aug 2002 13:56:34 +1000
Message-Id: <20020818232457.227812C195@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1029443580.2508.18.camel@gby.benyossef.com> you write:
> 
> This patch introduces PAGE_CACHE_PAGES which is the number of pages in a
> page cache.

AFAICT, you should simply do

/* Order of pages in page cache */
#define PAGE_CACHE_PAGE_ORDER 0

#define PAGE_CACHE_SHIFT	(PAGE_SHIFT + PAGE_CACHE_PAGE_ORDER)
#define PAGE_CACHE_SIZE		(1 << PAGE_CACHE_SHIFT)
#define PAGE_CACHE_MASK		(~(PAGE_CACHE_SIZE-1))
#define PAGE_CACHE_ALIGN(addr)	(((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)

*Then* fix up the misuses,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
