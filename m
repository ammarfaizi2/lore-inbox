Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270652AbTGPM33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 08:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270702AbTGPM33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 08:29:29 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52877
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S270652AbTGPM32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 08:29:28 -0400
Date: Wed, 16 Jul 2003 14:43:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030716124355.GE4978@dualathlon.random>
References: <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random> <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de> <20030714201637.GQ16313@dualathlon.random> <20030715052640.GY833@suse.de> <1058268126.3857.25.camel@dhcp22.swansea.linux.org.uk> <20030715112737.GQ833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715112737.GQ833@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 01:27:37PM +0200, Jens Axboe wrote:
> On Tue, Jul 15 2003, Alan Cox wrote:
> > On Maw, 2003-07-15 at 06:26, Jens Axboe wrote:
> > > Sorry, but I think that is nonsense. This is the way we have always
> > > worked. You just have to maintain a decent queue length still (like we
> > > always have in 2.4) and there are no problems.
> > 
> > The memory pinning problem is still real - and always has been. It shows up
> > best not on IDE disks but large slow media like magneto opticals where you
> > can queue lots of I/O but you get 500K/second
> 
> Not the same thing. On slow media, like dvd-ram, what causes the problem
> is that you can dirty basically all of the RAM in the system. That has
> nothing to do with memory pinned in the request queue.

you can trivially bound the amount of dirty memory to nearly 0% with the
bdflush sysctl. And the overkill size of the queue until pre3 could be
an huge VM overhead compared to the dirty memory on lowmem boxes,
example a 32/64M machine. So I disagree it's only a mistake of write
throttling that gives problems on slow media.

Infact I tend to think the biggest problem for slow media in 2.4 is the
lack of per spindle pdflush.

Andrea
