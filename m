Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267597AbUIDKQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267597AbUIDKQj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269866AbUIDKQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:16:39 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:54662 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267597AbUIDKQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:16:34 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
In-Reply-To: <20040904085717.GA15744@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
	 <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu>
	 <4138A56B.4050006@cybsft.com> <20040903181710.GA10217@elte.hu>
	 <20040903193052.GA16617@elte.hu> <413939F8.1030806@cybsft.com>
	 <20040904085717.GA15744@elte.hu>
Content-Type: text/plain
Message-Id: <1094292999.6575.161.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 04 Sep 2004 06:16:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-04 at 04:57, Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> > After hammering the system for a little more than an hour it gave up.
> > I don't have the serial logging setup yet because I haven't had time
> > this evening. I will be glad to do whatever I can to try to help debug
> > this, but it will have to wait until tomorrow. The log is here:
> > 
> > http://www.cybsft.com/testresults/crashes/2.6.9-rc1-vo-R3.txt
> 
> fyi, i have now triggered a similar crash on a testbox too. It takes
> quite some time to trigger but it does.
> 
> since it happens with VP=0,KP=0,SP=0,HP=0 as well it should be one of
> the cond_resched_lock() (or cond_resched()) additions.
> 

Here are some results for R0 on another machine, a 1.2Ghz Athlon XP:

http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-R0

I have also changed the test again, to be more accurate.  Now the jackd
alsa driver separately keeps track of the time it spends in poll(), and
the time it takes running the jackd process cycle.  The length of one
period less the sum of the time we spent in poll() and the time it took
to run the process cycle equals the amount of time we spent ready to
run, and waiting to be scheduled AKA latency.

The results are pretty amazing - out of a period time of 666 usecs most
of the time we spend between 0 and 1 usec in this state,  The worst is
27 usecs or so.

These results are of course not directly comparable with previous tests,
but I believe this is the most accurate way to measure latency in jackd.

Lee 

