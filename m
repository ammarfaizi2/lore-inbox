Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWJSIW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWJSIW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 04:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWJSIW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 04:22:57 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:18518 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030272AbWJSIW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 04:22:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=y16vV6QEQx30irn5BoNZu4Bpa4Ym4vOOYPkITt6oh23Nw54boKFsMg+F7CKQYpDpJtk2DcksyD95oYPORNPWtfpTVEQ4/2QgCbc3lLmqQSIVJ3NoM92btPm+MAUlawXfFxTfammcMuumoRkbAYk0bqP691cmQi1yNLPRwZ0d0f4=  ;
Message-ID: <453735D8.5040100@yahoo.com.au>
Date: Thu, 19 Oct 2006 18:22:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: holt@sgi.com, suresh.b.siddha@intel.com, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: exclusive cpusets broken with cpu hotplug
References: <20061017192547.B19901@unix-os.sc.intel.com>	<20061018001424.0c22a64b.pj@sgi.com>	<20061018095621.GB15877@lnx-holt.americas.sgi.com>	<20061018031021.9920552e.pj@sgi.com>	<45361B32.8040604@yahoo.com.au>	<20061018231559.8d3ede8f.pj@sgi.com>	<45371CBB.2030409@yahoo.com.au>	<20061018235746.95343e77.pj@sgi.com>	<4537238A.7060106@yahoo.com.au>	<20061019003405.15a4dd8c.pj@sgi.com>	<45373241.5060203@yahoo.com.au> <20061019011152.752f9657.pj@sgi.com>
In-Reply-To: <20061019011152.752f9657.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
>>Paul Jackson wrote:
>>
>>>Nick wrote:
>>>
>>>
>>>>(we simply shouldn't allow
>>>>situations where we put a partition in the middle of a cpuset).
>>>
>>>
>>>Could you explain to me what you mean by "put a partition in the
>>>middle of a cpuset?"
>>>
>>
>>Your example, if a partition is created for each of the sub cpusets.
> 
> 
> The thing "we simply shouldn't allow", then, is the bread and
> butter of cpusets.

No. They can put a cpuset there all they like. But the cpuset code
should *not* put a partition there. That is all.

> 
> I am convinced that we are trying to pound nails with toothpicks.
> 
> The cpu_exclusive flag was the wrong flag to overload to define
> sched domains.


Well it is the correct flag if we only create the domain for the
oldest ancestor with the cpu_exclusive flag set. From the documentation:

   "A cpuset may be marked exclusive, which ensures that no other
    cpuset (except direct ancestors and descendents) may contain
    any overlapping CPUs or Memory Nodes."

It is this non overlapping property that we can take advantage of, and
partition the scheduler. Obviously, the exception (from the POV of the
oldest ancestor) is its descendents, which can be overlapping. So just
don't create partitions for those guys.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
