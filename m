Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbRGIQWO>; Mon, 9 Jul 2001 12:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263334AbRGIQWE>; Mon, 9 Jul 2001 12:22:04 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:22029 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263149AbRGIQVx>; Mon, 9 Jul 2001 12:21:53 -0400
Date: Mon, 9 Jul 2001 09:20:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Christoph Rohland <cr@sap.com>, Rik van Riel <riel@conectiva.com.br>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107091130580.448-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0107090915310.14024-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Jul 2001, Mike Galbraith wrote:
>
> I'm running oom whether I have swap enabled or not.  The inactive
> dirty list starts growing forever, until it's full of (aparantly)
> dirty pages and I'm utterly oom.

Does it help if you just remove the

	if (atomic_read(&page->count) > 2)
		goto out;

from shmem_writepage()?

It _shouldn't_ matter (because writepage() should only be called with
inactive pages anyway), but your problem certainly sounds like your
inactive dirty list is not able to write out shmfs pages.

Note that if you don't have swap, you're screwed anyway. You just don't
have anywhere to put the pages.

		Linus

