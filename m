Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274929AbTGaXcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274943AbTGaXcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:32:18 -0400
Received: from users.ccur.com ([208.248.32.211]:50867 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S274929AbTGaXaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:30:55 -0400
Date: Thu, 31 Jul 2003 19:30:51 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect migration/%d etc from sched_setaffinity
Message-ID: <20030731233050.GE7852@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20030731224604.GA24887@tsunami.ccur.com.suse.lists.linux.kernel> <p73vftinv5c.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73vftinv5c.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 01:17:34AM +0200, Andi Kleen wrote:
> Joe Korty <joe.korty@ccur.com> writes:
> >  
> > diff -Nura linux-2.6.0-test2/include/linux/sched.h.orig linux-2.6.0-test2/include/linux/sched.h
> > --- linux-2.6.0-test2/include/linux/sched.h.orig	2003-07-27 12:57:39.000000000 -0400
> > +++ linux-2.6.0-test2/include/linux/sched.h	2003-07-31 15:52:25.000000000 -0400
> > @@ -488,6 +488,7 @@
> >  #define PF_LESS_THROTTLE 0x01000000	/* Throttle me less: I clena memory */
> >  #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
> >  #define PF_READAHEAD	0x00400000	/* I am doing read-ahead */
> > +#define PF_CPULOCK	0x00800000	/* lock users out from changing cpus_allowed */
> 
> It would be probably better to just check for ->mm == NULL
> 
> This should catch all kernel threads that use daemonize
> 
> -Andi

That is what Robert suggested and it is acceptable to me, though suboptimal..it blocks
every daemon, not just the ones that have to be blocked for system survivability.
Joe
