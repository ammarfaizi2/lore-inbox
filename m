Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbULMTtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbULMTtX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbULMTov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:44:51 -0500
Received: from gprs215-167.eurotel.cz ([160.218.215.167]:6528 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262294AbULMTNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 14:13:31 -0500
Date: Mon, 13 Dec 2004 20:12:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041213191249.GB1052@elf.ucw.cz>
References: <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041212234331.GO16322@dualathlon.random> <cone.1102897095.171542.10669.502@pc.kolivas.org> <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213125844.GY16322@dualathlon.random>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > But that does not matter, right? Yes, one-shot timer will not fire
> > exactly at right place, but as long as you are reading TSC and basing
> > next shot on current time, error should not accumulate.
> 
> As said in the rest of the message, the error (or some other error)
> accumulates heavily today in the tick-loss compensation/adjustment
> algorithm in arch/i386/kernel/timers/timer_tsc.c, so I'm sceptical
> about

I do not see how it should accumulate. Lets have working TSC. You want
to emulate fixed-period timer with single-shot timer.

int should_fire_at;

void handle_single_shot()
{
	int delay;
retry:n
	should_fire_at += loops_per_second/HZ
	delay = should_fire_at - get_tsc();
	if (delay < 0)
		goto retry;
	do_single_shot_in(delay);
}

I'm not sure what's broken with compensation code, but using
single-shot timer is not broken in theory.

> > [..] for their patent abuse against Java.
> 
> java isn't open source regardless of patents, use python instead ;).

Yes, java is bad, but using patents against it is evil, too. Plus
python does not yet run on my cellphone ;-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
