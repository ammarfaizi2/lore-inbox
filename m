Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945973AbWJSGfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945973AbWJSGfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161339AbWJSGfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:35:47 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:27760 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161337AbWJSGfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:35:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Lo/5NljvQ8I9sfgOXNfONMYpmFbbKHNCjY+GmxAhTtKj2Mu3qMdj9odiVDj/Rj2On4sHWmVdzyKKhBhRq3hoHlrlD/75eJcaIo3WZ/2Ys2l3GiYYzbaaoWcoiYTVQ2fTwVxLUCShYkODurXs6g60t1Jjnhs8zSCbhiufxowSitM=  ;
Message-ID: <45371CBB.2030409@yahoo.com.au>
Date: Thu, 19 Oct 2006 16:35:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: holt@sgi.com, suresh.b.siddha@intel.com, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: exclusive cpusets broken with cpu hotplug
References: <20061017192547.B19901@unix-os.sc.intel.com>	<20061018001424.0c22a64b.pj@sgi.com>	<20061018095621.GB15877@lnx-holt.americas.sgi.com>	<20061018031021.9920552e.pj@sgi.com>	<45361B32.8040604@yahoo.com.au> <20061018231559.8d3ede8f.pj@sgi.com>
In-Reply-To: <20061018231559.8d3ede8f.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
>>I don't know if you want customers do know what domains they have. I think
>>you should avoid having explicit control over sched-domains in your cpusets
>>completely, and just have the cpusets create partitioned domains whenever
>>it can.
> 
> 
> We have a choice to make.  I am increasingly convinced that the
> current mechanism linking cpusets with sched domains is busted,
> allowing people to easily and unspectingly set up broken sched domain
> configs, without even being able to see what they are doing.
> Certainly that linkage has been confusing to some of us who are
> not kernel/sched.c experts.  Certainly users on production systems
> cannot see what sched domains they have ended up with.
> 
> We should either make this linkage explicit and understandable, giving
> users direct means to construct sched domains and probe what they have
> done, or we should remove this linkage.
> 
> My patch to add sched_domain flags to cpusets was an attempt to
> make this control explicit.
> 
> I am now 90% convinced that this is the wrong direction, and that
> the entire chunk of code linking cpu_exclusive cpusets to sched
> domains should be nuked.
> 
> The one thing I found so far today that people actually needed from
> this was that my real time people needed to be able to something like
> marking a cpu isolated.  So I think we should have runtime support for
> manipulating the cpu_isolated_map.
> 
> I will be sending in a pair of patches shortly to:
>  1) nuke the cpu_exclusive - sched_domain linkage, and
>  2) support runtime marking of isolated cpus.
> 
> Does that sound better to you?
> 

I don't understand why you think the "implicit" (as in, not directly user
controlled?) linkage is wrong. If it is allowing people to set up busted
domains, then the cpusets code is asking for the wrong partitions.

Having them explicitly control it is wrong because it is really an
implementation detail that could change in the future.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
