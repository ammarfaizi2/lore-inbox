Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264273AbTLJXUS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 18:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTLJXUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 18:20:17 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:8626 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S264273AbTLJXUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 18:20:09 -0500
Date: Thu, 11 Dec 2003 00:17:30 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Rik van Riel <riel@redhat.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031210231729.GC28912@k3.hellgate.ch>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
References: <20031210135829.GA18370@k3.hellgate.ch> <Pine.LNX.4.44.0312100919090.3900-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312100919090.3900-100000@chimarrao.boston.redhat.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003 16:04:16 -0500, Rik van Riel wrote:
> > For me this discussion just confirmed that my approach fails to draw
> > much interest, either because there are better alternatives or because
> > heavy paging and medium thrashing are generally not considered
> > interesting problems.
> 
> I'm willing to take over this work if you really want
> to throw in the towel.  It has to be done, simply to
> make Linux better able to deal with load spikes.

I am willing to keep my work up if I don't have to pull this alone. As
far as thrashing is concerned, the VM changed significanly even during
the -test series and I expect that to continue once 2.6.0 is released.
It would be good to get help from the people who made those changes --
they should know their stuff best, after all.

For one, we could look at the regression in test3 which might be easier
to fix than others because the changes haven't been buried under dozens
of later kernels. Some time ago, I took some notes about how the two
patches I mentioned in an earlier message worked together to change
the pageout patterns. Is that something we could start with?

Setting up some regular regression testing for new kernels might be a
good idea, too. Otherwise it's going to be Sisyphus work. For the time
being I can continue the testing, provided the harddisk that miraculously
survived hundreds of hours of thrashing tests keeps going.

> Under light to moderate overload, a load controlled system
> will be more responsive than a thrashing system.

That I doubt. 2.4 is very responsive under light overload -- every
process is mostly in memory and ready to grab a few missing pages at any
time. Once you add load control, you have processes that are completely
evicted and stunned when they are needed. Of course it's a matter of
definition, too, so I'd go even as far as saying:

- It is light thrashing when load control has no advantage.

- It is medium thrashing when using load control is a toss-up. Probably
  better throughput, but somewhat higher latency.

- It is heavy thrashing when load control is a winner in both regards.

I just made this up. It neatly resolves all arguments about when load
control is appropriate. Yeah, so it's a circular definition. Sue me.

> Heavy overload is probably a "docter, it hurts ..." case.

That's pretty much my thinking, too. Might still be worthwhile adding
some load control if there are more people like wli's Russian guy.

Roger
