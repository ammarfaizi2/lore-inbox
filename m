Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132909AbRDQWFt>; Tue, 17 Apr 2001 18:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132908AbRDQWF3>; Tue, 17 Apr 2001 18:05:29 -0400
Received: from [212.95.166.64] ([212.95.166.64]:22532 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S132907AbRDQWFW>;
	Tue, 17 Apr 2001 18:05:22 -0400
Date: Wed, 18 Apr 2001 01:05:21 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: Sampsa Ranta <sampsa@netsonic.fi>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ARP responses broken!
Message-ID: <Pine.LNX.4.30.0104180023130.7698-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Sampsa Ranta wrote:

> 23:38:25.278848 > arp who-has 194.29.192.38 tell 194.29.192.10 (0:50:da:82:ae:9f)
> 23:38:25.278988 < arp reply 194.29.192.38 is-at 0:1:2:dc:d2:64 (0:50:da:82:ae:9f)
> 23:38:25.279009 < arp reply 194.29.192.38 is-at 0:1:2:dc:d2:6c (0:50:da:82:ae:9f)
>
> The second one is the valid one, but both interfaces seem to answer to the
> broadcasted packet with their own ARP addresses.

	arp_filter is not broken, it is simply not for your setup.
It depends what you want to achieve by defining two IP addresses in
different interfaces. Considering the fact you have two addresses
in one subnet you need the incoming traffic to come from the two
interfaces. In this case you need "hidden". For the outgoing traffic:
it is controlled only from the routing.

	While in your setup arp_filter and rp_filter will ARP answer
from one card only, for the both addresses, hidden will answer from the
both cards, "correctly" in your eyes. Use arp_filter for different
nets only, i.e. when the ARP probes come from different nets in your
routing universe. hidden does not depend on nets/subnets. But may
be there are exceptions I'm missing and the other guys can correct me.

Regards

--
Julian Anastasov <ja@ssi.bg>

