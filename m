Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUC3HRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbUC3HRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:17:32 -0500
Received: from ns.suse.de ([195.135.220.2]:35475 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262961AbUC3HP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:15:57 -0500
Date: Tue, 30 Mar 2004 09:13:23 +0200
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: mingo@elte.hu, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
 sched-2.6.5-rc2-mm2-A3
Message-Id: <20040330091323.5c0f557a.ak@suse.de>
In-Reply-To: <40691BCE.2010302@yahoo.com.au>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>
	<20040325154011.GB30175@wotan.suse.de>
	<20040325190944.GB12383@elte.hu>
	<20040325162121.5942df4f.ak@suse.de>
	<20040325193913.GA14024@elte.hu>
	<20040325203032.GA15663@elte.hu>
	<20040329084531.GB29458@wotan.suse.de>
	<4068066C.507@yahoo.com.au>
	<20040329080150.4b8fd8ef.ak@suse.de>
	<20040329114635.GA30093@elte.hu>
	<20040329221434.4602e062.ak@suse.de>
	<4068B692.9020307@yahoo.com.au>
	<20040330083450.368eafc6.ak@suse.de>
	<40691BCE.2010302@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004 17:03:42 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>
> So it is very likely to be a case of the threads running too
> long on one CPU before being balanced off, and faulting in
> most of their working memory from one node, right?

Yes.
 
> I think it is impossible for the scheduler to correctly
> identify this and implement the behaviour that OpenMP wants
> without causing regressions on more general workloads
> (Assuming this is the problem).

Regression on what workload? The 2.4 kernel who did the
early balancing didn't seem to have problems.

I have NUMA API for an application to select memory placement
manually, but it's unrealistic to expect all applications to use it,
so the scheduler has to do at least an reasonable default.

In general on Opteron you want to go as quickly as possible
to your target node. Keeping things on the local node and hoping
that threads won't need to be balanced off is probably a loss.
It is quite possible that other systems have different requirements,
but I doubt there is a "one size fits all" requirement and 
doing a custom domain setup or similar would be fine for me.
(or at least if sched domain cannot be tuned for Opteron then
it would have failed its promise of being a configurable scheduler)
 
> I suspect this would still be a regression for other tests
> though where thread creation is more frequent, threads share
> working set more often, or the number of threads > the number
> of CPUs.

I can try such tests if they're not too time consuming to set up.
What did you have in mind?

-Andi
