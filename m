Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSIEG3k>; Thu, 5 Sep 2002 02:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSIEG3k>; Thu, 5 Sep 2002 02:29:40 -0400
Received: from dsl-213-023-038-092.arcor-ip.net ([213.23.38.92]:3493 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317102AbSIEG3j>;
	Thu, 5 Sep 2002 02:29:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: Race in shrink_cache
Date: Thu, 5 Sep 2002 08:36:16 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
References: <E17mooe-00064m-00@starship> <3D76FB64.7AAB215F@zip.com.au>
In-Reply-To: <3D76FB64.7AAB215F@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mqFV-00065Y-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 08:36, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > Hi Marcelo,
> > 
> > This looks really suspicious, vmscan.c#435:
> > 
> >         spin_unlock(&pagemap_lru_lock);
> >                                                         if (put_page_testzero(page))
> >                                                                 __free_pages_ok(page, 0);
> >         /* avoid to free a locked page */
> >         page_cache_get(page);
> > 
> >         /* whoops, double free coming */
> > 
> > I suggest you bump the page count before releasing the lru lock.  The race
> > shown above may not in fact be possible, but the current code is fragile.
> > 
> 
> That's OK.  The page has a ref because of nonzero ->buffers  And it
> is locked, which pins page->buffers.

Yes, true.  Calm down ladies and gentlemen, and move away from the exits,
there is no fire.  While we're in here, do you have any idea what this is
about:

/*
 * We must not allow an anon page
 * with no buffers to be visible on
 * the LRU, so we unlock the page after
 * taking the lru lock
 */

That is, what's scary about an anon page without buffers?

-- 
Daniel
