Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265887AbRFYRvb>; Mon, 25 Jun 2001 13:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265889AbRFYRvV>; Mon, 25 Jun 2001 13:51:21 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:60302 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S265887AbRFYRvN>; Mon, 25 Jun 2001 13:51:13 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200106251750.SAA26652@mauve.demon.co.uk>
Subject: Re: Where is check for superuser in TCP port bind.
To: linux-kernel@vger.kernel.org
Date: Mon, 25 Jun 2001 18:50:08 +0100 (BST)
In-Reply-To: <200106250423.FAA31292@mauve.demon.co.uk> from "Ian Stirling" at Jun 25, 2001 05:23:00 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Obviously (to me) this check is in tcp_v4_get_port().
> But, I can't find it, or perhaps it's better hidden than I thought.
> Or maybe I'm just very confused.
> Any help would be most welcome.

The above poster was of course deeply stupid, and could have done with
more sleep :)
It's in net/ipv4/af_inet.c

I was looking for some way of letting users own devices, so they
can do some subset of the operations reserved for root on their device.

Further reading led to "route by owner" in netfilter, but it's not quite
it.
This would let me do something like:
ifconfig eth0:www 1.2.3.4
route add default 1.2.3.4 -user www

But would still not let www bind low ports on eth0:www.
There seem to be a few ways to do this. 
Teach capable() about owned routes.

Make interfaces/aliases directly ownable, add  CAP_NET_BIND_ANY 
so you can only bind to an interface you own, or if you have 
CAP_NET_BIND_ANY.

You need CAP_NET_BIND_ANY to chown an interface.

The second way seems cleaner to me. 
Any comments? 
