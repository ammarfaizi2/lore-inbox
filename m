Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTGOFZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTGOFZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:25:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32399 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262464AbTGOFZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:25:43 -0400
Date: Tue, 15 Jul 2003 07:40:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Mason <mason@suse.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715054031.GB833@suse.de>
References: <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random> <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de> <Pine.LNX.4.55L.0307141708210.8994@freak.distro.conectiva> <20030714202434.GS16313@dualathlon.random> <1058214881.13313.291.camel@tiny.suse.com> <20030714224528.GU16313@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714224528.GU16313@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15 2003, Andrea Arcangeli wrote:
> On Mon, Jul 14, 2003 at 04:34:41PM -0400, Chris Mason wrote:
> > patch.  It's a good starting point for the question "can we do better
> > for reads?" (clearly the answer is yes).
> 
> Jens's patch will block every writers until the parallel sync readers go
> away.  if we add a 5 seconds delay for every write, sure readers will
> run faster too in contest, and in turn it's not obvious to me it's

Andrea, these comments are getting pretty tiresome and are not very
constructive. If you want to go off on a tirade, be my guest, but I'm
not listening then.

> necessairly a good starting point.  I mean, it'd need to be tunable at
> least because otherwise readers can starve writers for a long time in a
> server workload (and it would overschedule big too since there's no
> separate waitqueue like in pre4, probably it doesn't deadlock only
> because of the redoundant weakup in get_request_wait_wakeup. I'd compare
> it to sending sigstop to the `tar x`, during the kernel compile to get a
> 1.0 ratio and peak contest performance.

Again, way overboard silly. You could see reads fill the entire queue
know (since it's sized ridicolously low, something like 35-40ms streamed
io on a modern _ATA_ disk). It's just not very likely, and I'd be very
surprised if it is happening in the contest run. You can see the
workloads making fine progress and iterations, while the score is better
too.

I agree that we don't _want_ to make this be a possibility in the 2.4.22
kernel, but (again) this is a _first version_ designed to show how far
we can take it.

-- 
Jens Axboe

