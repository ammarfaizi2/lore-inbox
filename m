Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTJRUHc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 16:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbTJRUHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 16:07:32 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:20608 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261779AbTJRUHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 16:07:30 -0400
Date: Sat, 18 Oct 2003 21:08:52 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310182008.h9IK8qrb000621@81-2-122-30.bradfords.org.uk>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>, Krzysztof Halasa <khc@pm.waw.pl>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB2EE@mcoexc04.mlm.maxtor.com>
References: <785F348679A4D5119A0C009027DE33C105CDB2EE@mcoexc04.mlm.maxtor.com>
Subject: RE: Blockbusting news, this is important (Re: Why are bad disk se ctors numbered strangely, and what happens to them?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Plus, all data recovery would be on drives already sold...  Since every
> drive optimizes itself as part of the manufacturing process to the exact
> capabilities of the channel ASIC, heads they were manufactured with, etc,
> the only way for these new recovery tools to work reliably would be to use
> option #1 above, which I've already said isn't worth the cost.  I hear about
> people swapping PCBs on disk drives to recover data when one fries... yes
> this can work to some degree, but I absolutely wouldn't trust anything
> written in a swapped-board setup.

Ah, OK, this is interesting, so basically it's not realistic to
produce 'data recovery PCBs' for $5000 each, which allow direct
head-seeks, and raw data extraction etc.  Fair enough.  I'm not really
interested in data recovery at this level, to be honest, something is
very wrong if backups haven't been made, and dieing drives been
detected long before then.

> > Although, to be honest, except where performance is critical, remap on
> > read is pointless.  It saves you from having to identify the bad block
> > again when you write to it.  Generally, guaranteed remap on write is
> > what I want.  What happens on read is less important if your data
> > isn't intact.  I can see your point of view for not re-mapping on read
> > given that advanced firmwares are not available, and the fact that it
> > allows you to do some form of data recovery.  Overall, though, if it
> > gets to the point where you have to start doing such data recovery,
> > downtime is usually significant, and for some applications, having the
> > data in a week's time may be little more than useless.  Predicting
> > possible disk fauliures is a good idea.
> 
> Writes are destructive, and very often "fix" the problem on the media.  If
> the write succeeds, and can be read by the disk, there's no point in
> remapping.

I totally agree - the world outside the drive doesn't even need to
know this, and the drive should be trusted to make the right decision,
and be critical about it, (I.E. use an area previously thought to be
bad, but only if it tests _really_ good now, not marginal requiring
multiple reads and every last bit of error correction possible to get
the data back).

I am not saying that it's a great thing to risk re-using an area that
was previously bad, far from it, but the place to make the decision as
to whether the area is indeed bad or not is inside the drive, based on
all the data it has available, not from the host, based on the
limited, interpreted data available from the drive.

> It is only when you're unable to write to a specific area that
> remap-on-write makes any sense.

But it is very important, (in my opinion), that it _does_ remap in
that case.  Specifically, I don't think that an unrecoverable read
error should prevent any future writes to that LBA address from
succeeding, unless the drive is out of spare blocks.

Reporting a write failure to the user should never happen on a drive
capable of defect management.

> We keep track of where we have trouble reading or writing, and use that to
> reassign based on various criteria automatically.
> 
> Best data to use, I'd guess, for "predicting" failures, is the blown rev
> counter in smart.  If you're blowing revs, you're having trouble getting the
> data you want off or onto the drive.

Which attribute is that?  I can't see anything like that in the SMART
output from a Maxtor disk, but it sounds like a useful measurement :-/.

John.
