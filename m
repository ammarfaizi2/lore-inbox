Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278783AbRJ1Wmc>; Sun, 28 Oct 2001 17:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278824AbRJ1WmW>; Sun, 28 Oct 2001 17:42:22 -0500
Received: from ibis.worldnet.net ([195.3.3.14]:11013 "EHLO ibis.worldnet.net")
	by vger.kernel.org with ESMTP id <S278783AbRJ1WmT>;
	Sun, 28 Oct 2001 17:42:19 -0500
Message-ID: <3BDC89E8.FF8446C@worldnet.fr>
Date: Sun, 28 Oct 2001 23:42:48 +0100
From: Laurent Deniel <deniel@worldnet.fr>
Organization: Home
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ethernet NIC dual homing
In-Reply-To: <Pine.LNX.4.10.10110281727070.5138-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> 
> > > > the kernel switches to the second NIC. Such a similar feature exists in
> > >
> > > why not user-space?
> >
> > Good question. The switch could be initiated by a user-space daemon but
> > the switch itself should be implemented at kernel level for performance
> > and atomicity reasons (to avoid too many loss of packets) ?
> 
> nets are lossy; no protocol can't tolerate losing a few packets.
> in any event, there's no way the kernel is going to contain elaborate
> heuristics that try to diagnose a failing NIC.  this sort of thing
> really has to be done by user-land. 

Yes. NetRAIN (Tru64 Unix) for instance has a daemon in user space that
monitor the device input & output statistics and try to generate some
traffic (e.g. by pinging some multicast groups) in case rx & tx packet counts
are not increased in some period of time. Then a switch is initiated if they
remain stable. But some failure conditions with some cards can be detected at
driver level (e.g. Ethernet link down).

> note that afaik, the switch
> could probably be done atomically simply by changing a route metric,
> and might even happen from the kernel's builtin load-balancing.
> it does depend on the failure mode you're expecting.  frankly, I've
> never had a NIC fail - what are you expecting, lightning damage or
> something?
> do you model that the device would give some sign that it's not working,
> or even some kind of warning?

The device could give the Ethernet link down indication. But most failures
would be detected at user-space level with the lack of rx/tx packets in 
some period of time. Such a feature would not only allow to have a working
redundant NIC but would also allow to have a fully redundant ethernet
connection (i.e. two Ethernet NIC could be connected to different switches 
in the same IP network), in case of failure of one NIC or switch, the other
route would be used by switching the NIC.

Laurent
