Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFQ6L>; Wed, 6 Dec 2000 11:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbQLFQ6B>; Wed, 6 Dec 2000 11:58:01 -0500
Received: from Cantor.suse.de ([194.112.123.193]:1804 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129183AbQLFQ5m>;
	Wed, 6 Dec 2000 11:57:42 -0500
Date: Wed, 6 Dec 2000 17:27:10 +0100
From: Andi Kleen <ak@suse.de>
To: Olaf Kirch <okir@caldera.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        security-audit@ferret.lmh.ox.ac.uk
Subject: Re: Traceroute without s bit
Message-ID: <20001206172710.A5145@gruyere.muc.suse.de>
In-Reply-To: <20001206135019.L9533@monad.caldera.de> <20001206140905.A408@gruyere.muc.suse.de> <20001206160737.M9533@monad.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001206160737.M9533@monad.caldera.de>; from okir@caldera.de on Wed, Dec 06, 2000 at 04:07:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 04:07:38PM +0100, Olaf Kirch wrote:
> On Wed, Dec 06, 2000 at 02:09:05PM +0100, Andi Kleen wrote:
> > IP_PKTINFO does not allow to set source addresses, only destination
> > addresses. Source address depends on the boundage or the route. 
> 
> No. At least udp_sendmsg uses the spec_dst_addr field as the source
> address.  I added some code to my traceroute that lets you select the
> source address in order to verify that.

Please read the code again.

It uses spec_dst to select the possibly policy sourced route -- the
actual source address is only set from that route (either default or what
was set using ip route's from flag) or the bound address.



> However the good thing is that somewhere something seems to check that
> the requested address is indeed one attached to a local interface.

That's not actually checked, but in most simple routing configurations it is
true.


> 
> > > 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> > > 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> > > 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> > > 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> > 
> > POLLERR is returned until the error queue is empty. I suspect you're
> > not emptying it properly in all cases. It can contain multiple errors.
> 
> But it doesn't return POLLERR. If it was returning it, pollfd.revents
> would be set. pollfd.events is the event mask that's being passed _into_
> the poll() call.

Right. I missed your 5ms timeout @)

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
