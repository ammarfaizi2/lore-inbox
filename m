Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWJRJur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWJRJur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWJRJur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:50:47 -0400
Received: from brick.kernel.dk ([62.242.22.158]:8723 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932134AbWJRJuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:50:46 -0400
Date: Wed, 18 Oct 2006 11:51:25 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
Message-ID: <20061018095125.GE24452@kernel.dk>
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com> <1161048269.3245.26.camel@laptopd505.fenrus.org> <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018080030.GU23492@unthought.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18 2006, Jakob Oestergaard wrote:
> On Tue, Oct 17, 2006 at 03:23:13PM +0200, Jens Axboe wrote:
> > On Tue, Oct 17 2006, Arjan van de Ven wrote:
> ...
> > > Hi,
> > > 
> > > it's a nice idea in theory. However... since IO bandwidth for seeks is
> > > about 1% to 3% of that of sequential IO (on disks at least), which
> > > bandwidth do you want to allocate? "worst case" you need to use the
> > > all-seeks bandwidth, but that's so far away from "best case" that it may
> > > well not be relevant in practice. Yet there are real world cases where
> > > for a period of time you approach worst case behavior ;(
> > 
> > Bandwidth reservation would have to be confined to special cases, you
> > obviously cannot do it "in general" for the reasons Arjan lists above.
> 
> How about allocating I/O operations instead of bandwidth ?
> 
> So, any read is really a seek+read, and we count that as one I/O
> operation. Same for writes.
> 
> Since the total "capacity" of the system is typically (in real-world
> scenarios) the number of operations (seek+X) rather than the raw
> sequential bandwidth anyway, I suppose that I/O operations would be what
> you wanted to allocate anyway.
> 
> Anyway, just a thought...

While that may make some sense internally, the exported interface would
never be workable like that. It needs to be simple, "give me foo kb/sec
with max latency bar for this file", with an access pattern or assumed
sequential io.

Nobody speaks of iops/sec except some silly benchmark programs. I know
that you are describing pseudo-iops, but it still doesn't make it more
clear.
Things aren't as simple 

-- 
Jens Axboe

