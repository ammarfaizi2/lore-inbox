Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310430AbSCBTxF>; Sat, 2 Mar 2002 14:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310432AbSCBTwz>; Sat, 2 Mar 2002 14:52:55 -0500
Received: from ja.mac.ssi.bg ([212.95.166.194]:57095 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S310430AbSCBTwl>;
	Sat, 2 Mar 2002 14:52:41 -0500
Date: Sat, 2 Mar 2002 21:52:12 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: erich@uruk.org
cc: Szekeres Bela <szekeres@lhsystems.hu>,
        Daniel Gryniewicz <dang@fprintf.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network Security hole (was -> Re: arp bug )
In-Reply-To: <E16hESa-0000Gn-00@trillium-hollow.org>
Message-ID: <Pine.LNX.4.44.0203022051100.5003-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Sat, 2 Mar 2002 erich@uruk.org wrote:

> [My apologies for getting into this thread rather late, but I just
>  came across this on a network I'm working with which is all on the
>  same switch/VLAN...  I had 2 network  cards per machine and was
>  puzzled why traffic destined for one interface went to the other]

	If another host (spoofer) on the LAN is faster all
your devices lose the race.

> I.e. the machine still may be accepting traffic destined for one
> interface on another, even though it won't *advertise* that fact
> any more.

	You mix two different issues:

1. ARP replying for same request through many devices

2. ARP probes advertising same source IP through many devices

	Your statement is related to (1). There are some golden
rules on this issue:

- use rp_filter protection for all your external interface

- use different "external" interfaces for the different external
networks if you want to differentiate the traffic from/to them
and protect them with rp_filter

- use rp_filter protection for all "internal" interfaces
attached to same medium (hub) as the "external" interfaces

- no need to use rp_filter protection for the other "internal"
interfaces, it is recommended, though

- if you want to differentiate traffic by protocol or ports
use firewall rules (IPSec, stateful conntracking, etc)

	As for (2) I don't see how this can be remotely
exploited but my opinion is that it should be fixed.
The current behavior is still valid: if you can talk
from one local IP to some remote IP through one device
then you should allow the reverse traffic to work. With
my fix we just want to reduce the set of the local IPs
that can be used for ARP announcement. It is only a local
problem - ARP uses scope link routes. Make sure (1) does
not lead to problems caused remotely.

> Am I the only one that saw this kind of scary hole?

	The users prefer protection provided from firewall
rules, even for address spoofing, a matter of taste.

Regards

--
Julian Anastasov <ja@ssi.bg>

