Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288781AbSA3Hwn>; Wed, 30 Jan 2002 02:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288811AbSA3HwY>; Wed, 30 Jan 2002 02:52:24 -0500
Received: from waste.org ([209.173.204.2]:59798 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S288781AbSA3HwM>;
	Wed, 30 Jan 2002 02:52:12 -0500
Date: Wed, 30 Jan 2002 01:52:10 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-list] Re: [reiserfs-dev] Re: Note describing poordcache
   utilization under high memory pressure
In-Reply-To: <3C57A1A9.E31CDB13@zip.com.au>
Message-ID: <Pine.LNX.4.44.0201300142180.25123-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Andrew Morton wrote:

> Oliver Xymoron wrote:
> >
> > On Tue, 29 Jan 2002, Andrew Morton wrote:
> >
> > > Andreas Dilger wrote:
> > > >
> > > > But if it is unused and not recently referenced, there is little benefit
> > > > in keeping it around, is there?
> > >
> > > In all of this, please remember that all caches are not of
> > > equal value-per-byte.  A single page contains 32 dentries,
> > > and can thus save up to 32 disk seeks.  It's potentially
> > > a *lot* more valuable than a (single-seek) pagecache page.
> >
> > Or it might equally well be 32 contiguous directory entries that you
> > scanned over to get to the file you wanted.
>
> The `scanned over' entries will be retained in the pagecache,
> not in the dentry cache.

For most values of 'scanned over', but not all. There are lots of ways of
looking for something that will prime the dcache..

> > If it's 32 hot items, as a
> > page it's going to be aged significantly less than one equally hot
> > pagecache page, so I don't think we need to worry about that too much.
>
> Sure they're LRU at present and we could use the referenced bit
> in their backing page in the future.
>
> But what we do *not* want to do is to reclaim memory "fairly" from
> all caches.  The value of a cached page should be measured in terms
> of the number of seeks required to repopulate it.  That's all.

..which may be zero in the above case if the dentries are all backed by
dirs in the page cache you mentioned. Or one in the case of dentries found
by visiting neighboring files. It's very hard to guess at what that number
is for any discardable VM object because it's entirely dependent on what
else is in cache and what order the data's accessed.

I'm sure that there is some merit to valuing some caches more highly than
other but there are obviously other issues to sort out before we can begin
weighing them against each other.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

