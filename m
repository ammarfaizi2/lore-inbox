Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbRGPMqz>; Mon, 16 Jul 2001 08:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267345AbRGPMqp>; Mon, 16 Jul 2001 08:46:45 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:24587 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267339AbRGPMqZ>; Mon, 16 Jul 2001 08:46:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        phillips@bonn-fries.net (Daniel Phillips)
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
Date: Mon, 16 Jul 2001 14:49:36 +0200
X-Mailer: KMail [version 1.2]
Cc: reiser@namesys.com (Hans Reiser), alan@lxorguk.ukuu.org.uk (Alan Cox),
        volodya@mindspring.com,
        ajschrotenboer@lycosmail.com (Adam Schrotenboer),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <200107160022.f6G0MBn310960@saturn.cs.uml.edu>
In-Reply-To: <200107160022.f6G0MBn310960@saturn.cs.uml.edu>
MIME-Version: 1.0
Message-Id: <01071614493604.06482@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 July 2001 02:22, Albert D. Cahalan wrote:
> Daniel Phillips writes:
> > Or we could introduce the notion of logical blocksize for each
> > block minor so that we can measure blocks in the same units the
> > filesystem uses.  This would give us 16 TB while being able to stay
> > with 32 bits everywhere outside the block drivers themselves.
> >
> > We are not that far away from being able to handle 8K blocks, so
> > that would bump it up to 32 TB.
>
> This is like what the hard drive and BIOS industry has been doing.
> First we had the 528 MB limit. Then the 2 GB limit. Then the 4 GB
> limit. Then the 8.3 GB limit. Then the 33 GB limit. Then the 127 GB
> limit. All along the way, users are cursing the damn limits.
>
> An extra 4 bits buys us 6 years maybe. Nice, except that we
> already have people complaining. Maybe somebody remembers when
> the complaining started.

Well, that coincides nicely with the period when most of us will still
be using 32 bit processors, don't you think?  If we solve the problem
of internal fragmentation (as Reiserfs has) and memory management then
we can keep going on up to 64K blocksize, giving a 256 TB limit.  Not
too shabby.  (Some things need fixing after that, e.g. Ext2 directory
entry record sizes.)

At the same time, the larger block size means that, to transfer a given
number of blocks at random locations, less time is spent seeking and
less time in setup.  Larger blocks are good - there's a reason why the
industry is heading in that direction.  If it also helps us with our
partition size limits, then why not take advantage of it.  I'd say, do
both, use the logical blocksize measurements and provide 64 bit block
numbers as an option.

Note that there is a bug-by-design that comes from measuring device
capacity in 1K blocks the way we do now: on a device with 512 byte
blocks we can't correctly determine when a block access is out of 
range.  Measuring in logical block size would fix that cleanly.

--
Daniel
