Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbTEUTvz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 15:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTEUTvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 15:51:54 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:34826 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262252AbTEUTvx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 15:51:53 -0400
Date: Wed, 21 May 2003 22:03:44 +0200
To: Duraid Madina <duraid@octopus.com.au>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
Message-ID: <20030521200344.GA3693@hh.idb.hist.no>
References: <16075.8557.309002.866895@napali.hpl.hp.com> <1053507692.1301.1.camel@laptop.fenrus.com> <3ECB57A4.1010804@octopus.com.au> <1053522732.1301.4.camel@laptop.fenrus.com> <3ECBD0EA.70307@octopus.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ECBD0EA.70307@octopus.com.au>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 05:18:02AM +1000, Duraid Madina wrote:
> Arjan van de Ven wrote:
> 
> >if you had spent the time you spent on this colorful graphic on reading
> >SUS or Posix about what sched_yield() means
> 
> Quoth the man page,
> 
> "A process can relinquish the processor voluntarily without blocking by 
> calling sched_yield. The process will then be moved to the end of the 
> queue for its static priority and a new process gets to run."
>
This assumes the implementation uses queues, one per 
priority level.
And even if it does, the process may be the only one with that
priority, making this a useless way of giving up "some time".
It'll still get rescheduled over and over and prevent
lower-priority processes from running.

 
> How you get from there to "I'm the least important thing in the system" 
> is, once again, beyond me. And even if that were a reasonable 
> interpretation of the word 'yield', you would still hope that more than 
> one CPU would get something to do if there was enough work to go around. 
> Agreed, "spinning" on sched_yield is a very naive way of doing 
> spinlocks. But that doesn't change the fact that it's a simple and 
> correct way. One would have hoped that calling sched_yield every few 
> million cycles wouldn't break the scheduler.

The way I understand it, the scheduler doesn't "break".  You just
get a lot of useless busy waiting.

Helge Hafting
