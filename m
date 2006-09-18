Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965639AbWIRK3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965639AbWIRK3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 06:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965640AbWIRK3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 06:29:22 -0400
Received: from tentacle.snto-msu.net ([194.88.210.4]:31952 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S965639AbWIRK3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 06:29:21 -0400
Date: Mon, 18 Sep 2006 14:29:19 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Andi Kleen <ak@suse.de>
Cc: Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Message-ID: <20060918102918.GA23261@tentacle.sectorb.msk.ru>
References: <4492D5D3.4000303@atmos.washington.edu> <44948EF6.1060201@atmos.washington.edu> <Pine.LNX.4.61.0606191638550.23553@ask.diku.dk> <200606191724.31305.ak@suse.de> <20060916120845.GA18912@tentacle.sectorb.msk.ru> <p73k6414lnp.fsf@verdi.suse.de> <20060918090330.GA9850@tentacle.sectorb.msk.ru> <p73eju94htu.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <p73eju94htu.fsf@verdi.suse.de>
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.17-rc6-64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 11:58:21AM +0200, Andi Kleen wrote:
> > > The x86-64 timer subsystems currently doesn't have clocksources
> > > at all, but it supports TSC and some other timers.
> > 
> 
> > until I hacked arch/i386/kernel/tsc.c
> 
> Then you don't use x86-64. 
> 
Oh. I mean I made arch/i386/kernel/tsc.c compile on x86-64
by hacking some Makefiles and headers. 

But the question is, why stock 2.6.18-rc7 could not use TSC on its own?

> > > > I've also had experience of unsychronized TSC on dual-core Athlon,
> > > > but it was cured by idle=poll.
> > > 
> > > You can use that, but it will make your system run quite hot 
> > > and cost you a lot of powe^wmoney.
> > 
> > Here in Russia electric power is cheap compared with hardware upgrade.
> 
> It's not just electrical power - the hardware is more stressed and will
> likely fail earlier too.  As a rule of thumb the hotter your hardware runs
> the earlier it will fail.

What hardware exactly. Doesn't it affect only CPU? And they are not
know to fail before any other components.
> > 
> > > > It seems that dhcpd3 makes the box timestamping incoming packets,
> > > > killing the performance. I think that combining router and DHCP server
> > > > on a same box is a legitimate situation, isn't it?
> > > 
> > > Yes.  Good point. DHCP is broken and needs to be fixed. Can you
> > > send a bug report to the DHCP maintainers? 
> > > 
> > > iirc the problem used to be that RAW sockets didn't do something
> > > they need them to do. Maybe we can fix that now.
> > 
> > Will try some days later.
> > 
> > Oh, and pppoe-server uses some kind of packet socket too, doesn't it?
> 
> The problem is not really using a packet socket, but using the SIOCGSTAMP
> ioctl on it. As soon as someone issues it the system will take accurate 
> time stamps for each incoming packet until the respective socket is closed.
> 
> Quick fix is to change user space to use gettimeofday() when it reads
> the packet instead.

Ok, thank you, I now understand.

> 
> For netdev: I'm more and more thinking we should just avoid the problem
> completely and switch to "true end2end" timestamps. This means don't
> time stamp when a packet is received, but only when it is delivered
> to a socket. The timestamp at receiving is a lie anyways because
> the network hardware can add an arbitary long delay before the driver interrupt
> handler runs. Then the problem above would completely disappear. 
> Comments? Opinions? 
> 
> -Andi
> 
~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

