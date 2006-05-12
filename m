Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWELOvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWELOvu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWELOvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:51:50 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:12168 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750727AbWELOvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:51:50 -0400
Date: Fri, 12 May 2006 10:51:41 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mark Hounschell <markh@compro.net>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, johnstul@us.ibm.com
Subject: Re: rt20 patch question
In-Reply-To: <44649D73.4090700@compro.net>
Message-ID: <Pine.LNX.4.58.0605121042580.3328@gandalf.stny.rr.com>
References: <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
 <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
 <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
 <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com>
 <20060512081628.GA26736@elte.hu> <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
 <20060512092159.GC18145@elte.hu> <446481C8.4090506@compro.net>
 <Pine.LNX.4.58.0605120854480.30264@gandalf.stny.rr.com> <44649119.5040105@compro.net>
 <Pine.LNX.4.58.0605120956440.30264@gandalf.stny.rr.com> <44649D73.4090700@compro.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 May 2006, Mark Hounschell wrote:

>
> They stops can be anywhere up to even a few minutes depending how
> patient I want to be. I was just playing with it to possibly get another
> log. The machine froze. Did the log thing while frozen. Then I attempted
> to ssh into it from another machine. It let me in and the machine
> unfroze at that same time. But only to stop again in a few seconds. The
> new shell was also frozen. I sshd to it again, same thing.

This is a good indictation of a missed wake up.  Now the question is, what
is sleeping and why didn't it wake up.

>
> While the machine was unfrozen I was able to halt the cpu process
> basically taking it out of its execution loop and putting into a delay
> loop of 1 ms via
>
> while(clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &tim, NULL) &&
> errno == EINTR);

Hmm, do you have high res timers turned on?

>
> As long as the CPU process is halted and in this loop the machine acts
> normal. As soon as the CPU process goes back into his execution loop we
> are back to the "stops".
>

Could you hook up a serial, and on the machine do a

  # cat /dev/ttyS0 &

Just to open the serial for reading.  And then on the machine on the other
end of the serial cable, bring up minicom, do a ctrl-a f t

ctl-a f sends a break,

the t will do a task dump.  Do this when the machine is stopped and see
what is running.  Hopefuly the sysrq works from serial (I've had boxes
where the keyboard sysrq didn't work but serial did).

Oh, and send me the output too.

Thanks,

-- Steve

