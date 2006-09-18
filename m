Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWIRIgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWIRIgH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWIRIgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:36:07 -0400
Received: from ns1.suse.de ([195.135.220.2]:46558 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751621AbWIRIgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:36:04 -0400
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
References: <4492D5D3.4000303@atmos.washington.edu>
	<44948EF6.1060201@atmos.washington.edu>
	<Pine.LNX.4.61.0606191638550.23553@ask.diku.dk>
	<200606191724.31305.ak@suse.de>
	<20060916120845.GA18912@tentacle.sectorb.msk.ru>
From: Andi Kleen <ak@suse.de>
Date: 18 Sep 2006 10:35:38 +0200
In-Reply-To: <20060916120845.GA18912@tentacle.sectorb.msk.ru>
Message-ID: <p73k6414lnp.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Vladimir B. Savkin" <master@sectorb.msk.ru> writes:

> On Mon, Jun 19, 2006 at 05:24:31PM +0200, Andi Kleen wrote:
> > 
> > > If you use "pmtmr" try to reboot with kernel option "clock=tsc".
> > 
> > That's dangerous advice - when the system choses not to use
> > TSC it often has a reason.
> 
> I just found out that TSC clocksource is not implemented on x86-64.
> Kernel version 2.6.18-rc7, is it true?

The x86-64 timer subsystems currently doesn't have clocksources
at all, but it supports TSC and some other timers.

> 
> I've also had experience of unsychronized TSC on dual-core Athlon,
> but it was cured by idle=poll.

You can use that, but it will make your system run quite hot 
and cost you a lot of powe^wmoney.

> It seems that dhcpd3 makes the box timestamping incoming packets,
> killing the performance. I think that combining router and DHCP server
> on a same box is a legitimate situation, isn't it?


Yes.  Good point. DHCP is broken and needs to be fixed. Can you
send a bug report to the DHCP maintainers? 

iirc the problem used to be that RAW sockets didn't do something
they need them to do. Maybe we can fix that now.

If that's not possible we can probably add a ioctl or similar
to disable time stamping for packet sockets (DHCP shouldn't really
need a fine grained time stamp). dhcpcd would need to use that then.

Keep me updated what they say.

-Andi
