Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUINSzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUINSzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269199AbUINSxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:53:21 -0400
Received: from holomorphy.com ([207.189.100.168]:45461 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269387AbUINSwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:52:24 -0400
Date: Tue, 14 Sep 2004 11:52:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@ximian.com>
Cc: Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040914185212.GY9106@holomorphy.com>
References: <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au> <20040914150316.GN4180@dualathlon.random> <1095185103.23385.1.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095185103.23385.1.camel@betsy.boston.ximian.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 17:03 +0200, Andrea Arcangeli wrote:
>> we simply need a cond_resched_bkl() for that, no? Very few places are
>> still serialized with the BKL, so I don't think it would be a big issue
>> to convert those few places to use cond_resched_bkl.

On Tue, Sep 14, 2004 at 02:05:03PM -0400, Robert Love wrote:
> Yes, this is all we need to do.
> cond_resched() goes away under PREEMPT.
> cond_resched_bkl() does not.
> I did this a looong time ago, but did not get much interest.
> Explicitly marking places that use BKL's "I can always call schedule()"
> assumption help make it easier to phase out that assumption, too.  Or at
> least better mark it.

I'd vaguely prefer to clean up the BKL (ab)users... of course, this
involves working with some of the dirtiest code in the kernel that's
already discouraged most/all of those who work on reducing/eliminating
BKL use from touching it... maybe the latency trend is the final nail
in the coffin of resistance to cleaning that up, though I agree with
Alan that we have to be very careful about it, particularly since all
prior attempts failed to be sufficiently so.


-- wli
