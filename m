Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269553AbUJFVL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269553AbUJFVL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269547AbUJFVJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:09:15 -0400
Received: from fmr04.intel.com ([143.183.121.6]:32678 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269570AbUJFVDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:03:40 -0400
Message-Id: <200410062103.i96L37608539@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@redhat.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <nickpiggin@yahoo.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Default cache_hot_time value back to 10ms
Date: Wed, 6 Oct 2004 14:03:22 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSr5kKF5FxM3HhnSpW3ZNev4o0sLAAAGQvA
In-Reply-To: <Pine.LNX.4.58.0410061643160.20121@devserv.devel.redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Wednesday, October 06, 2004 1:51 PM
> On Wed, 6 Oct 2004, Chen, Kenneth W wrote:
> > Let me try to persuade ;-).  First, it hard to accept the fact that we
> > are leaving 11% of performance on the table just due to a poorly chosen
> > parameter. This much percentage difference on a db workload is a huge
> > deal.  It basically "unfairly" handicap 2.6 kernel behind competition,
> > even handicap ourselves compare to 2.4 kernel.  We have established from
> > various workloads that 10 ms works the best, from db to java workload.
> > What more data can we provide to swing you in that direction?
>
> the problem is that 10 msec might be fine for a 9MB L2 cache CPU running a
> DB benchmark, but it will sure be too much of a migration cutoff for other
> boxes. And too much of a migration cutoff means increased idle time -
> resulting in CPU-under-utilization and worse performance.
>
> so i'd prefer to not touch it for 2.6.9 (consider that tree closed from a
> scheduler POV), and we can do the auto-tuning in 2.6.10 just fine. It will
> need the same weeks-long testcycle that all scheduler balancing patches
> need. There are so many different type of workloads ...

I would argue that the testing should be the other way around: having people
argue/provide data why 2.5 is better than 10.  Is there any prior measurement
or mailing list posting out there?


> > Secondly, let me ask the question again from the first mail thread:
> > this value *WAS* 10 ms for a long time, before the domain scheduler.
> > What's so special about domain scheduler that all the sudden this
> > parameter get changed to 2.5? I'd like to see some justification/prior
> > measurement for such change when domain scheduler kicks in.
>
> iirc it was tweaked as a result of the other bug that you fixed.

Is it possible that whatever the tweak was done before, was running with
broken load balancing logic and thus invalidates the 2.5 ms result?


> anyway, we were running based on cache_decay_ticks for a long time - is
> that what was 10 msec on your box? The cache_decay_ticks calculation was
> pretty fine too, it scaled up with cachesize.

Yes, cache_decay_tick is what I referring to.  I guess I was too concentrated
on ia64. For ia64, it was hard coded to 10ms regardless what cache size is.

cache_decay_ticks isn't used anywhere in 2.6.9-rc3, maybe that should be the
one for cache_hot_time.

- Ken


