Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269365AbUIIIHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269365AbUIIIHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 04:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269366AbUIIIHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 04:07:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61092 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269365AbUIIIHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 04:07:39 -0400
Date: Thu, 9 Sep 2004 10:06:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Christoph Hellwig <hch@lst.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in md write barrier support?
Message-ID: <20040909080612.GJ1737@suse.de>
References: <20040903172414.GA6771@lst.de> <16697.4817.621088.474648@cse.unsw.edu.au> <20040904082121.GB2343@suse.de> <16699.48946.29579.495180@cse.unsw.edu.au> <20040908092309.GD2258@suse.de> <1094650500.11723.32.camel@localhost.localdomain> <20040908154608.GN2258@suse.de> <1094682098.12280.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094682098.12280.19.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08 2004, Alan Cox wrote:
> On Mer, 2004-09-08 at 16:46, Jens Axboe wrote:
> > That's a worry if it really does that - does it, or are you just
> > speculating about possible problems?
> 
> I2O defines cache flush very losely. It flushes the cache and returns
> when the cache has been flushed. From playing with the controllers I
> have it seems some at least merge further queued writes into the output
> stream. Thus if I issue
> 
> write 1, 2, 3, 4 , 40, 41, flush cache, write 5, 6, 100
> 
> it'll write 1,2,3,4,5,6, 40, 41, report flush cache complete. 
> 
> Obviously I can implement full barrier semantics in the driver if need
> be but that would cost performance hence the question.

Precisely, it's always possible to just drop queueing depth to zero at
that point. If I2O really does reorder around the cache flush (this
seems broken...), then you probably should.

-- 
Jens Axboe

