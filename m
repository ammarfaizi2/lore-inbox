Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271932AbTHRO3b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 10:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271922AbTHRO3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 10:29:31 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:57355 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S271904AbTHRO32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 10:29:28 -0400
Date: Mon, 18 Aug 2003 16:28:47 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-ID: <20030818142847.GA19910@alpha.home.local>
References: <200308171759540391.00AA8CAB@192.168.128.16> <1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk> <200308171827130739.00C3905F@192.168.128.16> <1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk> <20030817224849.GB734@alpha.home.local> <20030817223118.3cbc497c.davem@redhat.com> <20030818133957.3d3d51d2.skraw@ithnet.com> <20030818044419.0bc24d14.davem@redhat.com> <20030818125158.GA18699@alpha.home.local> <20030818055329.44db9262.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818055329.44db9262.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: list stripped down to MLs only]

> > > 2) what the default behavior should be
> > 
> > I think we should apply the exact same source selection as IP to ARP.
> 
> This is what setting the "arp_filter" sysctl on a device does
> if you've setup the preferred source on your routes correctly.
> If we would use that IP address to speak to the destination in
> the ARP, we respond, else we do not.
> 
> I've quoted the 'arp_filter' entry in Documentation/sysctl/ip-sysctl.txt
> please give it a read.

I've read it, but it's not about the same problem. It solves some problems
related to *INCOMING REQUESTS*, that some people are complaining about. My
problem was with source address for *OUTGOING REQUESTS*, and the arp_filter
sysctl has nothing to do with it since it. Arptables helps fixing this problem.

I fully respect your desire not to break existing behaviour, because even if
I'm fairly certain that *nobody* uses the current "feature" I'm facing, it's
possible that a definitive fix would break the workarounds they have set up for
this problem.

But if you agree to review it, I'm willing to write a simple patch which
provides a sysctl to enable automatic valid source for *OUTGOING REQUESTS*.
Basically, echoing 1 to /proc/sys/net/ipv4/ethXXX/arp_auto_src would select a
valid source address for outgoing ARP requests. I can even do it both for 2.4
and 2.6 (just need a bit more time). All other strange setups will have to be
left to arptables.

Now if you think that the behaviour I'm proposing is broken, please explain me
why. I'm not closed, I just want to understand, and since the beginning, I've
only heard about ARP replies but not requests.

Cheers,
Willy

