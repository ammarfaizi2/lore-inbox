Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267881AbRGRN0x>; Wed, 18 Jul 2001 09:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267876AbRGRN0n>; Wed, 18 Jul 2001 09:26:43 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:59921 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267880AbRGRN01>; Wed, 18 Jul 2001 09:26:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>,
        Craig Soules <soules@happyplace.pdl.cmu.edu>
Subject: Re: NFS Client patch
Date: Wed, 18 Jul 2001 15:30:07 +0200
X-Mailer: KMail [version 1.2]
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96L.1010717180713.13980K-100000@happyplace.pdl.cmu.edu> <3B54BA7A.42B0E107@namesys.com>
In-Reply-To: <3B54BA7A.42B0E107@namesys.com>
MIME-Version: 1.0
Message-Id: <01071815300708.12129@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 July 2001 00:21, Hans Reiser wrote:
> Craig Soules wrote:
> > On Wed, 18 Jul 2001, Hans Reiser wrote:
> > > I take issue with the word "properly".  We have bastardized our
> > > FS design to do it.  NFS should not be allowed to impose stable
> > > cookie maintenance on filesystems, it violates layering.  Simply
> > > returning the last returned filename is so simple to code, much
> > > simpler than what we have to do to cope with cookies.  Linux
> > > should fix the protocol for NFS, not ask Craig to screw over his
> > > FS design.  Not that I think that will happen.....
> >
> > Unfortunately to comply with NFSv2, the cookie cannot be larger
> > than 32-bits.  I believe this oversight has been correct in later
> > NFS versions.
> >
> > I do agree that forcing the underlying fs to "fix" itself for NFS
> > is the wrong solution. I can understand their desire to follow unix
> > semantics (although I don't entirely agree with them), so until I
> > think up a more palatable solution for the linux community, I will
> > just keep my patches to myself :)
> >
> > Craig
>
> 64 bits as in NFS v4 is still not large enough to hold a filename. 
> For practical reasons, ReiserFS does what is needed to work with NFS,
> but what is needed bad design features, and any FS designer who
> doesn't feel the need to get along with NFS should not have
> acceptance of bad design be made a criterion for the acceptance of
> his patches.  Just let NFS not work for Craig's FS, what is the
> problem with that?

I was planning to add coalesce-on-delete to my ext2 directory index
patch at some point, now I see I'll step right into this NFS
doo-d^H^H^H^H^H problem.  What to do?  Obviously it's not an option
to have NFS not work for ext2.  Just leaving the directory 
uncoalesced fixes the problem in some sense and doesn't hurt things
all that much.  Ext2 has been running that way for years.

Can I automagically know that a directory is mounted via NFS and
disable the coalescing?  Or maybe I need a -o coalesce=on/off, with
"off" as the default.  Ugh.

As you point out, this sucks.

--
Daniel
