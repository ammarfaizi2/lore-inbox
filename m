Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285377AbRLGFfz>; Fri, 7 Dec 2001 00:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285391AbRLGFfq>; Fri, 7 Dec 2001 00:35:46 -0500
Received: from www.wen-online.de ([212.223.88.39]:52742 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S285377AbRLGFf2>;
	Fri, 7 Dec 2001 00:35:28 -0500
Date: Fri, 7 Dec 2001 06:37:07 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rik van Riel <riel@conectiva.com.br>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Pablo Borges <pablo.borges@uol.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.16 & Heavy I/O
In-Reply-To: <E16C7Lj-0003O4-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112070624570.653-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Alan Cox wrote:

> > Once a page is used twice, it's not a candidate for eviction
> > until (most of) the use-once pages are gone.
> >
> > This means that if you have these 40 MB of used-twice-but-never-again
> > buffer cache memory, this memory will never be evicted until other
> > pages get promoted from use-once to active.
>
> Its worth noting btw that you can intentionally exploit this in an app
> to get unfair use of memory. That makes me very dubious about the heuristic

In Rik's VM I had a problem with use-once when Bonnie was doing
rewrite.  It's used-twice data became too hard to get rid of at
the aging volume we were doing, leading to an inactive shortage
and unwanted swapping.  The active list grew until ~all of ram
was on the active list.  I 'fixed' it here by keeping the dirty
list very strictly ordered (lengthened it too) and requiring more
than two accesses before promoting to active.

I have not seen this behavior in the new VM yet.

	-Mike

