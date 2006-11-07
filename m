Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753376AbWKGVfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbWKGVfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753381AbWKGVfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:35:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:26467 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1753376AbWKGVfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:35:09 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,397,1157353200"; 
   d="scan'208"; a="159625408:sNHT27163430"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>, "Ingo Molnar" <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, <akpm@osdl.org>,
       <mm-commits@vger.kernel.org>, <nickpiggin@yahoo.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: RE: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
Date: Tue, 7 Nov 2006 13:35:07 -0800
Message-ID: <000001c702b4$9895c730$e734030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccCsDHIO4bzIg0gTSqgbP3QsFM9JgAAeLEw
In-Reply-To: <Pine.LNX.4.64.0611071258280.5516@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Tuesday, November 07, 2006 12:59 PM
> On Tue, 7 Nov 2006, Ingo Molnar wrote:
> 
> > Per-CPU tasklets are equivalent to softirqs, with extra complexity and 
> > overhead ontop of it :-)
> > 
> > so please just introduce a rebalance softirq and attach the scheduling 
> > rebalance tick to it. But i'd suggest to re-test on the 4096-CPU box, 
> > maybe what 'fixed' your workload was the global serialization of the 
> > tasklet. With a per-CPU softirq approach we are i think back to the same 
> > situation that broke your system before.
> 
> What broke the system was the disabling of interrupts over long time 
> periods during load balancing.


The previous global load balancing tasket could be an interesting data point.
Do you see a lot of imbalance in the system with the global tasket?  Does it
take prolonged interval to reach balanced system from imbalance?

Conceptually, it doesn't make a lot of sense to serialize load balance in the
System.  But in practice, maybe it is good enough to cycle through each cpu
(I suppose it all depends on the user environment).  This exercise certainly
make me to think in regards to what is the best algorithm in terms of efficiency
and minimal latency to achieve maximum system throughput.  Does kernel really
have to do load balancing so aggressively in polling mode? Perhaps an event
driven mechanism is a better solution.

- Ken

