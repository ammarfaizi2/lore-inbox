Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313316AbSC2A2B>; Thu, 28 Mar 2002 19:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313317AbSC2A1w>; Thu, 28 Mar 2002 19:27:52 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:64260 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313316AbSC2A1l>; Thu, 28 Mar 2002 19:27:41 -0500
Message-ID: <3CA3B48F.25F9042D@zip.com.au>
Date: Thu, 28 Mar 2002 16:25:51 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <3CA356AE.2E61F712@zip.com.au> <Pine.GSO.4.21.0203281838310.25746-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Thu, 28 Mar 2002, Andrew Morton wrote:
> 
> > > For one thing, the latter is hell on any search.
> >
> > If the usage of the type is hard to search for then
> > then wrong identifier was chosen.
> 
> Huh?
> 
> Search for ext2_sb_info will give you all places that refer to it.
> Including a buttload of
>         struct ext2_sb_info *p;
> 
> Now, search for ext2_sb_info[   ]*[^    *] is much more interesting.
> With explicit sizeof it is guaranteed to give you all places where
> such beast is allocated or subjected to memset, etc.

Where "etc" is "typecast".  I can't think of much else
which would be found.

So the search for ext2_sb_info found the function, and
then you're down to perfoming a forward search for "p".
Which, of course, doesn't work because "p" is an asinine
identifier.  Which was my point.  (Insert monthly whine
about ext2_new_block)

> ...
> BTW, I _really_ wonder who had audited lvm.c for inclusion - quite a
> few places in there pull such lovely stunts as, say it, use of strcmp()
> on a user-supplied array of characters.  Whaddya mean, "what if there's
> no NUL"?  Sigh...

We do not appear to have an "audit for inclusion" process.
I wish we did.  If a tree owner threw a patch at me and
asked for comments I'd gladly help out that way.  Jeff
did some absolutely brilliant work on the e100/e1000
drivers behind the scenes - it'd be nice to have more of that.

BTW, ext3 keeps a kdev_t on-disk for external journals.  The
external journal support is experimental, added to allow people
to evaluate the usefulness of external journalling.  If we
decide to retain the capability we'll be moving it to a UUID
or mount-based scheme.  So if the kdev_t is being a problem,
I think we can just break it.

-
