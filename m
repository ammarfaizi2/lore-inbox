Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270794AbTGNUZB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270793AbTGNUYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:24:01 -0400
Received: from 69-55-72-150.ppp.netsville.net ([69.55.72.150]:25810 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S270788AbTGNUVN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:21:13 -0400
Subject: Re: RFC on io-stalls patch
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
In-Reply-To: <20030714202434.GS16313@dualathlon.random>
References: <1057932804.13313.58.camel@tiny.suse.com>
	 <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com>
	 <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random>
	 <20030714054918.GD843@suse.de>
	 <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva>
	 <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de>
	 <Pine.LNX.4.55L.0307141708210.8994@freak.distro.conectiva>
	 <20030714202434.GS16313@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1058214881.13313.291.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 14 Jul 2003 16:34:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-14 at 16:24, Andrea Arcangeli wrote:

> 
> this isn't what we had in pre4, this is more equivalent to an hack in
> pre4 where the requests aren't distributed anymore 50/50 but 10/90. Of
> course an I/O queue filled mostly by parallel sync reads, will make the
> writer go slower since it will very rarely find the queue not oversized
> in presence of a flood of readers. So the writer won't be able to make
> progress.
> 
> This is a "stop the writers and give unlimited requests to the reader"
> hack, not a "reserve some request for the reader", of course then the
> reader is faster. of course then, contest shows huge improvements for
> the read loads.

Which is why it's a good place to start.  If we didn't see huge
improvements here, there's no use in experimenting with this tactic
further.

> 
> But contest only benchmarks the reader, it has no clue how fast the
> writer is AFIK. I would love to hear the bandwidth the writer is writing
> into the xtar_load. Maybe it's shown in some of the Loads/LCPU or
> something, but I don't know the semantics of those fields and I only
> look at time and ratio which I understand. so if any contest expert can
> enaborate if the xtar_load bandwidth is taken into consideration
> somewhere I would love to hear.

I had a much longer reply at first as well, but this is only day 1 of
Jens' benchmark, and he had plans to test other workloads.  I'd like to
give him the chance to do that work before we think about merging the
patch.  It's a good starting point for the question "can we do better
for reads?" (clearly the answer is yes).

-chris


