Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268234AbUHKVNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268234AbUHKVNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268233AbUHKVNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:13:37 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:61432 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268234AbUHKVN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:13:28 -0400
Message-ID: <411A8BAD.1010008@watson.ibm.com>
Date: Wed, 11 Aug 2004 17:12:13 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>	<200408071722.36705.efocht@hpce.nec.com>	<2447730000.1091976606@[10.10.2.4]>	<200408111140.14466.efocht@hpce.nec.com>	<10920000.1092235770@[10.10.2.4]> <20040811105057.76f97ead.pj@sgi.com>
In-Reply-To: <20040811105057.76f97ead.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:

> Martin wrote:
> 
>>but they're still close enough, that especially when programming
>>them in combination, it seems silly to have 2 separate interfaces. 
> 
> 
> The specific attributes needed of CKRM classes are not the same as those
> needed for cpusets.
> 
> The semantics of the two are distinct -- each has different rules that
> have little relevance to the other.


> 
> The typical uses of the two have little overlap.  More often than not,
> the applications that customers want to run in isolation in cpusets are
> not the same as those which customers want to run while sharing compute
> resources with a managed balance.

If you want to emphasize the differences, this might help:  cpusets 
allows apps to be confined to a set for gaining benefits like cache 
affinity and reduced memory latency. CKRM doesn't and cannot and in this 
use case, the two are orthogonal.

But when apps are being confined to a set of cpus *only* for purposes of 
  getting a certain fraction of the total compute power, cpusets are not 
orthogonal in intent, not implementation, from a CKRM CPU class 
implementing hard limits. More capable of achieving those limits, yes, 
but orthogonal, no.

Note that this does not suggest the joint use of the two mechanisms - 
merely that there exists a usage scenario where both are relevant and 
for users of which, a common interface might be handy.


> No, it is not silly to have 2 separate interfaces.  What's silly is to
> presume that everything that seems similar at the 10,000 foot level
> should be combined.
> 
> The details matter.  Show me the synergy.

What's your opinion on the commonalities between the two interfaces 
pointed out in my previous mail ?

Also, if CKRM were to move to the "each controller exports its own 
interface" model, how would this affect the discussion ?


> It is fitting and proper for kernels to provide independent mechanisms,
> and let user space connect them as it will.  


> Look at the actual hooks
> in the kernel code to implement these two facilities....  
> Perhaps the proper place to resolve this discussion in is a detailed
> examination of the kernel hooks required for CKRM and cpusets, the
> hooks in the scheduler, allocator and such.

No one is questioning that the internals differ. There is very little in 
common between a CKRM I/O controller and its CPU controller too. But 
that doesn't prevent them from sharing the same interface.

I repeat - the question isn't one of the internals - its about the 
interface. Do you think there's *any* merit to cpusets sharing the rcfs 
interface *if* the latter were to make the changes mentioned in earlier 
mail ?

If not (and others agree), lets end this discussion and move on - both 
projects have enough to do. If there is some commonality, lets see what 
we can do to enhance the eventual user's experience.

-- Shailabh

> You have both patches available to you.  Examine them.  Especially
> examine the hooks in the scheduler and allocator code.  These are not
> the same hooks.  I defy you to make them the same and propose such with
> a straight face.  If you do so successfully, I will sit up and take
> notice.



