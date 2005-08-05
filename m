Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263124AbVHEUQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbVHEUQE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbVHEUOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:14:00 -0400
Received: from waste.org ([216.27.176.166]:2013 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263107AbVHEUMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:12:21 -0400
Date: Fri, 5 Aug 2005 13:12:16 -0700
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@suse.de>
Cc: John B?ckstrand <sandos@home.se>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: lockups with netconsole on e1000 on media insertion
Message-ID: <20050805201215.GG7425@waste.org>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73ek987gjw.fsf@bragg.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 01:45:55PM +0200, Andi Kleen wrote:
> John B?ckstrand <sandos@home.se> writes:
> 
> > I've been trying to hunt down a hard lockup issue with some hardware
> > of mine, but I've possibly hit a kernel bug instead. When using
> > netconsole on my e1000, if I unplug the cable and then re-plug it, the
> > machine locks up hard. It manages to print the "link up" message on
> > the screen, but nothing after that. Now, I wonder if this is supposed
> > to be so? I tried this on 4 different configurations, 2.6.13-rc5 and
> > 2.6.12 with and without "noapic acpi=off", same result on all of
> > them. I've tried with 1 and 3 other NICs in the machine at the same
> > time.
> 
> I ran into the same problem some time ago on e1000. The problem was
> that if the link doesn't come up netconsole ends up waiting forever
> for it.

I still don't like this fix. Yes, you're right, it should eventually
give up. But here it gives up way too easily - 5 could easily
translate to 5 microseconds. This is analogous to giving up on serial
transmit if CTS is down for 5 loops.

I'd be much happier if there were some udelay or the like in here so
that we're not giving up on such a short timeframe.

-- 
Mathematics is the supreme nostalgia of our time.
