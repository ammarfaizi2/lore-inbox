Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbULMQPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbULMQPG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbULMQPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:15:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44928 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261256AbULMQGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:06:07 -0500
Date: Mon, 13 Dec 2004 17:06:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
Message-ID: <20041213160605.GB25688@atrey.karlin.mff.cuni.cz>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <41BD483B.1000704@suse.de> <20041213135820.A24748@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213135820.A24748@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Just being devils advocate here...
> > > 
> > > I had variable Hz in my tree for a while and found there was one 
> > > solitary purpose to setting Hz to 100; to silence cheap capacitors.
> > 
> > power savings? Having the cpu wake up 1000 times per second if the
> > machine is idle cannot be better than only waking it up 100 times.
> > 
> > Yes, i am always on the quest for the 5 extra minutes on battery :-)
> 
> This is an easy thing to grab hold of, but rather pointless in the
> overall scheme of things.  Those of us who have done power usage
> measurements know this already.
> 
> The only case where this really makes sense is where the CPU power
> usage outweighs the power consumption of all other peripherals by
> at least an order of magnitude such that the rest of the system is
> insignificant compared to the CPU power.

Why by order of magnitude? Anyway on PC machines, cpu in low-power
mode takes about as much as rest of system, and in high-power mode it
takes more than rest of system combined.

I measured 1W savings from HZ=100, and that was on system that takes
17W total (arima athlon64 notebook). That is > 5%.

> Lets take an example.  Lets say that:
> * a CPU runs at about 245mA when active
> * 90mA when inactive
> * the timer interrupt takes 2us to execute 1000 times a second
> * no other processing is occuring

You assume that cpu goes to sleep immeidately. That is *very* far away
from reality on at least pentium 4. It takes half a milisecond to
sleep/wakeup the cpu, that basically means that low power mode is not
ever entered with HZ=1000...
								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
