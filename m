Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265283AbUEZBrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265283AbUEZBrx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 21:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUEZBrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 21:47:53 -0400
Received: from CPE-203-45-91-55.nsw.bigpond.net.au ([203.45.91.55]:23533 "EHLO
	mudlark.pw.nest") by vger.kernel.org with ESMTP id S265283AbUEZBru
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 21:47:50 -0400
Message-ID: <40B3F694.9090000@aurema.com>
Date: Wed, 26 May 2004 11:44:52 +1000
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
Subject: Re: [Lse-tech] Re: Minutes from 5/19 CKRM/PAGG discussion
References: <Pine.LNX.4.44.0405241404080.22438-100000@chimarrao.boston.redhat.com> <40B2534E.3040302@watson.ibm.com> <40B2A78E.3060302@aurema.com> <40B36288.9050205@watson.ibm.com>
In-Reply-To: <40B36288.9050205@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> Peter Williams wrote:
> 
>> Hubertus Franke wrote:
>>
>>>
>>> One important input the PAGG team could give is some real
>>> examples where actually multiple associations to different groups
>>> is required and help us appreciate that position and let us
>>> see how this would/could be done in CKRM.
>>
>>
>>
>> One example would be the implementation of CPU sets (or pools) a la 
>> Solaris where there are named CPU pools to which processors and 
>> processes are assigned.   Processors can be moved between CPU pools 
>> and when this happens it is necessary to visit all the processes that 
>> are assigned to the pools involved (one losing and one gaining the 
>> processor) and change their CPU affinity masks to reflect the new 
>> assignment of processors.  PAGG would be ideal for implementing this.
>>
>> At the same time, a resource management client could be controlling 
>> resources allocated to processes based on some other criteria such as 
>> the real user or the application being run without regard to which CPU 
>> pool they are running in.
>>
>> Peter
> 
> 
> Good one, at question though is again though is whether the very 
> communalities warrant some realignment. We want to hook into the base 
> schedulers and be the clearing house or umbrella to consolidate all the 
> ideas, such as the well defined RCFS recently introduced together with 
> Rik van Riel. PAGG is as stated a way of doing things outside the core 
> kernel and hookable schedulers have been several times rejected at the 
> lkml base.

PAGG does not provide any control capabilities and anyone who wished to 
use PAGG for control would have to use existing control interfaces.  So 
this argument does not apply.

> 
> One potential is to agree that the communalities are so few that it 
> makes sense to continue with both approaches independently.
> 

I don't think that it's that bad.  The problem is that CKRM (which is 
huge) wants to do everything itself (and its way).  In reality, CKRM 
needs a lot of lower level features that don't currently exist and many 
of these features have merit in their own right independent of CKRM's 
need for them.  These lower level features should be separated out from 
CKRM and presented as the (potentially) small and easy to understand 
mechanisms that they are.  Other developers would then be free to use 
these mechanisms as they see fit (probably using them for innovative 
things not envisaged by any of us).  To fully realize their potential 
these features need to (where it's sensible) support multiple 
simultaneous clients and be as efficient and easy to use as possible 
(and some of the ideas present in PAGG would help in this regard).

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

