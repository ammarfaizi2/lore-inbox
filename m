Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268080AbUJLXdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268080AbUJLXdm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 19:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUJLXdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 19:33:42 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:15366 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S268080AbUJLXdh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 19:33:37 -0400
Date: Tue, 12 Oct 2004 16:33:08 -0700
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bill Huey <bhuey@lnxw.com>, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       amakarov@ru.mvista.com, ext-rt-dev@mvista.com,
       LKML <linux-kernel@vger.kernel.org>, Doug Niehaus <niehaus@ittc.ku.edu>
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041012233308.GA31150@nietzsche.lynx.com>
References: <20041010142000.667ec673.akpm@osdl.org> <20041010215906.GA19497@elte.hu> <1097517191.28173.1.camel@dhcp153.mvista.com> <20041011204959.GB16366@elte.hu> <1097607049.9548.108.camel@dhcp153.mvista.com> <1097610393.19549.69.camel@thomas> <20041012211201.GA28590@nietzsche.lynx.com> <1097618415.19549.190.camel@thomas> <20041012223642.GB30966@nietzsche.lynx.com> <1097622634.19549.235.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097622634.19549.235.camel@thomas>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 01:10:34AM +0200, Thomas Gleixner wrote:
> > This has been articulate a couple of times by both me and Ingo (recent email).
> > The MV's system is highly unstable, not because of priority inheritance,
> > but because of basic lock violation in the lock graph itself. It's another kind
> > of SMP granularity problem. The hard problem was just what Ingo was saying and
> > it's higher, but higher in the graph.
> 
> Can you point me a bit more clear on what you are talking about ?

It's just a lock graph dependency problem. Things up top in the graph
force things below it to be non-preemptable. The things up top need
to be changed, so that things below it can also be preemptable. Sleeping
within an atomic critical section, local_irq* or preempt_count() > 0,
is a deadlock waiting to happen.

> So the natural consequence is to convert _all_ concurrency control
> mechanisms into a single identifiable one. That's a purely semantical
> conversion, in terms of macro replacement, where no functional change
> takes place.
... 
> The bad thing of hidden gcc magic is that you will not be able to
> analyse nested concurrency controls in one go. You have to figure out
> what the heck spin_lock vs. _spin_lock vs. semaphore vs. _semaphore vs.
> mutex vs. _mutex means.

Yeah, I thought of it initially as a great idea, but ultimately this
is going to impose on the overall Linux development methodology if
these patches go into the mainstream.

I know what you're saying, but I ask you to be patient. All of this
stuff is going to get clean up when I get some critical parts in place.
And, yes, I do agree that this is unspeakably horrid. The static
type determination thing probably will have to be removed at some point,
but it's useful for rapid changing in the kernel at this time so that
Ingo can make changes to keep up with MontaVista.

All I can ask is for folks to be patient as all groups get synced up
to each other and then we'll be able to talk about it more meaningfully.
A bunch of things will fall into place once we all parties are mentally
synced up.

bill

