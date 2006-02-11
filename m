Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWBKLRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWBKLRG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 06:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWBKLRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 06:17:06 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:63884 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751402AbWBKLRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 06:17:05 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: [PATCH] mm: Implement Swap Prefetching v24
Date: Sat, 11 Feb 2006 22:16:37 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, pj@sgi.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <200602110347.43121.kernel@kolivas.org> <200602111248.16067.kernel@kolivas.org>
In-Reply-To: <200602111248.16067.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602112216.37792.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 February 2006 12:48, Con Kolivas wrote:
> On Saturday 11 February 2006 03:47, Con Kolivas wrote:
> > Try again. Tackled everything I could think of mentioned and more.
>
> Hrm BUG..
>
> This version appears to work fine with the pages being added to the tail of
> the LRU, however there's a problem with the custom lru_cache_add_tail
> function. I end up hitting a bug at:
> 	if (!TestClearPageLRU(page))
> 		BUG();
>
> in isolate_lru_pages called from shrink_zone, find_busiest_group,
> shrink_slab... ultimately from kswapd.

I've been unable to get this one working without reliably BUGging there. As 
soon as anything is prefetched, the next time ram is full it will BUG. So 
I've hacked a lru_cache_add_tail using a variation of the current 
lru_cache_add that uses pagevecs and it has been working flawlessly. I'll 
thrash this implementation around a bit more to see if it breaks and unless 
someone can suggest what I've done wrong with v24 I'll be posting v25 with 
the pagevecs version.

Cheers,
Con
