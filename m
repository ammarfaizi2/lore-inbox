Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130059AbRB1FE4>; Wed, 28 Feb 2001 00:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130063AbRB1FEr>; Wed, 28 Feb 2001 00:04:47 -0500
Received: from www.wen-online.de ([212.223.88.39]:57349 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130059AbRB1FE0>;
	Wed, 28 Feb 2001 00:04:26 -0500
Date: Wed, 28 Feb 2001 06:04:12 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.21.0102271808340.6958-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0102280556040.972-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001, Marcelo Tosatti wrote:

> On Tue, 27 Feb 2001, Mike Galbraith wrote:
>
> > What the patch does is simply to push I/O as fast as we can.. we're
> > by definition I/O bound and _can't_ defer it under any circumstance,
> > for in this direction lies constipation.  The only thing in the world
> > which will make it better is pushing I/O.
>
> In your I/O bound case, yes. But not in all cases.

That's one reason I tossed it out.  I don't _think_ it should have any
negative effect on other loads, but a test run might find otherwise.

> > What we do right now (as kswapd) is scan a tiny portion of the active
> > page list, and then push an arbitrary amount of swap because we can't
> > possibly deactivate enough pages if our shortage is larger than the
> > search area (nr_active_pages >> 6).. repeat until give-up time.  In
> > practice here (test load, but still..), that leads to pushing soon
> > to be unneeded [supposition!] pages into swap a full 3/4 of the time.

(correction: it's 2/3 of the time not 3/4.. off by one bug in fingers;)

> Have you tried to use SWAP_SHIFT as 4 instead of 5 on a stock 2.4.2-ac5 to
> see if the system still swaps out too much?

Not yet, but will do.

	-Mike

