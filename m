Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263360AbUC3H6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbUC3H6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:58:19 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:13971 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263360AbUC3H6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:58:17 -0500
Message-ID: <4069288B.9040806@yahoo.com.au>
Date: Tue, 30 Mar 2004 17:58:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
References: <20040329084531.GB29458@wotan.suse.de> <4068066C.507@yahoo.com.au> <20040329080150.4b8fd8ef.ak@suse.de> <20040329114635.GA30093@elte.hu> <20040329221434.4602e062.ak@suse.de> <4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de> <20040330064015.GA19036@elte.hu> <20040330090716.67d2a493.ak@suse.de> <40691E58.2080500@yahoo.com.au> <20040330074506.GB21596@elte.hu>
In-Reply-To: <20040330074506.GB21596@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>This works much better, but wildly varying (my tests go from 2.8xCPU to 
>>>~3.8x CPU for 4 CPUs. 2,3 CPU cases are ok). A bit more consistent 
>>>results would be better though.
>>
>>Oh good, thanks Ingo. Andi you probably want to lower your minimum
>>balance time too then, and maybe try with an even lower maximum. Maybe
>>reduce cache_hot_time a bit too.
> 
> 
> i dont think we want to balance with that high of a frequency on NUMA
> Opteron. These tunes were for testing only.
> 

I guess not. Andi says he wants it more like UMA balancing though...


> i'm dusting off the balance-on-clone patch right now, that should be the
> correct solution. It is based on a find_idlest_cpu() function which
> searches for the least loaded CPU and checks whether we can do passive
> load-balancing to it. Ie. it's yet another balancing point in the
> scheduler, _not_ some balancing logic change.
> 

Yep, as I said to Martin, I also agree this is probably good if it
is done carefully. I think we'll need to get a horde of thread
benchmarking people together before turning it on by default, of
course.

It seems Andi can now get equivalent results without it now, so it
isn't a pressing issue.
