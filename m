Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131619AbQLVBSy>; Thu, 21 Dec 2000 20:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131630AbQLVBSo>; Thu, 21 Dec 2000 20:18:44 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:7689 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S131619AbQLVBSm>; Thu, 21 Dec 2000 20:18:42 -0500
Date: Fri, 22 Dec 2000 01:48:10 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        adilger@turbolinux.com
Subject: Re: [PATCH] Re: fs corruption with invalidate_buffers()
Message-ID: <20001222014810.A1419@gondor.com>
In-Reply-To: <20001222010334.A984@gondor.com> <Pine.LNX.4.10.10012211634440.945-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012211634440.945-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 21, 2000 at 04:37:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2000 at 04:37:30PM -0800, Linus Torvalds wrote:
> This looks bogus.

It may be - I just did what Al told me without really understanding it ;-)

The test I did initially was the following:

if(!atomic_read(&bh->b_count) &&
	(destroy_dirty_buffers || !buffer_dirty(bh))
	&& ! (bh->b_page && bh->b_page->mapping)
	)

That is, I was explicitely checking for a mapped page. It worked well, too.
Is this more reasonable?

Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
