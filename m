Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280798AbRKTAN6>; Mon, 19 Nov 2001 19:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280792AbRKTANs>; Mon, 19 Nov 2001 19:13:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64523 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280790AbRKTANg>; Mon, 19 Nov 2001 19:13:36 -0500
Date: Mon, 19 Nov 2001 16:08:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Rik van Riel <riel@marcelothewonderpenguin.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Simon Kirby <sim@netnation.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <Pine.LNX.4.33L.0111192205080.4079-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0111191607110.19585-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Rik van Riel wrote:
>
> The thing is, the "exclusively owned" situation cannot
> be checked in any way, except maybe through the fact
> that page->mapping==NULL ...

Well, you also have to check that the page isn't on the LRU list, so it
would have to be something like

	!page->mapping && !PageLRU(page)

which I agree is ugly. It's much better to just move the page->flag
setting into the callers (and most of the callers _can_ trivially check
that they are exclusive owners, because most of them will just have
allocated the page ;)

		Linus

