Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271076AbRHUCOJ>; Mon, 20 Aug 2001 22:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271089AbRHUCN7>; Mon, 20 Aug 2001 22:13:59 -0400
Received: from ns.suse.de ([213.95.15.193]:49671 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271076AbRHUCNv>;
	Mon, 20 Aug 2001 22:13:51 -0400
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <3B80EADC.234B39F0@evision-ventures.com.suse.lists.linux.kernel> <2248596630.998319423@[10.132.112.53].suse.lists.linux.kernel> <3B811DD6.9648BE0E@evision-ventures.com.suse.lists.linux.kernel> <20010820211107.A20957@thunk.org.suse.lists.linux.kernel> <200108210136.f7L1aa008756@vindaloo.ras.ucalgary.ca.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Aug 2001 04:14:04 +0200
In-Reply-To: Richard Gooch's message of "21 Aug 2001 03:43:08 +0200"
Message-ID: <oupk7zyqhw3.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch <rgooch@ras.ucalgary.ca> writes:

> Theodore Tso writes:
> > On Mon, Aug 20, 2001 at 04:25:26PM +0200, Martin Dalecki wrote:
> > > 
> > > The primary reson of invention of /dev/random was the need
> > > for a bit of salt to the initial packet sequence number inside
> > > the networking code in linux. And for this purspose the
> > > whole /dev/*random stuff is INDEED a gratitious overdesign.
> > > For anything else crypto related it just doesn't cut the corner.
> > 
> > A number of other people helped me with the design and development of
> > the /dev/random driver, including one of the primary authors of the
> > random number generation routines in PGP 2.x and 5.0.  Most folks feel
> > that it does a good job.
> 
> Indeed. If Martin has some deep insight as to why the /dev/random
> implementation is insufficient for strong crypto, I'd like to hear
> it.

The only flaw I see in the random device is that its enviromental constraints
are not sufficiently documented.

It is rather unreliable on boxes with no hard disk IO or 
non supported hard disk IO (i.e. until recently a lot of RAID controllers
didn't feed entropy) and no keyboard/mouse -- that is on a lot of appliances
and servers. The box has some random pool still left over from installation,
which gets smaller and smaller over runtime until urandom quickly degenerates
to a not-so-great-and-slow pseudo random generator and /dev/random turns into 
a DoS.

It is not that they are hard to fix; e.g. a $10 sound card
with a noise generating circuit on input and a small daemon to feed
/dev/audio to /dev/random can do it; but few people seem to know about
these problems and still trust the session key generation of their sshd 
(which uses /dev/urandom BTW I guess because of these problems) on their 
headless servers. The both SSL libraries I checked (mozilla and openssl)
do not even seem to use it at all.

-Andi

