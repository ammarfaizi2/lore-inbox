Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264272AbUEXXpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUEXXpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 19:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbUEXXpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 19:45:47 -0400
Received: from CPE-203-45-91-55.nsw.bigpond.net.au ([203.45.91.55]:19696 "EHLO
	mudlark.pw.nest") by vger.kernel.org with ESMTP id S264272AbUEXXpd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 19:45:33 -0400
Message-ID: <40B288BA.7010905@aurema.com>
Date: Tue, 25 May 2004 09:43:54 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: Rik van Riel <riel@redhat.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       kanderso@redhat.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       limin@sgi.com, jlan@sgi.com, linux-kernel@vger.kernel.org, jh@sgi.com,
       Paul Jackson <pj@sgi.com>, gh@us.ibm.com,
       Erik Jacobson <erikj@subway.americas.sgi.com>, ralf@suse.de,
       lse-tech@lists.sourceforge.net, Vivek Kashyap <kashyapv@us.ibm.com>,
       mason@suse.com
Subject: Re: Minutes from 5/19 CKRM/PAGG discussion
References: <Pine.LNX.4.44.0405241404080.22438-100000@chimarrao.boston.redhat.com> <40B2534E.3040302@watson.ibm.com>
In-Reply-To: <40B2534E.3040302@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> Rik van Riel wrote:
> 
>> On Mon, 24 May 2004, Hanna Linder wrote:
>>
>>  
>>
>>> Minutes from LSE call on CKRM and PAGG on May 19, 2004.   
>>
>>
>> Thanks for organising this call, Hanna!
>>
> Thanks 2.. sorry I couldn't make it ...
> 
>>
>>  
>>
>>> Conclusion:
>>>
>>>     CSA/PAGG look at CKRM     CKRM look at PAGG
>>>   
>>
>>
>> I really hope the projects will be able to agree on one
>> framework.  As long as there are multiple competing
>> frameworks the chance of any of them being merged into
>> the upstream kernel is exceedingly low...
>>
>>  
>>
> Agreed, so let's get the ball rolling.
> 
> We (CKRM team) will look at PAGG (again) ... Actually we did
> last year and basically assumed due to the inactivity that
> PAGG was not actively persued anymore.
> 
> I believe at our end we will come to the conclusion that CKRM can serve
> as the base for CSA, as PAGG seems to be lowest level layer of
> this management silo. The level CSA would hook to is that of
> the CKRM event hooking which is part of the CKRM core.
> 
> One important input the PAGG team could give is some real
> examples where actually multiple associations to different groups
> is required and help us appreciate that position and let us
> see how this would/could be done in CKRM.
> 
>  From our point of view we don't see this requirement. In contrast
> we use the modified rbce (CRBCE) to push the "interesting" kernel events
> to userspace where any kind of accounting aggregation can take place.
> Yet, we believe the integrated resource scheduling (e.g. cpu) will
> always happen at the dominant class - object association in the kernel.
> 
> Another point that has not been made is that CKRM's philosophy
> is to manage any kind of objects wrt to some class type.
> By definition, PAGG is a Process Aggregation, which is a subset
> of what CKRM needs namely (obj->class) associations.
> 
> In our hooking scheme we therefore provide the ability to attach
> to so called kernel events a callback function. Any kernel code
> can attach a callback function. This is part of our core.
> 
> Any classtype (not part of the core) can register a callback at
> any of those events, so typically only limited
> events are "hooked" for a particular type. Regardless, we have
> function stacking, rather then object stacking.

I'm assuming that this means several clients can use the same callback 
simultaneously?

> 
> PAGG by itself manages the proper association of a (or several)
> "transparent" group object with the task. The functionality
> hidden behind the group object
> still needs to be implemented by the group object itself.
> 
> In CKRM this is similar, yet, the class object is associated with
> a particular class type. All interactions with the user component
> and classification engine are architected by the higher layers of CKRM,
> in that classes have automatic representation in RCFS and RBCE if
> those are loaded.
> 
> So here are some of the stickling points, we need to work on ...
> 
> (a) how can PAGG be made general enough so we can provide generic
>       KernelObject <-> ClassObject associations .. not just tasks groups.

I would suggest that rather than extending PAGG, separate mechanisms 
similar in design to PAGG be created for each KernelObject for which 
such associations are required.  Perhaps the generic component of such 
mechanisms could be separated out into a generic package and then each 
specific mechanism just provides the specialization for its KernelObject 
type.  I'd imagine that the main difference between the specialized 
packages would be (apart from the different type of KernelObject) in the 
set of callbacks provided.

> 
> (b) Can CSA use the extended rbce (CRBCE) instead of PAGG to
>       do its accounting ?

 From my (possibly incorrect) understanding of the above description, 
one thing that PAGG provides to its clients that CKRM doesn't is the 
ability to attach some private data to task structs and it passes that 
data to the client as part of the callback.  Am I correct in this 
interpretation?

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

