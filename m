Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965602AbWIRJDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965602AbWIRJDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 05:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965601AbWIRJDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 05:03:33 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:41622 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S965599AbWIRJDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 05:03:32 -0400
Date: Mon, 18 Sep 2006 13:03:30 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Andi Kleen <ak@suse.de>
Cc: Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Message-ID: <20060918090330.GA9850@tentacle.sectorb.msk.ru>
References: <4492D5D3.4000303@atmos.washington.edu> <44948EF6.1060201@atmos.washington.edu> <Pine.LNX.4.61.0606191638550.23553@ask.diku.dk> <200606191724.31305.ak@suse.de> <20060916120845.GA18912@tentacle.sectorb.msk.ru> <p73k6414lnp.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <p73k6414lnp.fsf@verdi.suse.de>
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.17-rc6-64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 10:35:38AM +0200, Andi Kleen wrote:
> > I just found out that TSC clocksource is not implemented on x86-64.
> > Kernel version 2.6.18-rc7, is it true?
> 
> The x86-64 timer subsystems currently doesn't have clocksources
> at all, but it supports TSC and some other timers.

Hm. On my box, TSC did not work, until I hacked arch/i386/kernel/tsc.c
in it. 
Neither clock=tsc nor clocksource=tsc didn't have any effect.

> > I've also had experience of unsychronized TSC on dual-core Athlon,
> > but it was cured by idle=poll.
> 
> You can use that, but it will make your system run quite hot 
> and cost you a lot of powe^wmoney.

Here in Russia electric power is cheap compared with hardware upgrade.

> > It seems that dhcpd3 makes the box timestamping incoming packets,
> > killing the performance. I think that combining router and DHCP server
> > on a same box is a legitimate situation, isn't it?
> 
> Yes.  Good point. DHCP is broken and needs to be fixed. Can you
> send a bug report to the DHCP maintainers? 
> 
> iirc the problem used to be that RAW sockets didn't do something
> they need them to do. Maybe we can fix that now.

Will try some days later.

Oh, and pppoe-server uses some kind of packet socket too, doesn't it?

> 
> If that's not possible we can probably add a ioctl or similar
> to disable time stamping for packet sockets (DHCP shouldn't really
> need a fine grained time stamp). dhcpcd would need to use that then.

I would like some sysctl very much, too. Let tcpdump show imprecise
timestamps when forwarding performance is more important.
After all, Ciscos don't have any tcpdump analog at all, and they are 
very popular :)

> 
> Keep me updated what they say.
> 
> -Andi
> 
~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

