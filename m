Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288679AbSADQjX>; Fri, 4 Jan 2002 11:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288680AbSADQjN>; Fri, 4 Jan 2002 11:39:13 -0500
Received: from chunnel.redhat.com ([12.107.208.220]:5616 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S288679AbSADQjE>; Fri, 4 Jan 2002 11:39:04 -0500
Date: Fri, 4 Jan 2002 16:38:34 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd 	kern el panic woes
Message-ID: <20020104163834.H1896@redhat.com>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB0F@mail0.myrio.com> <200112201946.fBKJkNw01262@penguin.transmeta.com> <20011221004251.K1477@athlon.random>, <20011221004251.K1477@athlon.random>; <20011221024910.L1477@athlon.random> <3C22CF16.C78B1F19@zip.com.au>, <3C22CF16.C78B1F19@zip.com.au>; <20011229164056.H1356@athlon.random> <3C2EB208.B2BA7CBF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C2EB208.B2BA7CBF@zip.com.au>; from akpm@zip.com.au on Sat, Dec 29, 2001 at 10:19:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[catching up from holidays]

On Sat, Dec 29, 2001 at 10:19:52PM -0800, Andrew Morton wrote:
> 
> It appeared in 2.4.2-ac25, and it looks like sct was the author:
> 
> o       Fix higmem block_prepare_write crash            (Stephen Tweedie)
> 
> Which is interesting - from the changelog it looks like he was
> fixing a different problem!  I always though that code was there
> to prevent leakage of stale blocks.  Stephen?

The code I fixed was the

-			memset(bh->b_data, 0, bh->b_size);
+			memset(kaddr+block_start, 0, bh->b_size);

chunk to prevent the block_prepare_write out: error path from oopsing
on highmem pages -- that's unrelated to the problem at hand here.

Cheers,
 Stephen
