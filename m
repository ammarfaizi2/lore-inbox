Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbRFRQzv>; Mon, 18 Jun 2001 12:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbRFRQzl>; Mon, 18 Jun 2001 12:55:41 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48610 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261577AbRFRQz2>;
	Mon, 18 Jun 2001 12:55:28 -0400
Date: Mon, 18 Jun 2001 12:55:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: Re: [PATCH] devfs v181 available
In-Reply-To: <200106181515.f5IFFcA00598@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0106181240360.18769-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Jun 2001, Richard Gooch wrote:

> > Irrelevant. BKL provides an exclusion only on non-blocking areas.
> 
> Yeah, I know all that.

So what the hell are you talking about?

> > _Moved_ them there from the callers of these functions. And AFAICS
> > you do need BKL for get_devfs_entry_...(); otherwise relocation of
> > the table will be able to screw you inside of that function. Now, it
> > will merrily screw you anyway in a lot of places, but that's another
> > story.
> 
> OK, so it was another global change.

Moving BKL into the ->readlink() and ->follow_link()? Sure, it was a global
change. About a year ago.

> Question: assuming data fed to vfs_follow_link() is "safe", does it
            ^^^^^^^^
> need the BKL? I can see that vfs_readlink() obviously doesn't need
> it. From reading Documentation/filesystems/Locking I suspect it
> doesn't need the BKL, but the way I read it says "follow_link() method
> does not *have* the BKL already". But that doesn't explicitely say
> whether vfs_follow_link() needs it.

vfs_follow_link() doesn't need it. Moreover, if data fed to it is unsafe
without BKL, you are screwed even if you take BKL. So assumption above
is bogus - you _never_ need BKL on that call.

