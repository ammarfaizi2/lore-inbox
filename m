Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280940AbRKGUDA>; Wed, 7 Nov 2001 15:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280943AbRKGUCt>; Wed, 7 Nov 2001 15:02:49 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:64443 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280940AbRKGUCl>;
	Wed, 7 Nov 2001 15:02:41 -0500
Date: Wed, 7 Nov 2001 15:02:29 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Stephen Tweedie <sct@redhat.com>, ext2-devel@lists.sourceforge.net,
        m@mo.optusnet.com.au, Andrew Morton <akpm@zip.com.au>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] ext2/ialloc.c cleanup
In-Reply-To: <20011107123430.D5922@lynx.no>
Message-ID: <Pine.GSO.4.21.0111071446020.4283-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Nov 2001, Andreas Dilger wrote:

> Minor nits, from my changes to this same function:
> 1) please replace use of "i" for best block group in find_cg_*, to
>    something better like "group", just for clarity.

Consider that done.

> 2) in find_cg_*, when you fail the quadratic search, the linear search
>    should skip groups that were previously checked in the quadratic search,
>    with slight changes to both loops:

I'm not actually sure that it's a good thing.  The different between the
sequences we do is that I do
	n n+1 n+3 n+7 ... n+2 (linear)
and you do
	n n+1 n+2 n+4 n+8 ... n+3 (linear)
which has slightly worse properties.  You avoid duplicated check on n+3,
but lose a very nice property - shifting the old sequence is guaranteed
not to have many intersections with original in the beginning (distances
between elements do not repeat).  With your sequence it's no longer true.

> 3) I know that "cylinder groups" were used in old FFS/whatever implementation,
>    but all of the ext2 code/documentation refers to these as block groups.
>    Can you stick with that for ext2 (e.g. gdp, not cg; bg_foo, not cg_foo)?

Ehh... Try to read that aloud.  Maybe it's just me, but "gdp" sounds (and
looks) bad...

> 4) sbi can be gotten by "EXT2_SB(sb)".

True, consider that done.

Right now I'm doing alternative strategy for directory allocation, as soon
as I finish that I'll put the result on usual place.

