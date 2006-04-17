Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWDQWfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWDQWfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWDQWfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:35:21 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:45771 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751353AbWDQWfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:35:21 -0400
Subject: Re: [-rt] time-related problems with CPU frequency scaling
From: Lee Revell <rlrevell@joe-job.com>
To: woho@woho.de
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <200604162041.10844.woho@woho.de>
References: <200604162041.10844.woho@woho.de>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 18:35:16 -0400
Message-Id: <1145313317.16138.90.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-16 at 20:41 +0200, Wolfgang Hoffmann wrote:
> - if CPU frequency is low when jackd is started, it complains:
>     "delay of 2915.000 usecs exceeds estimated spare
>     time of 2847.000; restart ..."
>   as soon as frequency is scaled up. Seems that jackd gets confused by some
>   influence of CPU frequency on timekeeping? No problems as long as CPU
>   frequency isn't scaled up, though.

JACK still uses the TSC for timing and thus is incompatible with CPU
frequency scaling.  You must use the -clockfix branch from CVS.

> - values in /proc/sys/kernel/preempt_max_latency scales inverse to
>     CPU frequency, i.e. 24us with CPU @ 800MHz and 12us with CPU @ 1,6GHz 

This is normal - code that takes 12us to run at 1.6 GHz will take 24us
at 800MHz.  TANSTAAFL ;-)

Lee

