Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269641AbRIRMJl>; Tue, 18 Sep 2001 08:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269413AbRIRMJb>; Tue, 18 Sep 2001 08:09:31 -0400
Received: from unamed.infotel.bg ([212.39.68.18]:28934 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id <S269641AbRIRMJT>;
	Tue, 18 Sep 2001 08:09:19 -0400
Date: Tue, 18 Sep 2001 15:11:34 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@l>
To: Roberto Arcomano <berto@fatamorgana.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proxy arp bug on shaper device
Message-ID: <Pine.LNX.4.33.0109181432450.3322-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Roberto Arcomano wrote:

> This patch should correct proxy arp feature in shaper devices forcing kernel
> checking (before sending ARP REPLY) for "physical" device (i.e. eth0) instead
> of "shaper" device (i.e. shaper0): in this way we avoid useless ARP REPLY and
> "IP CONFLICT" messages on client hosts.

	You can also try to stop the ARP for your asymmetric route
using the per-route ARP flag (patch for 2.4 only):

http://www.linux-vs.org/~julian/
go to "Solution 2: Per-route ARP flag"

May be you need to add ip rule before reaching table main, i.e.
to use such commands:

ip rule add prio 100 to shaped_network/24 iif eth0 table 100
ip route add shaped_network/24 dev shaper0 table 100 noarp

I assume (if I understand your setup correctly) this command will
drop the ARP probes coming through eth0 and asking for non-local IP
addresses on shaped networks on shaper device(s). You can put all
your networks reachable through shaper devices in table 100. All
other networks on non-shaper devices will be reported from the
proxy_arp.

	I don't know whether this will work but you can try. At
least, I don't see a way the other device flags related to ARP
to work for you: hidden (only in 2.2), arp_filter and rp_filter.

Regards

--
Julian Anastasov <ja@ssi.bg>

