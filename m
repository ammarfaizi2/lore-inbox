Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFPii>; Wed, 6 Dec 2000 10:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLFPi2>; Wed, 6 Dec 2000 10:38:28 -0500
Received: from ns.caldera.de ([212.34.180.1]:275 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129183AbQLFPiW>;
	Wed, 6 Dec 2000 10:38:22 -0500
Date: Wed, 6 Dec 2000 16:07:38 +0100
From: Olaf Kirch <okir@caldera.de>
To: Andi Kleen <ak@suse.de>
Cc: Olaf Kirch <okir@caldera.de>, linux-kernel@vger.kernel.org,
        security-audit@ferret.lmh.ox.ac.uk
Subject: Re: Traceroute without s bit
Message-ID: <20001206160737.M9533@monad.caldera.de>
In-Reply-To: <20001206135019.L9533@monad.caldera.de> <20001206140905.A408@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001206140905.A408@gruyere.muc.suse.de>; from ak@suse.de on Wed, Dec 06, 2000 at 02:09:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 02:09:05PM +0100, Andi Kleen wrote:
> IP_PKTINFO does not allow to set source addresses, only destination
> addresses. Source address depends on the boundage or the route. 

No. At least udp_sendmsg uses the spec_dst_addr field as the source
address.  I added some code to my traceroute that lets you select the
source address in order to verify that.

However the good thing is that somewhere something seems to check that
the requested address is indeed one attached to a local interface.

> > 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> > 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> > 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> > 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> 
> POLLERR is returned until the error queue is empty. I suspect you're
> not emptying it properly in all cases. It can contain multiple errors.

But it doesn't return POLLERR. If it was returning it, pollfd.revents
would be set. pollfd.events is the event mask that's being passed _into_
the poll() call.

You're right about the IP_RETOPS stuff though. I didn't look closely enough;
ip_cmsg_send does expect raw options.

Thanks,
Olaf
-- 
Olaf Kirch         |  --- o --- Nous sommes du soleil we love when we play
okir@monad.swb.de  |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax
okir@caldera.de    +-------------------- Why Not?! -----------------------
         UNIX, n.: Spanish manufacturer of fire extinguishers.            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
