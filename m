Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135448AbRDRWrF>; Wed, 18 Apr 2001 18:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135450AbRDRWq4>; Wed, 18 Apr 2001 18:46:56 -0400
Received: from [212.95.166.64] ([212.95.166.64]:37892 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S135448AbRDRWql>;
	Wed, 18 Apr 2001 18:46:41 -0400
Date: Thu, 19 Apr 2001 01:46:55 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: Sampsa Ranta <sampsa@netsonic.fi>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ARP responses broken!
In-Reply-To: <Pine.LNX.4.33.0104190039460.27239-100000@nalle.netsonic.fi>
Message-ID: <Pine.LNX.4.30.0104190112190.1192-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Thu, 19 Apr 2001, Sampsa Ranta wrote:

> Yes, I wan't that other routers only see the MAC address of the interface
> I assigned the IP address for if someone asks it by ARP. I also control
> outgoing traffic with routing. But how am I supposed to do this in 2.4
> enviroment?

	Eric Weigle exactly pointed out the solutions and the links.
There is still no standard support in the 2.4 kernel for your problem
but you can try http://www.linuxvirtualserver.org/hidden-2.3.41-1.diff
You can see some fails while applying but don't worry. You can try
the same 2.4.2 patch (I should make actual diff one day, for now may be
I'm trying to determine how long can live this patch) from
http://marc.theaimsgroup.com/?l=linux-virtual-server&m=98286657511673&w=2
This functionality is same as in Linux 2.2

> I also would want outgoing traffic to work from either of the interfaces,
> not depending from which the incoming traffic did come, so outgoing ARP
> requests would have the MAC address and IP address of the interface they
> were asked from. For filtering IP traffic, the iptables is good enough so

	With "hidden" you will see that your ARP probes can go through
any device without problem, of course, if the targets listen everywhere.
If an address can't be announced from the outgoing device, it is replaced
with valid source address in the ARP probe. You still can need some
source routing rules if you want the other IP traffic with specific
source address to go through specific interface. In other case (routes
by destination, for example), your ARP probes and the IP traffic will
go through one device only.

> I can filter just as I want, I don't need filtering to happen by routing
> table at the moment.

	Fine :) Because the "hidden" usage assumes secure environment
in some cases.

> Yeah, I could do this by defining ARP addresses by hand but I would rather
> not do that because there are two many routers involved.

        The ARP usage is recommended :)

> Btw. Kernel sets up two routes to the subnet, which one is selected and
>      should the other one be deleted?

        You can determine it with:

ip route get DESTINATION_IP

	Only the displayed route will be selected but you don't need
to delete the other.

> Thanks,
>    Sampsa Ranta
>    sampsa@netsonic.fi


Regards

--
Julian Anastasov <ja@ssi.bg>

