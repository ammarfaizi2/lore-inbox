Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbUC3HYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbUC3HYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:24:32 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:64687 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263322AbUC3HYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:24:25 -0500
Message-ID: <40692099.80708@yahoo.com.au>
Date: Tue, 30 Mar 2004 17:24:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: mingo@elte.hu, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>	<20040325154011.GB30175@wotan.suse.de>	<20040325190944.GB12383@elte.hu>	<20040325162121.5942df4f.ak@suse.de>	<20040325193913.GA14024@elte.hu>	<20040325203032.GA15663@elte.hu>	<20040329084531.GB29458@wotan.suse.de>	<4068066C.507@yahoo.com.au>	<20040329080150.4b8fd8ef.ak@suse.de>	<20040329114635.GA30093@elte.hu>	<20040329221434.4602e062.ak@suse.de>	<4068B692.9020307@yahoo.com.au>	<20040330083450.368eafc6.ak@suse.de>	<40691BCE.2010302@yahoo.com.au> <20040330091323.5c0f557a.ak@suse.de>
In-Reply-To: <20040330091323.5c0f557a.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tue, 30 Mar 2004 17:03:42 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>So it is very likely to be a case of the threads running too
>>long on one CPU before being balanced off, and faulting in
>>most of their working memory from one node, right?
> 
> 
> Yes.
>  
> 
>>I think it is impossible for the scheduler to correctly
>>identify this and implement the behaviour that OpenMP wants
>>without causing regressions on more general workloads
>>(Assuming this is the problem).
> 
> 
> Regression on what workload? The 2.4 kernel who did the
> early balancing didn't seem to have problems.
> 

No, but hopefully sched domains balancing will do
better than the old numasched.


> I have NUMA API for an application to select memory placement
> manually, but it's unrealistic to expect all applications to use it,
> so the scheduler has to do at least an reasonable default.
> 
> In general on Opteron you want to go as quickly as possible
> to your target node. Keeping things on the local node and hoping
> that threads won't need to be balanced off is probably a loss.
> It is quite possible that other systems have different requirements,
> but I doubt there is a "one size fits all" requirement and 
> doing a custom domain setup or similar would be fine for me.

It is the same situation with all NUMA, obviously Opteron's
1 CPU per node means it is sensitive to node imbalances.

> (or at least if sched domain cannot be tuned for Opteron then
> it would have failed its promise of being a configurable scheduler)
>  

Well it seems like Ingo is on to something. Phew! :)

> 
>>I suspect this would still be a regression for other tests
>>though where thread creation is more frequent, threads share
>>working set more often, or the number of threads > the number
>>of CPUs.
> 
> 
> I can try such tests if they're not too time consuming to set up.
> What did you have in mind?
> 

Not really sure. I guess probably most things that use a
lot of threads, maybe java, a web server using per connection
threads (if there is such a thing).

On the other hand though, maybe it will be a good idea if it
is done carefully...
