Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266192AbUGONI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266192AbUGONI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 09:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUGONI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 09:08:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23686 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266192AbUGONIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 09:08:24 -0400
Date: Thu, 15 Jul 2004 09:03:47 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>, lmb@suse.de,
       arjanv@redhat.com, phillips@istop.com, sdake@mvista.com,
       teigland@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040715120347.GA17412@logos.cnet>
References: <20040712101107.GA31013@devserv.devel.redhat.com> <20040712102124.GH3933@marowsky-bree.de> <20040712102818.GB31013@devserv.devel.redhat.com> <20040712115003.GV3933@marowsky-bree.de> <20040712120127.GB16604@devserv.devel.redhat.com> <20040712131312.GY3933@marowsky-bree.de> <40F294D2.3010203@yahoo.com.au> <20040712135432.57d0133c.akpm@osdl.org> <20040714121920.GA2350@elf.ucw.cz> <40F5E9A0.3050402@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F5E9A0.3050402@yahoo.com.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 12:19:12PM +1000, Nick Piggin wrote:
> Pavel Machek wrote:
> >Hi!
> >
> >
> >>>I don't see why it would be a problem to implement a "this task
> >>>facilitates page reclaim" flag for userspace tasks that would take
> >>>care of this as well as the kernel does.
> >>
> >>Yes, that has been done before, and it works - userspace "block drivers"
> >>which permanently mark themselves as PF_MEMALLOC to avoid the obvious
> >>deadlocks.

Andrew, as curiosity, what userspace "block driver" sets PF_MEMALLOC for
normal operation?

> >>Note that you can achieve a similar thing in current 2.6 by acquiring
> >>realtime scheduling policy, but that's an artifact of some brainwave which
> >>a VM hacker happened to have and isn't a thing which should be relied 
> >>upon.
> >>
> >>A privileged syscall which allows a task to mark itself as one which
> >>cleans memory would make sense.
> >
> >
> >Does it work?
> >
> >I mean, in kernel, we have some memory cleaners (say 5), and they
> >need, say, 1MB total reserved memory.
> >
> >Now, if you add another task with PF_MEMALLOC. But now you'd need
> >1.2MB reserved memory, and you only have 1MB. Things are obviously
> >going to break at some point.
> >								Pavel
> 
> Well you'd have to be more careful than that. In particular
> you wouldn't just be starting these things up, let alone
> have them allocate 1MB in to free some memory.
> 
> This situation would still blow up whether you did it in
> kernel or not.

Indeed, such PF_MEMALLOC app can probably kill the system if it bugs
allocating lots of memory from the lower reservations. It needs
some limitation. 
