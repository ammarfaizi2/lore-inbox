Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVK3BHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVK3BHI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 20:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVK3BHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 20:07:07 -0500
Received: from ns1.suse.de ([195.135.220.2]:33439 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750736AbVK3BHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 20:07:06 -0500
Date: Wed, 30 Nov 2005 02:06:46 +0100
From: Andi Kleen <ak@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       acpi-devel@lists.sourceforge.net, nando@ccrma.Stanford.EDU,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com,
       tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com,
       bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org,
       george@mvista.com
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Message-ID: <20051130010646.GD19515@wotan.suse.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005456F00@hdsmsx401.amr.corp.intel.com> <20051129195336.GP19515@wotan.suse.de> <1133296540.4627.7.camel@mindpipe> <20051129205108.GQ19515@wotan.suse.de> <1133308505.4627.31.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133308505.4627.31.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But on my system gettimeofday uses the TSC and it's still ~35x slower
> than RDTSC:
> 
> rlrevell@mindpipe:~$ ./timetest 
> rdtsc: 10000 calls in 1079 usecs
> gettimeofday: 10000 calls in 36628 usecs

First if you run this on an Athlon 64 the measurement is likely
wrong because RDTSC can be speculated around. To get accurate
data you need to add synchronizing instructions.

Then you're likely running 32bit. It doesn't use vsyscall gettimeofday
yet, which makes it slower. 64bit would.

-Andi

