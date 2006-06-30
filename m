Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWF3Sma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWF3Sma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933021AbWF3Sma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:42:30 -0400
Received: from ns2.suse.de ([195.135.220.15]:20629 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932363AbWF3Sm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:42:29 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Date: Fri, 30 Jun 2006 20:42:23 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephane Eranian <eranian@hpl.hp.com>
References: <200606301435_MC3-1-C3DD-5B3E@compuserve.com>
In-Reply-To: <200606301435_MC3-1-C3DD-5B3E@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606302042.23661.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 June 2006 20:33, Chuck Ebbert wrote:
> In-Reply-To: <200606301541.22928.ak@suse.de>
> 
> On Fri, 30 Jun 2006 15:41:22 +0200, Andi Kleen wrote:
> 
> > > So why do we need care about context switch in cpu-wide mode?
> > > It is because we support a mode where the idle thread is excluded
> > > from cpu-wide monitoring. This is very useful to distinguish 
> > > 'useful kernel work' from 'idle'. 
> > 
> > I don't quite see the point because on x86 the PMU doesn't run
> > during C states anyways. So you get idle excluded automatically.
> 
> Looks like it does run:

I'm pretty sure it doesn't. You can see it by watching 
the frequency of the perfctr mode NMI watchdog in /proc/interrupts 
under different loads.

When the system is idle the frequency goes down and increases
when the system is busy. I also got confirmation of this behaviour
from both Intel and AMD. C states > 0 are not supposed to run
the performance counters.

Are you sure you didn't boot with poll=idle? Otherwise something must
be wrong with your measurements.

-Andi
