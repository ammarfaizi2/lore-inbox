Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270342AbTGMTEz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 15:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270344AbTGMTEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 15:04:55 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54701
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S270342AbTGMTEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 15:04:53 -0400
Date: Sun, 13 Jul 2003 21:19:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Chris Mason <mason@suse.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030713191921.GI16313@dualathlon.random>
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva> <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com> <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com> <20030713090116.GU843@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713090116.GU843@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 11:01:16AM +0200, Jens Axboe wrote:
> No I don't have anything specific, it just seems like a bad heuristic to
> get rid of. I can try and do some testing tomorrow. I do feel strongly

well, it's not an heuristic, it's a simplification and it will certainly
won't provide any benefit (besides saving some hundred kbytes of ram per
harddisk that is a minor benefit).

> that we should at least make sure to reserve a few requests for reads
> exclusively, even if you don't agree with the oversized check. Anything
> else really contradicts all the io testing we have done the past years
> that shows how important it is to get a read in ASAP. And doing that in

Important for latency or throughput? Do you know which is the benchmarks
that returned better results with the two queues, what's the theory
behind this?

> the middle of 2.4.22-pre is a mistake imo, if you don't have numbers to
> show that it doesn't matter for the quick service of reads.

Is it latency or throughput that you're mainly worried about? Latency
certainly isn't worse with this lowlatency improvement (no matter one or
two queues, that's a very minor issue w.r.t. to latency).

I could imagine readahead throughput could be less likely to be hurted
by writes with the two queue. But I doubt it's very noticeable.

However I'm not against re-adding it, clearly there's a slight benefit
for reads in never blocking in wait_for_request, I just didn't consider
it very worthwhile since they've to block anyways later normally for
batch_sectors anyways, just like every write (in a congested I/O
subsystem - when the I/O isn't congested nothing blocks in the first
place).

Andrea
