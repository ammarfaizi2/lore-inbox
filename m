Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRAXHqY>; Wed, 24 Jan 2001 02:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129953AbRAXHqO>; Wed, 24 Jan 2001 02:46:14 -0500
Received: from dial-pool33.vega.bg ([62.176.76.33]:260 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S129534AbRAXHqH>;
	Wed, 24 Jan 2001 02:46:07 -0500
Date: Wed, 24 Jan 2001 09:21:02 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: Pete Elton <elton@iqs.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off ARP in linux-2.4.0
Message-ID: <Pine.LNX.4.30.0101240857420.1024-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On 22 Jan 2001, Pete Elton wrote:

> In the 2.2 kernel, I could do the following:
> echo 1 > /proc/sys/net/ipv4/conf/all/hidden
> echo 1 > /proc/sys/net/ipv4/conf/lo/hidden
>
> The 2.4 kernel does not have these sysctl files any more.  Why was
> this functionality taken out?  or was it simply moved to another place
> in the proc filesystem?  How can I accomplish the same thing I was
> doing in the 2.2 kernel in the 2.4 kernel?

	You can use this temporary solution (the same patch ported to
2.3.41+):

http://www.linuxvirtualserver.org/arp.html
http://www.linuxvirtualserver.org/hidden-2.3.41-1.diff

	It is not ported to 2.4 because it touches code in the
IP address autoselection that is in the fast path. This
autoselection code is going to be changed and the required support
can't be ported.

	The problem is complex and can't be solved with ifconfig -arp

	The needs for clusters with shared addresses include:

1. block ARP replies for such addresses
2. don't announce these addresses in the ARP probes (can be achieved
using ip addr add IP brd + dev lo scope host)
3. don't autoselect such addresses (for source addresses)


Regards

--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
