Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264060AbVBDXA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbVBDXA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbVBDW7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:59:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:56508 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264324AbVBDWed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:34:33 -0500
Date: Fri, 4 Feb 2005 14:39:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: bstroesser@fujitsu-siemens.com, roland@redhat.com, jdike@addtoit.com,
       blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Race condition in ptrace
Message-Id: <20050204143917.1f9507cb.akpm@osdl.org>
In-Reply-To: <4203F40C.8040707@yahoo.com.au>
References: <42021E35.8050601@fujitsu-siemens.com>
	<4202C18F.5010605@yahoo.com.au>
	<42036C2C.5040503@fujitsu-siemens.com>
	<4203F40C.8040707@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Bodo Stroesser wrote:
> > Nick Piggin wrote:
> > 
> >> Bodo Stroesser wrote:
> 
> >> I don't see how this could help because AFAIKS, child->saving is only
> >> set and cleared while the runqueue is locked. And the same runqueue lock
> >> is taken by wait_task_inactive.
> >>
> > 
> > Sorry, that not right. There are some routines called by sched(), that 
> > release
> > and reacquire the runqueue lock.
> > 
> 
> Oh yeah, it is the wake_sleeping_dependent / dependent_sleeper crap.
> Sorry, you are right. And that's definitely a bug in sched.c, because
> it breaks wait_task_inactive, as you've rightly observed.
> 
> Andrew, IMO this is another bug to hold 2.6.11 for.

Sure.  I wouldn't consider Bodo's patch to be the one to use though..
