Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUEANIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUEANIk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 09:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUEANIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 09:08:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:22929 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262106AbUEANIP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 09:08:15 -0400
Message-ID: <4093A128.80806@watson.ibm.com>
Date: Sat, 01 May 2004 09:07:52 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>, Christoph Hellwig <hch@infradead.org>
CC: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release
References: <Pine.LNX.4.44.0404301527400.6976-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0404301527400.6976-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Fri, 30 Apr 2004, Shailabh Nagar wrote:
>  
>
>>Rik van Riel wrote:
>>    
>>
>
>  
>
>>>User Mode Linux could definitely be an option for implementing
>>>resource management, provided that the overhead can be kept
>>>low enough.
>>>      
>>>
>>....and provided the groups of processes that are sought to be 
>>regulated as a unit are relatively static.
>>    
>>
>
>Good point, I hadn't thought of that one.
>
>It works for most of the workloads I had in mind, but
>you're right that it's not good enough for eg. the
>university shell server.
>
>  
>
Let's keep in mind that UML provides you a virtual machine, its an 
architecture.

"User-Mode Linux gives you a virtual machine that may have more hardware 
and software virtual resources than your actual, physical computer. Disk 
storage for the virtual machine is entirely contained inside a single 
file on your physical machine. "   straight from the side.

It has its well deserved place, its great for fault protection 
isolation, but it does have performance hits.
Futhermore, there is no resource management associated with it. As we 
pointed out at last year's OLS. UML and CKRM would go great in concert, 
as CKRM could deliver the resource management underneath.
AFAIK, UML tasks manifest themselves as tasks in the host, hence the UML 
image would provide naturally a class that could be assigned resources 
under CKRM.

One part that can not be done with virtual machines is the case of a 
shared middleware, where different classes of work are driving through a 
shared space.

UML and CKRM solve different issues and IMHO they nicely complement each 
other.

>>>For these purposes, "low enough" could be as much as 30%
>>>overhead, since that would still allow people to grow the
>>>utilisation of their server from a typical 10-20% to as
>>>much as 40-50%.
>>>      
>>>
>>In overhead, I presume you're including the overhead of running as 
>>many uml instances as expected number of classes. Not just the 
>>slowdown of applications because they're running under a uml instance 
>>(instead of running native) ?
>>
>>I think UML is justified more from a fault-containment point of view 
>>(where overheads are a lower priority) than from a performance 
>>isolation viewpoint.
>>
>>In any case, a 30% overhead would send a large batch of higher-end 
>>server admins running to get a stick to beat you with :-)
>>    
>>
>
>True enough, but from my pov the flip side is that
>merging the CKRM memory resource enforcement module
>has the potential of undoing lots of the performance
>tuning that was done to the VM in 2.6.
>
>That could result in bad performance even for the
>people who aren't using workload management at all...
>
>  
>
I am sure that can be worked out .. take a look at the history of NUMA 
support
When initially NUMA support was put in it was done through hooks at 
various interfaces.
Now its nicely embedded and abstracted out through macros in the memory 
space
and similar stuff is happening in the scheduler area through the 
introduction of sched domains.
We don't pay for NUMA or SMT if we are running on a single CPU system.

So I/we presume a similar progression will take place here. CKRM in its 
current
state provides you the infrastructure in the kernel. The way it is 
written or intended,
it should provide no overhead when not configured, neglible overhead 
when compiled
in but not used and "minimal/acceptable" overhead when resource 
management is enabled.

-- Hubertus


