Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265284AbUEZBym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbUEZBym (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 21:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265286AbUEZBym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 21:54:42 -0400
Received: from CPE-203-45-91-55.nsw.bigpond.net.au ([203.45.91.55]:28141 "EHLO
	mudlark.pw.nest") by vger.kernel.org with ESMTP id S265284AbUEZByi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 21:54:38 -0400
Message-ID: <40B3F8B4.50800@aurema.com>
Date: Wed, 26 May 2004 11:53:56 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: Shailabh Nagar <nagar@watson.ibm.com>, kanderso@redhat.com,
       Rik van Riel <riel@redhat.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, limin@sgi.com, jlan@sgi.com,
       linux-kernel@vger.kernel.org, jh@sgi.com, Paul Jackson <pj@sgi.com>,
       gh@us.ibm.com, Erik Jacobson <erikj@subway.americas.sgi.com>,
       ralf@suse.de, Vivek Kashyap <kashyapv@us.ibm.com>,
       lse-tech@lists.sourceforge.net, mason@suse.com
Subject: Re: Minutes from 5/19 CKRM/PAGG discussion
References: <Pine.LNX.4.44.0405241404080.22438-100000@chimarrao.boston.redhat.com>	<40B2534E.3040302@watson.ibm.com> <40B2A78E.3060302@aurema.com> <40B2CB0E.8030606@aurema.com> <40B3641F.508@watson.ibm.com>
In-Reply-To: <40B3641F.508@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> Peter Williams wrote:
> 
>> Peter Williams wrote:
>>
>>> Hubertus Franke wrote:
>>>
>>>>
>>>> One important input the PAGG team could give is some real
>>>> examples where actually multiple associations to different groups
>>>> is required and help us appreciate that position and let us
>>>> see how this would/could be done in CKRM.
>>>
>>>
>>>
>>>
>>> One example would be the implementation of CPU sets (or pools) a la 
>>> Solaris where there are named CPU pools to which processors and 
>>> processes are assigned.   Processors can be moved between CPU pools 
>>> and when this happens it is necessary to visit all the processes that 
>>> are assigned to the pools involved (one losing and one gaining the 
>>> processor) and change their CPU affinity masks to reflect the new 
>>> assignment of processors.  PAGG would be ideal for implementing this.
>>>
>>> At the same time, a resource management client could be controlling 
>>> resources allocated to processes based on some other criteria such as 
>>> the real user or the application being run without regard to which 
>>> CPU pool they are running in.
>>
>>
>>
>> Additionally, it seems to me that even within the field of resource 
>> management it is not necessarily the case that the same grouping is 
>> required for different resource types e.g. the grouping for control of 
>> CPU resources might be different to the grouping for control of 
>> network bandwidth allocation or disk space or disk I/O bandwidth, etc.
>>
>> Peter
> 
> 
> Correct, that is in principle possible. We went through this discussion 
> on the mailing list  .. (Rik, Shailabh help me out here) and decided 
> that mostly that is

Mostly isn't good enough :-)

> not being required. The extra overhead of putting that we deemed 
> unnecessary.

I think that this would be minimal.

> 
> Instead, if really desired, one would require a different classtype for 
> each of those groupings. Note however, our entire infrastructure already 
> supports that in that RCFS would pick these specialized class types up, 
> provide the proper hierarchy as an FS subdirectory structure. For us it 
> was mainly a question how we can get the most out of the initial 
> prototype without having general users have to go and specify all kinds 
> of hierarchies, i.e. one per resource.

If that is what you want (and it's not an unreasonable desire) there is 
nothing to stop CKRM from imposing this view of the world on top but you 
shouldn't be forcing this view on others.  I.e. it's easy to consolidate 
separate grouping mechanisms to have a common grouping for all 
KernelObjects but it would be very close to impossible to try to present 
separate groupings for each KernelObject if there was only one 
underlying grouping.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

