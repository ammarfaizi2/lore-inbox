Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261849AbSJNHNM>; Mon, 14 Oct 2002 03:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSJNHNM>; Mon, 14 Oct 2002 03:13:12 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:38542 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261849AbSJNHNL>;
	Mon, 14 Oct 2002 03:13:11 -0400
Date: Mon, 14 Oct 2002 09:18:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ingo Adlung <Ingo.Adlung@t-online.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
Message-ID: <20021014091855.A4197@ucw.cz>
References: <3DA4B1EC.781174A6@mvista.com> <Pine.LNX.4.44.0210091613590.9234-100000@home.transmeta.com> <3DA94F07.7070109@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DA94F07.7070109@t-online.de>; from Ingo.Adlung@t-online.de on Sun, Oct 13, 2002 at 12:46:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 12:46:31PM +0200, Ingo Adlung wrote:

> Linus Torvalds wrote:
> > On Wed, 9 Oct 2002, george anzinger wrote:
> > 
> >>This patch, in conjunction with the "core" high-res-timers
> >>patch implements high resolution timers on the i386
> >>platforms.
> > 
> > 
> > I really don't get the notion of partial ticks, and quite frankly, this 
> > isn't going into my tree until some major distribution kicks me in the 
> > head and explains to me why the hell we have partial ticks instead of just 
> > making the ticks shorter.

Not speaking for a major distro, just for me writing HPET (high
performance event timer ...) support for x86-64 (and it happens to exist
on ia64 as well, and possibly might be in new Intel P4 chipsets, too).

It's a very nice piece of hardware that allows very fine granularity
aperiodic interrupts (in each interrupt you set when the next one will
happen), without much overhead.

It'd be a shame to just set this timer to 1kHz periodic just use that as
a base timer, when you can do much better resolution and latency-wise.
HPET has a base clock > 10 MHz.

> > 		Linus
> 
> In any kind of virtual environment you would rather prefer a completely 
> tickless system alltogether than increased tick rates. In a S/390 
> virtual machine, running many hundreds of virtual Linux servers the 
> 100Hz timer pops are already considerably painful, and going to a higher 
> tick rate achieving higher timer resolution is completely prohibitive. 
> Similar is true in many embedded systems related to power consumption of 
> high frequency ticks.
> 
> However, George has shown that introducing the notion of a completely 
> tickless system is expensive on Intel overhead wise, thus partial ticks 
> seem to be a possibility addressing the needs for embedded and virtual 
> environments, getting decent timer resolution as needed.

When HPET becomes a standard (yes, it's a MS requirement for new PCs),
it won't be expensive on i386 anymore.

-- 
Vojtech Pavlik
SuSE Labs
