Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVDPDdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVDPDdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 23:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVDPDdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 23:33:05 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:37550 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261675AbVDPDdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 23:33:00 -0400
Date: Fri, 15 Apr 2005 23:31:29 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Sven Dietrich <sdietrich@mvista.com>
cc: "'Inaky Perez-Gonzalez'" <inaky@linux.intel.com>,
       "'Bill Huey'" <bhuey@lnxw.com>, dwalker@mvista.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, "'Esben Nielsen'" <simlo@phys.au.dk>,
       robustmutexes@lists.osdl.org
Subject: RE: FUSYN and RT
In-Reply-To: <000801c54230$73a0f940$c800a8c0@mvista.com>
Message-ID: <Pine.LNX.4.58.0504152327170.21376@localhost.localdomain>
References: <000801c54230$73a0f940$c800a8c0@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Apr 2005, Sven Dietrich wrote:

> > > >
> > > 	/** A fuqueue, a prioritized wait queue usable from
> > kernel space. */
> > > 	struct fuqueue {
> > > 	        spinlock_t lock;
> > > 	        struct plist wlist;
> > > 	        struct fuqueue_ops *ops;
> > > 	};
> > >
> >
> > Would the above spinlock_t be a raw_spinlock_t? This goes
> > back to my first question. I'm not sure how familiar you are
> > with Ingo's work, but he has turned all spinlocks into
> > mutexes, and when you really need an original spinlock, you
> > declare it with raw_spinlock_t.
> >
>
> This one probably should be a raw_spinlock.
> This lock is only held to protect access to the queues.
> Since the queues are already priority ordered, there is
> little benefit to ordering -the order of insertion-
> in case of contention on a queue, compared with the complexity.
>

Surprisingly, this makes perfect sense to me! I'm not going to comment on
this code until I actually get to see the whole package.  I don't know how
much Inaky has used Ingo's work, but I'd figured it should be a
raw_spinlock.

> Just what you want to say to a guy who says he is tired  ;)
>

This is nothing, I'm currently trying to test stuff from another thread
dealing with qdiscs in the net code. %-}

-- Steve

