Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262097AbREZARD>; Fri, 25 May 2001 20:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262116AbREZAQy>; Fri, 25 May 2001 20:16:54 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:46343 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262097AbREZAQk>; Fri, 25 May 2001 20:16:40 -0400
Date: Fri, 25 May 2001 17:16:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <Pine.LNX.4.33.0105252103570.10469-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0105251714120.1011-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 May 2001, Rik van Riel wrote:
> On Fri, 25 May 2001, Linus Torvalds wrote:
>
> > So I think I'll buy some experimentation. That HIGHMEM change is
> > too ugly to live, though, I'd really like to hear more about why
> > something that ugly is necessary.
>
> If you mean the "GFP_BUFFER allocations should fail instead
> of looping forever" thing, it is because:

No, I was thinking more of the dirty buffer balancing thing.

It seems to have this hardcoded notion of "DMA + NORMAL", which is just
wrong. There could be more zones that are acceptable to buffers, so what
it _should_ do is to just walk the zone list that GFP_BUFFER points to.

		Linus

