Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264162AbTKSWmD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 17:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbTKSWmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 17:42:03 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:43656 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264162AbTKSWl7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 17:41:59 -0500
Subject: Re: Losing too many ticks! TSC cannot be used as time source...
From: john stultz <johnstul@us.ibm.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20031119112122.GA31451@vana.vc.cvut.cz>
References: <20031119112122.GA31451@vana.vc.cvut.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1069281424.23578.27.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 Nov 2003 14:37:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-19 at 03:21, Petr Vandrovec wrote:
> Hi,
>   today morning my kernel (2.6.0-test9-something) said that
> TSC became unusable. There are no other messages around this
> time in the log. It could be thermal throttling, but it should
> print some message when X86_MCE_P4THERMAL is enabled, yes?
> It happened after 17hrs 56min of uptime. System never produced
> this message before. 

Hmmm. Interesting. You haven't seen it before and you've been running
2.6.0-testX for awhile?

Any heavy cron jobs running at that time? 

The message is caused after 100 consecutive timer ticks where it appears
that the system has lost ticks. The assumption is that something has
gone wrong and we can no longer trust the TSC as a time source
(speedstep, for instance). Thermal throttling is a possibility, but I've
not actually seen it occur. I'd have to defer to the cpufreq folks on
that one. 

If we're getting false positives, we may have to bump that
100-consecutive-ticks number up. 

Anything else quirky about the system?


>   Are there some more information I could supply, or should I
> simple live with fact that TSC stopped working on my P4 today
> morning?

Well, the TSC didn't stop working, we just stopped using it as a time
source. Things should work fine using just the PIT, although I'd be
interested to hear if ntpd finally settled down after the change. If it
cannot stay synced it may be an issue w/ your system's PIT. 

You may also want to check the ACPI PM timesource code in -mm4, and see
how that works for you. 

thanks for the report!
-john


