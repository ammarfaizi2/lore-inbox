Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUK3DT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUK3DT0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 22:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbUK3DT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 22:19:26 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:18605 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261943AbUK3DTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 22:19:00 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-13
Date: Mon, 29 Nov 2004 22:19:06 -0500
User-Agent: KMail/1.7
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <200411291816.43591.gene.heskett@verizon.net> <41ABD1CE.1010004@cybsft.com>
In-Reply-To: <41ABD1CE.1010004@cybsft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411292219.06756.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.42.91] at Mon, 29 Nov 2004 21:18:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 November 2004 20:50, K.R. Foley wrote:
>Gene Heskett wrote:
>> On Monday 29 November 2004 10:23, Ingo Molnar wrote:
>>>* Ingo Molnar <mingo@elte.hu> wrote:
>>>>but please try to the -31-10 kernel that i've just uploaded, it
>>>>has a number of tracer enhancements:
>>>
>>>make that -31-13 (or later). Earlier kernels had a bug in where
>>> the process name tracking only worked for the first latency trace
>>> saved, subsequent traces showed 'unknown' for the process name.
>>> In -13 i've also added a printk that shows the latest user
>>> latency in a one-line printk - just like the built-in latency
>>> tracing modes do:
>>>
>>>(gettimeofday/3671/CPU#0): new 3068 us user-latency.
>>>(gettimeofday/3784/CPU#0): new 1008627 us user-latency.
>>>
>>>(this should also make it easier for helper scripts to save the
>>>traces, whenever they happen.)
>>>
>>>Ingo
>>
>> I just built this to see how much blood it would draw, which isn't
>> much.  I don't have jack here, so I don't have your standard
>> torture test.  Instead, I run tvtime, which runs at a -19
>> priority.
>>
>> I let it run about 30 seconds (untimed), noted that the frame
>> error slippage wasn't improved, and got this output histogram when
>> I quit it.
>>
>> Its (tvtime) is running here of course.
>> --------------------
>> Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
>> Nov 29 18:05:45 coyote kernel: wow!  That was a 22 millisec bump
>> Nov 29 18:05:45 coyote kernel: `IRQ 8'[846] is being piggy.
>> need_resched=0, cpu=0
>> Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
>> Nov 29 18:05:45 coyote kernel: wow!  That was a 22 millisec bump
>> Nov 29 18:05:45 coyote kernel: `IRQ 8'[846] is being piggy.
>> need_resched=0, cpu=0
>> Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
>> Nov 29 18:05:45 coyote kernel: wow!  That was a 21 millisec bump
>> Nov 29 18:05:45 coyote kernel: `IRQ 8'[846] is being piggy.
>> need_resched=0, cpu=0
>> Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
>> Nov 29 18:05:45 coyote kernel: wow!  That was a 21 millisec bump
>> Nov 29 18:05:45 coyote kernel: `IRQ 8'[846] is being piggy.
>> need_resched=0, cpu=0
>> Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
>> Nov 29 18:05:45 coyote kernel:
>>
>> And was stopped here.
>>
>> Nov 29 18:05:45 coyote kernel: rtc latency histogram of
>> {tvtime/3398, 10609 samples}:
>> Nov 29 18:05:45 coyote kernel: 4 11
>> Nov 29 18:05:45 coyote kernel: 5 1716
>> Nov 29 18:05:45 coyote kernel: 6 4827
>> Nov 29 18:05:45 coyote kernel: 7 1495
>> Nov 29 18:05:45 coyote kernel: 8 382
>> Nov 29 18:05:45 coyote kernel: 9 193
>> Nov 29 18:05:45 coyote kernel: 10 206
>> Nov 29 18:05:45 coyote kernel: 11 188
>> Nov 29 18:05:45 coyote kernel: 12 148
>> Nov 29 18:05:45 coyote kernel: 13 202
>> Nov 29 18:05:45 coyote kernel: 14 195
>> Nov 29 18:05:45 coyote kernel: 15 95
>> Nov 29 18:05:45 coyote kernel: 16 70
>> Nov 29 18:05:45 coyote kernel: 17 23
>> Nov 29 18:05:45 coyote kernel: 18 18
>> Nov 29 18:05:45 coyote kernel: 19 8
>> Nov 29 18:05:45 coyote kernel: 20 9
>> Nov 29 18:05:45 coyote kernel: 21 1
>> Nov 29 18:05:45 coyote kernel: 22 1
>> Nov 29 18:05:45 coyote kernel: 26 1
>> --------------------
>> And I note that the 1-26 column of numbers does not seem to add up
>> to whats being logged above there, which are all 21 and 22 ms
>> bumps (whatever a bump is)
>
>Is this all that is in the log? For some reason there are 820
> samples not represented in the output above. The ms+ hits would
> have been represented by something like:
>
>Nov 29 18:05:45 coyote kernel: 9999 4

There are NO lines in the log that look like that.  There are many 
hundred duplicates of the 3 line pattern you see at the top of the 
snip, but thats it.

AND I just discovered that I am not running the -13 kernel, but the -7 
version as I had that entry set as the fallback in grub.conf.  I've 
since reset that to the -9 kernel as fallback and thats whats running 
right now.

Which brings up something thats been an excedrin headache here since I 
bought this #*&^^$^% ati 9200-SE video card to replace a failed 
nvidia that took the motherboard with it when it failed.  Thats the 
fact that I boot blind.  From the grub screen to the start of the 
rc.sysinit script, this machine has no fonts!  Sure, I see the curser 
dancing back and forth over the bottom line of the screen, but 
nothing is displayed, and this is true whether the fonts are compiled 
in or as modules, whether the radeonfb is compiled in or as a module, 
and with or without the VGA(16) or vesafb, compiled in or as a 
module.

So its doing an automatic reboot to the kernel set as default, and 
doing it during the time that I am blind from a lack of fonts.

FWIW, I've mentioned this on a couple of occasions but no one has 
commented one way or the other.

One thing I haven't tried is to take all frame buffers out of the 
kernel, not even as available modules, in order to force it to use 
the cards own display.  That would effectively convert this machine 
into a 66 mhz 486, but I guess its worth the test.  I'll be back 
after trying that.

>
>Not that it is related to the missing output, but does tvtime use
>polling on the rtc?

Sorry.  All I can tell you is that I did have to put the rtc into the 
kernel before tvtime would run well at all.

>kr

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
