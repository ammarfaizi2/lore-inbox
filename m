Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262042AbREXOYr>; Thu, 24 May 2001 10:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262033AbREXOYi>; Thu, 24 May 2001 10:24:38 -0400
Received: from www.wen-online.de ([212.223.88.39]:24071 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S262036AbREXOY1>;
	Thu, 24 May 2001 10:24:27 -0400
Date: Thu, 24 May 2001 16:23:32 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105240800020.10469-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0105241557160.894-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2001, Rik van Riel wrote:

> > > > OK.. let's forget about throughput for a moment and consider
> > > > those annoying reports of 0 order allocations failing :)
> > >
> > > Those are ok.  All failing 0 order allocations are either
> > > atomic allocations or GFP_BUFFER allocations.  I guess we
> > > should just remove the printk()  ;)
> >
> > Hmm.  The guy who's box locks up on him after a burst of these
> > probably doesn't think these failures are very OK ;-)  I don't
> > think order 0 failing is cool at all.. ever.
>
> You may not think it's cool, but it's needed in order to
> prevent deadlocks. Just because an allocation cannot do
> disk IO or sleep, that's no reason to loop around like
> crazy in __alloc_pages() and hang the machine ... ;)

True, but if we have resources available there's no excuse for a
failure.  Well, yes there is.  If the cost of that resource is
higher than the value of letting the allocation succeed.  We have
no data on the value of success, but we do plan on consuming the
reclaimable pool and do that (must), so I still think turning
these resources loose at strategic moments is logically sound.
(doesn't mean there's not a better way.. it's just an easy way)

I'd really like someone who has this problem to try the patch to
see if it does help.  I don't have this darn problem myself, so
I'm left holding a bag of idle curiosity. ;-)

	Cheers,

	-Mike

