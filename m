Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271637AbRIBQQs>; Sun, 2 Sep 2001 12:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271638AbRIBQQi>; Sun, 2 Sep 2001 12:16:38 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:40889 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271637AbRIBQQ0>; Sun, 2 Sep 2001 12:16:26 -0400
Date: Sun, 2 Sep 2001 10:16:41 -0600
Message-Id: <200109021616.f82GGfG16166@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [RFC] lazy allocation of struct block_device
In-Reply-To: <Pine.GSO.4.21.0109021156050.21487-100000@weyl.math.psu.edu>
In-Reply-To: <200109021538.f82FcAB15856@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0109021156050.21487-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Sun, 2 Sep 2001, Richard Gooch wrote:
> 
> > Yep. Having to allocate/search for a device structure during open(2)
> > is insane. It's wasteful. For ext2fs you can do it in lookup(), and
> > for devfs (or similar) you can do the ideal thing: when the device
> > entry is registered with the FS (i.e. only once).
> 
> No.  We _must_ do it on ->open() for cases when it had been NULL.  Driver
> might be not there at ->lookup() time and hunting down all inodes with
> give major/minor is insanity.

Apologies. Let me clarify what I meant: it's insane to only ever
allow allocate/search during open(2).

Oh, and yeah: doing allocate/search during lookup() for ext2fs is a
bad idea. Wasn't thinking straight.

> Now, if inode had been created by the driver - sure, we create the
> association between it and <whatever>_device from the very
> beginning.

Yep. That's what I meant.

> We must support device nodes on normal filesystems.

Of course. No argument.

> Support for such beasts is there to stay.  However, we shouldn't do
> things that make allocation of new majors mandatory.  IOW, as far as
> I'm concerned solutions that do not allow "establish connection with
> foo_device upon inode creation and don't bother with device number
> for that one" are broken.

Nod.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
