Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263353AbRFEVCL>; Tue, 5 Jun 2001 17:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263357AbRFEVBw>; Tue, 5 Jun 2001 17:01:52 -0400
Received: from www.wen-online.de ([212.223.88.39]:38668 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263353AbRFEVBs>;
	Tue, 5 Jun 2001 17:01:48 -0400
Date: Tue, 5 Jun 2001 23:00:59 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Benjamin C.R. LaHaise" <blah@kvack.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Zlatko Calusic <zlatko.calusic@iskon.hr>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Comment on patch to remove nr_async_pages limitA
In-Reply-To: <Pine.LNX.3.96.1010605151500.25725C-100000@kanga.kvack.org>
Message-ID: <Pine.LNX.4.33.0106052211490.2310-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001, Benjamin C.R. LaHaise wrote:

> On Tue, 5 Jun 2001, Mike Galbraith wrote:
>
> > Yes.  If we start writing out sooner, we aren't stuck with pushing a
> > ton of IO all at once and can use prudent limits.  Not only because of
> > potential allocation problems, but because our situation is changing
> > rapidly so small corrections done often is more precise than whopping
> > big ones can be.
>
> Hold on there big boy, writing out sooner is not better.  What if the

(do definitely beat my thoughts up, please don't use condescending terms)

In some cases, it definitely is.  I can routinely improve throughput
by writing more.. that is a measurable and reproducable fact.  I know
also from measurement that it is not _always_ the right thing to do.

> memory shortage is because real data is being written out to disk?

(I would hope that we're doing our best to always be writing real data
to disk.  I also know that this isn't always the case.)

> Swapping early causes many more problems than swapping late as extraneous
> seeks to the swap partiton severely degrade performance.

That is not the case here at the spot in the performance curve I'm
looking at (transition to throughput).

Does this mean the block layer and/or elevator is having problems?  Why
would using avaliable disk bandwidth vs letting it lie dormant be a
generically bad thing?.. this I just can't understand.  The elevator
deals with seeks, the vm is flat not equipped to do so.. it contains
such concept.

Avoiding write is great, delaying write is not at _all_ great.

	-Mike

