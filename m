Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129478AbRCVRi1>; Thu, 22 Mar 2001 12:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130038AbRCVRiR>; Thu, 22 Mar 2001 12:38:17 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:55566 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129478AbRCVRiN>; Thu, 22 Mar 2001 12:38:13 -0500
Date: Thu, 22 Mar 2001 09:36:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <arjanv@redhat.com>
Subject: Re: Thinko in kswapd?
In-Reply-To: <20010322145810.A7296@redhat.com>
Message-ID: <Pine.LNX.4.31.0103220931330.18728-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Mar 2001, Stephen C. Tweedie wrote:
>
> There is what appears to be a simple thinko in kswapd.  We really
> ought to keep kswapd running as long as there is either a free space
> or an inactive page shortfall; but right now we only keep going if
> _both_ are short.

Hmm.. The comment definitely says "or", so changing it to "and" in the
sources makes the comment be non-sensical.

I suspect that the comment and the code were true at some point. The
behaviour of "do_try_to_free_pages()" has changed, though, and I suspect
your suggested change makes more sense now (it certainly seems to be
logical to have the reverse condition for sleeping and for when to call
"do_try_to_free_pages()").

The only way to know is to test the behaviour. My only real worry is that
kswapd might end up eating too much CPU time and make the system feel bad,
but on the other hand the same can certainly be true from _not_ doing this
change too.

		Linus

