Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUK3BuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUK3BuW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 20:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUK3BuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 20:50:22 -0500
Received: from relay02.pair.com ([209.68.5.16]:5 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S261779AbUK3BuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:50:07 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <41ABD1CE.1010004@cybsft.com>
Date: Mon, 29 Nov 2004 19:50:06 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-13
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <20041129143316.GA3746@elte.hu> <20041129152344.GA9938@elte.hu> <200411291816.43591.gene.heskett@verizon.net>
In-Reply-To: <200411291816.43591.gene.heskett@verizon.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Monday 29 November 2004 10:23, Ingo Molnar wrote:
> 
>>* Ingo Molnar <mingo@elte.hu> wrote:
>>
>>>but please try to the -31-10 kernel that i've just uploaded, it
>>>has a number of tracer enhancements:
>>
>>make that -31-13 (or later). Earlier kernels had a bug in where the
>>process name tracking only worked for the first latency trace saved,
>>subsequent traces showed 'unknown' for the process name. In -13 i've
>>also added a printk that shows the latest user latency in a one-line
>>printk - just like the built-in latency tracing modes do:
>>
>>(gettimeofday/3671/CPU#0): new 3068 us user-latency.
>>(gettimeofday/3784/CPU#0): new 1008627 us user-latency.
>>
>>(this should also make it easier for helper scripts to save the
>>traces, whenever they happen.)
>>
>>Ingo
> 
> 
> I just built this to see how much blood it would draw, which isn't 
> much.  I don't have jack here, so I don't have your standard torture 
> test.  Instead, I run tvtime, which runs at a -19 priority.
> 
> I let it run about 30 seconds (untimed), noted that the frame error 
> slippage wasn't improved, and got this output histogram when I quit 
> it.
> 
> Its (tvtime) is running here of course.
> --------------------
> Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
> Nov 29 18:05:45 coyote kernel: wow!  That was a 22 millisec bump
> Nov 29 18:05:45 coyote kernel: `IRQ 8'[846] is being piggy. 
> need_resched=0, cpu=0
> Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
> Nov 29 18:05:45 coyote kernel: wow!  That was a 22 millisec bump
> Nov 29 18:05:45 coyote kernel: `IRQ 8'[846] is being piggy. 
> need_resched=0, cpu=0
> Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
> Nov 29 18:05:45 coyote kernel: wow!  That was a 21 millisec bump
> Nov 29 18:05:45 coyote kernel: `IRQ 8'[846] is being piggy. 
> need_resched=0, cpu=0
> Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
> Nov 29 18:05:45 coyote kernel: wow!  That was a 21 millisec bump
> Nov 29 18:05:45 coyote kernel: `IRQ 8'[846] is being piggy. 
> need_resched=0, cpu=0
> Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
> Nov 29 18:05:45 coyote kernel:
> 
> And was stopped here. 
> 
> Nov 29 18:05:45 coyote kernel: rtc latency histogram of {tvtime/3398, 
> 10609 samples}:
> Nov 29 18:05:45 coyote kernel: 4 11
> Nov 29 18:05:45 coyote kernel: 5 1716
> Nov 29 18:05:45 coyote kernel: 6 4827
> Nov 29 18:05:45 coyote kernel: 7 1495
> Nov 29 18:05:45 coyote kernel: 8 382
> Nov 29 18:05:45 coyote kernel: 9 193
> Nov 29 18:05:45 coyote kernel: 10 206
> Nov 29 18:05:45 coyote kernel: 11 188
> Nov 29 18:05:45 coyote kernel: 12 148
> Nov 29 18:05:45 coyote kernel: 13 202
> Nov 29 18:05:45 coyote kernel: 14 195
> Nov 29 18:05:45 coyote kernel: 15 95
> Nov 29 18:05:45 coyote kernel: 16 70
> Nov 29 18:05:45 coyote kernel: 17 23
> Nov 29 18:05:45 coyote kernel: 18 18
> Nov 29 18:05:45 coyote kernel: 19 8
> Nov 29 18:05:45 coyote kernel: 20 9
> Nov 29 18:05:45 coyote kernel: 21 1
> Nov 29 18:05:45 coyote kernel: 22 1
> Nov 29 18:05:45 coyote kernel: 26 1
> --------------------
> And I note that the 1-26 column of numbers does not seem to add up to 
> whats being logged above there, which are all 21 and 22 ms bumps 
> (whatever a bump is)

Is this all that is in the log? For some reason there are 820 samples 
not represented in the output above. The ms+ hits would have been 
represented by something like:

Nov 29 18:05:45 coyote kernel: 9999 4

Not that it is related to the missing output, but does tvtime use 
polling on the rtc?

kr

> 
> Is this a helpfull report, or just noise?  Subjectively, tvtime is 
> running with far fewer visible frame glitches than before I started 
> playing with these patches.  A marked improvement IMO.
> 

