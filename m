Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUF2GBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUF2GBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 02:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265490AbUF2GBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 02:01:17 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:3478 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265487AbUF2GBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 02:01:14 -0400
Message-ID: <40E1059F.7020105@comcast.net>
Date: Tue, 29 Jun 2004 02:01:03 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Peter Williams <pwil3058@bigpond.net.au>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Con Kolivas <kernel@kolivas.org>, Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <200406251840.46577.mbuesch@freenet.de> <200406261929.35950.mbuesch@freenet.de> <1088363821.1698.1.camel@teapot.felipe-alfaro.com> <200406272128.57367.mbuesch@freenet.de> <1088373352.1691.1.camel@teapot.felipe-alfaro.com> <Pine.LNX.4.58.0406281013590.11399@kolivas.org> <1088412045.1694.3.camel@teapot.felipe-alfaro.com> <40DFDBB2.7010800@yahoo.com.au> <40E0A7FC.3030200@bigpond.net.au> <40E0F3B1.2030906@yahoo.com.au>
In-Reply-To: <40E0F3B1.2030906@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Peter Williams wrote:
>
>> Nick Piggin wrote:
>>
>>> Felipe Alfaro Solana wrote:
>>>
>>>> I have tested 2.6.7-bk10 plus from_2.6.7_to_staircase_7.7 patch and,
>>>> while it's definitively better than previous versions, it still 
>>>> feels a
>>>> little jerky when moving windows in X11 wrt to -mm3. Renicing makes 
>>>> it a
>>>> little bit smoother, but not as much as -mm3 without renicing.
>>>>
>>>
>>> You know, if renicing X makes it smoother, then that is a good thing
>>> IMO. X needs large amounts of CPU and low latency in order to get
>>> good interactivity, which is something the scheduler shouldn't give
>>> to a process unless it is told to.
>>
>>
>>
>> I agree.  Although the X servers CPU usage is usually relatively low 
>> (less than 5%) it does have periods when it can get quite high 
>> (greater than 80%) for reasonably long periods.  This makes it 
>> difficult to come up with a set of rules for CPU allocation that 
>> makes sure the X server gets what it needs (when it needs it) without 
>> running the risk of giving other tasks with similar load patterns 
>> unnecessary and unintentional preferential treatment.
>>
>
> Well exactly. This is what the standard scheduler tries to do, and
> it does have weird starvation and priority problems that pop up.
>
>> However, I think that there is still a need for automatic boosts for 
>> some tasks.  For instance, programs such as xmms and other media 
>> streamers are ones whose performance could worsen as a result of the 
>> X server being reniced unless it is treated specially and the boost 
>> they are given needs to be enough to put them before the X server in 
>> priority order.  But renicing X would enable a tightening of the 
>> rules that govern the automatic dispensing of preferential treatment 
>> to tasks that are perceived to be interactive which should be good 
>> for overall system performance.
>
>
> I agree renicing X is helpful.

I've seen different audio players react very differently in the same 
situations with the same kernel.  Are people testing alternatives to 
make sure it's not just the program being bad?  Maybe the people doing 
these scheduler tests are using all the popular media players and 
different widely available gui systems to make sure they're not tuning 
the kernel for a specific program.   That should probably be clarified. 

I think it ought to be made clear that the gain is being made for a type 
of program, and not a single one, a type of workload and not a workload 
consisting of this and that and this program.  That can include 
different windowing systems (xfree86 vs non-free X implimentations or 
DirectFB) and gtk vs qt vs no toolkit..  This way obvious userspace bugs 
can be exposed and all this tuning wont be done for helping keep bugs 
and bad implimentations in use. 




