Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271832AbRIQQrx>; Mon, 17 Sep 2001 12:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271847AbRIQQrn>; Mon, 17 Sep 2001 12:47:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1550 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271832AbRIQQrf>; Mon, 17 Sep 2001 12:47:35 -0400
Date: Mon, 17 Sep 2001 09:46:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, <ast@domdv.de>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010917183433.5b992e74.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0109170942161.8900-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Sep 2001, Stephan von Krawczynski wrote:
> >
> > No, I think they are related, and bad. I suspect it just means that pages
> > really do not get elevated to the active list, and it's probably _too_
> > unwilling to activate pages. That's bad too - it means that the inactive
> > list is the one solely responsible for working set changes, and the VM
> > won't bother with any other pages. Which also leads to bad results..
>
> Hm, remember my setup: I read a lot from CD, write it to disk and read a lot
> from nfs and write it to disk. Basically both are read once - write once
> setups, so the pages are touched once (or worst twice) at maximum, so I see a
> good chance none of them ever make it to the active list, according to your
> state explanation from previous posts.

Right. That part is fine.

The problematic part is that I suspect that _because_ there's a lot of
inactive pages, the VM layer won't even try to age the active ones.
Which will result in the inactive pages being re-circulated reasonably
quickly..

Hmm. Although maybe that's the right behaviour, considering that you don't
actually _want_ to cache them. It leaves your _truly_ active set
untouched.

> Anyway I cannot "feel" a difference in performance (maybe even worse than
> before), but it _looks_ cleaner. How about taking it as a first step in the
> cleanup direction? :-)

"Looks cleaner" is very important for me for maintenance reasons - having
behaviour that you cannot explain tends to result in more and more ad-hoc
hacks over time, and it just tends to get worse and worse.

However, at the same time I'd really like to hear about improved
behaviour, not just "feels the same". And certainly not "(maybe even
worse.."

		Linus

