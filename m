Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276507AbRJGR4V>; Sun, 7 Oct 2001 13:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276505AbRJGR4L>; Sun, 7 Oct 2001 13:56:11 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:2552 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276507AbRJGRzw>;
	Sun, 7 Oct 2001 13:55:52 -0400
Date: Sun, 7 Oct 2001 13:56:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Tobias Ringstrom <tori@ringstrom.mine.nu>, Simon Kirby <sim@netnation.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11pre4 swapping out all over the place
In-Reply-To: <Pine.LNX.4.33.0110071031160.7151-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0110071347390.8020-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Oct 2001, Linus Torvalds wrote:

> > I just noticed that when reading from an umounted block device, the pages
> > are not cached between runs, i.e. the cache is dropped on close().  If the
> > block device contains a mounted filesystem, the pages are not dropped.
> > Is this intentional?

Actually, they are dropped as soon as there's no openers left.  mounted
fs counts as opener, so does opened file.

> It's intentional, although something that can probably be discussed. The
> reasons for it are:
>  - devices with broken or unreliable disk change mechanisms
>  - the current dynamic [de-]allocation of block device data structures.
>  - historical coherency reasons.
 
   - current logics for driver use count.  Block ones do MOD_INC_US_COUNT
on->open() and MOD_DEC_USE_COUNT on ->release().

