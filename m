Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbUJYRDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbUJYRDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbUJYRAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:00:47 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:56544 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262030AbUJYQ73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:59:29 -0400
Subject: Re: [patch] scheduler: active_load_balance fixes
From: Darren Hart <dvhltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, lkml <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>, Martin J Bligh <mbligh@aracnet.com>,
       Rick Lindsley <ricklind@us.ibm.com>
In-Reply-To: <20041024023709.2e99cb6d.akpm@osdl.org>
References: <1098488173.2854.13.camel@farah.beaverton.ibm.com>
	 <4179EC91.2070100@cyberone.com.au>  <20041024023709.2e99cb6d.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Oct 2004 09:58:29 -0700
Message-Id: <1098723509.23374.10.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-24 at 02:37 -0700, Andrew Morton wrote:
> Nick Piggin <piggin@cyberone.com.au> wrote:
> >
> > 
> > 
> > Darren Hart wrote:
> > 
> > >The following patch against the latest mm fixes several problems with
> > >active_load_balance().
> > >
> > >
> > 
> > This seems much better. Andrew can you put this into -mm please.
> > 
> 
> Whenever we touch the load balancing we get sad little reports about
> performance regressions two months later.  How do we gain confidence in
> this change?
> 

I did run a kernbench test and forgot to include the results, my
apologies.  On a 16 way NUMA the new code was slightly faster.  The new
code basically does what I believe the original code was intended to do,
it doesn't take a radically new approach to load balancing.  It closes
up some corner cases (like continuing to balance after the runqueue is
empty) and fragile code (like removing the dependency on the order of
the sched_group construction).  It also removes some of the artificial
limits imposed by the old code, like always moving tasks to the last CPU
of a completely idle group.

I will run some more tests on this code today to improve our confidence.
It would help if others could do the same, particularly those who have
experience balancing problems in the past.

Thanks,

-- 
Darren Hart
IBM, Linux Technology Center
503 578 3185
dvhltc@us.ibm.com
