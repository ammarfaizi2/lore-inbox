Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSIEGTJ>; Thu, 5 Sep 2002 02:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSIEGTJ>; Thu, 5 Sep 2002 02:19:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6672 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317072AbSIEGTJ>;
	Thu, 5 Sep 2002 02:19:09 -0400
Message-ID: <3D76FB64.7AAB215F@zip.com.au>
Date: Wed, 04 Sep 2002 23:36:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Race in shrink_cache
References: <E17mooe-00064m-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> Hi Marcelo,
> 
> This looks really suspicious, vmscan.c#435:
> 
>         spin_unlock(&pagemap_lru_lock);
>                                                         if (put_page_testzero(page))
>                                                                 __free_pages_ok(page, 0);
>         /* avoid to free a locked page */
>         page_cache_get(page);
> 
>         /* whoops, double free coming */
> 
> I suggest you bump the page count before releasing the lru lock.  The race
> shown above may not in fact be possible, but the current code is fragile.
> 

That's OK.  The page has a ref because of nonzero ->buffers  And it
is locked, which pins page->buffers.
