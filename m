Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVDDBqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVDDBqd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 21:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVDDBqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 21:46:33 -0400
Received: from fmr23.intel.com ([143.183.121.15]:61574 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261969AbVDDBqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 21:46:25 -0400
Message-Id: <200504040146.j341kEg32047@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, <mingo@elte.hu>,
       <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] sched: improve pinned task handling again!
Date: Sun, 3 Apr 2005 18:46:14 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU3OSojVIe0eg5dRtSDzxfJmFYjOwAHXB0g
In-Reply-To: <20050401200509.C5598@unix-os.sc.intel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote on Friday, April 01, 2005 8:05 PM
> On Sat, Apr 02, 2005 at 01:11:20PM +1000, Nick Piggin wrote:
> > How important is this? Any application to real workloads? Even if
> > not, I agree it would be nice to improve this more. I don't know
> > if I really like this approach - I guess due to what it adds to
> > fastpaths.
>
> Ken initially observed with older kernels(2.4 kernel with Ingo's sched),
> it was happening with few hundred processes. 2.6 is not that bad and it
> improved with recent fixes. It is not very important. We want to raise
> the flag and see if we can comeup with a decent solution.

The livelock is observed with an in-house stress test suite.  The original
intent of that test is remotely connected to stress the kernel.  It is by
accident that it triggered a kernel issue.  Though, we are now worried that
this can be used as a DOS attack.


Nick Piggin wrote on Friday, April 01, 2005 7:11 PM
> > Now presumably if the all_pinned logic is working properly in the
> > first place, and it is correctly causing balancing to back-off, you
> > could tweak that a bit to avoid livelocks? Perhaps the all_pinned
> > case should back off faster than the usual doubling of the interval,
> > and be allowed to exceed max_interval?

This sounds plausible, though my first try did not yield desired result
(i.e., still hangs the kernel, I might missed a few things here and there).


