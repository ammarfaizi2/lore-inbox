Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261187AbSJLN0w>; Sat, 12 Oct 2002 09:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261191AbSJLN0w>; Sat, 12 Oct 2002 09:26:52 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:25860 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261187AbSJLN0v>; Sat, 12 Oct 2002 09:26:51 -0400
Date: Sat, 12 Oct 2002 14:32:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@redhat.com>, Jens Axboe <axboe@suse.de>
Subject: Re: Linux v2.5.42
Message-ID: <20021012143233.A17090@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@redhat.com>, Jens Axboe <axboe@suse.de>
References: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Oct 11, 2002 at 09:59:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 09:59:58PM -0700, Linus Torvalds wrote:
> PS: NOTE - I'm not going to merge either EVMS or LVM2 right now as things
> stand.  I'm not using any kind of volume management personally, so I just
> don't have the background or inclination to walk through the patches and
> make that kind of decision. My non-scientific opinion is that it looks 
> like the EVMS code is going to be merged, but ..
> 
> Alan, Jens, Christoph, others - this is going to be an area where I need
> input from people I know, and preferably also help merging. I've been 
> happy to see the EVMS patches being discussed on linux-kernel, and I just 
> wanted to let people know that this needs outside help.

I don't think the work to get EVMS in shape can be done in time (feel
free to preove me wrong..).  The problem in my eyes is that large
parts of what evms does should be in the higher layers, i.e. the
block layer, but they implement their own new layer as the consumer of
those.  i.e. instead of using the generic block layer structures to
present a volume/device they use their own, private structures that
need hacks to get the access right (pass-through ioctls) and need
constant resyncing with the native structures in the case where we
have both (the lowest layer).  IMHO we should try to get a common
userspace API in first, then implement the missing functionality for
properly interaction of voulme managers at the block layer.  After
that EVMS would just be a set of coulme mangment drivers + a library
of common functionality.

Doing that higher level work will take some time to get right, and the
current EVMS API seems unsuitable for me, it contains lots of very#
strange APIs that need rework.  Merging EVMS now for 2.6 means that
we'll have to keep those strange APIs around, and have to maintain
backwards-compatiblity.

I've not seen LVM2 code for 2.5 yet, but the 2.4 code looks very
promising, although it might need some work in different areas.
I'll take a look as soon as Sistina publishes patches for 2.5 instead
of just a BK repository.  LVM1 is totally unusable in 2.5, I think
we should better remove the dead code now than later.

	Christoph

