Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUEZXI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUEZXI0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 19:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUEZXI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 19:08:26 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:43162 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261162AbUEZXIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 19:08:24 -0400
Subject: Re: System clock speed too high - 2.6.3 kernel
From: john stultz <johnstul@us.ibm.com>
To: Joris van Rantwijk <joris@eljakim.nl>
Cc: lkml <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>
In-Reply-To: <Pine.LNX.4.58.0405270020080.1496@eljakim.netsystem.nl>
References: <1E4zj-77w-69@gated-at.bofh.it>
	 <Pine.LNX.4.58.0405251112040.30050@eljakim.netsystem.nl>
	 <1085518688.8653.19.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0405270020080.1496@eljakim.netsystem.nl>
Content-Type: text/plain
Message-Id: <1085612915.8653.42.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 26 May 2004 16:08:35 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-26 at 15:43, Joris van Rantwijk wrote:
> On Tue, 25 May 2004, john stultz wrote:
> > On Tue, 2004-05-25 at 02:22, Joris van Rantwijk wrote:
> > > If there are many systems with this problem, then calibrating the PM timer
> > > against the PIT timer at boot time (possibly rejecting invalid rates)
> > > might be an option.
> 
> > I'll put it on my todo list, but if you'd like to take a swing at ti and
> > beat me to the implementation, I wouldn't complain.
> 
> Sounds fair. I tried something and it even seems to work here.
> My dmesg now says:
>   PM-Timer running at invalid rate: 199% of normal - aborting.
>   Detected 400.816 MHz processor.
>   Using tsc for high-res timesource
> 
> Hmm, I think I'm enjoying this :-)
> My patch is included below and also submitted at the Kernel Bugzilla
> thing. I would appreciate it if someone else could also test it a bit.

As I said in the bugzilla bug, it looks good to me. I'm going to test it
on my box to make sure it works properly on normal systems, so I'll send
you the results. 

> Yesterday, I ran into a (hopefully) completely seperate issue with the
> timer. This happened before I even started messing with the kernel and
> while running with "clock=tsc". The kernel suddenly logged:
>   Losing too many ticks!
>   TSC cannot be used as a timesource
>    ...
>   Falling back to a sane timesource now.
> 
> And from that point on my system clock was running at about one third of
> normal speed. The fallback timesource is just the PIT timer, so it seems
> that my PIT had spontaneously dropped speed (thereby also causing the lost
> ticks). Anyone else seen this before ?

I've seen that occasionally, but normally due to cpufreq changes. Any
clue what else was happening on your system when it occurred? (heavy
disk load, etc?)

thanks
-john

