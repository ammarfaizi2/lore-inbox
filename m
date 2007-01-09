Return-Path: <linux-kernel-owner+w=401wt.eu-S1751248AbXAIKJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbXAIKJj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbXAIKJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:09:39 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:59319 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbXAIKJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:09:38 -0500
Date: Tue, 9 Jan 2007 15:39:26 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070109100925.GA22080@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org> <20070107210139.GA2332@tv-sign.ru> <20070108155428.d76f3b73.akpm@osdl.org> <20070109050417.GC589@in.ibm.com> <20070108212656.ca77a3ba.akpm@osdl.org> <20070109093302.GE589@in.ibm.com> <20070109015152.d5021254.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109015152.d5021254.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 01:51:52AM -0800, Andrew Morton wrote:
> > This thread makes absolutely -no- calls to try_to_freeze() in its lifetime.
> 
> Looks like a bug to me.  powerpc does appear to try to support the freezer.
> 
> > 1. Does this mean that the thread can't be frozen? (lets say that the
> >    thread's PF_NOFREEZE is not set)
> 
> yup.  I'd expect the freeze_processes() call would fail if this thread is
> running.

ok.

> 
> >    AFAICS it can still be frozen by sending it a signal and have the signal
> >    delivery code call try_to_freeze() ..
> 
> kernel threads don't take signals in the same manner as userspace.  A
> kernel thread needs to explicitly poll, via
> 
> 	if (signal_pending(current))
> 		do_something()

Thanks for the education! I feel much better about the use of process
freezer now ..

> > 2. If the thread can be frozen at any arbitrary point of its execution, then I
> >    dont see what prevents cpu_online_map from changing under the feet of rtasd
> >    thread,
> 
> It cannot.

Excellent ..

I just hope the latency of freeze_processes() is tolerable ..

-- 
Regards,
vatsa
