Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRBGTNn>; Wed, 7 Feb 2001 14:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130093AbRBGTNd>; Wed, 7 Feb 2001 14:13:33 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:55426 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S129443AbRBGTNW>; Wed, 7 Feb 2001 14:13:22 -0500
Date: Wed, 7 Feb 2001 12:12:44 -0700
Message-Id: <200102071912.f17JCiJ21131@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010207145215.D7254@redhat.com>
In-Reply-To: <20010207014928.O1167@redhat.com>
	<Pine.LNX.4.10.10102061829230.2448-100000@penguin.transmeta.com>
	<20010207145215.D7254@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie writes:
> Hi,
> 
> On Tue, Feb 06, 2001 at 06:37:41PM -0800, Linus Torvalds wrote:
> > Absolutely. And this is independent of what kind of interface we end up
> > using, whether it be kiobuf of just plain "struct buffer_head". In that
> > respect they are equivalent.
> 
> Sorry?  I'm not sure where communication is breaking down here, but
> we really don't seem to be talking about the same things.  SGI's
> kiobuf request patches already let us pass a large IO through the
> request layer in a single unit without having to split it up to
> squeeze it through the API.

Isn't Linus saying that you can use (say) 4 kiB buffer_heads, so you
don't need kiobufs? IIRC, kiobufs are page containers, so a 4 kiB
buffer_head is effectively the same thing.

> If you really don't mind the size of the buffer_head as a sg fragment
> header, then at least I'd like us to be able to submit a pre-built
> chain of bh's all at once without having to go through the remap/merge
> cost for each single bh.

Even if you are limited to feeding one buffer_head at a time, the
merge costs should be somewhat mitigated, since you'll decrease your
calls into the API by a factor of 8 or 16.
But an API extension to allow passing a pre-built chain would be even
better.

Hopefully I haven't missed the point. I've got the flu so I'm not
running on all 4 cylinders :-(

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
