Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130678AbRBGAvC>; Tue, 6 Feb 2001 19:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130788AbRBGAuw>; Tue, 6 Feb 2001 19:50:52 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:41222 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130678AbRBGAug>; Tue, 6 Feb 2001 19:50:36 -0500
Date: Tue, 6 Feb 2001 16:50:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010207003629.M1167@redhat.com>
Message-ID: <Pine.LNX.4.10.10102061642330.2045-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Feb 2001, Stephen C. Tweedie wrote:
> 
> That gets us from 512-byte blocks to 4k, but no more (ll_rw_block
> enforces a single blocksize on all requests but that relaxing that
> requirement is no big deal).  Buffer_heads can't deal with data which
> spans more than a page right now.

Stephen, you're so full of shit lately that it's unbelievable. You're
batting a clear 0.000 so far.

"struct buffer_head" can deal with pretty much any size: the only thing it
cares about is bh->b_size.

It so happens that if you have highmem support, then "create_bounce()"
will work on a per-page thing, but that just means that you'd better have
done your bouncing into low memory before you call generic_make_request().

Have you ever spent even just 5 minutes actually _looking_ at the block
device layer, before you decided that you think it needs to be completely
re-done some other way? It appears that you never bothered to.

Sure, I would not be surprised if some device driver ends up being
surpised if you start passing it different request sizes than it is used
to. But that's a driver and testing issue, nothing more.

(Which is not to say that "driver and testing" issues aren't important as
hell: it's one of the more scary things in fact, and it can take a long
time to get right if you start doing somehting that historically has never
been done and thus has historically never gotten any testing. So I'm not
saying that it should work out-of-the-box. But I _am_ saying that there's
no point in trying to re-design upper layers that already do ALL of this
with no problems at all).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
