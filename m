Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263581AbTHWVAO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 17:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263689AbTHWVAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 17:00:14 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60172 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263581AbTHWVAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 17:00:07 -0400
Date: Sat, 23 Aug 2003 16:50:39 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "David S. Miller" <davem@redhat.com>
cc: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
In-Reply-To: <20030820104831.6235f3b9.davem@redhat.com>
Message-ID: <Pine.LNX.3.96.1030823163751.957A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003, David S. Miller wrote:

> On Wed, 20 Aug 2003 10:44:41 -0700
> Ben Greear <greearb@candelatech.com> wrote:
> 
> > It seems that these reasons would not preclude the addition of a flag
> > that would default to the current behaviour but allow the behaviour that
> > other setups desire easily?
> 
> I would accept a patch that did something like
> the following in arp_solicit().
> 
> 	if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL &&
> 	    (in_dev->conf.shared_media ||
> 	     inet_addr_onlink(dev, skb->nh.iph->saddr, 0)))
> 		saddr = skb->nh.iph->saddr;
> 	else
> 		saddr = inet_select_addr(dev, target, RT_SCOPE_LINE);
> 
> Then people can frob the shared_media sysctl for devices
> where they want the behavior to be that we will only use
> addresses assigned to the device as the solicitor address.
> 
> The shared_media setting defaults to one and thus would preserve
> current behavior by default.
> 
> The idea is not mine, Alexey suggested it to me the other day.
> 
> I hope this pleases people wrt. ARP request solicitor address
> handling.

I'm not sure if you changed your mind or someone finally made a proposal
you like on the ARP issue, but is there an implementation your would find
acceptable (other than source routing) to send packets out from the NIC
with the SIP configured when there are multiple NICs and IPs in the same
subnet? Using a random NIC for a given SIP confuses Cisco routers (and
other things).

Source routing becomes very complicated when there are a lot of IPs and
they are changing, and there are several patches which force binding a SIP
to a NIC, but you don't seem to like any of them. Please suggest a better
way. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

