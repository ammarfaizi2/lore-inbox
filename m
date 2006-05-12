Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWELOgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWELOgn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWELOgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:36:42 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:14284 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S932086AbWELOgm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:36:42 -0400
Message-ID: <44649D73.4090700@compro.net>
Date: Fri, 12 May 2006 10:36:35 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, johnstul@us.ibm.com
Subject: Re: rt20 patch question
References: <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com> <20060512081628.GA26736@elte.hu> <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com> <20060512092159.GC18145@elte.hu> <446481C8.4090506@compro.net> <Pine.LNX.4.58.0605120854480.30264@gandalf.stny.rr.com> <44649119.5040105@compro.net> <Pine.LNX.4.58.0605120956440.30264@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605120956440.30264@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Fri, 12 May 2006, Mark Hounschell wrote:
> 
>> Steven Rostedt wrote:
>>  >
>>> I was looking at the logdump, but I don't see anything spinning.  CPU 1
>>> seems to be constantly running your v67 program (alternating with
>>> posix_cpu_timer), and CPU: 0 is still switching with the swapper, along
>>> with other tasks, so that this means nothing is just spinning and hogging
>>> the CPU (on CPU 0, but I assume the v67 tasks is suppose to keep running).
>>>
>> Yes the v67 task is the CPU process. Could it also mean I just didn't
>> get the logdump at the right time?
>>
> 
> 
> [  619.220396] CPU:0 (bash:7783) -->> (konsole:7763)
> [  619.220558] CPU:0 (konsole:7763) -->> (swapper:0)
> [  619.220706] CPU:1 (v67:11149) -->> (IRQ 161:11082)
> [  619.220717] CPU:1 (IRQ 161:11082) -->> (v67:11149)
> [  619.223111] CPU:0 (swapper:0) -->> (posix_cpu_timer:3)
> [  619.223116] CPU:0 (posix_cpu_timer:3) -->> (softirq-timer/0:5)
> [  619.223127] CPU:0 (softirq-timer/0:5) -->> (swapper:0)
> [  619.223570] CPU:1 (v67:11149) -->> (posix_cpu_timer:14)
> [  619.223573] CPU:1 (posix_cpu_timer:14) -->> (v67:11149)
> [  619.227097] CPU:0 (swapper:0) -->> (posix_cpu_timer:3)
> [  619.227099] CPU:0 (posix_cpu_timer:3) -->> (softirq-timer/0:5)
> [  619.227102] CPU:0 (softirq-timer/0:5) -->> (swapper:0)
> [  619.227566] CPU:1 (v67:11149) -->> (posix_cpu_timer:14)
> [  619.227568] CPU:1 (posix_cpu_timer:14) -->> (v67:11149)
> 
>    ...
> 
> [  633.861475] CPU:1 (v67:11149) -->> (posix_cpu_timer:14)
> [  633.861477] CPU:1 (posix_cpu_timer:14) -->> (v67:11149)
> [  633.865001] CPU:0 (swapper:0) -->> (posix_cpu_timer:3)
> [  633.865003] CPU:0 (posix_cpu_timer:3) -->> (softirq-timer/0:5)
> [  633.865006] CPU:0 (softirq-timer/0:5) -->> (swapper:0)
> [  633.865470] CPU:1 (v67:11149) -->> (posix_cpu_timer:14)
> [  633.865473] CPU:1 (posix_cpu_timer:14) -->> (v67:11149)
> [  633.866421] CPU:1 (v67:11149) -->> (IRQ 161:11082)
> [  633.866430] CPU:1 (IRQ 161:11082) -->> (v67:11149)
> [  633.868998] CPU:0 (swapper:0) -->> (posix_cpu_timer:3)
> [  633.869000] CPU:0 (posix_cpu_timer:3) -->> (softirq-timer/0:5)
> [  633.869002] CPU:0 (softirq-timer/0:5) -->> (swapper:0)
> [  633.869467] CPU:1 (v67:11149) -->> (posix_cpu_timer:14)
> [  633.869470] CPU:1 (posix_cpu_timer:14) -->> (v67:11149)
> [  633.872993] CPU:0 (swapper:0) -->> (posix_cpu_timer:3)
> [  633.872995] CPU:0 (posix_cpu_timer:3) -->> (softirq-timer/0:5)
> [  633.872998] CPU:0 (softirq-timer/0:5) -->> (swapper:0)
> [  633.873463] CPU:1 (v67:11149) -->> (posix_cpu_timer:14)
> [  633.873465] CPU:1 (posix_cpu_timer:14) -->> (v67:11149)
> [  633.874747] CPU:1 (v67:11149) -->> (IRQ 161:11082)
> [  633.874756] CPU:1 (IRQ 161:11082) -->> (v67:11149)
> [  633.876990] CPU:0 (swapper:0) -->> (posix_cpu_timer:3)
> [  633.876992] CPU:0 (posix_cpu_timer:3) -->> (softirq-timer/0:5)
> [  633.876996] CPU:0 (softirq-timer/0:5) -->> (kded:6119)
> [  633.877030] CPU:0 (kded:6119) -->> (swapper:0)
> [  633.877460] CPU:1 (v67:11149) -->> (posix_cpu_timer:14)
> [  633.877462] CPU:1 (posix_cpu_timer:14) -->> (v67:11149)
> [  633.878447] CPU:0 (swapper:0) -->> (IRQ 1:823)
> [  633.878474] CPU:0 (IRQ 1:823) -->> (softirq-tasklet:9)
> [  633.878478] CPU:0 (softirq-tasklet:9) -->> (events/0:24)
> [  633.878488] CPU:0 (events/0:24) -->> (X:5513)
> [  633.878627] CPU:0 (X:5513) -->> (konsole:7763)
> [  633.878669] CPU:0 (konsole:7763) -->> (X:5513)
> [  633.878683] CPU:0 (X:5513) -->> (konsole:7763)
> [  633.879309] CPU:0 (konsole:7763) -->> (X:5513)
> [  633.879415] CPU:0 (X:5513) -->> (konsole:7763)
> [  633.879457] CPU:0 (konsole:7763) -->> (X:5513)
> [  633.879463] CPU:0 (X:5513) -->> (konsole:7763)
> [  633.879467] CPU:0 (konsole:7763) -->> (X:5513)
> [  633.879553] CPU:0 (X:5513) -->> (kded:6119)
> [  633.879651] CPU:0 (kded:6119) -->> (kwin:6135)
> [  633.879711] CPU:0 (kwin:6135) -->> (kdesktop:6140)
> [  633.879782] CPU:0 (kdesktop:6140) -->> (kicker:6142)
> [  633.879858] CPU:0 (kicker:6142) -->> (X:5513)
> [  633.879927] CPU:0 (X:5513) -->> (kwin:6135)
> [  633.879963] CPU:0 (kwin:6135) -->> (X:5513)
> [  633.879977] CPU:0 (X:5513) -->> (bash:7783)
> [  633.880042] CPU:0 (bash:7783) -->> (konsole:7763)
> [  633.880103] CPU:0 (konsole:7763) -->> (X:5513)
> [  633.880119] CPU:0 (X:5513) -->> (konsole:7763)
> [  633.880211] CPU:0 (konsole:7763) -->> (bash:7783)
> 
> 
> Well, the bash is what turned off the logging, and the logging started at
> 619.xxx and ended at 633.xxx so that's ~14 seconds of logging.  So I would
> assume you did it in the right place.
> 
> How long does the stop happen, and what exactly freezes?  Can you ping the
> machine?  Also, have you tried to switch to a console before it freezes,
> and see if it doesn't freeze that.  I'm curious if X isn't waiting on
> something.
> 

They stops can be anywhere up to even a few minutes depending how
patient I want to be. I was just playing with it to possibly get another
log. The machine froze. Did the log thing while frozen. Then I attempted
to ssh into it from another machine. It let me in and the machine
unfroze at that same time. But only to stop again in a few seconds. The
new shell was also frozen. I sshd to it again, same thing.

While the machine was unfrozen I was able to halt the cpu process
basically taking it out of its execution loop and putting into a delay
loop of 1 ms via

while(clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &tim, NULL) &&
errno == EINTR);

As long as the CPU process is halted and in this loop the machine acts
normal. As soon as the CPU process goes back into his execution loop we
are back to the "stops".

Mark

