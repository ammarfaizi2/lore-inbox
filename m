Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264134AbUEOUvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbUEOUvw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 16:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264735AbUEOUvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 16:51:51 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:10477 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S264734AbUEOUvd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 16:51:33 -0400
Date: Sat, 15 May 2004 21:41:25 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: linux-kernel@tux.tmfweb.nl
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org, moqua@kurtenba.ch
Subject: Re: cpufreq and p4 prescott
Message-ID: <20040515194124.GA8212@dominikbrodowski.de>
Mail-Followup-To: linux-kernel@tux.tmfweb.nl,
	cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
	moqua@kurtenba.ch
References: <20040513173946.GA8238@dominikbrodowski.de> <20040514214751.GA8433@nospam.com> <20040515064434.GB8572@dominikbrodowski.de> <20040515105200.GA8095@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040515105200.GA8095@nospam.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 12:52:01PM +0200, rutger@nospam.com wrote:
> > > Ah, ok! This makes the measurement next to impossible. Unless we
> > > generate instructions of ~900 ticks, which should takes 900 + 5600
> > > ticks in case of modulated clock, and 900 ticks in case of
> > > non-modulated clock. Something to try...
> > 
> > As I said, I forgot the actual frequency, so 800 ticks is a guess...
> 
> The only thing I could find in Intel's documentation is the max. time
> of throttling is 3 microseconds (p.67; 5.2.1 of Prescott
> datasheet). So this 3 microseconds should correspond to 5600 ticks or
> so...

Can't find it in the datasheets right now, but did find an interesting
comment in section 13.15.3 of 24547212.pdf which explains the strange
behaviour we're seeing.

> ..so it has only effect on the same sibbling, not the other. That's
> what I meant with 'repeat scaling for each virtual processor'.

This is so strange... but it is what's to be found in said section in the
datasheet. It says both logical CPUs need to be set identically so that it
works "properly", i.e. as expected.

> That's true. I can set the freq. of each virtual CPU. Probably not
> very useful, and even confusing. And if we keep this,

I think we should not keep it; I'll prepare a patch soon.

> the scheduler
> should be told about the speed differences of both (virtual)
> processors.

On (real) SMP systems this is an issue; but even more on SMP systems where 
true frequency and voltage scaling is done. 

> > > However, what's the use of p4-clockmod if it doesn't have impact on
> > > the temperature and the power consumption of the CPU?
> > 
> > The use of the p4-clockmod driver is that it puts the CPU into a low-power
> > state -- it only has thermal and power consequences, however, if either the
> > "idling" does not work, or the processor load is higher than the frequency
> > the CPU is put into by p4-clockmod.
> 
> I saw several sleep states in which the processor can reside (like
> when using the 'hlt' instruction) like S3; would those help?

If you mean C3, then that's very good. ACPI C-States are "idling" -- ACPI
S-States (like S3) are for "suspend to ram/disk"

> I know this is not P4 specific, but motherboard specific, but do
> you know of modules which use motherboard specific knowledge to scale
> the processor?
No.
> If the BIOS can do it, so should we be able to do it.

Dynamic frequency scaling is (probably) way different from setting a
frequency at boot (which is what the BIOS does). Timing issues, settling
times, etc. are way too complicated, AFAICS. Even trying to do this might
result in severe non-recoverable hardware failures.

	Dominik
