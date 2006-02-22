Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWBVFQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWBVFQN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 00:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWBVFQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 00:16:13 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:50336 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750929AbWBVFQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 00:16:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=GrJCKp01YwrHFd2YVveub0wEgpJ0zB53c8HnUF9Xv9MYPiEE7jr+xwgAvthI14mf07YZxHWZv2u5ID4DcCLvGD9ImwUBrqM9Asy/FxJt9XdjBI+D5AY+eJIiBxhkF8S+enG3jBDj3ONiDMD9HxGd3bYY78+qJd9P7BIOIA56WTs=  ;
Message-ID: <43FBD5D5.5020706@yahoo.com.au>
Date: Wed, 22 Feb 2006 14:09:09 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Gibson <dwg@au1.ibm.com>
CC: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Block reservation for hugetlbfs
References: <20060221022124.GA18535@localhost.localdomain> <43FA94B3.4040904@yahoo.com.au> <20060221233950.GB20872@localhost.localdomain> <43FBB292.1000304@yahoo.com.au> <20060222021106.GB23574@localhost.localdomain>
In-Reply-To: <20060222021106.GB23574@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> On Wed, Feb 22, 2006 at 11:38:42AM +1100, Nick Piggin wrote:
> 
>>David Gibson wrote:
>>
>>>On Tue, Feb 21, 2006 at 03:18:59PM +1100, Nick Piggin wrote:
>>
>>>>This introduces
>>>>tree_lock(r) -> hugetlb_lock
>>>>
>>>>And we already have
>>>>hugetlb_lock -> lru_lock
>>>>
>>>>So we now have tree_lock(r) -> lru_lock, which would deadlock
>>>>against lru_lock -> tree_lock(w), right?
>>>>
>>>
>>>>From a quick glance it looks safe, but I'd _really_ rather not
>>>
>>>>introduce something like this.
>>>
>>>
>>>Urg.. good point.  I hadn't even thought of that consequence - I was
>>>more worried about whether I need i_lock or i_mutex to protect my
>>>updates to i_blocks.
>>>
>>>Would hugetlb_lock -> tree_lock(r) be any preferable (I think that's a
>>>possible alternative).
>>>
>>
>>Yes I think that should avoid the introduction of new lock dependency.
> 
> 
> Err... "Yes" appears to contradict the rest of you statement, since my
> suggestion would still introduce a lock dependency, just a different
> one one.  It is not at all obvious to me how to avoid a lock
> dependency entirely.
> 

I mean a new core mm lock depenency (ie. lru_lock -> tree_lock).

But I must have been smoking something last night: for the life
of me I can't see why I thought there was already a hugetlb_lock
-> lru_lock dependency in there...?!

So I retract my statement. What you have there seems OK.


> Also, any thoughts on whether I need i_lock or i_mutex or something
> else would be handy..
> 

I'm not much of an fs guy. How come you don't use i_size?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
