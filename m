Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129874AbRBYWuE>; Sun, 25 Feb 2001 17:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbRBYWty>; Sun, 25 Feb 2001 17:49:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57869 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129874AbRBYWto>;
	Sun, 25 Feb 2001 17:49:44 -0500
Date: Sun, 25 Feb 2001 23:49:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Steve Whitehouse <Steve@ChyGwyn.com>, torvalds@transmeta.com,
        pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: NBD Cleanup patch and bugfix in ll_rw_blk.c
Message-ID: <20010225234927.S7830@suse.de>
In-Reply-To: <200102251957.TAA01718@gw.chygwyn.com> <20010225223913.A3627@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010225223913.A3627@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Feb 25, 2001 at 10:39:13PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25 2001, Russell King wrote:
> On Sun, Feb 25, 2001 at 07:57:29PM +0000, Steve Whitehouse wrote:
> > -int nbd_init(void)
> > +int __init nbd_init(void)
> 
> > -void cleanup_module(void)
> > +void __exit nbd_cleanup(void)
> 
> > +
> > +module_init(nbd_init);
> > +module_exit(nbd_cleanup);
> 
> If you're using module_init/module_exit, shouldn't nbd_init/nbd_cleanup
> be declared statically?

And more importantly, the init calls from ll_rw_blk.c:blk_dev_init()
should be removed too.

-- 
Jens Axboe

