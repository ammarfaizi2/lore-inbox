Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268298AbUIHPrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268298AbUIHPrq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 11:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268359AbUIHPrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 11:47:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28814 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268298AbUIHPrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 11:47:32 -0400
Date: Wed, 8 Sep 2004 17:46:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Christoph Hellwig <hch@lst.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in md write barrier support?
Message-ID: <20040908154608.GN2258@suse.de>
References: <20040903172414.GA6771@lst.de> <16697.4817.621088.474648@cse.unsw.edu.au> <20040904082121.GB2343@suse.de> <16699.48946.29579.495180@cse.unsw.edu.au> <20040908092309.GD2258@suse.de> <1094650500.11723.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094650500.11723.32.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08 2004, Alan Cox wrote:
> On Mer, 2004-09-08 at 10:23, Jens Axboe wrote:
> > That is correct. The current definition is to ensure that previously
> > sent writes are on disk. I hope to tie a range to it in the future, for
> > devices that can optimize the flush in that case. So for ide with write
> > back caching, it's currently a FLUSH_CACHE command. Ditto for SCSI. SCSI
> > with write through cache can make it a noop as well.
> 
> Some semantics questions I have thinking about it from the I2O and
> aacraid side: You talk about it as a barrier. Can other I/O cross the
> cache flush ? In other words if I issue a flush_cache and continue doing
> I/O the flush will finish when the I/O outstanding at that time has
> completed but other I/O may get scheduled to disk first.

That's a worry if it really does that - does it, or are you just
speculating about possible problems?

> Secondly what are the intended semantics for a flush error ?

It's up to the issue. For IDE it would ideally be issuing FLUSH_CACHE
repeatedly until it doesn't error anymore, but keeping track of the
error location. Come to think of it, we should pass down the range right
now to flag which range we are actually interested in being errored on.

-- 
Jens Axboe

