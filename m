Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbTH0Hup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 03:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTH0Hup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 03:50:45 -0400
Received: from holomorphy.com ([66.224.33.161]:36533 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263151AbTH0Hun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 03:50:43 -0400
Date: Wed, 27 Aug 2003 00:51:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: mfedyk@matchmail.com, Andrew Morton <akpm@osdl.org>,
       Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
Message-ID: <20030827075143.GX4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Chubb <peter@chubb.wattle.id.au>, mfedyk@matchmail.com,
	Andrew Morton <akpm@osdl.org>,
	Peter Chubb <peterc@gelato.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au> <20030826181807.1edb8c48.akpm@osdl.org> <20030827012914.GB5280@matchmail.com> <20030827071648.GY1715@holomorphy.com> <16204.24623.273818.861350@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16204.24623.273818.861350@wombat.chubb.wattle.id.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 05:39:27PM +1000, Peter Chubb wrote:
> Yes, the kernel is (supposed) to calculate the integral over time of
> the memory sizes; user space divides these integrals by elapsed time
> to get averages.
> To calculate these you need a timestamp for last change, and a set of
> counters.
> Then code to update all the counters every time one of the sizes
> change (otherwise you need a timestamp for each counter) by adding
> current_size*(current_time - last_change_time) to each counter.

At some point after saying the wrong thing I realized this.


William> The fault counters are vaguely bogus when threads are
William> involved. There's a comment alluding to that nearby.

On Wed, Aug 27, 2003 at 05:39:27PM +1000, Peter Chubb wrote:
> The fault counters are incorrect anyway --- faults satisfied from the
> page cache are counted as major faults, whereas we expect only faults
> that sleep for disk I/O to be counted as major faults.

Okay, we can handle that by pushing the counter ticking down far enough
we can actually tell whether io was done or not. In the meantime we're
reporting garbage.


William> This already has two counters in the task_t (no, I will not
William> use Finnish Hungarian notation in my general posts) that are
William> 100% unused. Probably the only thing preventing slab poison
William> from showing up there outright is the whole task_t copy in
William> kernel/fork.c and the bss zeroing for init_task.

On Wed, Aug 27, 2003 at 05:39:27PM +1000, Peter Chubb wrote:
> It's unclear what `swaps' are in Linux.  Traditionally, this rusage
> field was the number of complete swapouts --- I'm not sure what the
> equivalent is when processes are not swapped out holus-bolus, but are
> paged gradually.

We don't have load control yet; the counters should probably be removed
until we do.


-- wli
