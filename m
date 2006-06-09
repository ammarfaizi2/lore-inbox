Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWFIR7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWFIR7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWFIR7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:59:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:55733 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030289AbWFIR7F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:59:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
cc: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3 
In-reply-to: Your message of Fri, 09 Jun 2006 09:09:01 PDT.
             <Pine.LNX.4.64.0606090907060.5498@g5.osdl.org> 
Date: Fri, 09 Jun 2006 10:58:00 -0700
Message-Id: <E1FolFA-0007RU-Ab@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Jun 2006 09:09:01 PDT, Linus Torvalds wrote:
> On Fri, 9 Jun 2006, Gerrit Huizenga wrote:
> > 
> > Jeff's approach taken to the rediculous would mean that we'd have
> > ext versions 1-40 by now at least.  I don't think that helps much,
> > either.
> 
> On the other hand, I _guarantee_ you that it helps that we have ext2-3, 
> and not just ext2 (nobody even tried to keep ext1 compatible, thank the 
> Gods).
 
I had originally argued for ext4 as well based on the fact that it would
allow lots of potential cleanups & simplifications and at the same time
would allow a break in the on disk filesystems layout.

These changes don't yet change the actual on-disk layout and that might
be something that would be done if ext4 were a real, new filesystem.

But then how long until ext4 is used enough to be put into production?
How much testing will it *really* get in any form?  How long before
the people that are using 100 TB+ disk farms today (some of which are
chopping filesystems into 2-8 GB chunks, others with 2 TB filesystems
today) actually trust this new filesystem (most vendors don't support
JFS today, XFS support isn't much better).

We are seeing storage needs increasing at a frightening rate.  Health
Care folks want to store your MRI's, x-ray's, ultraounds, etc. in high
res digital format across your entire life in near-line format.  Terabytes
over time per person.  Europe is already doing this pretty extensively,
the US is following suit.  Digital media creation has huge storage needs.
Most everything is moving to podcasts, webcasts, streaming audio & video.
Storage is huge, and ext3 is at the current breaking point.

I'd argue that whatever we call it, we need a standard, stable, supported
solution *soon* for large files, large filesystems, large storage systems
in Linux.

I'd think the quickest path is to relieve the pressure now in ext3.

We still haven't solved the filesystem check time problem, which is the
next big bugaboo.  But getting large fileysstems to real customers soon,
e.g. in mainline, well tested, ready for distro support is my real goal.

> If for no other reason, than the fact that the ext3 development could be 
> much more aggressive early on. Exactly because it did NOT screw up the old 
> filesystem that everybody else depended on.

Yes, but we want agressive with robustness for real users soon.  Lots
of crazy ext4 development could become technical wanking in no time, with
no point of stability, and no general usefulness in the short term.

> So we have empirical evidence that splitting filesystem work up does 
> actually help. 

Agreed.  But... Maybe that should be the set of changes *following*
extents.  Then the file format can change, several of the pending ideas
can be worked in, and some of the backwards compatibility can be cleaned
out if it is in the way.  Then the extents work can get us something
usable in all the interim distro releases for the real users who are
screaming now about the filesystem size limits.

gerrit
