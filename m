Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274178AbRIXV4r>; Mon, 24 Sep 2001 17:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274180AbRIXV4i>; Mon, 24 Sep 2001 17:56:38 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:17634 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274179AbRIXV4d>; Mon, 24 Sep 2001 17:56:33 -0400
Importance: Normal
Subject: Re: [PATCH] strict interface arp patch for Linux 2.4.2
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OF73AD00F9.F4B5F0CC-ON85256AD1.00788757@raleigh.ibm.com>
From: "Allen Lau" <pflau@us.ibm.com>
Date: Mon, 24 Sep 2001 17:54:52 -0400
X-MIMETrack: Serialize by Router on D04NMS38/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 09/24/2001 05:56:52 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------------------- Forwarded by Allen Lau/Raleigh/IBM on 09/24/2001
06:03 PM ---------------------------

Allen Lau
09/24/2001 01:09 PM

To:   Julian Anastasov <ja@ssi.bg>
cc:   inux-kernel@vger.kernel.org
From: Allen Lau/Raleigh/IBM@IBMUS
Subject:  Re: [PATCH] strict interface arp patch for Linux 2.4.2  (Document
      link: Allen Lau)

     Hello,

> - you make the assumption that all primary local IP addresses are
> configured on ARP devices. By this way you can't combine virtual
> network (with netsize < 32 bits on device lo) with your need for
> strict traffic paths. To allow this you have to clear the strict
> arp flag from the ARP devices. We don't talk about solutions where
> one host needs both primary and secondary network from shared
> addresses (both on device lo). This can be solved only with the
> route's noarp flag (ip addr add NET1/24 dev lo hidden,
> ip addr add NET2/24 dev lo), even hidden can't help here.

Julian, thanks for sharing the background info.
I assume that strict_interface_arp be enabled only for interfaces
that require it (e.g. for bandwidth control). It does not require loopback
to be hidden. You may have other interfaces (different ip subnets) that
does unrestricted operations.

> - something new: should the strict arp flag stop the "arp race" caused
> from the proxy_arp feature (i.e. to stop the proxy_arp feature)?

The arp patches all operate on the case of RTN_LOCAL (address in the box)
- proxy_arp should not be affected.

> > That's the "arp flux" problem which strict_interface_arp solves.
> > In Linux arp requests, it is possible for 2.2.2.1 eth1 node1 to be
advertised
> > as source by eth0 node1. For illustration, eth0 is 10/100M and eth1 is
gigabit.
> > It'll cause clients to redirect traffic for the gigabit to the 10/100M
port.

>    Well, you are talking about the case where someone binds to
> 2.2.2.1 and talks to 1.1.1.2. What to say, IMO the right solution is
> arp_solicit always to select the preferred source address from a new
> [0 -> target, neigh->dev] output route call. We know that the remote
> host should be able to receive our probes from many devices (if the
> IP traffic is also received there) but it helps to solve the "arp flux"
> problem and helps not to announce shared addresses in our probes.
> Then the filtering of the remote probes can be done in different ways.
> I don't know what the maintainers have against it. IMO, the route's
> noarp flag + arp_solicit always to use the prefsrc is the best we can
> do for 2.4.

Agreed. (strict_interface_arp touched arp_solicit and inet_addr_select for
that)

Regards
Allen Lau
--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




