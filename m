Return-Path: <linux-kernel-owner+w=401wt.eu-S1750814AbXACOg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbXACOg0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 09:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbXACOg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 09:36:26 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:52900 "EHLO madara.hpl.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbXACOgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 09:36:25 -0500
Date: Wed, 3 Jan 2007 06:36:02 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com,
       suresh.b.siddha@intel.com, kenneth.w.chen@intel.com,
       tony.luck@intel.com
Subject: Re: sched_clock() on i386
Message-ID: <20070103143602.GG7238@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061222104306.GC1895@frankl.hpl.hp.com> <1166889227.14081.13.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166889227.14081.13.camel@imap.mvista.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On Sat, Dec 23, 2006 at 07:53:47AM -0800, Daniel Walker wrote:
> On Fri, 2006-12-22 at 02:43 -0800, Stephane Eranian wrote:
> > Hello,
> > 
> > 
> > The perfmon subsystems needs to compute per-CPU duration. It is using
> > sched_clock() to provide this information. However, it seems they are
> > big variations in the way sched_clock() is implemented for each architectures,
> > especially in the accuracy of the returned value (going from TSC to jiffies).
> > 
> 
> The vast majority of architectures return a scaled jiffies value for
> sched_clock(). MIPS, and ARM for instance are two, and i386 does
> sometimes. The function isn't very predictable in terms or what you'll
> get as output. 
> 
My understanding is that you'll get a per-CPU timestamp expressed in nanoseconds.
The granularity of the returned value is highly dependent on the CPU
architecture (and apparently on how you've compiled your kernel).

> The most reliable way to get timing is to use gettimeofday() which in
> turn uses a lowlevel clock. I'm not sure exactly what your application
> is, but sometimes gettimeofday() can be a little complicated to use.
> Which is why I create the following clocksource changes,
> 
I do NOT need a wall-clock time. I am looking for a simple per-CPU clock
source with best possible granularity. I use the clock to compute elapsed
execution duration. I initially was using TSC, then during the code review
someone suggested I use sched_clock(). Using getttimeofday() can be failry
expensive and I need to compute the duration in the context switch path.

Now my understanding is that on some processors with frequence scaling,
using TSC may not easily allow computing elapsed time. So there may not
be any cheap solution to my problem.

> ftp://source.mvista.com/pub/dwalker/clocksource/
> 
> the purpose of which is to allow generic access to suitable lowlevel
> clocks. It just extends the mechanism already used by gettimeofday(). 
> 

-- 

-Stephane
