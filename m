Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSFMS04>; Thu, 13 Jun 2002 14:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317403AbSFMS0z>; Thu, 13 Jun 2002 14:26:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51361 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315455AbSFMS0y>;
	Thu, 13 Jun 2002 14:26:54 -0400
Date: Thu, 13 Jun 2002 14:26:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andi Kleen <ak@muc.de>
cc: engler@csl.Stanford.EDU, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <m3d6uvxdts.fsf@averell.firstfloor.org>
Message-ID: <Pine.GSO.4.21.0206131420010.20315-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 Jun 2002, Andi Kleen wrote:

> Alexander Viro <viro@math.psu.edu> writes:
> > 
> > I mean that due to the loop (link_path_walk->do_follow_link->foofs_follow_link
> > ->vfs_follow_link->link_path_walk) you will get infinite maximal depth
> > for everything that can be called by any of these functions.  And that's
> > a _lot_ of stuff.
> 
> Surely an analysis pass can detect recursive function chains and flag them
> (e.g. the global IPA alias analysis pass in open64 does this)

Ugh...  OK, let me try again:

One bit of apriory information needed to get anything interesting from
this analysis:  there is a set of mutually recursive functions (see above)
and there is a limit (5) on the depth of recursion in that loop.

It has to be known to checker.  Explicitly, since
	a) automatically deducing it is not realistic
	b) cutting off the stuff behind that loop will cut off a _lot_ of
things - both in filesystems and in VFS (and in block layer, while we are
at it).

I'm not saying that checker can't be used for that analysis - it can, but
naive approach (find recursive stuff and cut it off) will not be too
interesting.  One of the main stumbling blocks - see above.  With explicit
knowledge of that one the thing will be definitely very interesting - no
arguments here.

