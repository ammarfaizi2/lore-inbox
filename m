Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRB1Tl7>; Wed, 28 Feb 2001 14:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbRB1Tlt>; Wed, 28 Feb 2001 14:41:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:3087 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129242AbRB1Tli>; Wed, 28 Feb 2001 14:41:38 -0500
Date: Wed, 28 Feb 2001 11:41:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Steve Whitehouse <Steve@ChyGwyn.com>
cc: pavel@suse.cz, Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: NBD Cleanup patch and bugfix in ll_rw_blk.c
In-Reply-To: <200102251957.TAA01718@gw.chygwyn.com>
Message-ID: <Pine.LNX.4.10.10102281138470.5932-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Feb 2001, Steve Whitehouse wrote:
> 
> Here is a new version of the patch I recently sent to the list with some 
> NBD cleanups and a bug fix in ll_rw_blk.c. The changes to NBD have Pavel 
> Machek's approval as I've left out the two changes as he suggested.
> 
> The bug fix in ll_rw_blk.c prevents hangs when using block devices which
> don't have plugging functions,

I'm convinced that the right fix is to just make everybody have plugging
functions.

Right now, who doesn't? The fix is unbelievably ugly, AND can break real
drivers that _do_ have plugging functions (where they get surprised by
having their request function called several times per plug just because 
somebody unplugged them and new requests came in).

Just fix ndb instead.

		Linus

