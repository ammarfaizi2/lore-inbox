Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752015AbWJ1JQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbWJ1JQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 05:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbWJ1JQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 05:16:25 -0400
Received: from styx.suse.cz ([82.119.242.94]:11486 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1752015AbWJ1JQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 05:16:25 -0400
Date: Sat, 28 Oct 2006 11:14:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: thockin@hockin.org, Jiri Bohac <jbohac@suse.cz>,
       Luca Tettamanti <kronos.it@gmail.com>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061028091453.GA17500@suse.cz>
References: <1161969308.27225.120.camel@mindpipe> <68676e00610271700i741b949frc73bf790d38ab1f@mail.gmail.com> <20061028024638.GA16579@hockin.org> <200610272059.13753.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610272059.13753.ak@suse.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 08:59:13PM -0700, Andi Kleen wrote:

> > There are few problems at hand.  I'm not familiar with the patch Andi's
> > talking about but it has to solve all these problems to be really useful:
> 
> It's from Jiri and Vojtech.  Basically it will allow to use RDTSC
> in gettimeofday even with unsynchronized TSCs by keeping
> the necessary offsets CPU local.
> 
> Drawback: for vsyscall you need RDTSCP, this means AMD F stepping
> at least. But even as a syscall it will be still faster than before.
> 
> > * TSC skew across CPUs at bootup (Linux handles this already)
> 
> Just not very good. There is still a significant error when it's done.
> 
> > * TSC drift across CPUs at the "same" frequency (pretty constant, minimal)
> 
> It just adds up over time.
> 
> > * TSC drift because of PM states, such as C1 (hlt) (semi-random, severe)
> 
> TSC drift with powernow -- CPUs run at different frequencies
 
And the patch does exactly that.

It doesn't assume much about TSCs, except that they're individually
monotonic and that without a warning (cpufreq notifier, c1 state
enter/leave) the frequency doesn't change quickly. Slow frequency drift
(spread spectrum modulation, thermal effects on Xtal) is compensated for.

We still are testing the patch and fixing the issues we find, currently
with our cpufreq handling, but I believe we're on a good way to have it
working well.

-- 
Vojtech Pavlik
Director SuSE Labs
