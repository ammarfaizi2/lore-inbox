Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312106AbSCQUTY>; Sun, 17 Mar 2002 15:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312109AbSCQUTQ>; Sun, 17 Mar 2002 15:19:16 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:46545 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312108AbSCQUTC>; Sun, 17 Mar 2002 15:19:02 -0500
Date: Sun, 17 Mar 2002 13:18:50 -0700
Message-Id: <200203172018.g2HKIoB12081@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C945D7D.8040703@mandrakesoft.com>
In-Reply-To: <3C945635.4050101@mandrakesoft.com>
	<3C945A5A.9673053F@zip.com.au>
	<3C945D7D.8040703@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Andrew Morton wrote:
> 
> >Jeff Garzik wrote:
> >>So... we have madvise, why not fadvise?  I would love the capability for
> >>applications to provide hints to the OS like madvise, but for file
> >>descriptors...
> >>
> >
> >The one hint which I can think of which would be beneficial would
> >be an equivalent to MADV_SEQUENTIAL.  Something which says "this
> >is a big streaming read/write - don't go and evict other stuff because
> >of it".  O_STREAMING perhaps.  Or working dropbehind heuristics,
> >although I suspect that explicit controls will always do better.
> >
> >For MADV_RANDOM, readahead window scaling should get that right.
> >
> >What else were you thinking of?
> >
> 
> Hints for,
> * sequential read
> * sequential write
> * sequential write, where the application considers the data it's 
> writing to be unlikely to be read again any time soon (hopefully 
> implying to the page cache that these pages have low value as cacheable 
> objects)
> * some sort of streaming hints, implying that the application cares a 
> lot about maintaining some minimum i/o rate.  note I said hint, not 
> requirement.  -not- guaranteed-rate-IO.
> 
> I might even go so far as to advocate identifying common usage
> patterns, and creating hint constants for them, even if we don't
> support them in the kernel immediately (if ever).  Makes the
> interface much more future-proof, at the expense of a few integers
> in a 32-bit numberspace, and a few more bytes in the C compiler's
> symbol table.

Here's one that I'd like (came up recently with these 21600x21600x3
images from NASA:-): MADV_REVERSE_SEQUENTIAL. When converting images
from stupid formats which have the origin in the top-left, to formats
which have the origin in the bottom-left (the way god intended), you
can avoid a massive malloc(3) if you read the input file backwards
(basically through llseek(2) steps).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
