Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279631AbRJ2X1u>; Mon, 29 Oct 2001 18:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279630AbRJ2X1l>; Mon, 29 Oct 2001 18:27:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20229 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279624AbRJ2X1b>; Mon, 29 Oct 2001 18:27:31 -0500
Date: Mon, 29 Oct 2001 15:25:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <20011029181527.G25434@redhat.com>
Message-ID: <Pine.LNX.4.33.0110291522490.16656-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Oct 2001, Benjamin LaHaise wrote:
>
> I think it's far more expensive to pull a page back in from disk.

Note that _if_ the page is so often accessed that it stays in the TLB, it
won't ever hit the disk. We _will_ do a TLB invalidate when we unmap it,
and it will get re-mapped long before it's written out.

So it's more likely to result in extra soft-faults, but considering that
if the system is paging stuff out we'll almost certainly be doing enough
context switches that the thing doesn't matter.

And avoiding the extra TLB flush (for _every_ page scanned) is noticeable
according to Andrea.

		Linus

