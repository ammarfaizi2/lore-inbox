Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319313AbSHWU3C>; Fri, 23 Aug 2002 16:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319390AbSHWU3C>; Fri, 23 Aug 2002 16:29:02 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:19350 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319313AbSHWU3B>;
	Fri, 23 Aug 2002 16:29:01 -0400
Message-ID: <3D669B4F.7090402@us.ibm.com>
Date: Fri, 23 Aug 2002 13:30:07 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020808
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Hartner <hartner@austin.ibm.com>
CC: Mala Anand <manand@us.ibm.com>, Benjamin LaHaise <bcrl@redhat.com>,
       alan@lxorguk.ukuu.org.uk, Bill Hartner <bhartner@us.ibm.com>,
       davem@redhat.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, lse-tech-admin@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
References: <OF1AAF39E9.D733B26C-ON87256C1E.004ACC87@boulder.ibm.com> <3D666531.4020909@us.ibm.com> <3D669737.67ED34AF@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Hartner wrote:
> 
> Dave Hansen wrote:
> 
>>Mala Anand wrote:
>>
>>>Readprofile ticks are not as accurate as the cycles I measured.
>>>Moreover readprofile can give misleading information as it profiles
>>>on timer interrupts. The alloc_skb and __kfree_skb call memory
>>>management routines and interrupts are disabled in many parts of that code.
>>>So I don't trust the readprofile data.
>>
>>I don't believe your results to be accurate.  They may be _precise_
>>for a small case, but you couldn't have been measuring them for very
>>long.  A claim of accuracy requires a large number of samples, which
>>you apparently did not do.
> 
> What is your definition of a "very long time" ?
> 
> Read the 1st email.  There were 2.4 million samples.
> 
> How many do you think is sufficient ?

I must have misunderstood the data from the first email.  I was under 
the impression that it was much smaller than that number.

>>I can't use oprofile or other NMI-based profilers on my hardware, so
>>we'll just have to guess.  Is there any chance that you have access to
>>a large Specweb setup on hardware that is close to mine and can run
>>oprofile?
> 
> Why do you think oprofile is a better way to measure this ?

Mala's main complaint about readprofile is that it cannot profile 
while interrupts are disabled.  oprofile's timer interrupts cannot be 
disabled, they _always_ occur.

> BTW, Mala works with Troy Wilson who is running SPECweb99 on
> an 8-way system using Apache.  Troy has run with Mala's patch
> and that data will be posted.

I look forward to seeing it.

>>Where are interrupts disabled?   I just went through a set of kernprof
>>data and traced up the call graph.  In the most common __kfree_skb
>>case, I do not believe that it has interupts disabled.  I could be
>>wrong, but I didn't see it.
> 
> What is the revelance of the above ?

Mala's main complaint about readprofile is that it cannot profile 
while interrupts are disabled.  I didn't see the case where it was 
being called with interrupts disabled.  I was hoping that you could 
point it out to me.

-- 
Dave Hansen
haveblue@us.ibm.com

