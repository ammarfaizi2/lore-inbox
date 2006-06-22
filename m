Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWFVREU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWFVREU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWFVREU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:04:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42895 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932168AbWFVRET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:04:19 -0400
Message-ID: <449ACCC4.8010105@redhat.com>
Date: Thu, 22 Jun 2006 13:00:52 -0400
From: William Cohen <wcohen@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eranian@hpl.hp.com
CC: Christoph Hellwig <hch@infradead.org>,
       "Frank Ch. Eigler" <fche@redhat.com>, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com, perfmon@napali.hpl.hp.com
Subject: Re: [perfmon] Re: [PATCH 9/16] 2.6.17-rc6 perfmon2 patch for review:
 kernel-level API support (kapi)
References: <200606150907.k5F97coF008178@frankl.hpl.hp.com> <20060616135014.GB12657@infradead.org> <20060616140234.GI10034@frankl.hpl.hp.com> <y0mhd2lumz7.fsf@ton.toronto.redhat.com> <20060616154519.GA28931@infradead.org> <20060622121259.GF30281@frankl.hpl.hp.com>
In-Reply-To: <20060622121259.GF30281@frankl.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian wrote:
> Christoph,
> 
> On Fri, Jun 16, 2006 at 04:45:19PM +0100, Christoph Hellwig wrote:
> 
>>On Fri, Jun 16, 2006 at 11:41:32AM -0400, Frank Ch. Eigler wrote:
>>
>>>Whether one uses systemtap, raw kprobes, or some specialized
>>>tracing/stats-collecting patch surely forthcoming, kernel-level APIs
>>>would be needed to perform fine-grained kernel-scope measurements
>>>using these counters.
>>
> You do not need to be in the kernel to measure kernel level
> execution. Monitoring is statistical by nature, this is not about capturing
> execution traces. All PMU models have the capability to filter on privilege
> levels so you can distinguish user from kernel.
> 
> To measure certain functions of the kernel, some PMU models provide a
> way to restrict monitoring to a range of contiguous code addresses, e.g.
> Itanium 2. 

The filtering on privilege level is too coarse. For example want to 
start event counting on entry into a kernel function and stop when 
exiting the function. The itanium hw is not ideal for this application. 
The children functions may not be contiguous with the starting function. 
  Other kinds of predication based on state information, e.g. particular 
process or thread could be very useful.

> The case of systemtap is different. I think they would like to start/stop
> monitoring on certain systemtap events, e.g., a function is called, a
> threshold is met. Start and stop would be triggered from a systemtap
> callback which is implemented by a kernel module, if I understand
> the architecture. In the scenario, the monitoring session would have
> to be created and controlled from the kernel. One could envision an
> architecture, where monitoring would be controlled from user level 
> with systemtap making upcalls  but I do not think this is possible given
> that the instrumentation points can be very low level.
> 
> Another usage for a kernel-level monitoring API that I know about is 
> people who want to explore how to use the performance monitoring
> (and profiles) to guide the scheduler. A thread profile can tell the cache
> hit rates, stalls, bus bandwidth utilization, whether it uses flops and so on.
> This could be useful to to find the best placement for threads and avoid co-scheduling
> threads that trash each other's micro-architectural state or saturate the memory bus.
> In this scenario, one could envision a kernel thread controlling monitoring
> and processing profiles for the scheduler. But, to concur with you Christoph,
> I think this could be achieved from user level and the valuable information
> may be passed to the scheduler via a specific system call for instance.

One probably could configure the performance monitoring hardware from 
userspace. However, for micro-measurement in the kernel it seems like 
the pmu reads in kernel space would still be required.

-Will
