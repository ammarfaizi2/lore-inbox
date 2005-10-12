Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbVJLXlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVJLXlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 19:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVJLXlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 19:41:40 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:41953 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S932481AbVJLXlj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 19:41:39 -0400
Subject: Re: 2.6.14-rc4-rt1
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: george@mvista.com
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       dwalker@mvista.com, david singleton <dsingleton@mvista.com>
In-Reply-To: <434D8973.8000706@mvista.com>
References: <20051011111454.GA15504@elte.hu>
	 <1129064151.5324.6.camel@cmn3.stanford.edu>
	 <20051012061455.GA16586@elte.hu>
	 <Pine.LNX.4.58.0510120230001.5830@localhost.localdomain>
	 <434D8973.8000706@mvista.com>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 16:41:10 -0700
Message-Id: <1129160470.4633.6.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-12 at 15:08 -0700, George Anzinger wrote:
> Steven Rostedt wrote:
> > On Wed, 12 Oct 2005, Ingo Molnar wrote:
> > 
> > 
> >>i'm not sure latency traces will uncover anything useful for this bug.
> >>Your problems could be timer issues: timers going off too fast cause
> >>high keyboard repeat rates, and the same goes for the screensaver. Does
> >>'sleep 1' work as expected, or is that timing out in an "accelerated"
> >>way too?
> >>
> > 
> > 
> > I usually recommend doing a 'sleep 10'.  It really shows you if things are
> > wrong.  If a sleep 1 returns 2 seconds, or 0.5 seconds later it may not be
> > detected.  But a sleep 10 returning 20 seconds or 5 seconds later is
> > obvious.
> 
> Or maybe:
> 'time sleep 10'
> 
> Lets the machine time it.

My first thought was "this can't work" as I imagined the same timing
services would be used and you would get always 10 secs or so...

Ingo: I tried with PREEMPT_RCU=y and it made no difference. 

When the system starts to misbehave I tried 'time sleep 10' and got
really wild results:

# time sleep 10

real    0m10.007s
user    0m0.001s
sys     0m0.003s
# time sleep 10

real    0m10.006s
user    0m0.000s
sys     0m0.003s
# time sleep 10
[the return key "autorepeated" here :-]



real    0m10.006s
user    0m0.001s
sys     0m0.003s
#
#
#
# time sleep 10

real    0m0.016s
user    0m0.002s
sys     0m0.001s
[yes I really got the prompt back that fast!]
#
#
# time sleep 10

real    73m18.087s
user    0m0.000s
sys     0m0.003s
[this last one was also very fast, it did not take 73 minutes...]
# time sleep 10

real    73m18.089s
user    0m0.000s
sys     0m0.003s
#
#
# time sleep 10

real    0m10.006s
user    0m0.000s
sys     0m0.004s
# time sleep 10

real    73m18.069s
user    0m0.000s
sys     0m0.003s
# time sleep 10

And so on and so forth. At least this shows the problem clearly.
I still have to test with a up kernel and try again PREEMPT_RT.

-- Fernando


