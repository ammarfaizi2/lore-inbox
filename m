Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280416AbRKEJVM>; Mon, 5 Nov 2001 04:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280422AbRKEJVC>; Mon, 5 Nov 2001 04:21:02 -0500
Received: from 42.ppp1-1.hob.worldonline.dk ([212.54.84.42]:56448 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S280416AbRKEJUu>; Mon, 5 Nov 2001 04:20:50 -0500
Date: Mon, 5 Nov 2001 10:20:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <20011105102036.Q2580@suse.de>
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>, <3BE5F5BF.7A249BDF@zip.com.au> <20011104193232.A16679@mikef-linux.matchmail.com> <3BE60B51.968458D3@zip.com.au> <20011105080635.D2580@suse.de> <20011105081836.F2580@suse.de> <20011105011437.A377@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011105011437.A377@mikef-linux.matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05 2001, Mike Fedyk wrote:
> On Mon, Nov 05, 2001 at 08:18:36AM +0100, Jens Axboe wrote:
> > On Mon, Nov 05 2001, Jens Axboe wrote:
> > > Interesting, the 2.5 design prevents this since it doesn't account
> > > merges as a penalty (like a seek). I can do something like that for 2.4
> > > too, I'll do a patch for you to test.
> > 
> > Ok here it is. It's not as efficient as the 2.5 version since it
> > proceeds to scan the entire queue for a merge, but it should suffice for
> > your testing.
> > 
> 
> Does the elevator still favor blocks that are on the outside of the platter
> over all others?  If so, I think this should be removed in favor of a
> timeout just like the other seek requests...

It doesn't quite favor outside LBA's (lower numbers), it's a combination
of sector and device. It's hard to do this right in 2.4 because request
sectors are not absolute but a combination of partion + offset. 2.5 will
have this fixed, generic_make_request remaps buffer heads (well actually
bio's, but same deal) before submitting so the I/O scheduler can be a
bit smarter.

> I've been able to put a swap partition on the outside of my drive, and get
> utterly abizmal performance, while on another similar system, with swap on
> the inside of the drive performance was much better during a swap storm...

That sounds very odd, swap should be much faster on the outside.

-- 
Jens Axboe

