Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262218AbREXTQu>; Thu, 24 May 2001 15:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262217AbREXTQl>; Thu, 24 May 2001 15:16:41 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:36854 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262213AbREXTQZ>; Thu, 24 May 2001 15:16:25 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105241915.f4OJF6mI014834@webber.adilger.int>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD  w/info-PATCH]device
 arguments from lookup)
In-Reply-To: <20010524102058.B1249@sable.ox.ac.uk> "from Malcolm Beattie at May
 24, 2001 10:20:58 am"
To: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Date: Thu, 24 May 2001 13:15:06 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Malcolm Beattie writes:
> Andreas Dilger writes:
> > PS - I used to think shrinking a filesystem online was useful, but there
> >      are a huge amount of problems with this and very few real-life
> >      benefits, as long as you can at least do offline shrinking.  With
> >      proper LVM usage, the need to shrink a filesystem never really
> >      happens in practise, unlike the partition case where you always
> >      have to guess in advance how big a filesystem needs to be, and then
> >      add 10% for a safety margin.  With LVM you just create the minimal
> >      sized device you need now, and freely grow it in the future.
> 
> In an attempt to nudge you back towards your previous opinion: consider
> a system-wide spool or tmp filesystem. It would be nice to be able to
> add in a few extra volumes for a busy period but then shrink it down
> again when usage returns to normal. In the absence of the ability to
> shrink a live filesystem, storage management becomes a much harder job.
> You can't throw in a spare volume or two where it's needed without
> careful thought because you'll be ratchetting up the space on that one
> filesystem without being able to change your mind and reduce it again
> later. You'll end up with stingy storage admins who refuse to give you
> a bunch of extra filesystem space for a while because they can't get it
> back again afterwards.

I suppose it depends a bit on how your system is administered.  On LVM
systems, I tend to allocate new volumes for special situations like this.
When the special need is gone, you simply remove the whole thing.  Yes,
this is a bit of a hack for not having online shrinking, but I have not
really had a _big_ need to do that.

The only time I've really needed online shrinking is when someone
screwed up and made / or /var way too huge for some (bad) reason and
you can't unmount it conveniently.  Under AIX, you can't shrink JFS
even unmounted so it meant backup/restore.  Even so, having empty
space in a filesystem is not a reason to panic, while having no free
space in a filesystem _is_ a reason to panic, hence online growing
of ext2.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
