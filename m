Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVHCC7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVHCC7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 22:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVHCC7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 22:59:05 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28913 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262000AbVHCC7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 22:59:04 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1123036936.1590.69.camel@localhost.localdomain>
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
Content-Type: text/plain
Date: Tue, 02 Aug 2005 19:58:53 -0700
Message-Id: <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 22:42 -0400, Steven Rostedt wrote:
> On Tue, 2005-08-02 at 19:25 -0700, Daniel Walker wrote:
> > On Tue, 2005-08-02 at 20:00 -0400, Steven Rostedt wrote:
> > > On Tue, 2005-08-02 at 16:38 -0700, Daniel Walker wrote:
> > > > Couldn't you just do some math off current->timestamp to see how long
> > > > the task has been running? This per arch stuff seems a bit invasive..
> > > 
> > > The thing is, I'm tracking how long the task is running in the kernel
> > > without doing a schedule.  That's actually easy, but I don't want to
> > 
> > Why make the distinction ? For what I was going for all I wanted to know
> > was that an RT task was eating up all the CPU . Did you have something
> > else in mind?
> 
> Yeah, bugs in the kernel :-)
> 
> I can change the patch to just see who is hogging the CPU for more than
> X amount of seconds (10 by default) if that pleases everyone. If that's
> what people want, then I'll send another patch tomorrow. If this is the
> way to go, then I'll add back the check for RT tasks to limit the output
> to just RT hogs.  Or is any hog OK?

The stack trace should show where the problem is . If it's in the kernel
we will see kernel functions before do_IRQ() , if it's just a whacked
out task then do_IRQ() would be first in the stack trace . 

I can't speak for everyone else, but I would want to catch both. That
way we'll know if it's just a whacked out task, or a kernel problem.

Daniel



