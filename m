Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262651AbREOGUq>; Tue, 15 May 2001 02:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262652AbREOGUg>; Tue, 15 May 2001 02:20:36 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:44954 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262651AbREOGU3>; Tue, 15 May 2001 02:20:29 -0400
Date: Tue, 15 May 2001 00:20:20 -0600
Message-Id: <200105150620.f4F6KKd22491@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <Pine.LNX.4.21.0105142130480.23663-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0105142054180.23578-100000@penguin.transmeta.com>
	<Pine.LNX.4.21.0105142130480.23663-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> You could choose to do "partial coherency", ie be coherent only one
> way, for example. That would make the coherency overhead much less,
> but would also make the caches basically act very unpredictably -
> you might have somebody write through the page cache yet on a read
> actually not _see_ what he wrote, because it got written out to disk
> and was shadowed by cached data in the buffer cache that didn't get
> updated.

OK, I see your concern. And the old way of doing things, placing a
copy in the buffer cache when the page cache does a write, will eat
away performance.

However, what about simply invalidating an entry in the buffer cache
when you do a write from the page cache? By the time you get ready to
do the I/O, you have the device bnum, so then isn't it a trivial
operation to index into the buffer cache and invalidate that block?

Is there some other subtlety I'm missing here?

Actually, I'd kind of like it if the page cache steals from the buffer
cache on read. The buffer cache is mostly populated by fsck. Once I've
done the fsck, those buffers are useless to me. They might be useful
again if they are steal-able by the page cache.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
