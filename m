Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265684AbUHCKt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUHCKt1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 06:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUHCKt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 06:49:27 -0400
Received: from holomorphy.com ([207.189.100.168]:19123 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265684AbUHCKtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 06:49:24 -0400
Date: Tue, 3 Aug 2004 03:49:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
Message-ID: <20040803104912.GW2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Williams <pwil3058@bigpond.net.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
References: <410DDFD2.5090400@bigpond.net.au> <20040802134257.GE2334@holomorphy.com> <410EDD60.8040406@bigpond.net.au> <20040803020345.GU2334@holomorphy.com> <410F08D6.5050200@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410F08D6.5050200@bigpond.net.au>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 01:39:02PM +1000, Peter Williams wrote:
> OK.  Now I understand.
> The main reason that I didn't do something like that is that 
> (considering that real time tasks don't get promoted) it would complicate:
> 1. the selection (in schedule()) of the next task to be run as it would 
> no longer be a case of just finding the first bit in the bitmap,
> 2. determining the appropriate list to put the task on in 
> enqueue_task(), etc., and
> 3. determining the right bit to turn off in the bit map when dequeuing 
> the last task in a slot.
> As these are frequent operations compared to promotion I thought it 
> would be better to leave the complexity in do_promotion().  Now that 
> you've caused me to think about it again I realize that the changes in 
> the above areas may not be as complicated as I thought would be 
> necessary.  So I'll give it some more thought.

In such schemes, realtime tasks are considered separately from
timesharing tasks. Finding a task to run or migrate proceeds with a
circular search of the portion of the bitmap used for timesharing tasks
after a linear search of that for RT tasks. The list to enqueue a
timesharing task in is just an offset from the fencepost determined by
priority. Dequeueing is supported with a tag for actual array position.
I did this for aperiodic queue rotations, which differs from your SPA.


-- wli
