Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVBPXC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVBPXC3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 18:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVBPXC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 18:02:29 -0500
Received: from fmr19.intel.com ([134.134.136.18]:23962 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262106AbVBPXCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 18:02:11 -0500
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: george@mvista.com, "David S. Miller" <davem@davemloft.net>
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
Date: Wed, 16 Feb 2005 14:55:06 -0800
User-Agent: KMail/1.5.4
Cc: Ingo Molnar <mingo@elte.hu>, rostedt@goodmis.org,
       linux-kernel@vger.kernel.org, Mark_H_Johnson@raytheon.com
References: <200502141240.14355.mgross@linux.intel.com> <20050216081143.50d0a9d6.davem@davemloft.net> <421389F5.3060007@mvista.com>
In-Reply-To: <421389F5.3060007@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502161455.07039.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 February 2005 09:59, George Anzinger wrote:
> David S. Miller wrote:
> > On Wed, 16 Feb 2005 06:16:45 +0100
> >
> > Ingo Molnar <mingo@elte.hu> wrote:
> >>Maybe the networking
> >>stack would break if we allowed the TIMER softirq (thread) to preempt
> >>the NET softirq (threads) (and vice versa)?
> >
> > The major assumption is that softirq's run indivisibly per-cpu.
> > Otherwise the per-cpu queues of RX and TX packet work would
> > get corrupted.

That's a problem (for my idea).

>
> For what its worth, I, a short while ago, put together a workqueue package
> to a) allow easy priority setting for work queues and b) change either
> softirq, tasklet or bh code to use workqueues.  This was done mostly with
> CPP macros and a few conversion routines.  I then converted the network
> code to use this package simply by adding a key include to a couple of
> files.  The result worked on UP but ended up hanging the network code on
> SMP.  Everything else still worked, but not the net stuff.  I never ran
> down the problem as the "boss" was not interested in SMP...
>

Thanks,  my implementation doesn't lock up with my unit testing (scp kernel 
tarballs).  However; I did have my scheduling pollocy for the net_tx net_rx 
and timer set to SCHED_RR using the same priority for each.  I'll fiddle with 
t relative prioites across the different soft IRQ's an see how much smoke I 
can cause.

--mgross


