Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVJLXxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVJLXxm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 19:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVJLXxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 19:53:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35057 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932490AbVJLXxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 19:53:41 -0400
Message-ID: <434DA1C1.9010108@mvista.com>
Date: Wed, 12 Oct 2005 16:52:33 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       dwalker@mvista.com, david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc4-rt1
References: <20051011111454.GA15504@elte.hu>	 <1129064151.5324.6.camel@cmn3.stanford.edu>	 <20051012061455.GA16586@elte.hu>	 <Pine.LNX.4.58.0510120230001.5830@localhost.localdomain>	 <434D8973.8000706@mvista.com> <1129160470.4633.6.camel@cmn3.stanford.edu>
In-Reply-To: <1129160470.4633.6.camel@cmn3.stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Lopez-Lezcano wrote:
> On Wed, 2005-10-12 at 15:08 -0700, George Anzinger wrote:
> 
>>Steven Rostedt wrote:
>>
>>>On Wed, 12 Oct 2005, Ingo Molnar wrote:
>>>
>>>
>>>
>>>>i'm not sure latency traces will uncover anything useful for this bug.
>>>>Your problems could be timer issues: timers going off too fast cause
>>>>high keyboard repeat rates, and the same goes for the screensaver. Does
>>>>'sleep 1' work as expected, or is that timing out in an "accelerated"
>>>>way too?
>>>>
>>>
>>>
>>>I usually recommend doing a 'sleep 10'.  It really shows you if things are
>>>wrong.  If a sleep 1 returns 2 seconds, or 0.5 seconds later it may not be
>>>detected.  But a sleep 10 returning 20 seconds or 5 seconds later is
>>>obvious.
>>
>>Or maybe:
>>'time sleep 10'
>>
>>Lets the machine time it.
> 
> 
> My first thought was "this can't work" as I imagined the same timing
> services would be used and you would get always 10 secs or so...
> 
> Ingo: I tried with PREEMPT_RCU=y and it made no difference. 
> 
> When the system starts to misbehave I tried 'time sleep 10' and got
> really wild results:
> 
> # time sleep 10
> 
> real    0m10.007s
> user    0m0.001s
> sys     0m0.003s
> # time sleep 10
> 
> real    0m10.006s
> user    0m0.000s
> sys     0m0.003s
> # time sleep 10
> [the return key "autorepeated" here :-]
> 
> 
> 
> real    0m10.006s
> user    0m0.001s
> sys     0m0.003s
> #
> #
> #
> # time sleep 10
> 
> real    0m0.016s
> user    0m0.002s
> sys     0m0.001s
> [yes I really got the prompt back that fast!]
> #
> #
> # time sleep 10
> 
> real    73m18.087s
> user    0m0.000s
> sys     0m0.003s
> [this last one was also very fast, it did not take 73 minutes...]

Uh... this implies that your system clock is not keeping very good time.  Is that so?  Try:
date
time sleep 10
date

~
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
