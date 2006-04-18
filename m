Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWDRGOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWDRGOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 02:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWDRGOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 02:14:08 -0400
Received: from natipslore.rzone.de ([81.169.145.179]:24244 "EHLO
	natipslore.rzone.de") by vger.kernel.org with ESMTP id S932246AbWDRGOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 02:14:07 -0400
From: Wolfgang Hoffmann <woho@woho.de>
Reply-To: woho@woho.de
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [-rt] time-related problems with CPU frequency scaling
Date: Tue, 18 Apr 2006 08:11:13 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
References: <200604162041.10844.woho@woho.de> <1145313317.16138.90.camel@mindpipe>
In-Reply-To: <1145313317.16138.90.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604180811.13110.woho@woho.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 April 2006 00:35, Lee Revell wrote:
> On Sun, 2006-04-16 at 20:41 +0200, Wolfgang Hoffmann wrote:
> > - if CPU frequency is low when jackd is started, it complains:
> >     "delay of 2915.000 usecs exceeds estimated spare
> >     time of 2847.000; restart ..."
> >   as soon as frequency is scaled up. Seems that jackd gets confused by
> > some influence of CPU frequency on timekeeping? No problems as long as
> > CPU frequency isn't scaled up, though.
>
> JACK still uses the TSC for timing and thus is incompatible with CPU
> frequency scaling.  You must use the -clockfix branch from CVS.

Ok, so that's a userspace issue? Thanks for the pointer, I'll try the CVS 
branch.

> > - values in /proc/sys/kernel/preempt_max_latency scales inverse to
> >     CPU frequency, i.e. 24us with CPU @ 800MHz and 12us with CPU @ 1,6GHz
>
> This is normal - code that takes 12us to run at 1.6 GHz will take 24us
> at 800MHz.  TANSTAAFL ;-)

So I misunderstood preempt_max_latency. I thought it to be absolute time, but 
it actually is codepath cycles, translated to microseconds using the current 
CPU frequency. Thanks for clarifying. 

Wolfgang
