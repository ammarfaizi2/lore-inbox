Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144138AbRAHOwr>; Mon, 8 Jan 2001 09:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144124AbRAHOw1>; Mon, 8 Jan 2001 09:52:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28888 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S144123AbRAHOwW>;
	Mon, 8 Jan 2001 09:52:22 -0500
Date: Mon, 8 Jan 2001 09:52:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <E14FdTa-0004fs-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0101080941430.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Alan Cox wrote:

> > > Why not start to fix this problem outside the funny switch/case in glibc ?
> > > The filesystem itself should able to handle this.
> > 
> > Sigh... And the API would be?
> 
> In SuS its pathconf()

Which happens to be remarkably ugly. And it will not get better tomoorow...

I _really_ don't think that this barfbag should make its way into the
kernel API. Some parts of information make sense. Some don't. API is...
well, "int name" with a bunch of constatnts is a dead giveaway in itself.

If anything, we might want a mount-ID created upon mount(2) and never
reused + pseudo-fs a-la /proc that would give access to per-mount data.
That might be more or less reasonable, but that would also require
returning such ID from stat()...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
