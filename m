Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUA0AMd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUA0AMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:12:32 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:54403 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265691AbUA0AMC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:12:02 -0500
Message-ID: <4015ABA8.3090202@cyberone.com.au>
Date: Tue, 27 Jan 2004 11:07:04 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Theurer <habanero@us.ibm.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: New NUMA scheduler and hotplug CPU
References: <20040125235431.7BC192C0FF@lists.samba.org> <315060000.1075134874@[10.10.2.4]> <40159C41.9030707@cyberone.com.au> <200401261740.12657.habanero@us.ibm.com>
In-Reply-To: <200401261740.12657.habanero@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Theurer wrote:

>>>To me, it'd make more sense to add the CPUs to the scheduler structures
>>>as they get brought online. I can also imagine machines where you have
>>>a massive (infinite?) variety of possible CPUs that could appear -
>>>like an NUMA box where you could just plug arbitrary numbers of new
>>>nodes in as you wanted.
>>>
>>I guess so, but you'd still need NR_CPUS to be >= that arbitrary
>>number.
>>
>>
>>>Moreover, as the CPUs aren't fixed numbers in advance, how are you going
>>>to know which node to put them in, etc? Setting up every possible thing
>>>in advance seems like an infeasible way to do hotplug to me.
>>>
>>Well this would be the problem. I guess its quite possible that
>>one doesn't know the topology of newly added CPUs before hand.
>>
>>Well OK, this would require a per architecture function to handle
>>CPU hotplug. It could possibly just default to arch_init_sched_domains,
>>and just completely reinitialise everything which would be the simplest.
>>
>
>Call me crazy, but why not let the topology be determined via userspace at a 
>more appropriate time?  When you hotplug, you tell it where in the scheduler 
>to plug it.  Have structures in the scheduler which represent the 
>nodes-runqueues-cpus topology (in the past I tried a node/rq/cpu structs with 
>simple pointers), but let the topology be built based on user's desires thru 
>hotplug.  
>

Well isn't userspace's idea of topology just what the kernel tells it?
I'm not sure what it would buy you... but I guess it wouldn't be too
much harder than doing it in kernel, just a matter of making the userspace
API.

BTW. I guess you haven't seen my sched domains code. It can describe
arbitrary topologies.


