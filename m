Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTKHJ3y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 04:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTKHJ3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 04:29:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:450 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261656AbTKHJ3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 04:29:52 -0500
Date: Sat, 8 Nov 2003 10:29:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BIO] Bounce queue in bio_add_page
Message-ID: <20031108092935.GH14728@suse.de>
References: <20031104084929.GH1477@suse.de> <20031104090325.GA21301@gondor.apana.org.au> <20031104090353.GM1477@suse.de> <20031105094855.GD1477@suse.de> <20031106210900.GA29000@gondor.apana.org.au> <20031107112346.GA5153@gondor.apana.org.au> <20031107112555.GC591@suse.de> <20031107112833.GA5239@gondor.apana.org.au> <20031107113235.GD591@suse.de> <20031107225253.GA8864@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031107225253.GA8864@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 08 2003, Herbert Xu wrote:
> On Fri, Nov 07, 2003 at 12:32:35PM +0100, Jens Axboe wrote:
> > On Fri, Nov 07 2003, Herbert Xu wrote:
> > > On Fri, Nov 07, 2003 at 12:25:55PM +0100, Jens Axboe wrote:
> > > > 
> > > > Could be related, someone is doing an unlock on an already unlocked
> > > > page. Is this the same system that saw the bounce problem initially?
> > > 
> > > Yes, see http://bugs.debian.org/218566 for details.
> > 
> > Then there's likely just some other bug wrt bouncing. Hmm, does this
> > work?
> 
> It's OK, it turns out that he applied my earlier patch which called
> blk_queue_bounce() in blk_add_page.  That obviously breaks down when
> the bio is bounced since the real end_io functions haven't been set
> yet.
> 
> So this problem is resolved.

Great, I'm a lot more relieved now.

-- 
Jens Axboe

