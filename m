Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282482AbRLFSfV>; Thu, 6 Dec 2001 13:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282489AbRLFSfP>; Thu, 6 Dec 2001 13:35:15 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:59282 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S282482AbRLFSes>; Thu, 6 Dec 2001 13:34:48 -0500
Date: Thu, 6 Dec 2001 11:39:41 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Jens Axboe <axboe@suse.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org
Subject: Re: new bio: compile fix for alpha
Message-ID: <20011206113941.B22810@vger.timpanogas.org>
In-Reply-To: <20011129165456.A13610@jurassic.park.msu.ru> <20011129152339.M10601@suse.de> <20011206204330.A608@jurassic.park.msu.ru> <20011206182318.GI4996@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206182318.GI4996@suse.de>; from axboe@suse.de on Thu, Dec 06, 2001 at 07:23:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens,

This interface is totally cool and much appreciated.  I am 
nearly done getting the page cache mapped into NWFS.  I am 
waiting for the bugs to settle down, I still see some issues
with the AHA1512 drivers, but IDE works great and is 
really fast.

Jeff


On Thu, Dec 06, 2001 at 07:23:18PM +0100, Jens Axboe wrote:
> On Thu, Dec 06 2001, Ivan Kokshaysky wrote:
> > On Thu, Nov 29, 2001 at 03:23:39PM +0100, Jens Axboe wrote:
> > > Please send whatever you find, thanks.
> > 
> > Well, I think this one is critical - in -pre4 BIO_CONTIG macro
> > has been changed:
> > -	(bio_to_phys((bio)) + bio_size((bio)) == bio_to_phys((nxt)))
> > +	(bvec_to_phys(__BVEC_END((bio)) + (bio)->bi_size) ==bio_to_phys((nxt)))
> > 		      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > This means that you add size in bytes to the `struct bio_vec' pointer,
> > which is obviously bogus. I wonder why this typo didn't expose itself
> > on x86 - on alpha I've got an oops on very first disk i/o in partition
> > check...
> 
> Irk, good spotting. Thanks!
> 
> > The rest is cleaning up some format vs. arg inconsistency on 64-bit
> > platforms.
> > Oh, and yet another [incorrect] BUG_ON macro on alpha killed.
> 
> Applied, although I think we'll make BUG_ON a kernel generic and not
> platform specific as per Rusty's patch.
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
