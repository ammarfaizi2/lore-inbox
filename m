Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133022AbREERMT>; Sat, 5 May 2001 13:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133023AbREERMA>; Sat, 5 May 2001 13:12:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49334 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133022AbREERLw>;
	Sat, 5 May 2001 13:11:52 -0400
Date: Sat, 5 May 2001 13:11:51 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <200105051120.f45BKic207817@saturn.cs.uml.edu>
Message-ID: <Pine.GSO.4.21.0105051257390.23716-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 May 2001, Albert D. Cahalan wrote:

>   case P_SWAP:
>     sprintf(tmp, "%4.4s ",
> 	scale_k(((task->size - task->resident) << CL_pg_shift), 4, 1));
>     break;

Albert, you can't be serious. The system had demand-loading for almost
ten years. ->size - ->resident can be huge with no swap at all. As in,
"box had never been subjected to swapon(8)".

	That value is a  mix of amount of stuff we hadn't paged in,
amount of stuff we had paged in but then dropped (e.g. code that
had never been touched for two weeks, since application only uses
it on startup) and amount of stuff that had been swapped out _and_
wasn't swapped in (it may very well stay in swap).

	BTW, "shared" is also bogus - page_count(page) can be raised
by any number of things.

> > 	* makes stuff like top(1) _walk_ _whole_ _page_ _tables_ _of_ _all_
> > 	  _processes_ each 5 seconds. No wonder it's slow like hell and eats
> > 	  tons of CPU time.
> 
> On my system, "statm" takes 50% longer than "stat" or "status".
> Maybe there is a significant difference with Oracle on a 32 GB box?

Depends on that applications mix.

