Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267230AbUIEVDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267230AbUIEVDH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 17:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbUIEVDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 17:03:07 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31114 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267230AbUIEVDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 17:03:00 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
In-Reply-To: <20040905191227.GA29797@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
	 <1094408203.4445.5.camel@krustophenia.net> <20040905191227.GA29797@elte.hu>
Content-Type: text/plain
Message-Id: <1094418192.4445.58.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 05 Sep 2004 17:03:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-05 at 15:12, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Ok, first new one in a while.  This was with -R0, but I haven't seen
> > anyone else report it.  Let me know if you need the complete trace.
> > 
> > preemption latency trace v1.0.2
> > -------------------------------
> >  latency: 511 us, entries: 951 (951)
> >     -----------------
> >     | task: dbench/4810, uid:1000 nice:0 policy:0 rt_prio:0
> >     -----------------
> >  => started at: kill_pg_info+0x10/0x50
> >  => ended at:   kill_pg_info+0x2e/0x50
> > =======>
> > 00000001 0.000ms (+0.000ms): kill_pg_info (sys_kill)
> > 00000001 0.000ms (+0.000ms): __kill_pg_info (kill_pg_info)
> > 00000001 0.000ms (+0.000ms): find_pid (__kill_pg_info)
> 
> this is quite hard to fix - lots of processes were SIGKILL-ed (or
> SIGTERM-ed) and the signal semantics require us to deliver signals
> atomically. The only fix would be to turn the signal locks into
> semaphores but that's quite hard. (it's also a bit problematic for
> interrupt-delivered signals.)
> 
> 	Ingo
> 

Here is a histogram I generated using realfeel2.  This should provide
better data than my jackd histograms because the latter are dependent on
the ALSA driver, jackd's design, etc.

I had to modify the amlat utilities to use usecs instead of msecs, this
is a very good sign. ;-)

http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-R0#/var/www/2.6.9-rc1-R0/foo.hist

I find the two smaller spikes to either side of the central spike really
odd.  These showed up in my jackd tests too, I had attributed them to
some measurement artifact, but they seem real.  Maybe a rounding bug, or
some kind of weird cache effect?

Lee


