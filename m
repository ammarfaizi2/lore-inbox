Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262582AbRFRSx4>; Mon, 18 Jun 2001 14:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262593AbRFRSxq>; Mon, 18 Jun 2001 14:53:46 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:2980 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262582AbRFRSxi>; Mon, 18 Jun 2001 14:53:38 -0400
Date: Mon, 18 Jun 2001 12:53:06 -0600
Message-Id: <200106181853.f5IIr6u02682@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: Re: [PATCH] devfs v181 available
In-Reply-To: <Pine.GSO.4.21.0106181240360.18769-100000@weyl.math.psu.edu>
In-Reply-To: <200106181515.f5IFFcA00598@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0106181240360.18769-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Mon, 18 Jun 2001, Richard Gooch wrote:
> 
> > > Irrelevant. BKL provides an exclusion only on non-blocking areas.
> > 
> > Yeah, I know all that.
> 
> So what the hell are you talking about?

Never mind. We seem to be talking at cross purposes. We both know how
the BKL works and the implications, so there's not much point beating
our heads trying to communicate redundant information :-)

> > > _Moved_ them there from the callers of these functions. And AFAICS
> > > you do need BKL for get_devfs_entry_...(); otherwise relocation of
> > > the table will be able to screw you inside of that function. Now, it
> > > will merrily screw you anyway in a lot of places, but that's another
> > > story.
> > 
> > OK, so it was another global change.
> 
> Moving BKL into the ->readlink() and ->follow_link()? Sure, it was a global
> change. About a year ago.
> 
> > Question: assuming data fed to vfs_follow_link() is "safe", does it
>             ^^^^^^^^
> > need the BKL? I can see that vfs_readlink() obviously doesn't need
> > it. From reading Documentation/filesystems/Locking I suspect it
> > doesn't need the BKL, but the way I read it says "follow_link() method
> > does not *have* the BKL already". But that doesn't explicitely say
> > whether vfs_follow_link() needs it.
> 
> vfs_follow_link() doesn't need it. Moreover, if data fed to it is
> unsafe without BKL, you are screwed even if you take BKL. So
> assumption above is bogus - you _never_ need BKL on that call.

OK, you didn't see what I was driving at. If I had said "if my data is
protected by a semaphore, do I still need the BKL for
vfs_follow_link()" I guess it would have been clearer. Anyway, you've
answered my question, thanks.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
