Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbVITTYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbVITTYV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 15:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbVITTYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 15:24:21 -0400
Received: from enterprise.francisscott.net ([64.235.237.105]:20747 "EHLO
	enterprise.francisscott.net") by vger.kernel.org with ESMTP
	id S965096AbVITTYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 15:24:21 -0400
Message-ID: <433061E4.20903@lampert.org>
Date: Tue, 20 Sep 2005 12:24:20 -0700
From: Scott Lampert <scott@lampert.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Langsdorf, Mark" <mark.langsdorf@amd.com>
CC: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH] x86-64: Fix bad assumption that dualcore
 cpus have synced TSCs
References: <84EA05E2CA77634C82730353CBE3A843032187C4@SAUSEXMB1.amd.com>
In-Reply-To: <84EA05E2CA77634C82730353CBE3A843032187C4@SAUSEXMB1.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Langsdorf, Mark wrote:

>>On Mon, 2005-09-19 at 21:49 +0200, Andi Kleen wrote:
>>    
>>
>>>On Mon, Sep 19, 2005 at 12:42:16PM -0700, john stultz wrote:
>>>      
>>>
>>>>On Mon, 2005-09-19 at 21:31 +0200, Andi Kleen wrote:
>>>>        
>>>>
>>>>>On Mon, Sep 19, 2005 at 12:16:43PM -0700, john stultz wrote:
>>>>>          
>>>>>
>>>>>>	This patch should resolve the issue seen in 
>>>>>>            
>>>>>>
>>bugme bug #5105, 
>>    
>>
>>>>>>where it is assumed that dualcore x86_64 systems have synced 
>>>>>>TSCs. This is not the case, and alternate timesources 
>>>>>>            
>>>>>>
>>should be 
>>    
>>
>>>>>>used instead.
>>>>>>            
>>>>>>
>>>>>I asked AMD some time ago and they told me it was synchronized. 
>>>>>The TSC on K8 is C state invariant, but not P state 
>>>>>          
>>>>>
>>invariant, but 
>>    
>>
>>>>>P states always happen synchronized on dual cores.
>>>>>
>>>>>So I'm not quite convinced of your explanation yet.
>>>>>          
>>>>>
>>>>Would a litter userspace test checking the TSC 
>>>>        
>>>>
>>synchronization maybe 
>>    
>>
>>>>shed additional light on the issue?
>>>>        
>>>>
>>>Sure you can try it.
>>>      
>>>
>>So, bugzilla.kernel.org has (temporarily at least) lost the 
>>reports from yesterday, but from the email i got, folks using 
>>my TSC consistency check that I posted were seeing what 
>>appears to be unsynched TSCs on dualcore AMD systems.
>>    
>>
>
>My understanding was that each TSC on a dual-core processor
>will advance individually and atomically.  They will not 
>always be in synchronization.
>
>  
>
>>Personally I suspect that the powernow driver is putting the 
>>cores independently into low power sleep and the TSCs are 
>>being independently halted, causing them to become unsynchronized.
>>    
>>
>
>The powernow-k8 driver doesn't know what a low power sleep state
>is, so I strongly doubt it is involved here.  It only handles
>pstates.
> 
>-Mark Langsdorf
>K8 PowerNow! Maintainer
>AMD, Inc.
>
>  
>

Just to add some end-user input here, I see the same issues regardless 
of whether I'm running with the powernow-k8 or not.  The clock problems 
seem to be unrelated to that, at least on my system.
    -Scott
