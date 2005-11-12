Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVKLJWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVKLJWB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 04:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVKLJWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 04:22:01 -0500
Received: from styx.suse.cz ([82.119.242.94]:20902 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932247AbVKLJWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 04:22:00 -0500
Date: Sat, 12 Nov 2005 10:22:00 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH 13/39] NLKD/x86-64 - time adjustment
Message-ID: <20051112092200.GA7997@midnight.suse.cz>
References: <43720DAE.76F0.0078.0@novell.com> <200511101419.03838.ak@suse.de> <437365EF.76F0.0078.0@novell.com> <200511110312.15616.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511110312.15616.ak@suse.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 03:12:15AM +0100, Andi Kleen wrote:
> On Thursday 10 November 2005 15:23, Jan Beulich wrote:
> 
> >
> > >Please remove the ifdefs too.  64bit HPET support would be fine, but
> > >only as a runtime mechanism, not compile time.
> >
> > This I added only for the purpose of not affecting existing code in
> > existing configurations. If the code is generally acceptable, then I'll be
> > more than happy to convert it.
> 
> We can't use 64bit HPET everywhere because quite some chipsets only
> support 32bit HPET. So it has to be a runtime switch depending on the 
> capabilities of the hardware.

Is there any advantage to using 64-bit HPET? It's read is even slower
(and thus even more unusable in a vsyscall than a 32-bit HPET read), and
the missing 32 bits can be quite easily added should we need them for
computations, which I doubt.

> > >Can you remove debugger_jiffies please?
> > >The code has to handle long delays anyways (e.g. if someone uses a target
> > >probe), so we cannot rely on such hacks anyways.
> >
> > As above, I introduced this only to not affect existing code. If the added
> > latency is no problem, then of course only the overflow safe code path
> > should be kept, and then debugger_jiffies is completely unnecessary.
> 
> Hmm - didn't notice anything particularly slow. Or what were you thinking 
> about regarding the latency? And it should only run at each timer interrupt,
> so it isn't a fast path. So I guess it's best to run it always.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
