Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281921AbRLFSZz>; Thu, 6 Dec 2001 13:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281923AbRLFSZn>; Thu, 6 Dec 2001 13:25:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55314 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281916AbRLFSXi>;
	Thu, 6 Dec 2001 13:23:38 -0500
Date: Thu, 6 Dec 2001 19:23:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new bio: compile fix for alpha
Message-ID: <20011206182318.GI4996@suse.de>
In-Reply-To: <20011129165456.A13610@jurassic.park.msu.ru> <20011129152339.M10601@suse.de> <20011206204330.A608@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011206204330.A608@jurassic.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06 2001, Ivan Kokshaysky wrote:
> On Thu, Nov 29, 2001 at 03:23:39PM +0100, Jens Axboe wrote:
> > Please send whatever you find, thanks.
> 
> Well, I think this one is critical - in -pre4 BIO_CONTIG macro
> has been changed:
> -	(bio_to_phys((bio)) + bio_size((bio)) == bio_to_phys((nxt)))
> +	(bvec_to_phys(__BVEC_END((bio)) + (bio)->bi_size) ==bio_to_phys((nxt)))
> 		      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This means that you add size in bytes to the `struct bio_vec' pointer,
> which is obviously bogus. I wonder why this typo didn't expose itself
> on x86 - on alpha I've got an oops on very first disk i/o in partition
> check...

Irk, good spotting. Thanks!

> The rest is cleaning up some format vs. arg inconsistency on 64-bit
> platforms.
> Oh, and yet another [incorrect] BUG_ON macro on alpha killed.

Applied, although I think we'll make BUG_ON a kernel generic and not
platform specific as per Rusty's patch.

-- 
Jens Axboe

