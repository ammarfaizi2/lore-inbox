Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264405AbUEYBKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUEYBKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 21:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264422AbUEYBKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 21:10:38 -0400
Received: from mail.fastclick.com ([205.180.85.17]:26600 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S264405AbUEYBKc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 21:10:32 -0400
Message-ID: <40B29CB8.6040105@fastclick.com>
Date: Mon, 24 May 2004 18:09:12 -0700
From: "Brett E." <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Theurer <habanero@us.ibm.com>
CC: Andi Kleen <ak@muc.de>, "Bryan O'Sullivan" <bos@serpentine.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
References: <1Y6yr-eM-11@gated-at.bofh.it> <1085272089.25212.6.camel@obsidian.pathscale.com> <20040523142806.GA33866@colin2.muc.de> <200405241700.57249.habanero@us.ibm.com>
In-Reply-To: <200405241700.57249.habanero@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Theurer wrote:

> On Sunday 23 May 2004 09:28, Andi Kleen wrote:
> 
>>On Sat, May 22, 2004 at 05:28:09PM -0700, Bryan O'Sullivan wrote:
>>
>>>On Fri, 2004-05-21 at 16:42, Brett E. wrote:
>>>
>>>>Right now, 5 processes are running taking up a good deal of the CPU
>>>>doing memory-intensive work(cacheing) and I notice that none of the
>>>>processes seem to have CPU affinity.
>>>
>>>I don't know what kind of system you're running on, but if it's a
>>>multi-CPU Opteron, it is normally a sufficient fudge to just use
>>>sched_setaffinity to bind individual processes to specific CPUs.  The
>>>mainline kernel memory allocator does the right thing in that case, and
>>>allocates memory locally when it can.
>>>
>>>You can use the taskset command to get at this from the command line, so
>>>you may not even need to modify your code.
>>
>>Linus also merged the NUMA API support into mainline now with 2.6.7rc1, so
>>you can use numactl for more finegrained tuning.
> 
> 
> FYI Brett, some Opteron systems have a BIOS option to interleave memory.  If 
> you are going to make use of NUMA, I think you want to not interleave.
Thanks for the heads up, I just disabled interleaving in the BIOS.

> 
> Also, if you have a 25% imbalance within a domain/node, the scheduler can have 
> a tendency to bounce around a task for fairness.  That might be why you are 
> seeing little/no affinity to a cpu (even top might be causing some of this).   
> Not sure what the threshold is between domains/nodes, but I am curious if it 
> still happens with CONFIG_NUMA on.  If these are long lived cpu bound 
> processes, I would try to have the number of processes be a multiple of the 
> number of cpus.
I have CONFIG_NUMA on and yes these are long-lived processes(duration is 
1 hour).  And you and I are on the same wavelength, I'm imagining 3 
processes per CPU with apache handing off work to the processes in 
question.  This is on a 1.6ghz 2-way opteron if that matters at all. 
Hopefully I can make the modifications and test this tomorrow.



Thanks,

Brett

