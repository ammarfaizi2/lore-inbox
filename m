Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130695AbQLaUCW>; Sun, 31 Dec 2000 15:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130747AbQLaUCN>; Sun, 31 Dec 2000 15:02:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:59912 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130695AbQLaUCE>; Sun, 31 Dec 2000 15:02:04 -0500
Date: Sun, 31 Dec 2000 11:31:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@innominate.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <3A4F84B2.D691EC50@innominate.de>
Message-ID: <Pine.LNX.4.30.0012311119350.29339-100000@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2000, Daniel Phillips wrote:

> Linus Torvalds wrote:
> >  I do not believe that "get_block()" is as big of a problem as people make
> >  it out to be.
>
> I didn't mention get_block - disk accesses obviously far outweigh
> filesystem cpu/cache usage in overall impact.  The question is, what
> happens to disk access patterns when we do the deferred allocation.

Note that the deferred allocation is only possible with a full page write.

Go and do statistics on a system of how often this happens, and what the
circumstances are. Just for fun.

I will bet you $5 USD that 99.9% of all such writes are to new files, at
the end of the file. I'm sure you can come up with other usage patterns,
but they'll be special (big databases etc, and I bet that they'll want to
have stuff cached all the time anyway for other reasons).

So I seriously doubt that you'll have much of an IO component to the
writing anyway - except for the "normal" deferred write of actually
writing the stuff out at all.

Now, this is where I agree with you, but I disagree with where most of the
discussion has been going: I _do_ believe that we may want to change block
allocation discussions at write-out-time. That makes sense to me. But that
doesn't really impact "ENOSPC" - the write would not be really "deferred"
by the VM layer, and the filesystem would always be aware of the writer
synchronously.

> > One form of deferred writes I _do_ like is the mount-time-option form.
> > Because that one doesn't add complexity. Kind of like the "noatime" mount
> > option - it can be worth it under some circumstances, and sometimes it's
> > acceptable to not get 100% unix semantics - at which point deferred writes
> > have none of the disadvantages of trying to be clever.
>
> And the added attraction of requiring almost no effort.

Did I mention my belief in the true meaning of "intelligence"?

"Intelligence is the ability to avoid doing work, yet get the work done".

Lazy programmers are the best programmers. Think Tom Sawyer painting the
fence. That's intelligence.

Requireing almost no effort is a big plus in my book.

It's the "clever" programmer I'm afraid of. The one who isn't afraid of
generating complexity, because he has a Plan (capital "P"), and he knows
he can work out the details later.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
