Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSA3C5q>; Tue, 29 Jan 2002 21:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288169AbSA3C5e>; Tue, 29 Jan 2002 21:57:34 -0500
Received: from dsl-213-023-043-145.arcor-ip.net ([213.23.43.145]:60298 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288248AbSA3Czz>;
	Tue, 29 Jan 2002 21:55:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Date: Wed, 30 Jan 2002 04:00:08 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201292133400.32617-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201292133400.32617-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Vkym-0000BY-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 12:35 am, Rik van Riel wrote:
> On Tue, 29 Jan 2002, Alan Cox wrote:
> > > We can let oracle shared memory segments use 4 MB pages,
> > > but still use the normal page cache code to look up the
> > > pages.
> >
> > That has some potential big wins beyond oracle. Some of the big number
> > crunching algorithms also benefit heavily from 4Mb pages even when you
> > try and minimise tlb misses.
> 
> Note that I'm not sure whether the complexity of using
> 4 MB pages is worth it or not ... I just like the fact
> that the radix tree page cache gives us the opportunity
> to easily implement and try it.
> 
> I like radix trees for making our design more flexible
> and opening doors to possible new functionality.
> 
> It could even be a CONFIG option for the embedded folks,
> if we can keep the code isolated enough ;)

Making it a CONFIG option would preclude leveraging the advantages of the 
radix tree that fall out from its ordered nature, so I'd vote for all or 
nothing in this case.

I also have some perhaps-twisted plans for this thing, but if this patch 
passes muster on its own merits - that is, in the context we're currently 
using the pcache hash as opposed to new capabilities that can be leveraged - 
that's the ideal situation.  Hence no, or minimal, talking up other 
advantages.

I'm inclined to think that the radix tree has locality advantages for UP as 
well as SMP, under certain types of filesystem loads, and that it is never 
worse.  Well, we shall see about that soon enogh.

-- 
Daniel
