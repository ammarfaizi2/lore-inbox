Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274559AbRITQYs>; Thu, 20 Sep 2001 12:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274560AbRITQYi>; Thu, 20 Sep 2001 12:24:38 -0400
Received: from ljbc.wa.edu.au ([203.59.143.14]:53487 "HELO gamma.ljbc")
	by vger.kernel.org with SMTP id <S274559AbRITQYT>;
	Thu, 20 Sep 2001 12:24:19 -0400
Date: Fri, 21 Sep 2001 00:22:59 +0800 (WST)
From: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Chris Mason <mason@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems,
 kupdated bugfixes
In-Reply-To: <20010920101544.A14526@turbolinux.com>
Message-ID: <Pine.LNX.4.30.0109210015190.19847-100000@gamma.student.ljbc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Sep 2001, Andreas Dilger wrote:

> On Sep 20, 2001  23:20 +0800, Beau Kuiper wrote:
> > Patch 3 doesn't improve performace much (even in theory the number of
> > dirty buffers being wrongly flushed is pretty low)
>
> Actually, it _may_ even make performance worse (hard to say).  Consider
> the case where the "young" dirty buffers are in the same area of the
> disk as the "old" dirty buffers.  Once you are forced to write the "old"
> buffers, you pretty much get to write the new buffers for free (low seek
> overhead).  They _could_ be merged in the elevator code.
>
> Sadly, it is hard to tell whether this is possible or not, because the
> code to do these things live in different places.  Maybe we could have
> an "optimistic" elevator merge, which only added "young" buffers if
> they merged with other old buffers.

But don't forget that when dirty buffers are being flushed, they become
locked while the disk update is occuring. That means any programs that are
still using these "young" dirty buffers must wait for disk io to complete
(including all the older buffers that have to be written to disk before
it). When several hundred other buffers are slso being flushed to disk by
kupdated , it could be a long wait.

Also, it is nicer behaviour not to write out to disk before the time
indicated in the bdflush tuning structure. It allows sys admins to better
tune the overal performace of a system. (unless the kernel need s more
free memory)

Have fun
Beau Kuiper
kuib-kl@ljbc.wa.edu.au




 >
> Cheers, Andreas
> --
> Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
>                  \  would they cancel out, leaving him still hungry?"
> http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
>

