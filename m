Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267020AbTGOJth (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 05:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267026AbTGOJth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 05:49:37 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8404
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S267020AbTGOJtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 05:49:36 -0400
Date: Tue, 15 Jul 2003 12:03:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Chris Mason <mason@suse.com>, Andrew Morton <akpm@osdl.org>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715100357.GI30537@dualathlon.random>
References: <20030714175238.3eaddd9a.akpm@osdl.org> <20030715020706.GC16313@dualathlon.random> <20030715054551.GD833@suse.de> <20030715060101.GB30537@dualathlon.random> <20030715060857.GG833@suse.de> <20030715070314.GD30537@dualathlon.random> <20030715082850.GH833@suse.de> <1058260347.4012.11.camel@tiny.suse.com> <20030715091730.GI833@suse.de> <20030715091838.GJ833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715091838.GJ833@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 11:18:38AM +0200, Jens Axboe wrote:
> On Tue, Jul 15 2003, Jens Axboe wrote:
> > > BTW, the contest run times vary pretty wildy.  My 3 compiles with
> > > io_load running on 2.4.21 were 603s, 443s and 515s.  This doesn't make
> > > the average of the 3 numbers invalid, but we need a more stable metric.
> > 
> > Mine are pretty consistent [1], I'd suspect that it isn't contest but your
> > drive tcq skewing things. But it would be nice to test with other things
> > as well, I just used contest because it was at hand.
> 
> Oh and in the same spirit, I'll do the complete runs on an IDE drive as
> well. Sometimes IDE vs SCSI shows the funniest things.

this is the first suspect IMHO too. Especially given the way that SCSI
releases the requests. 

One more thing: unlike my patch where I forced all drivers to support
elevator-lowlatency (either that or not compile at all), Chris made it
optional when he pushed it into mainline, so now the device driver has
to call blk_queue_throttle_sectors(q, 1) to enable it. Otherwise it'll
run like 2.4.21.

Andrea
