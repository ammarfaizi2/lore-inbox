Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269754AbUJMRAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269754AbUJMRAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 13:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269758AbUJMRAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 13:00:15 -0400
Received: from lehre.fh-hagenberg.at ([193.170.124.119]:61659 "EHLO
	postfix.fhs-hagenberg.ac.at") by vger.kernel.org with ESMTP
	id S269754AbUJMRAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 13:00:08 -0400
Date: Wed, 13 Oct 2004 19:03:14 +0200
From: Clemens Buchacher <drizzd@aon.at>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Questions about memory barriers
Message-ID: <20041013170313.GA9976@kzelldran.lan>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Kernel development list <linux-kernel@vger.kernel.org>
References: <20041013005640.GB12351@kzelldran.lan> <Pine.LNX.4.44L0.0410131043460.1181-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0410131043460.1181-100000@ida.rowland.org>
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 13 Oct 2004 17:00:08.0546 (UTC) FILETIME=[18396C20:01C4B146]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 11:25:30AM -0400, Alan Stern wrote:
> The impression I get from what you wrote below is that the barrier
> instruction causes the processor to abandon all speculative reads until
> any already-issued reads have completed.  Isn't that essentially the same
> as saying that no speculative (i.e., non-constant) read can be moved back
> past the barrier and that the barrier won't finish until all
> already-issued reads have completed (in other words, these reads can't be
> moved forward past the barrier)?

Well, first you have to invalidate any preceding speculative reads and, as you
correctly stated, abstain from any further speculative reads until all reads
preceding the barrier have completed. This restriction, however, does not force
us to wait at the barrier until all reads have completed (as a read barrier
would). We can continue to execute instructions for which all reads they depend
on have completed.

As a result, all read_barrier_depends() does is to prohibit reordering of
dependent instructions _across_ the barrier.

> This seems like a devilishly easy sort of thing to overlook!

True. Note that Alpha is the only architecture whose read_barrier_depends()
macro expands to something other than a no-op.

Clemens
