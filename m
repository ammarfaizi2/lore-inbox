Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266670AbUG0Wb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266670AbUG0Wb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266678AbUG0Wbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:31:55 -0400
Received: from h00904b3573a3.ne.client2.attbi.com ([66.30.117.150]:54483 "EHLO
	lips.xiph.org") by vger.kernel.org with ESMTP id S266670AbUG0WaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:30:20 -0400
Date: Tue, 27 Jul 2004 18:38:53 -0400
From: Monty <xiphmont@xiph.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: large, spurious[?] TSC skews on AMD 760MPX boards
Message-ID: <20040727223853.GL14553@xiph.org>
References: <2kECV-3a0-3@gated-at.bofh.it> <m3isc9mker.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3isc9mker.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Tue, Jul 27, 2004 at 07:26:04PM +0200, Andi Kleen wrote:
> xiphmont@xiph.org (Monty) writes:
> 
> > Ever since getting my first dual Athlon, the system timer was 'not
> > quite right' when running at stock speed.  Selects, alarms, etc, had a
> > strange way of firing fractions of a second or several seconds 'too
> > late'.  I discovered that overclocking by about 10% made the problem
> 
> That points away from the TSC actually. select and alarm use the jiffies
> clock, which is managed by the PIT timer in the southbridge. AFAIK
> they never rely on the TSC. 

Although I believe you, the timer problem exists only when boot
reports the TSC skew.

> Assuming it is the TSC: 
> 
> You could write a multithreaded program that polls the TSCs
> on your both CPU for a long time and check out the drift rate. 
> The kernel will try to fix it at boot time, but it cannot do that when the TSCs
> are drifting later.

Drift doesn't seem to be a problem; if the system boots without the
'skew' message, I have no timer difficulties even if the box is up for
months.  If the system boots with a skew message, not a single
timer-based op on the machine seems to work ever; I can't watch
movies, play games or anything.  I'll get a few frames, a freeze for
several seconds, a few seconds of frames, freeze for several seconds,
a frame or two, more freeze, etc...  This appears to be related to
processor affinity (when the process gets bounced to the other CPU,
the timers appear to just freeze for a while or stop entirely).

> One way to work around it would be to boot with "notsc". This will
> make your gettimeofday() slower and more inaccurate though.

I will try that and report back.

> Assuming it is not: 
> 
> Something is wrong with your PIT timer in the southbridge. Maybe
> just run ntpd ?

I do run ntpd. My problem and concern is primarily with sub-second
timers having a granularity of several seconds.

> I know that later AMD chipsets - in particular the 8111 - are somewhat
> bad time keepers, which makes it a good idea to run NTP always.

The bug is all or nothing.  Without the bootup skew report, the
machine runs flawlessly indefinitely.

Monty
