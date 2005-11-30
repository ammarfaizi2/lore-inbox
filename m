Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVK3BWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVK3BWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 20:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVK3BWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 20:22:53 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24770 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750759AbVK3BWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 20:22:53 -0500
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, kr@cybsft.com, tglx@linutronix.de, pluto@agmk.net,
       john.cooper@timesys.com, bene@linutronix.de, dwalker@mvista.com,
       trini@kernel.crashing.org, george@mvista.com,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20051130010646.GD19515@wotan.suse.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005456F00@hdsmsx401.amr.corp.intel.com>
	 <20051129195336.GP19515@wotan.suse.de> <1133296540.4627.7.camel@mindpipe>
	 <20051129205108.GQ19515@wotan.suse.de> <1133308505.4627.31.camel@mindpipe>
	 <20051130010646.GD19515@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 20:22:50 -0500
Message-Id: <1133313771.4627.39.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-30 at 02:06 +0100, Andi Kleen wrote:
> > But on my system gettimeofday uses the TSC and it's still ~35x slower
> > than RDTSC:
> > 
> > rlrevell@mindpipe:~$ ./timetest 
> > rdtsc: 10000 calls in 1079 usecs
> > gettimeofday: 10000 calls in 36628 usecs
> 
> First if you run this on an Athlon 64 the measurement is likely
> wrong because RDTSC can be speculated around. To get accurate
> data you need to add synchronizing instructions.
> 

OK.  Just for reference here's what people on the JACK list reported:

2.6.14-rt13, PREEMPT_RT, Athlon X2 4400+ (dual core)

rdtsc: 10000 calls in 68 usecs
gettimeofday: 10000 calls in 5170 usecs

P4@3.3Ghz/HT (OpenSUSE 10.0 2.6.13-15-smp):

rdtsc: 10000 calls in 253 usecs
gettimeofday: 10000 calls in 26547 usecs

> Then you're likely running 32bit. It doesn't use vsyscall gettimeofday
> yet, which makes it slower. 64bit would.

Yes, I am.  So it sounds like vsyscall gettimeofday for i386 is in the
works?

Lee

