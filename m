Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTGOFU5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTGOFU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:20:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49550 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262385AbTGOFUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:20:55 -0400
Date: Tue, 15 Jul 2003 07:35:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715053540.GA833@suse.de>
References: <1058034751.13318.95.camel@tiny.suse.com> <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random> <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de> <Pine.LNX.4.55L.0307141708210.8994@freak.distro.conectiva> <20030714202434.GS16313@dualathlon.random> <1058214881.13313.291.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058214881.13313.291.camel@tiny.suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14 2003, Chris Mason wrote:
> On Mon, 2003-07-14 at 16:24, Andrea Arcangeli wrote:
> 
> > 
> > this isn't what we had in pre4, this is more equivalent to an hack in
> > pre4 where the requests aren't distributed anymore 50/50 but 10/90. Of
> > course an I/O queue filled mostly by parallel sync reads, will make the
> > writer go slower since it will very rarely find the queue not oversized
> > in presence of a flood of readers. So the writer won't be able to make
> > progress.
> > 
> > This is a "stop the writers and give unlimited requests to the reader"
> > hack, not a "reserve some request for the reader", of course then the
> > reader is faster. of course then, contest shows huge improvements for
> > the read loads.
> 
> Which is why it's a good place to start.  If we didn't see huge
> improvements here, there's no use in experimenting with this tactic
> further.

Exactly. The path I'm looking for is something ala 'at least allow one
read in, even if writes have oversized the queue'.

> > But contest only benchmarks the reader, it has no clue how fast the
> > writer is AFIK. I would love to hear the bandwidth the writer is writing
> > into the xtar_load. Maybe it's shown in some of the Loads/LCPU or
> > something, but I don't know the semantics of those fields and I only
> > look at time and ratio which I understand. so if any contest expert can
> > enaborate if the xtar_load bandwidth is taken into consideration
> > somewhere I would love to hear.
> 
> I had a much longer reply at first as well, but this is only day 1 of
> Jens' benchmark, and he had plans to test other workloads.  I'd like to
> give him the chance to do that work before we think about merging the
> patch.  It's a good starting point for the question "can we do better
> for reads?" (clearly the answer is yes).

Thanks Chris, this is exactly the point. BTW, I'd be glad to take hints
on other interesting work loads.

-- 
Jens Axboe

