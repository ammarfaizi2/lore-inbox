Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbTHTOAZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 10:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTHTOAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 10:00:25 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:44266 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261604AbTHTOAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 10:00:23 -0400
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: Bill Davidsen <davidsen@tmr.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
Date: Wed, 20 Aug 2003 08:59:36 -0500
User-Agent: KMail/1.5
Cc: David Lang <david.lang@digitalinsight.com>,
       Eric St-Laurent <ericstl34@sympatico.ca>, linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1030820000415.11300B-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030820000415.11300B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308200859.36164.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 August 2003 23:11, Bill Davidsen wrote:
> On Tue, 19 Aug 2003, William Lee Irwin III wrote:
> > On Tue, Aug 19, 2003 at 05:32:04PM -0700, David Lang wrote:
> > > while thinking about scaling based on CPU speed remember systems with
> > > variable CPU clocks (or even just variable performance like the
> > > transmeta CPU's)
> >
> > This and/or mixed cpu speeds could make load balancing interesting on
> > SMP. I wonder who's tried. jejb?
>
> Hum, I *guess* that if you are using some "mean time between dispatches"
> to tune time slice you could apply a CPU speed correction, but mixed speed
> SMP is too corner a case for me. I think if you were tuning time slice by
> mean time between dispatches (or similar) you could either apply a
> correction, set affinity low to keep jobs changing CPUs, or just ignore
> it.

One could continue this thinking (more load_balance corrections than 
timeslice, IMO) on to SMT processors, where the throughput of a sibling is 
highly dependent on what the other siblings are doing in the same core.  For 
example, in a dual proc system, the first physical cpu with one task will run 
much faster than the second cpu with 2 tasks.  Actually, using a shared 
runqueue would probably fix this (something we still don't have in 2.6-test).

But one other thing, and maybe this has been brought up before (sorry, I have 
not been following all the discussions), but why are we not altering 
timeslice based on the runqueue length for that processor?  Would it not make 
sense, for the sake of good interactivity, to lower all the timeslices when 
we have a longer runqueue?

-Andrew Theurer
