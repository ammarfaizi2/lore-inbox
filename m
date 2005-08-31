Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVHaBKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVHaBKh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 21:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVHaBKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 21:10:37 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:23954 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932317AbVHaBKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 21:10:36 -0400
Subject: Re: 2.6.13-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: dwalker@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1125441274.18150.39.camel@dhcp153.mvista.com>
References: <20050829084829.GA23176@elte.hu>
	 <1125372830.6096.7.camel@localhost.localdomain>
	 <20050830055321.GB5743@elte.hu>
	 <1125407163.5675.16.camel@localhost.localdomain>
	 <1125441274.18150.39.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 30 Aug 2005 21:10:07 -0400
Message-Id: <1125450607.5614.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-30 at 15:34 -0700, Daniel Walker wrote:
> Have you tried turning on 
> "Non-preemptible critical section latency timing" or "Latency tracing"

I just turned on the following:

  CONFIG_CRITICAL_PREEMPT_TIMING
  CONFIG_CRITICAL_IRQSOFF_TIMING
  CONFIG_LATENCY_TRACE

recompiled and booted.  No problem here.

> 
> I don't know if it's related to the PI changes, but I'm getting a crash
> with those on em64t .
> 
> With both above options I get
> 
> <0>init[1]: segfault at ffffffff8010ef44 rip ffffffff8010ef44 rsp 00007fffferror 5
> <0>init[1]: segfault at ffffffff8010ef44 rip ffffffff8010ef44 rsp 00007ffffffe8de8 error 5
> 
> printed never ending right after init starts.
> 
> If I only turn on "Non-preemptible critical section latency timing",
> then when I enter the command,
> "echo 0 > /proc/sys/kernel/preempt_max_latency"
> 
> The kernel will spit out a couple of max critical section updates , then
> it will hang silently.
> 
> This is all new in 2.6.13-rtX . It could have just come in with 2.6.13 ,
> but I thought I'd mention it.

Did you try the latest patches I just sent. Mainly this last one on
-rt2?  There is a deadlock that is fixed wrt the BKL.

-- Steve


