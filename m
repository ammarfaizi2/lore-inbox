Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWDRIK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWDRIK2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 04:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWDRIK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 04:10:28 -0400
Received: from ms-smtp-05.tampabay.rr.com ([65.32.5.135]:52629 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751399AbWDRIK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 04:10:28 -0400
Message-ID: <44449EE2.8070907@cfl.rr.com>
Date: Tue, 18 Apr 2006 04:10:10 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Lee Revell <rlrevell@joe-job.com>, markh@compro.net,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RT question : softirq and minimal user RT priority
References: <200601131527.00828.Serge.Noiraud@bull.net> <1137167600.7241.22.camel@localhost.localdomain> <4443966B.8020802@compro.net> <1145286325.16138.26.camel@mindpipe>
In-Reply-To: <1145286325.16138.26.camel@mindpipe>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> Please don't trim CC lists
> 

Sorry.

> On Mon, 2006-04-17 at 09:21 -0400, Mark Hounschell wrote:
>> Steven Rostedt wrote:
>>>> Is the smallest usable real-time priority greater than the highest real-time softirq ?
>>> Nope, you can use any rt priority you want.  It's up to you whether you
>>> want to preempt the softirqs or not. Be careful, timers may be preempted
>>> from delivering signals to high priority processes.  I have a patch to
>>> fix this, but I'm waiting on input from either Thomas Gleixner or Ingo.
>>>
>>> -- Steve
>> I know this is an old thread but I seem to be having a problem similar
>> to this and I didn't find any real resolution in the archives.
>>
>> I'm using the rt16 patch on 2.6.16.5 with complete preemption. I have a
>> high priority rt compute bound task that isn't getting signals from a
>> pci cards interrupt handler. Only when I insure the rt priority of the
>> task is lower than the rt priority of the irq thread ([IRQ 193]) will my
>> task receive signals.
>>
>> Is this a bug? Is the bug in my interrupt handler? Or is this expected
>> and acceptable?
> 
> It's expected if your high priority RT task never gives up the CPU - if
> this is the case the IRQ thread should have higher priority.
> 
> Lee

The default IRQ threads seem to be at RT priorities 25-49. So a user
should never have a RT compute bound task at a RT priority higher than
25? Doesn't seem quite right. In any case, I have other less compute
bound lower priority RT tasks also running on the same CPU so my high
priority RT task must be giving up the CPU somewhere along the line. Why
is it not able to receive signals? Something is not quite right here.

Regards
Mark
