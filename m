Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262659AbREOGuj>; Tue, 15 May 2001 02:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262661AbREOGuc>; Tue, 15 May 2001 02:50:32 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:48794 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262659AbREOGuV>; Tue, 15 May 2001 02:50:21 -0400
Date: Tue, 15 May 2001 00:49:58 -0600
Message-Id: <200105150649.f4F6nwD22946@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <Pine.LNX.4.21.0105142324140.23912-100000@penguin.transmeta.com>
In-Reply-To: <200105150620.f4F6KKd22491@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.21.0105142324140.23912-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> 
> On Tue, 15 May 2001, Richard Gooch wrote:
> > 
> > However, what about simply invalidating an entry in the buffer cache
> > when you do a write from the page cache?
> 
> And how do you do the invalidate the other way, pray tell?
> 
> What happens if you create a buffer cache entry? Does that
> invalidate the page cache one? Or do you just allow invalidates one
> way, and not the other? And why=

I just figured on one way invalidates, because that seems cheap and
easy and has some benefits. Invalidating the other way is costly, so
don't bother, even if there were some benefits.

> > Actually, I'd kind of like it if the page cache steals from the buffer
> > cache on read. The buffer cache is mostly populated by fsck. Once I've
> > done the fsck, those buffers are useless to me. They might be useful
> > again if they are steal-able by the page cache.
> 
> Ehh.. And then you'll be unhappy _again_, when we early in 2.5.x
> start using the page cache for block device accesses. Which we
> _have_ to do if we want to be able to mmap block devices. Which we
> _do_ want to do (hint: DVD's etc).

So what happens if I dd from the block device and also from a file on
the mounted FS, where that file overlaps the bnums I dd'ed? Do we get
two copies in the page cache? One for the block device access, and one
for the file access?

> Face it. What you ask for is stupid and fundamentally unworkable. 
> 
> Tell me WHY you are completely ignoring my arguments, when I (a)
> tell you why your way is bad and stupid (and when you ignore the
> arguments, don't complain when I call you stupid) and (b) I give you
> alternate ways to do the same thing, except my suggestion is
> _faster_ and has none of the downside yours has.
> 
> WHY?

Because I like to understand completely all the different options
before giving up on any. That in itself is a good enough reason, IMO.

Because I've found that when arguing about this kind of stuff, even if
the other person asks for something that is "wrong" or "stupid" from
your own point of view, if you respect their intelligence, then maybe
you can together find an alternative solution that solves the
underlying problem but does it cleanly.

I've been on the other side of this with a friend and colleague. We
used to have healthy arguments that lasted all afternoon. He'd ask for
something that was unclean and didn't fit into the structure or the
philosophy. But I respected his intelligence, skill and his need for a
solution. In the end, we'd come up with a better way than either one
would have proposed. We had a dialogue.

And because your suspend/resume idea isn't really going to help me
much. That's because my boot scripts have the notion of
"personalities" (change the boot configuration by asking the user
early on in the boot process). If I suspend after I've got XDM
running, it's too late.

So what I want is a solution that will keep the kernel clean (believe
me, I really do want to keep it clean), but gives me a fast boot too.
And I believe the solution is out there. We just haven't found it yet.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
