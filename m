Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWJRLN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWJRLN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 07:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWJRLN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 07:13:29 -0400
Received: from brick.kernel.dk ([62.242.22.158]:31285 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030208AbWJRLN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 07:13:28 -0400
Date: Wed, 18 Oct 2006 13:14:07 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Jakob Oestergaard <jakob@unthought.net>,
       Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
Message-ID: <20061018111407.GF24452@kernel.dk>
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com> <1161048269.3245.26.camel@laptopd505.fenrus.org> <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net> <20061018095125.GE24452@kernel.dk> <45360952.5020307@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45360952.5020307@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18 2006, Helge Hafting wrote:
> Jens Axboe wrote:
> >While that may make some sense internally, the exported interface would
> >never be workable like that. It needs to be simple, "give me foo kb/sec
> >with max latency bar for this file", with an access pattern or assumed
> >sequential io.
> >
> >Nobody speaks of iops/sec except some silly benchmark programs. I know
> >that you are describing pseudo-iops, but it still doesn't make it more
> >clear.
> >Things aren't as simple
> >  
> How about "give me 10% of total io capacity?"  People understand
> this, and the io scheduler can then guarantee this by ensuring
> that the process gets 1 out of 10 io requests as long as it
> keeps submitting enough.

The thing about disks is that it's not as easy as giving the process 10%
of the io requests issued. Only if the considered bandwidth is random
load will that work, but that's not very interesting.

You need to say 10% of the disk time, which is something CFQ can very
easily be modified to do since it works with time slices already. 10%
doesn't mean very much though, you need a timeframe for that to make
sense anyways. Give me 100msec every 1000msecs makes more sense.

-- 
Jens Axboe

