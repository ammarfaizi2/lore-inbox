Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWBKBta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWBKBta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 20:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWBKBta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 20:49:30 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:54478 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750762AbWBKBt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 20:49:29 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v24
Date: Sat, 11 Feb 2006 12:48:15 +1100
User-Agent: KMail/1.9.1
Cc: nickpiggin@yahoo.com.au, linux-mm@kvack.org, ck@vds.kolivas.org,
       pj@sgi.com, linux-kernel@vger.kernel.org
References: <200602110347.43121.kernel@kolivas.org>
In-Reply-To: <200602110347.43121.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602111248.16067.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 February 2006 03:47, Con Kolivas wrote:
> Try again. Tackled everything I could think of mentioned and more.

Hrm BUG..

This version appears to work fine with the pages being added to the tail of 
the LRU, however there's a problem with the custom lru_cache_add_tail 
function. I end up hitting a bug at:
	if (!TestClearPageLRU(page))
		BUG();

in isolate_lru_pages called from shrink_zone, find_busiest_group, 
shrink_slab... ultimately from kswapd.

Just looking at the lru_cache_add function I note that my lru_cache_add_tail 
function is missing a page_cache_get on the page before adding it to the LRU. 
I'm guessing this is wrong.

Cheers,
Con

P.S. Sorry if this thread is getting long winded; there's a record amount of 
noise on lkml already :(
