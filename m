Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWEQLmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWEQLmK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 07:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWEQLmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 07:42:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:33920 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751090AbWEQLmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 07:42:08 -0400
X-Authenticated: #14349625
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: tim.c.chen@linux.intel.com, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200605172025.22626.kernel@kolivas.org>
References: <4t16i2$12rqnu@orsmga001.jf.intel.com>
	 <200605171823.24476.kernel@kolivas.org> <1147859363.8813.41.camel@homer>
	 <200605172025.22626.kernel@kolivas.org>
Content-Type: text/plain
Date: Wed, 17 May 2006 13:42:41 +0200
Message-Id: <1147866161.7676.31.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-17 at 20:25 +1000, Con Kolivas wrote:
> On Wednesday 17 May 2006 19:49, Mike Galbraith wrote:
> > On Wed, 2006-05-17 at 18:23 +1000, Con Kolivas wrote:
> > > There is a ceiling to the priority beyond which tasks that only ever
> > > sleep for very long periods cannot surpass.
> >
> > (Hmm.  The intent is more clear, ie reserve the top for low latency
> > tasks,... but that sounds a bit like xmms protection.)
> >
> > The main problem I see with this ceiling, solely from the interactivity
> > viewpoint, is that interactive tasks which have started burning cpu
> > and/or freshly forked interactive tasks land in the same spot.  Thud.c
> > demonstrates this problem quite well.  You don't want a few copies of
> > thud in the same queue with your interactive task, much less above it if
> > it's used enough cpu to drop a notch or two.  Much pain ensues.
> 
> If there are thud processes that have earned their place they deserve it, just 
> as any other task. If something uses only 1% cpu it is unfair just because it 

Fair?  I said interactivity wise.  But what the heck, if we're talking
fairness, I can say the same thing about I/O bound tasks.  Heck, it's
not fair to stop any task from reaching the top, and it's certainly not
fair to let them have (for all practical purposes) all the cpu they want
once they sleep enough.  Shoot, the scheduler is unfair even without any
interactivity code.  Long term, it splits tasks into two groups... those
that sleep for more than 50% of the time... yack yack yack... zzzzz

Let's stick to the interactivity side :)

> only ever sleeps for long sleeps to prevent it getting as good priority as 
> anything else that uses only 1% cpu. I've noticed that 'top' suffers this 
> fate for example. The problem I've had all along with thud as a test case is 
> that while it causes a pause on the system for potentially a few seconds, it 
> does this by raising the load transiently to a load of 50 (or whatever you 
> set it to). I have no problem with a system having a hiccup when the load is 
> 50, provided the system eventually recovers and isn't starved forever (which 
> it isn't). There are other means to prevent one user having that many running 
> tasks if so desired.

Three of the little buggers are enough to cause plenty of pain.

	-Mike

