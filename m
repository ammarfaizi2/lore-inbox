Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132099AbQK2U17>; Wed, 29 Nov 2000 15:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132100AbQK2U1t>; Wed, 29 Nov 2000 15:27:49 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:22174 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S132099AbQK2U1j>;
        Wed, 29 Nov 2000 15:27:39 -0500
Date: Wed, 29 Nov 2000 14:57:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries.Brouwer@cwi.nl, Tigran Aivazian <tigran@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <Pine.LNX.4.10.10011291121090.15230-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0011291437240.16506-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000, Linus Torvalds wrote:

> 
> 
> On Wed, 29 Nov 2000, Alexander Viro wrote:
> > 
> > Problem fixed by Jens' patch had been there since March, so if it's a
> > mix of __make_request() screwing up and something else... Urgh.
> 
> No, the bug really got introduced in test11 due to the request merging
> stuff.
> 
> The patch may _look_ like it fixed a generic problem that has been there
> forever, but we didn't actually need the spinlock for initializing "head"

Sure.

> at all. It's initialized to a constant offset within the unchaning request
> queue, so we can happily do it outside the spinlock.

Actually, I was not thinking about spinlock. What I missed was the fact
that again: was quite recent. My apologies...

> > I'ld really like to see details on the box with ext2 corruption on SCSI.
> > Tigran, IIRC you had it on SCSI boxen, right? Could you send me relevant
> > part of logs?
> 
> I suspect that Tigran may have seen other instability (of which we had
> lots back when he saw it), and that the current rash is for the IDE
> problem only. 
> 
> Which is not to say that there might not be SCSI issues or other issues
> too, but I'm also not convinced that the SCSI thing might not just be a
> red herring at this point.

There are two quite distinct patterns: duplicated range vs. crap in metadata.
The former looks like a bug caught by Jens. The latter (especially in
bitmaps) seems to be older[1] and independent from elevator stuff. _That_ may
be a fs/buffer.c or fs/ext2/* bug. The former definitely lives below the
fs/buffer.c level.

[1] "older" may mean "shared with 2.2" here - ISTR bug reports looking like
that and IIRC they were never resolved. BTW, if you know some searchable
l-k archive... DN sucks coprolites through the straw these days ;-/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
