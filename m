Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270702AbTGPMcS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 08:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270709AbTGPMcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 08:32:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36587 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270702AbTGPMcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 08:32:14 -0400
Date: Wed, 16 Jul 2003 14:46:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030716124656.GY833@suse.de>
References: <20030713191921.GI16313@dualathlon.random> <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de> <20030714201637.GQ16313@dualathlon.random> <20030715052640.GY833@suse.de> <1058268126.3857.25.camel@dhcp22.swansea.linux.org.uk> <20030715112737.GQ833@suse.de> <20030716124355.GE4978@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716124355.GE4978@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16 2003, Andrea Arcangeli wrote:
> On Tue, Jul 15, 2003 at 01:27:37PM +0200, Jens Axboe wrote:
> > On Tue, Jul 15 2003, Alan Cox wrote:
> > > On Maw, 2003-07-15 at 06:26, Jens Axboe wrote:
> > > > Sorry, but I think that is nonsense. This is the way we have always
> > > > worked. You just have to maintain a decent queue length still (like we
> > > > always have in 2.4) and there are no problems.
> > > 
> > > The memory pinning problem is still real - and always has been. It shows up
> > > best not on IDE disks but large slow media like magneto opticals where you
> > > can queue lots of I/O but you get 500K/second
> > 
> > Not the same thing. On slow media, like dvd-ram, what causes the problem
> > is that you can dirty basically all of the RAM in the system. That has
> > nothing to do with memory pinned in the request queue.
> 
> you can trivially bound the amount of dirty memory to nearly 0% with the
> bdflush sysctl. And the overkill size of the queue until pre3 could be
> an huge VM overhead compared to the dirty memory on lowmem boxes,
> example a 32/64M machine. So I disagree it's only a mistake of write
> throttling that gives problems on slow media.
> 
> Infact I tend to think the biggest problem for slow media in 2.4 is the
> lack of per spindle pdflush.

Well it's a combined problem. Threshold too high on dirty memory,
someone doing a read well get stuck flushing out as well.

-- 
Jens Axboe

