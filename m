Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263826AbUEXCOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263826AbUEXCOY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 22:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbUEXCOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 22:14:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:34730 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263826AbUEXCOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 22:14:22 -0400
Date: Sun, 23 May 2004 19:13:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: rettw@rtwnetwork.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 high CPU utilization with multimedia apps {Scanned}
Message-Id: <20040523191348.27b0492b.akpm@osdl.org>
In-Reply-To: <32786.192.168.0.243.1085363267.squirrel@webmail.rtwsecurenet.com>
References: <32847.192.168.0.243.1085236590.squirrel@webmail.rtwsecurenet.com>
	<20040522172724.6c804068.akpm@osdl.org>
	<32786.192.168.0.243.1085363267.squirrel@webmail.rtwsecurenet.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rettw@rtwnetwork.com wrote:
>
> Hi Andrew,
> 
> > This could be an artifact from the instrumentation - if
> > the application is
> > doing short bursts of work the 1000Hz clock may be
> > providing more accurate
> > sampling.
> >
> > In 2.6, edit include/asm/param.h and set HZ to 100 and
> > then redo the
> > measurement.
> >
> That did it - the CPU utilization is back down to what I
> am used to seeing on 2.4. - Now, the question is - what
> was more accurate?  Was 2.4 producing abnormally low
> numbers?  Or 2.6 abnormally high?

It's hard to tell.  I'd assume that the 1000Hz number are
more accurate due to the improved sampling frequency.

If you want a really accurate estimate of CPU usage you could use
`cyclesoak' from http://www.zip.com.au/~akpm/linux/#zc.  It works by
running a low-priority busy-wait loop and then seeing how much CPU is left
over for it by the real workload.  It's not 100% accurate unless you run
your test load with SCHED_FIFO or SCHED_OTHER policy, but it's close.

Making the in-kernel instrumentation more accurate would be possible, but
would incur additional overhead in the CPU scheduler and interrupt handlers
- we don't see a lot of call for it.

But yes, one needs to be cautious when comparing 2.4 CPU load measurements
against 2.6 kernels.

>  One interesting thing,
> just below the define statements in the file mentioned
> above is a conditional define that sets HZ to 100 anyway,
> if not already defined - it almost seems that the 1000
> value is bogus to begin with.

Nope, we use 1000Hz on most architectures.
