Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030726AbWI0Ttn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030726AbWI0Ttn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030725AbWI0Ttm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:49:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36615 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030723AbWI0Ttl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:49:41 -0400
Date: Wed, 27 Sep 2006 19:46:00 +0000
From: Pavel Machek <pavel@ucw.cz>
To: jeremy@goop.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Per-processor private data areas for i386
Message-ID: <20060927194600.GA4538@ucw.cz>
References: <20060925184540.601971833@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925184540.601971833@goop.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [ Changes since previous post:
>   - roll a new set of patches with all updates, based on 2.6.18-mm1 ]
> 
> Implement per-processor data areas for i386.
> 
> This patch implements per-processor data areas by using %gs as the
> base segment of the per-processor memory.  This has two principle
> advantages:
> 
> - It allows very simple direct access to per-processor data by
>   effectively using an effective address of the form %gs:offset, where
>   offset is the offset into struct i386_pda.  These sequences are faster
>   and smaller than the current mechanism using current_thread_info().
> 
> - It also allows per-CPU data to be allocated as each CPU is brought
>   up, rather than statically allocating it based on the maximum number
>   of CPUs which could be brought up.
> 
> Performance:
> 
> I've done some simple performance tests on an Intel Core Duo running
> at 1GHz (to emphisize any performance delta).  The results for the
> lmbench null syscall latency test, which should show the most negative
> effect from this change, show a ~9ns decline (.237uS -> .245uS).
> This corresponds to around 9 CPU cycles, and correlates well with
> the addition of the push/load/pop %gs into the hot path.

So we have 4% slowdown...

> I have not yet measured the effect on other typees of processor or
> more complex syscalls (though I would expect the push/pop overhead
> would be drowned by longer times spent in the kernel, and mitigated by
> actual use of the PDA).
> 
> The size improvements on the kernel text are nice as well: 
>     2889361 -> 2883936 = 5425 bytes saved

...and 0.2% smaller kernel. I guess you should demonstrate speedup at
complex syscalls before wedecide it is worth it...?

-- 
Thanks for all the (sleeping) penguins.
