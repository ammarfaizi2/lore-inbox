Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbUJZEqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUJZEqY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbUJZBiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:38:10 -0400
Received: from zeus.kernel.org ([204.152.189.113]:985 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262100AbUJZBYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:24:07 -0400
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
Date: Mon, 25 Oct 2004 15:37:29 -0700
Message-Id: <1098743849.23374.44.camel@farah.beaverton.ibm.com>
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

I ran kernbench and specjbb on a 16 way xeon ht numa machine (32 total
sibling CPUs) and an 8 way ppc64 machine against 2.6.9-mm1 w/ and w/o my
active_load_balance() patch.  Kernbench was marginally faster on each
machine, and specjbb performed better on 64% of the tests.  SpecJBB is a
bit erratic anyway, so I feel good about these numbers.


Kernbench results below. (2.6.9-mm1-ab is the run with the
active_load_balance patch).

32 way xeon 
2.6.9-mm1
	Elapsed: 81.444s User: 1044.06s System: 138.008s CPU: 1451.2%
2.6.9-mm1-ab
	Elapsed: 81.372s User: 1037.842s System: 139.134s CPU: 1446%

8 way ppc64
2.6.9-mm1
	Elapsed: 53.336s User: 352.932s System: 45.302s CPU: 746%
2.6.9-mm1-ab
	Elapsed: 53.24s User: 353.096s System: 44.98s CPU: 747%

-- 
Darren Hart
IBM, Linux Technology Center
503 578 3185
dvhltc@us.ibm.com
