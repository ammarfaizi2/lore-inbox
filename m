Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVJEQHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVJEQHz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVJEQHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:07:55 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:11923
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1030203AbVJEQHy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:07:54 -0400
Subject: Re: 2.6.14-rc3-rt2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: david singleton <dsingleton@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
In-Reply-To: <D0B94C2C-35B8-11DA-A5C0-000A959BB91E@mvista.com>
References: <20051004084405.GA24296@elte.hu>
	 <Pine.LNX.4.58.0510050928440.23350@localhost.localdomain>
	 <Pine.LNX.4.58.0510051023460.23350@localhost.localdomain>
	 <1128527319.13057.139.camel@tglx.tec.linutronix.de>
	 <D0B94C2C-35B8-11DA-A5C0-000A959BB91E@mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 05 Oct 2005 18:08:58 +0200
Message-Id: <1128528538.13057.145.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 08:58 -0700, david singleton wrote:
> >
> > Yes. Thats happening. I moved the priority of softirq-timer above
> > hackbench priority and the problem goes away. I look into this further.
> 
> I had to set the threaded softirqs to real time priorities with the hi 
> thread at 24,
> the timer thread at 23, net_rx at 22, etc.    I wanted their priorities 
>   just below the IRQ threads.
> 
>   The problem was the timer thread.  Other real time threads got in its 
> way and held off timers.
> 
> And I had to make a note if any higher priority apps depended on timers 
> that the timer
> thread had to be boosted in priority to match that real time threads 
> priority.   It's like
> the softirqd's timer thread needs priority inheritance.

Well, we had implemented this in one of the previous -rt versions for
the high resolution timers. It was a bit hacky and I did not come around
to reimplement it on top of ktimers. This is only a problem for itimers
and posix interval timers at the moment. The nanosleep variants do not
suffer from this problem as the wakeup happens directly from the hr
timer interrupt. That way we have only one instead of two task switches.

tglx




