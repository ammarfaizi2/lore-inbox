Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277016AbRJCWvJ>; Wed, 3 Oct 2001 18:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277019AbRJCWu7>; Wed, 3 Oct 2001 18:50:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63362 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277016AbRJCWuu>;
	Wed, 3 Oct 2001 18:50:50 -0400
Date: Wed, 3 Oct 2001 18:51:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: "Vladimir V. Saveliev" <vs@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Re: bug? in using generic read/write functions to
 read/write block devices  in 2.4.11-pre2
In-Reply-To: <200110032156.f93LuJb01378@ns.caldera.de>
Message-ID: <Pine.GSO.4.21.0110031841180.23558-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Christoph Hellwig wrote:

> Hi Al,
> 
> In article <Pine.GSO.4.21.0110031643130.23558-100000@weyl.math.psu.edu> you wrote:
> > Moreover, ->release() for block_device also doesn't care for the junk
> > we pass - it only uses inode->i_rdev.  In all cases.  And I'd rather
> > see it them as
> > 	int (*open)(struct block_device *bdev, int flags, int mode);
> > 	int (*release)(struct block_device *bdev);
> > 	int (*check_media_change)(struct block_device *bdev);
> > 	int (*revalidate)(struct block_device *bdev);
> > - that would make more sense than the current variant.  They are block_device
> > methods, not file or inode ones, after all.
> 
> How about starting 2.5 with that patch ones 2.4.11 is done?  Linus?

I don't think that it's a good idea.  Such patch is trivial - it can be
done at any point in 2.5.  Moreover, while it does clean some of the
mess up, I don't see a lot of other stuff that would depend on it.

