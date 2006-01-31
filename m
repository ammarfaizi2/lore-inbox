Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWAaQe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWAaQe0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 11:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWAaQe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 11:34:26 -0500
Received: from smtpout.mac.com ([17.250.248.47]:17360 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750934AbWAaQeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 11:34:25 -0500
In-Reply-To: <200601311856.17569.a1426z@gawab.com>
References: <OFA0FDB57C.2E4B1B4D-ON88257103.00688AE2-88257103.0069EF1C@us.ibm.com> <200601301621.24051.a1426z@gawab.com> <8F530CA8-1AC8-4AE5-8F1E-DC6518BD7D42@mac.com> <200601311856.17569.a1426z@gawab.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9162B459-F175-4F3A-9F7B-849890A9FDC2@mac.com>
Cc: Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] VM: I have a dream...
Date: Tue, 31 Jan 2006 11:34:16 -0500
To: Al Boldi <a1426z@gawab.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, unless you have a patch or something to propose, let's take this  
off-list, it's getting kind of OT now.

On Jan 31, 2006, at 10:56, Al Boldi wrote:
> Kyle Moffett wrote:
>> Is it necessarily faulty?  It seems to me that the current way  
>> works pretty well so far, and unless you can prove a really strong  
>> point the other way, there's no point in changing.  You have to  
>> remember that change introduces bugs which then have to be located  
>> and removed again, so change is not necessarily cheap.
>
> Faulty, because we are currently running a legacy solution to  
> workaround an 8,16,(32) arch bits address space limitation, which  
> does not exist in 64bits+ archs for most purposes.

There are a lot of reasons for paging, only _one_ of them is/was to  
deal with too-small address spaces.  Other reasons are that sometimes  
you really _do_ want a nonlinear mapping of data/files/libs/etc.  It  
also allows easy remapping of IO space or video RAM into application  
address spaces, etc.  If you have a direct linear mapping from  
storage into RAM, common non-linear mappings become _extremely_  
complex and CPU-intensive.

Besides, you never did address the issue of large changes causing  
large bugs.  Any large change needs to have advantages proportional  
to the bugs it will cause, and you have not yet proven this case.

> Trying to defend the current way would be similar to rejecting the  
> move from  16bit to 32bit. Do you remember that time?  One of the  
> arguments used was:  the current way works pretty well so far.

Arbitrary analogies do not prove things.  Can you cite examples that  
clearly indicate how paged-memory is to direct-linear-mapping as 16- 
bit processors are to 32-bit processors?

> There is a lot to gain, for one there is no more swapping w/ all  
> its related side-effects.

This is *NOT* true.  When you have more data than RAM, you have to  
put data on disk, which means swapping, regardless of the method in  
which it is done.

> You're dealing with memory only.  You can also run your fs inside  
> memory, like tmpfs, which is definitely faster.

Not on Linux.  We have a whole unique dcache system precisely so that  
a frequently accessed filesystem _is_ as fast as tmpfs (Unless you're  
writing and syncing a lot, in which case you still need to wait for  
disk hardware to commit data).

> And there may be lots of other advantages, due to the simplified  
> architecture applied.

Can you describe in detail your "simplified architecture"?? I can't  
see any significant complexity advantages over the standard paging  
model that Linux has.

>>> Why would you think that the shortest path between two points is  
>>> complicated, when you have the ability to fly?
>>
>> Bad analogy.
>
> If you didn't understand it's meaning.  The shortest path meaning  
> accessing hw w/o running workarounds; using 64bits+ to fly over  
> past limitations.

This makes *NO* technical sense and is uselessly vague.  Applying  
vague indirect analogies to technical topics is a fruitless  
endeavor.  Please provide technical points and reasons why it _is_  
indead shorter/better/faster, and then you can still leave out the  
analogy because the technical argument is sufficient.

>>>> But unless the stumbling block since 1980 has been that it was too
>>>> hard to get/make a CPU with a 64 bit address space, I don't see
>>>> what's different today.
>>>
>>> You are hitting the nail right on it's head here. Nothing moves the
>>> masses like mass-production.
>>
>> Uhh, no, you misread his argument: If there were other reasons that
>> this was not done in the past than lack of 64-bit CPUS, then this is
>> probably still not practical/feasible/desirable.
>
> Uhh?
> The point here is: Even if there were 64bit archs available in the  
> past, this did not mean that moving into native 64bits would be  
> commercially viable, due to its unavailability on the mass-market.

Are you even reading these messages?

1) IF the ONLY reason this was not done before is that 64-bit archs  
were hard to get, then you are right.

2) IF there were OTHER reasons, then you are not correct.

This is the argument.  You keep discussing how 64-bit archs were not  
easily available before and are now, and I AGREE, but that is NOT  
RELEVANT to the point he made.  Can you prove that there are no other  
disadvantages to a linear-mapped model?

Cheers,
Kyle Moffett

--
Q: Why do programmers confuse Halloween and Christmas?
A: Because OCT 31 == DEC 25.



