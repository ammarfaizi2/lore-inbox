Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbTKGWxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbTKGWxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:53:32 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:19727 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262133AbTKGWxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 17:53:05 -0500
Date: Sat, 8 Nov 2003 09:52:53 +1100
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BIO] Bounce queue in bio_add_page
Message-ID: <20031107225253.GA8864@gondor.apana.org.au>
References: <20031103205234.GA17570@gondor.apana.org.au> <20031104084929.GH1477@suse.de> <20031104090325.GA21301@gondor.apana.org.au> <20031104090353.GM1477@suse.de> <20031105094855.GD1477@suse.de> <20031106210900.GA29000@gondor.apana.org.au> <20031107112346.GA5153@gondor.apana.org.au> <20031107112555.GC591@suse.de> <20031107112833.GA5239@gondor.apana.org.au> <20031107113235.GD591@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031107113235.GD591@suse.de>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07, 2003 at 12:32:35PM +0100, Jens Axboe wrote:
> On Fri, Nov 07 2003, Herbert Xu wrote:
> > On Fri, Nov 07, 2003 at 12:25:55PM +0100, Jens Axboe wrote:
> > > 
> > > Could be related, someone is doing an unlock on an already unlocked
> > > page. Is this the same system that saw the bounce problem initially?
> > 
> > Yes, see http://bugs.debian.org/218566 for details.
> 
> Then there's likely just some other bug wrt bouncing. Hmm, does this
> work?

It's OK, it turns out that he applied my earlier patch which called
blk_queue_bounce() in blk_add_page.  That obviously breaks down when
the bio is bounced since the real end_io functions haven't been set
yet.

So this problem is resolved.

Thanks,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
