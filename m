Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265279AbUEZBci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbUEZBci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 21:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbUEZBch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 21:32:37 -0400
Received: from CPE-203-45-91-55.nsw.bigpond.net.au ([203.45.91.55]:15853 "EHLO
	mudlark.pw.nest") by vger.kernel.org with ESMTP id S265279AbUEZBcS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 21:32:18 -0400
Message-ID: <40B3F356.2050200@aurema.com>
Date: Wed, 26 May 2004 11:31:02 +1000
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
References: <Pine.LNX.4.44.0405241404080.22438-100000@chimarrao.boston.redhat.com> <40B2534E.3040302@watson.ibm.com> <40B288BA.7010905@aurema.com> <40B35F83.8090901@watson.ibm.com>
In-Reply-To: <40B35F83.8090901@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> Peter Williams wrote:
>> From my (possibly incorrect) understanding of the above description, 
>> one thing that PAGG provides to its clients that CKRM doesn't is the 
>> ability to attach some private data to task structs and it passes that 
>> data to the client as part of the callback.  Am I correct in this 
>> interpretation?
>>
>> Peter
> 
> 
> That is the "stickling" point. Yes, PAGG provides this feature that one 
> can chain private data to the attach/detach callback. CKRM at this point 
> does not do that as we do not see the need for multiple class 
> associations in the core.

I think that you are looking at this issue too much from a CKRM point of 
view.  I.e. just because CKRM doesn't need it doesn't mean that it isn't 
  a good idea.  In fact the issue should be viewed more broadly than 
just a "resource management" point of view.

If there are multiple clients then having their per KernelObject data 
managed using the PAGG mechanism greatly simplifies the task of 
implementing a client AND reduces the potential overhead on the system 
as the alternative is for the client to use some type of search 
mechanism to find its copy of its per KernelObject specific data when 
servicing its callback functions.

> Instead we can drive such things through the 
> extended RBCE interface. Here you register callbacks to the task 
> classtype to be notified of the ckrm events.
> 
> Since we do networking, PAGG is not sufficient for us as it only deals 
> with processes.

I think that this is just a detail and that what should happen is that a 
PAGG like mechanism be applied to sockets.  Similarly, to enable memory 
management/monitoring one attached to address space structures would be 
useful.  And so on.

> Hence we need our generic infrastructure at the core 
> level. Sure we can try to modularize further to take the CKRM EVENTS 
> out.

I think that breaking these up into smaller chunks (based on the type of 
KernelObject to which they apply) would be a good idea.  The fact that 
CKRM wants to use them all isn't sufficient justification to lump them 
all together.

> Then potentially one could implement task types on top of PAGG on 
> top of CKRM Events (which are needed anyway for other the task class 
> associations), but then again PAGG brings nothing but another indirections.
> 
> It worthwhile to consider to bite the bullet and allow PAGG to enter its 
> task class association chain (1 word) and allow CKRM its own. CKRM is 
> going after the integrated resource schedulers, PAGG/CSA (afaik) does not.

I think that this is another example of you taking a too CKRM centric 
point of view.  What I'm trying to say is that I think that these lower 
level interfaces need to be more independent of CKRM's requirements.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

