Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbUC2LUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 06:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbUC2LUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 06:20:51 -0500
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:41066 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262812AbUC2LUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 06:20:23 -0500
Message-ID: <4068066C.507@yahoo.com.au>
Date: Mon, 29 Mar 2004 21:20:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ingo Molnar <mingo@elte.hu>, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <20040325154011.GB30175@wotan.suse.de> <20040325190944.GB12383@elte.hu> <20040325162121.5942df4f.ak@suse.de> <20040325193913.GA14024@elte.hu> <20040325203032.GA15663@elte.hu> <20040329084531.GB29458@wotan.suse.de>
In-Reply-To: <20040329084531.GB29458@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thu, Mar 25, 2004 at 09:30:32PM +0100, Ingo Molnar wrote:
> 
>>* Andi Kleen <ak@suse.de> wrote:
>>
>>
>>>That won't help for threaded programs that use clone(). OpenMP is such
>>>a case.
>>
>>this patch:
>>
>>        redhat.com/~mingo/scheduler-patches/sched-2.6.5-rc2-mm3-A4
>>
>>does balancing at wake_up_forked_process()-time.
>>
>>but it's a hard issue. Especially after fork() we do have a fair amount
>>of cache context, and migrating at this point can be bad for
>>performance.
> 
> 
> I ported it by hand to the -mm4 scheduler now and tested it. While
> it works marginally better than the standard -mm scheduler 
> (you get 1 1/2 the bandwidth of one CPU instead of one) it's still
> still much worse than the optimum of nearly 4 CPUs archived by
> 2.4 or the standard scheduler.
> 

OK there must be some pretty simple reason why this is happening.
I guess being OpenMP it is probably a bit complicated for you to
try your own scheduling in userspace using CPU affinities?
Otherwise could you trace what gets scheduled where for both
good and bad kernels? It should help us work out what is going
on.

I wonder if using one CPU from each quad of the NUMAQ would be
give at all comparable behaviour...

If it isn't a big problem, could you test with -mm5 with the
generic sched domain? STREAM doesn't take long, does it?
I don't expect much difference, but the code is in flux while
Ingo and I try to sort things out.
