Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVEOKv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVEOKv2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 06:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVEOKv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 06:51:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5356 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261446AbVEOKvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 06:51:20 -0400
Date: Sun, 15 May 2005 12:51:00 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Alexander Nyberg <alexn@telia.com>, Jan Beulich <JBeulich@novell.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] adjust x86-64 watchdog tick calculation
Message-ID: <20050515105100.GB2223@elf.ucw.cz>
References: <s2832159.057@emea1-mh.id2.novell.com> <1115892008.918.7.camel@localhost.localdomain> <20050512142920.GA7079@openzaurus.ucw.cz> <20050513113023.GD15755@wotan.suse.de> <20050513195215.GC3135@elf.ucw.cz> <20050515103646.GF26242@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050515103646.GF26242@wotan.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Because it kills machine when interrupt latency gets too high?
> > > > Like reading battery status using i2c...
> > > 
> > > That's a bug in the I2C reader then. Don't shot the messenger for bad news.
> > 
> > Disagreed.
> > 
> > Linux is not real time OS. Perhaps some real-time constraints "may not
> > spend > 100msec with interrupts disabled" would be healthy, but it
> > certainly needs more discussion than "lets enable NMI
> > watchdog.". It needs to be written somewhere in big bold letters, too.
> 
> While linux is not a real time OS it has been always known that
> turning off interrupts for a long time is extremly rude.

Yes, it is rude, but it should not panic machines.

> If you really want you can use touch_nmi_watchdog in the delay
> loop then.  But note you have to compile it in, because touch_nmi_watchdog
> is not exported (Linus vetoed that for good reasons).
> 
> But again do you really need to disable interrupts during this
> i2c access? Can't you just use a schedule_timeout() and a semaphore?
> Why would other interrupts cause a problem during such a long delay?

In this case it is "AML code told you to disable interrupts, and do
this kind of bitbang". AML interpretter has no idea of what that code
does... Perhaps we could sprinkle touch_nmi_watchdog all over the
interpretter, but that's just ugly.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
