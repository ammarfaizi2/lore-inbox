Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSGNTav>; Sun, 14 Jul 2002 15:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSGNTau>; Sun, 14 Jul 2002 15:30:50 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:52228 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S317017AbSGNTat>;
	Sun, 14 Jul 2002 15:30:49 -0400
Date: Sun, 14 Jul 2002 22:35:04 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: Andi Kleen <ak@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
Message-ID: <Pine.LNX.4.44.0207142213210.1343-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello All, David,

Andi Kleen wrote:

> The main use of this seem to be certain HA failover setups.
> Some people use a patch that allows to disable ARP per interface for it
> ("hidden") but for some reasons it was not integrated.

	Yes, "hidden" has its own purpose which is limitted
usually to HA setups. Then Alexey proposed (from long time)
such ARP tricks to be controlled with hook(s)/rules. My ideas in
such direction resulted in "iparp" which is completed:

http://www.linuxvirtualserver.org/~julian/#iparp

	Its purpose is "tuning" of ARP (the kernel's use
only), not for security. For example, it can't deal with remote
replies.

	But at the same time I see David implements arptables.
May be now it is good time to ask:

	David,

	can you explain what kind of control will be
possible with arptables. For now, I see only filtering of
remote probes. As we know the clusters have different needs.
Can you draw a list of goals that will be achieved with
arptables and whether the 2 ARP requirements for clusters ("drop
probes to VIP" and the most needed "don't announce VIP in our
probes") will exist in arptables? The 3th requirement (used
from "hidden" to avoid problems with autoselecting VIP as src
IP can be easily solved in routing).

> It would be likely easier/more straightforward if there was a special
> ARP routing table that is only consulted by ARP filter (as an extension
> to the current multi table routing). Then you could just put reject routes
> there to filter ARP Unfortunately nobody has stepped forward to implement it
> yet, so it remained a dream so far.
>
> Another thing that was implemented is a netfilter chain for ARP, but
> afaik there are no filtering modules for it yet, so Joe User cannot
> use it. It likely just exists somewhere as a proprietary module in
> someone's firewall appliance and all they did was to contribute the
> hook. It probably would not be hard to rewrite a filter module for it,
> but again nobody did it yet.

Regards

--
Julian Anastasov <ja@ssi.bg>

