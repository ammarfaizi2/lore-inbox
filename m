Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWA0I3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWA0I3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 03:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWA0I3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 03:29:51 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:58074 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751382AbWA0I3u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 03:29:50 -0500
Message-ID: <43D9D9FB.8070903@us.ibm.com>
Date: Fri, 27 Jan 2006 00:29:47 -0800
From: Sridhar Samudrala <sri@us.ibm.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Matthew Dobson <colpatch@us.ibm.com>
CC: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 0/9] Critical Mempools
References: <1138217992.2092.0.camel@localhost.localdomain> <Pine.LNX.4.62.0601260954540.15128@schroedinger.engr.sgi.com> <43D954D8.2050305@us.ibm.com> <Pine.LNX.4.62.0601261516160.18716@schroedinger.engr.sgi.com> <43D95BFE.4010705@us.ibm.com>
In-Reply-To: <43D95BFE.4010705@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> Christoph Lameter wrote:
>   
>> On Thu, 26 Jan 2006, Matthew Dobson wrote:
>>
>>
>>     
>>>> All subsystems will now get more complicated by having to add this 
>>>> emergency functionality?
>>>>         
>>> Certainly not.  Only subsystems that want to use emergency pools will get
>>> more complicated.  If you have a suggestion as to how to implement a
>>> similar feature that is completely transparent to its users, I would *love*
>>>       
>> I thought the earlier __GFP_CRITICAL was a good idea.
>>     
>
> Well, I certainly could have used that feedback a month ago! ;)  The
> general response to that patchset was overwhelmingly negative.  Yours is
> the first vote in favor of that approach, that I'm aware of.
>
>
>   
>>> to hear it.  I have tried to keep the changes to implement this
>>> functionality to a minimum.  As the patches currently stand, existing slab
>>> allocator and mempool users can continue using these subsystems without
>>> modification.
>>>       
>> The patches are extensive and the required changes to subsystems in order 
>> to use these pools are also extensive.
>>     
>
> I can't really argue with your first point, but the changes required to use
> the pools should actually be quite small.  Sridhar (cc'd on this thread) is
> working on the changes required for the networking subsystem to use these
> pools, and it looks like the patches will be no larger than the ones from
> the last attempt.
>   
I would say that the patches to support critical sockets will be 
slightly more complex with mempools
than the earlier patches that used the global critical page pool with a 
new GFP_CRITICAL flag.

Basically we need a facility to mark an allocation request as critical 
and satisfy this request without
any blocking in an emergency situation.

Thanks
Sridhar
>
>   
>>>> There surely must be a better way than revising all subsystems for 
>>>> critical allocations.
>>>>         
>>> Again, I could not find any way to implement this functionality without
>>> forcing the users of the functionality to make some, albeit very minor,
>>> changes.  Specific suggestions are more than welcome! :)
>>>       
>> Gfp flag? Better memory reclaim functionality?
>>     
>
> Well, I've got patches that implement the GFP flag approach, but as I
> mentioned above, that was poorly received.  Better memory reclaim is a
> broad and general approach that I agree is useful, but will not necessarily
> solve the same set of problems (though it would likely lessen the severity
> somewhat).
>
> -Matt
>   


