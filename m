Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbTIJKKy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbTIJKKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:10:53 -0400
Received: from [213.13.155.14] ([213.13.155.14]:18186 "EHLO zmail.pt")
	by vger.kernel.org with ESMTP id S261284AbTIJKKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:10:51 -0400
Subject: Re: Scaling noise
From: Ricardo Bugalho <ricardo.b@zmail.pt>
To: rob@landley.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200309100114.37867.rob@landley.net>
References: <20030903040327.GA10257@work.bitmover.com>
	 <200309090211.16136.rob@landley.net>
	 <pan.2003.09.09.16.07.28.847940@zmail.pt>
	 <200309100114.37867.rob@landley.net>
Content-Type: text/plain
Message-Id: <1063188639.1601.15.camel@ezquiel.nara.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 10 Sep 2003 11:10:40 +0100
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: ricardo.b@zmail.pt
X-Spam-Processed: zmail.pt, Wed, 10 Sep 2003 11:08:05 +0100
	(not processed: spam filter disabled)
X-Return-Path: ricardo.b@zmail.pt
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: ricardo.b@zmail.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-10 at 06:14, Rob Landley wrote:
> I'm not sure what the point of out-of-order VLIW would be.  You just put extra 
> pressure on the memory bus by tagging your instructions with grouping info, 
> just to give you even LESS leeway about shuffling the groups at run-time...

The point is: simpler in-order implementations. In-order CPUs don't
reorder instructions at run-time, as the name suggests.

> > VLIW ISAs are no different from others regarding branch prediction --
> > which is a problem for ALL pipelined implementations, superscalar or not.
> > Speculative execution is a feature of out-of-order implementation.
> 
> Ah yes, predication.  Rather than having instruction execution thingies be 
> idle, have them follow both branches and do work with a 100% chance of being 
> thrown away.  And you wonder why the chips have heat problems... :)

You're confusing brach prediction with instruction predication.
Branch prediction is a design feature, needed for most pipelined CPUs.
Because they're pipelined, the CPU may not know whether to take or not
the branch when its time to fetch the next instructions. So, instead of
stalling, it guesses. If its wrong, it has to rollback.
Instruction predication is another form of conditional execution: each
instruction has a predicate (a register) and is only executed if the
predicate is true.
The bad thing is that these instructions take their slot in the
pipeline, even if the CPU knows they'll never be executed in the moment
it fecthed them.
The good sides are:
a) Unlike branches, it doesn't have a constant mispredict penalty. So,
its good to replace "small" and unpredictable branches
b) Instead of a control dependency (branches) predication is a data
dependency. So, it gives compilers more freedom in scheduling-

> The point was, you can spend your transistor budget with big caches on the 
> die, but there are diminishing returns.

Depends on the workload..

-- 
	Ricardo

