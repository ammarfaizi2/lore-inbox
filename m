Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131925AbRAAPrk>; Mon, 1 Jan 2001 10:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131862AbRAAPra>; Mon, 1 Jan 2001 10:47:30 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:23486 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131925AbRAAPrV>;
	Mon, 1 Jan 2001 10:47:21 -0500
Date: Mon, 1 Jan 2001 10:16:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Roman Zippel <zippel@fh-brandenburg.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.GSO.4.10.10101011119240.10093-100000@zeus.fh-brandenburg.de>
Message-ID: <Pine.GSO.4.21.0101011006300.10106-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Jan 2001, Roman Zippel wrote:

> The other reason for the question is that I'm currently overwork the block
> handling in affs, especially the extended block handling, where I'm
> implementing a new extended block cache, where I would pretty much prefer
> to use a semaphore to protect it. Although I could do it probably without
> the semaphore and use a spinlock+rechecking, but it would keep it so much
> simpler. (I can post more details about this part on fsdevel if needed /
> wanted.)

But... But with AFFS you _have_ exclusion between block-allocation and
truncate(). It has no sparse files, so pageout will never allocate
anything. I.e. all allocations come from write(2). And both write(2) and
truncate(2) hold i_sem.

Problem with AFFS is on the directory side of that business and there it's
really scary. Block allocation is trivial...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
