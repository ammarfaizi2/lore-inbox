Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVEOKxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVEOKxT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 06:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVEOKxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 06:53:19 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44760 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261584AbVEOKxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 06:53:01 -0400
Date: Sun, 15 May 2005 12:52:55 +0200
From: Andi Kleen <ak@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
       Alexander Nyberg <alexn@telia.com>, Jan Beulich <JBeulich@novell.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] adjust x86-64 watchdog tick calculation
Message-ID: <20050515105255.GJ26242@wotan.suse.de>
References: <s2832159.057@emea1-mh.id2.novell.com> <1115892008.918.7.camel@localhost.localdomain> <20050512142920.GA7079@openzaurus.ucw.cz> <20050513113023.GD15755@wotan.suse.de> <20050513195215.GC3135@elf.ucw.cz> <1116019676.6380.37.camel@mindpipe> <20050513225127.GB2016@elf.ucw.cz> <1116024993.6380.47.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116024993.6380.47.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 06:56:33PM -0400, Lee Revell wrote:
> On Sat, 2005-05-14 at 00:51 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > > > > Because it kills machine when interrupt latency gets too high?
> > > > > > Like reading battery status using i2c...
> > > > > 
> > > > > That's a bug in the I2C reader then. Don't shot the messenger for bad news.
> > > > 
> > > > Disagreed.
> > > > 
> > > > Linux is not real time OS. Perhaps some real-time constraints "may not
> > > > spend > 100msec with interrupts disabled" would be healthy
> > >              ^^^^
> > > You mean "microseconds", right?  100ms will be perceived by the user as,
> > > well, their machine freezing for 100ms...
> > 
> > I did mean miliseconds. IIRC current watchdog is at one second and it
> > still triggers even in cases when operation just takes too long.
> 
> I thought there was an understanding that 1 ms would be the target for
> desktop responsiveness.  So yes, disabling interrupts for more than 1ms
> is considered a bug.

No, it's a bit different. Let's say disabling interrupts after
boot even for considerable fractions of 1ms is a bug. But then
there are exceptional circumstances where you have no other choice.
In that case you need to use touch_nmi_watchdog yourself.
But these things should be rare, e.g. only in unlikely error
handling situations.

> 
> Why do you need to disable interrupts for 100ms to read the battery
> status exactly?

I guess because he's too lazy to rewrite the code use semaphores
and schedule_timeout(). He just needs to get over that. 

-Andi
