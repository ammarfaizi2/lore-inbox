Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269777AbRHDDiG>; Fri, 3 Aug 2001 23:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269780AbRHDDh4>; Fri, 3 Aug 2001 23:37:56 -0400
Received: from [63.209.4.196] ([63.209.4.196]:56847 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269777AbRHDDhk>; Fri, 3 Aug 2001 23:37:40 -0400
Date: Fri, 3 Aug 2001 20:35:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@bonn-fries.net>, Ben LaHaise <bcrl@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33L.0108040022110.2526-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0108032030430.15155-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 4 Aug 2001, Rik van Riel wrote:
> On Fri, 3 Aug 2001, Linus Torvalds wrote:
>
> > Please just remove the code instead. I don't think it buys you anything.
>
> IIRC you applied the patch introducing that logic because it
> gave a 25% performance increase under some write intensive
> loads (or something like that).

That's the batching code, which is somewhat intertwined with the same
code.

The batching code is a separate issue: when we free the requests, we don't
actually make them available as they get free'd (because then the waiters
will trickle out new requests one at a time and cannot do any merging
etc).

Also, the throttling code probably _did_ make behaviour nicer back when
"sync()" used to use ll_rw_block().  Of course, now most of the IO layer
actually uses "submit_bh()" and bypasses this code completely, so only the
ones that still use it get hit by the unfairness. What a double whammy ;)

		Linus

