Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUJFC2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUJFC2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 22:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUJFC2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 22:28:34 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:22397 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266704AbUJFC22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 22:28:28 -0400
Message-ID: <41635848.8050001@yahoo.com.au>
Date: Wed, 06 Oct 2004 12:28:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Robert Love <rml@novell.com>, Roland Dreier <roland@topspin.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost> <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au> <20041006020734.GA29383@havoc.gtf.org>
In-Reply-To: <20041006020734.GA29383@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Wed, Oct 06, 2004 at 12:02:48PM +1000, Nick Piggin wrote:
> 
>>Jeff Garzik wrote:
>>
>>>On Tue, Oct 05, 2004 at 09:52:55PM -0400, Robert Love wrote:
>>>
>>>
>>>>On Tue, 2004-10-05 at 21:40 -0400, Jeff Garzik wrote:
>>>>
>>>>
>>>>
>>>>>And with preempt you're still hiding stuff that needs fixing.  And when 
>>>>>it gets fixed, you don't need preempt.
>>>>>
>>>>>Therefore, preempt is just a hack that hides stuff that wants fixing 
>>>>>anyway.
>>
>>What is it hiding exactly?
> 
> 
> Bugs and high latency code paths that should instead be fixed.
> 

OK - high latency code paths: It doesn't hide critical section latency.
I suppose you could say it hides cond_resched latency (the important
metric for !preempt kernels), but people who care about latency should
enable preempt; those that don't won't (to a point - I agree !preempt
latency needs to be kept in check with the *occasional* cond_resched).

I can't imagine it should hide any bugs though...

> 
> 
>>>>This actually sounds like the argument for preempt, and against
>>>
>>>
>>>As opposed to fixing drivers???  Please fix the drivers and code first.
>>>
>>
>>I thought you just said preempt should be turned off because it
>>breaks things (ie. as opposed to fixing the things that it breaks).
>>
>>But anyway, yeah obviously fixing drivers always == good. I don't
>>think anybody advocated otherwise.
> 
> 
> By _definition_, when you turn on preempt, you hide the stuff I just
> described above.
> 

I really don't see the requirement to have less than a few ms latency
without preempt.

> Hiding that stuff means that users and developers won't see code paths
> that need fixing.  If users and developers aren't aware of code paths
> that need fixing, they don't get fixed.
> 
> Therefore, by advocating preempt, you are advocating a solution _other
> than_ actually making the necessary fixes.
> 

So the "necessary fixes" would be adding more cond_resched checks,
right? In that case, I disagree with your assumption that the fix is
necessary (again, to a point. We don't want 10s of ms latency).
