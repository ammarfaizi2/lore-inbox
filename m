Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUFWWey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUFWWey (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUFWWd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:33:59 -0400
Received: from holomorphy.com ([207.189.100.168]:49541 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263555AbUFWWbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:31:48 -0400
Date: Wed, 23 Jun 2004 15:31:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-ID: <20040623223146.GG1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com> <20040623151659.70333c6d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623151659.70333c6d.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> While running OAST to test 2.6's maximum client capacity, the kernel
>> deadlocked instead of properly OOM'ing. The obvious cause was the
>> line if (nr_swap_pages > 0) in out_of_memory(), which fails to account
>> for pinned allocations. This can't simply be removed.

On Wed, Jun 23, 2004 at 03:16:59PM -0700, Andrew Morton wrote:
> It all seems like rather a lot of fuss.
> It should be the case that zone->all_unreclaimable is set by the time this
> happens.  Did you consider feeding that into the oom-killing decision
> instead?

The vast majority of all this are the couhters for reporting, which have
no effect on functionality. The actual functional effect is achieved by
two aspects: (a) passing __GFP_WIRED to __alloc_pages() and (b) passing
__GFP_WIRED to out_of_memory(), which informs it not to perform the test
if (nr_swap_pages > 0). I also made the small addition of removing wired
pagecache from the LRU lists, which is performance, not correctness.

I'll resend with all reporting/counters and LRU bits ripped out if needed.


-- wli
