Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132428AbQK3BET>; Wed, 29 Nov 2000 20:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132504AbQK3BEK>; Wed, 29 Nov 2000 20:04:10 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:20940 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S132489AbQK3BD5>;
        Wed, 29 Nov 2000 20:03:57 -0500
Date: Wed, 29 Nov 2000 19:33:30 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.4.0-test11 ext2 fs corruption
In-Reply-To: <news2mail-3A259959.89EAD4DE@innominate.de>
Message-ID: <Pine.GSO.4.21.0011291931180.17068-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Nov 2000, Daniel Phillips wrote:

> Alexander Viro wrote:
> > Bloody hell...
> 
> I don't know if this is the bug he's got, in fact I doubt it, but it's a
> bug and it needs fixing.  The problem is, ext2_get_group_desc
> effectively returns two results; one of them is being assigned from on
> conditional paths and the other isn't.  This bug will cause - on very
> rare occasions - the wrong group descriptor block to be marked dirty,
> and changes might be lost.  I think what we'd see as a result is wrong
> block, inode and directory counts.
> 
> The fix below is kind of gross.  The way I really want to do the fix is
> to remove one parameter from ext2_get_group_desc and thereby get rid of
> the troublesome side effect for good, but that kind of change isn't
> compatible with 'code freeze'.

Yes, it is. Moreover, correct solution is slightly different and changes
ext2_get_group_desc() semantics. Wait until tomorrow, OK?

However, it's not the source of reported problems. We clearly have b0rken
data in bitmaps themselves.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
