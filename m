Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270021AbRHGB1X>; Mon, 6 Aug 2001 21:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270023AbRHGB1N>; Mon, 6 Aug 2001 21:27:13 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:37252 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270021AbRHGB1B>; Mon, 6 Aug 2001 21:27:01 -0400
Date: Mon, 6 Aug 2001 19:27:23 -0600
Message-Id: <200108070127.f771RNe27524@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <Pine.GSO.4.21.0108062053220.16817-100000@weyl.math.psu.edu>
In-Reply-To: <200108070051.f770pji27036@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0108062053220.16817-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Mon, 6 Aug 2001, Richard Gooch wrote:
> 
> > More importantly, the loop you used doesn't protect insertions into
> > the table. So it's not safe on SMP.
> 
> Nope.  Allocation of entry itself is moved ahead of the loop, so
> we insert immediately after expanding the thing.

I'm referring specifically to this code:
    new->inode.ino = fs_info.num_inodes + FIRST_INODE;
    fs_info.table[fs_info.num_inodes++] = new;

This is not SMP safe. Besides, even the allocation loop isn't SMP
safe. If two tasks both allocate a table, they each could end up
calling:
	kfree (fs_info.table);
for the same value. Or for a different one (which is also bad).

> > > PS: ObYourPropertyManager: karmic retribution?
> > 
> > Um, retribution for putting in an awful lot of time developing devfs
> > (despite extreme hostility), at considerable personal sacrifice, and
> > being patient and civilised to those who flamed against it? My, how
> > I've been such a horrible person.
> 
> <tongue-in-cheek>
> Nah, not that. Not plugging the holes that need to be plugged. Admit
> it, there is some poetic justice in the situation.
> </tongue-in-cheek>

Ah. I didn't get that one. OK. I guess seen that way it is funny.
Unfortunately I've been living with this flooding problem for several
months, so I'm a bit touchy on the subject. It is incredibly
disruptive to getting work done.

> As for the repugnant comments - IMO your "On the top of that, I have
> a life" used in the context it was used in counts pretty high on that
> scale. You know, you are _not_ unique in that respect.

Oh, that's not what I meant. I get the impression from some quarters
that one is expected to always put work ahead of personal
considerations. That's what I was railing against.

I apologise if it came across the other way (i.e. implying that others
don't have a life: it's obviously incorrect, and besides, I don't make
those kinds of cheap shots).

> Whatever.  I just hope that this time all that mess will be fixed
> and by now I really don't care who does it and what does it take.

Well, I *am* doing it. Like I said, today was due to be the day.
Really.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
