Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264933AbRGIUsO>; Mon, 9 Jul 2001 16:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264932AbRGIUsE>; Mon, 9 Jul 2001 16:48:04 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:28425 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264910AbRGIUrv>; Mon, 9 Jul 2001 16:47:51 -0400
Date: Mon, 9 Jul 2001 13:46:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Rohland <cr@sap.com>
cc: Mike Galbraith <mikeg@wen-online.de>, Rik van Riel <riel@conectiva.com.br>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <m3g0c5c2fn.fsf@linux.local>
Message-ID: <Pine.LNX.4.33.0107091345070.20937-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Jul 2001, Christoph Rohland wrote:
>
> No, it does matter. It prevents races against getpage.

No it doesn't.

We have the page locked.

And if somebody does "getpage()" and doesn't check for the page lock, then
that test _still_ doesn't prevent races, because the getpage might happen
just _after_ the "atomic_read()".

As it stands now, that atomic_read() does _nothing_. If you think
something depends on it, then that something is already buggy.

		Linus

