Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271335AbRHOR4e>; Wed, 15 Aug 2001 13:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271334AbRHOR4Z>; Wed, 15 Aug 2001 13:56:25 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:36339 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271333AbRHOR4K>; Wed, 15 Aug 2001 13:56:10 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108151755.f7FHtmTH013535@webber.adilger.int>
Subject: Re: *** ANNOUNCEMENT *** LVM 1.0 available at www.sistina.com
In-Reply-To: <20010815185005.A32239@sistina.com> "from Heinz J . Mauelshagen
 at Aug 15, 2001 06:50:05 pm"
To: mauelshagen@sistina.com
Date: Wed, 15 Aug 2001 11:55:48 -0600 (MDT)
CC: Kurt Garloff <garloff@suse.de>, linux-lvm@sistina.com,
        lvm-devel@sistina.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sistina@sistina.com, mge@sistina.com
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heinz writes:
> On Wed, Aug 15, 2001 at 06:25:48PM +0200, Kurt Garloff wrote:
> > Is there finally a decent way to upgrade from 0.9.1b7?
> > Or is it still required to have multiple versions of the utils installed
> > just in order to be able to update from 0.9.1b7 to b8 (or 1.0)?
> 
> Well, as explained before on the lists we had an algorithm calculating
> the offset to the first PE in place till 0.9.1 Beta 7.
>
> Therefore, we *need* to run the installed version < LVM 0.9.1 Beta 8 to
> retrieve that sector offset for all PVs and change the metadata to hold the
> offset. No known way around this.

Sorry, I don't get the list email anymore, despite it telling me I'm
subscribed (may be my fault, I don't know), please reply to l-k where
I know I will see it.

Saying you "need" the old versions of the installed tools to read the
on disk data is bogus, IMNSHO.  You could easily have a flag which says
"calculate the PE offsets using the old algorithm or the new algorithm".
This could easily be keyed off of the presence/absence of the new
pe_offset field in the pv_data struct on disk, and whether or not you
actually have the misaligned PEs in the first place.

When I talked to them last, the IBM EVMS folks didn't have any such
problems correctly reading either the old (possibly offset) or new
layouts with the same driver.

Also, since this bug exists only for a limited number of users (only a
subset of users who created volumes with beta 5 and beta 6), it causes
grief for anyone who is NOT affected by the bug.

> > If yes, then I'd vote for not updating the kernel until this is fixed!
> 
> Well, we need to migrate the metadata in the future anyway once we want
> to offer support for enhanced metadata reliability and redundancy.

Well, that is the future, and should not impact users of 2.4.x kernels.
Just like we found an acceptable workaround to the (incompatible) IOP 11
change (which was later reverted), it is possible to find an acceptable
workaround for the new incompatible change.  Sadly, it is no longer my
job to fix such things, and I don't have any systems here that need
fixing.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

