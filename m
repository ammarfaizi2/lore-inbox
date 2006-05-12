Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWELNTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWELNTX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWELNTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:19:22 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:51850 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751282AbWELNTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:19:22 -0400
Date: Fri, 12 May 2006 09:18:38 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mark Hounschell <markh@compro.net>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, johnstul@us.ibm.com
Subject: Re: rt20 patch question
In-Reply-To: <446481C8.4090506@compro.net>
Message-ID: <Pine.LNX.4.58.0605120854480.30264@gandalf.stny.rr.com>
References: <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
 <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
 <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
 <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com>
 <20060512081628.GA26736@elte.hu> <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
 <20060512092159.GC18145@elte.hu> <446481C8.4090506@compro.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 May 2006, Mark Hounschell wrote:

> Ingo Molnar wrote:
> >
> > Mark, does this fix the problem?
> >
> > 	Ingo
> >
[...]
>
> It looks like it does fix at least the BUG and network disconnection
> problem I am/was seeing. It's been 45 minutes or so without a glitch.
>
> I'm still not running this in complete preempt mode. Should I see if it
> helps that situation also? It only took a few minutes for that one to
> show up.
>


I was looking at the logdump, but I don't see anything spinning.  CPU 1
seems to be constantly running your v67 program (alternating with
posix_cpu_timer), and CPU: 0 is still switching with the swapper, along
with other tasks, so that this means nothing is just spinning and hogging
the CPU (on CPU 0, but I assume the v67 tasks is suppose to keep running).

But, this could mean that something is blocked on a lock, or missed a
wakeup somewhere and we block X from responding. Although X is shown up,
but some signal to do an event my be prevented.

I wonder if the fact that softirqs are running with preemption enabled, is
the problem here.

Could you try the patch that Ingo sent here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114741312301909&q=raw

-- Steve

