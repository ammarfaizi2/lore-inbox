Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVDDFru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVDDFru (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 01:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVDDFru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 01:47:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:53721 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261309AbVDDFqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 01:46:33 -0400
Date: Mon, 4 Apr 2005 07:45:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, kenneth.w.chen@intel.com,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Message-ID: <20050404054545.GA22190@elte.hu>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com> <20050402145351.GA11601@elte.hu> <20050402215332.79ff56cc.pj@engr.sgi.com> <20050403070415.GA18893@elte.hu> <20050403043420.212290a8.pj@engr.sgi.com> <20050403071227.666ac33d.pj@engr.sgi.com> <20050403152413.GA26631@elte.hu> <20050403160807.35381385.pj@engr.sgi.com> <4250A195.5030306@yahoo.com.au> <20050403205558.753f2b55.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403205558.753f2b55.pj@engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@engr.sgi.com> wrote:

> Ingo, if I understood correctly, suggested pushing any necessary 
> detail of the CPU hierarchy into the scheduler domains, so that his 
> latest work tuning migration costs could pick it up from there.
> 
> It makes good sense for the migration cost estimation to be based on 
> whatever CPU hierarchy is visible in the sched domains.
> 
> But if we knew the CPU hierarchy in more detail, and if we had some 
> other use for that detail (we don't that I know), then I take it from 
> your comment that we should be reluctant to push those details into 
> the sched domains.  Put them someplace else if we need them.

There's no other place to push them - most of the hierarchy related 
decisions are done based on the domain tree. So the decision to make is: 
"is it worth complicating the domain tree, in exchange for more accurate 
handling of the real hierarchy?".

In general, the pros are potentially more accuracy and thus higher 
application performance, the cons are overhead (more tree walking) and 
artifacts (the sched-domains logic is good but not perfect, and even if 
there were no bugs in it, the decisions are approximations. One more 
domain level might make things worse.)

but trying and benchmarking it is necessary to tell for sure.

	Ingo
