Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318333AbSIBRSx>; Mon, 2 Sep 2002 13:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318342AbSIBRSx>; Mon, 2 Sep 2002 13:18:53 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:3817 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S318333AbSIBRSw>; Mon, 2 Sep 2002 13:18:52 -0400
Message-ID: <20020902172322.23692.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Mon, 2 Sep 2002 19:23:22 +0200
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Include LRU in page count
References: <3D644C70.6D100EA5@zip.com.au> <E17kunE-0003IO-00@starship> <20020831161448.12564.qmail@thales.mathematik.uni-ulm.de> <E17lEDR-0004Qq-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17lEDR-0004Qq-00@starship>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 09:47:29PM +0200, Daniel Phillips wrote:
> > Also there may be lru only pages on the active list, i.e. refill
> > inactive should have this hunk as well:
> > 
> > > +#if LRU_PLUS_CACHE==2
> > > +             BUG_ON(!page_count(page));
> > > +             if (unlikely(page_count(page) == 1)) {
> > > +                     mmstat(vmscan_free_page);
> > > +                     BUG_ON(!TestClearPageLRU(page)); // side effect abuse!!
> > > +                     put_page(page);
> > > +                     continue;
> > > +             }
> > > +#endif
> 
> If we have orphans on the active list, we'd probably better just count
> them and figure out what we're doing wrong to put them there in the first
> place.  In time they will migrate to the inactive list and get cleaned
> up.

Hm, think of your favourite memory hog being killed with lots of anon
pages on the active list while someone else holds the lru lock.
Won't all these anon pages legally end up orphaned on the active list
(due to the trylock in page_cache_release)?

   regards  Christian

-- 
THAT'S ALL FOLKS!
