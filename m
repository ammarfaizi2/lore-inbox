Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVHCPLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVHCPLG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 11:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVHCPLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 11:11:06 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:53241 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262309AbVHCPLF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 11:11:05 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1123065057.1590.77.camel@localhost.localdomain>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
	 <1122931238.4623.17.camel@dhcp153.mvista.com>
	 <1122944010.6759.64.camel@localhost.localdomain>
	 <20050802101920.GA25759@elte.hu>
	 <1123011928.1590.43.camel@localhost.localdomain>
	 <1123025895.25712.7.camel@dhcp153.mvista.com>
	 <1123027226.1590.59.camel@localhost.localdomain>
	 <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123036936.1590.69.camel@localhost.localdomain>
	 <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123065057.1590.77.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 08:10:54 -0700
Message-Id: <1123081854.4993.16.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 06:30 -0400, Steven Rostedt wrote:
> On Tue, 2005-08-02 at 19:58 -0700, Daniel Walker wrote:
> > The stack trace should show where the problem is . If it's in the kernel
> > we will see kernel functions before do_IRQ() , if it's just a whacked
> > out task then do_IRQ() would be first in the stack trace . 
> 
> The problem is not differentiating tho output as kernel or user, I just
> don't want too many false positives.

I was just testing RT tasks, which are few enough currently.

> > 
> > I can't speak for everyone else, but I would want to catch both. That
> > way we'll know if it's just a whacked out task, or a kernel problem.
> 
> The thing is, it may be OK for a RT process to run in userspace for 10
> seconds without sleeping.  If this is the case, you will constantly get
> this output saying you may mave a bug. But if the kernel is running for
> 10 seconds without scheduling, I strongly believe that is a bug.  Unless

True, it's just really odd .. If someone complained to the list about a
crash, but they had a "possible softlockup" we might be able to conclude
that the task hung the system.

You said that your IRQ 14 would trigger this, but I think it wasn't
running for 10 seconds straight, it was just running frequent enough
that it was often running during the timer interrupt. I think that would
be solved if we just checked the running time.


> someone has some special driver thread, I don't know of any kernel path
> that runs for 10 seconds without going back to userspace or sleeping.

Right, and if someone did make a path like that, they wouldn't run the
softlockup code..

> I still wish there was a nice arch-independent way to tell if the task
> is running in user space from do_IRQ.  Maybe there is?  I'll post
> another thread and ask the question.

There should be a way to tell which protection level a task on when it
was interrupted . I doubt it arch independent though.

Daniel

