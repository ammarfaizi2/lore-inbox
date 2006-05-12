Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWELNTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWELNTc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWELNTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:19:32 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:8855 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1751285AbWELNTb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:19:31 -0400
Message-ID: <44648B5E.80105@compro.net>
Date: Fri, 12 May 2006 09:19:26 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH -rt] irqd starvation on SMP by a single process?
References: <1147401812.1907.14.camel@cog.beaverton.ibm.com> <20060512055025.GA25824@elte.hu> <Pine.LNX.4.58.0605120337150.26721@gandalf.stny.rr.com> <4464740C.8060305@compro.net> <20060512115614.GA28377@elte.hu> <44648532.8080200@compro.net> <Pine.LNX.4.58.0605120902460.30264@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605120902460.30264@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Fri, 12 May 2006, Mark Hounschell wrote:
> 
>>> Mark, does this fix the problem?
>>>
>>> 	Ingo
>>>
>>> Index: linux-rt.q/drivers/net/3c59x.c
>>> ===================================================================
>>> --- linux-rt.q.orig/drivers/net/3c59x.c
>>> +++ linux-rt.q/drivers/net/3c59x.c
>>> @@ -1897,7 +1897,8 @@ vortex_timer(unsigned long data)
>>>
>>>  	if (vp->medialock)
>>>  		goto leave_media_alone;
>>> -	disable_irq(dev->irq);
>>> +	/* hack! */
>>> +	disable_irq_nosync(dev->irq);
>>>  	old_window = ioread16(ioaddr + EL3_CMD) >> 13;
>>>  	EL3WINDOW(4);
>>>  	media_status = ioread16(ioaddr + Wn4_Media);
>>>
>> Yes it does.
>>
> 
> 
> It fixes it for both "complete preemption" and "normal preemption"?
> 
> -- Steve
> 
> 

Nope, I still have the complete preemption problem. My box locked up
right away. Had to reboot it.

You guys know best but I think the problem the above patch fixes is
probably not related to my 'complete preemption' problem or the problem
reported by John. But my 'complete preemption' problem may certainly be
the same as Johns.

Mark
