Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264963AbUEYPWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbUEYPWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 11:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUEYPWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 11:22:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:20390 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264964AbUEYPV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 11:21:57 -0400
Message-ID: <40B3641F.508@watson.ibm.com>
Date: Tue, 25 May 2004 11:19:59 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
CC: Shailabh Nagar <nagar@watson.ibm.com>, kanderso@redhat.com,
       Rik van Riel <riel@redhat.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, limin@sgi.com, jlan@sgi.com,
       linux-kernel@vger.kernel.org, jh@sgi.com, Paul Jackson <pj@sgi.com>,
       gh@us.ibm.com, Erik Jacobson <erikj@subway.americas.sgi.com>,
       ralf@suse.de, Vivek Kashyap <kashyapv@us.ibm.com>,
       lse-tech@lists.sourceforge.net, mason@suse.com
Subject: Re: Minutes from 5/19 CKRM/PAGG discussion
References: <Pine.LNX.4.44.0405241404080.22438-100000@chimarrao.boston.redhat.com>	<40B2534E.3040302@watson.ibm.com> <40B2A78E.3060302@aurema.com> <40B2CB0E.8030606@aurema.com>
In-Reply-To: <40B2CB0E.8030606@aurema.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:

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
>> the real user or the application being run without regard to which 
>> CPU pool they are running in.
>
>
> Additionally, it seems to me that even within the field of resource 
> management it is not necessarily the case that the same grouping is 
> required for different resource types e.g. the grouping for control of 
> CPU resources might be different to the grouping for control of 
> network bandwidth allocation or disk space or disk I/O bandwidth, etc.
>
> Peter

Correct, that is in principle possible. We went through this discussion 
on the mailing list  .. (Rik, Shailabh help me out here) and decided 
that mostly that is
not being required. The extra overhead of putting that we deemed 
unnecessary.

Instead, if really desired, one would require a different classtype for 
each of those groupings. Note however, our entire infrastructure already 
supports that in that RCFS would pick these specialized class types up, 
provide the proper hierarchy as an FS subdirectory structure. For us it 
was mainly a question how we can get the most out of the initial 
prototype without having general users have to go and specify all kinds 
of hierarchies, i.e. one per resource.

-- Hubertus


