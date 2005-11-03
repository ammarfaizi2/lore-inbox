Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbVKCElo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbVKCElo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 23:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVKCElo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 23:41:44 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:2921 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030333AbVKCEln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 23:41:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Q77q4wlmvBB8cJZlW0zQoFR5E530ivgDB8nPU7ZF/GJZUC9jn0NXEn3Dy0dSUOwKbUCRgqCxCW2K8NWV+VxHlOwaJHV47eUo9+aahOvE9+9srwf4vfoTkNJDMbDLs9/fDPjtcMs7QcrwxwTXKBlp80che3ff3Uc1bwa83Hd+Qqs=  ;
Message-ID: <43699573.4070301@yahoo.com.au>
Date: Thu, 03 Nov 2005 15:43:31 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: Gerrit Huizenga <gh@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com> <436888E7.1060609@yahoo.com.au> <200511021747.45599.rob@landley.net>
In-Reply-To: <200511021747.45599.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> In the UML case, I want the system to automatically be able to hand back any 
> sufficiently large chunks of memory it currently isn't using.
> 

I'd just be happy with UML handing back page sized chunks of memory that
it isn't currently using. How does contiguous memory (in either the host
or the guest) help this?

> What does this have to do with specifying hard limits of anything?  What's to 
> specify?  Workloads vary.  Deal with it.
> 

Umm, if you hadn't bothered to read the thread then I won't go through
it all again. The short of it is that if you want guaranteed unfragmented
memory you have to specify a limit.

> 
>>If there are zone rebalancing problems[*], then it would be great to
>>have more users of zones because then they will be more likely to get
>>fixed.
> 
> 
> Ok, so you want to artificially turn this into a zone balancing issue in hopes 
> of giving that area of the code more testing when, if zones weren't involved, 
> there would be no need for balancing at all?
> 
> How does that make sense?
> 

Have you looked at the frag patches? Do you realise that they have to
balance between the different types of memory blocks? Duplicating the
same or similar infrastructure (in this case, a memory zoning facility)
is a bad thing in general.

> 
>>[*] and there are, sadly enough - see the recent patches I posted to
>>     lkml for example.
> 
> 
> I was under the impression that zone balancing is, conceptually speaking, a 
> difficult problem.
> 

I am under the impression that you think proper fragmentation avoidance
is easier.

> 
>>     But I'm fairly confident that once the particularly 
>>     silly ones have been fixed,
> 
> 
> Great, you're advocating migrating the fragmentation patches to an area of 
> code that has known problems you yourself describe as "particularly silly".  
> A ringing endorsement, that.
> 

Err, the point is so we don't now have 2 layers doing very similar things,
at least one of which has "particularly silly" bugs in it.

> The fact that the migrated version wouldn't even address fragmentation 
> avoidance at all (the topic of this thread!) is apparently a side issue.
> 

Zones can be used to guaranteee physically contiguous regions with exactly
the same effectiveness as the frag patches.

> 
>>     zone balancing will no longer be a 
>>     derogatory term as has been thrown around (maybe rightly) in this
>>     thread!
> 
> 
> If I'm not mistaken, you introduced zones into this thread, you are the 
> primary (possibly only) proponent of them.

So you didn't look at Yasunori Goto's patch from last year that implements
exactly what I described, then?

> Yes, zones are a way of categorizing memory.

Yes, have you read Mel's patches? Guess what they do?

> They're not a way of defragmenting it. 

Guess what they don't?


Send instant messages to your online friends http://au.messenger.yahoo.com 
