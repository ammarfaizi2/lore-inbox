Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273729AbRJTQzi>; Sat, 20 Oct 2001 12:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273691AbRJTQz2>; Sat, 20 Oct 2001 12:55:28 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:50439 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S273729AbRJTQzW>;
	Sat, 20 Oct 2001 12:55:22 -0400
Date: Sat, 20 Oct 2001 19:56:47 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: Andrey Savochkin <saw@saw.sw.com.sg>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: how to see manually specified proxy arp entries using "ip neigh"
Message-ID: <Pine.LNX.4.33.0110201937020.23322-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Andrey Savochkin wrote:

> Well, what I want is to make the host an arp "proxy" on all interfaces for
> all addresses reachable through devX.  I do not want to mess with how
> customer configures all other interfaces.
> Right now all routes to devX are /32, for all of them proxy arp entries are
> created by the same script, and all are happy.
>
> How can it be done better?
> New mechanism of fine-grained control over proxy arp? :-)

	I can tell you what Alexey and Andrey will answer on netdev :)
Make proxyarp a route flag. When arp_filter is not suitable for filtering
non-local input routes you can also solve the problem with the route's
noarp flag (known in netdev). The proxyarp flag for route can allow
the feature to work even on one device (indev==outdev) may be for NAT
purposes), probably running send_redirects=0 (send_redirects is another
candidate for a route flags). Of course, the target hosts should filter
these ARP probes with a simple rp_filter policy, only our box should
reply. We need only space for route flags and imagination :)

Regards

--
Julian Anastasov <ja@ssi.bg>

