Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290025AbSAWU3E>; Wed, 23 Jan 2002 15:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290047AbSAWU2y>; Wed, 23 Jan 2002 15:28:54 -0500
Received: from ida.rowland.org ([192.131.102.52]:58628 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id <S290025AbSAWU2s>;
	Wed, 23 Jan 2002 15:28:48 -0500
Date: Wed, 23 Jan 2002 15:28:46 -0500 (EST)
From: Alan Stern <stern@rowland.org>
To: Andrew Morton <akpm@zip.com.au>
cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Daemonize() should re-parent its caller
In-Reply-To: <3C4F1325.C65001EE@zip.com.au>
Message-ID: <Pine.LNX.4.33L2.0201231522450.1300-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Andrew Morton wrote:

> Alan Stern wrote:
> >
> > Consider the question: what happens when a kernel thread dies?  For
> > the most part this doesn't come up, since most kernel threads stay
> > alive as long as the system is up.  But when a kernel thread dies, the
> > same thing happens as with any other thread: it becomes a zombie, and
> > its exit_signal (if any) is posted to its parent.
> >
> > ...
> >
> > But a more elegant and economical solution is to have the daemonize()
> > routine automatically re-parent its caller to be a child of init
> > (assuming the caller's parent isn't init already).  At the same time,
> > the caller's exit_signal should be set to SIGCHLD.  This would
> > definitely solve the problem, and it is unlikely to introduce any
> > incompatibilities with existing code.
> >
>
> Yes.   There's a function in the 2.4 series called reparent_to_init()
> whch does this.  Typically a kernel thread will call that immediately
> after calling daemonize().  It _should_ solve any problem which you're
> observing.  Could you please test that, and if it fixes the problem
> which you're seeing, send a patch to the USB maintainers?
>
> Perhaps we should unconditionally call reparent_to_init() from within
> daemonize().  I wimped out on doing that because of the possibility
> of strangely breaking something.
>
> Really, an audit of all callers of kernel_thread() is needed, and
> most of them should would end up using reparent_to_init().  Difficult
> to do in the 2.4 context, so we should only do this when and where
> problems are demonstrated.
>
> (But you Cc'ed Alan.  Are you using 2.2.x?)

Andrew:

Thanks for your help.  I wasn't aware of the existence of
reparent_to_init() -- I wish I knew of some way to find out about all
these little things that get added and changed in various versions of the
kernel.  Anyway, I'll check it out, and if it works I'll send a patch to
the USB and the SCSI maintainers.

(In fact, I'm using both 2.2 and 2.4.  I Cc'ed Alan Cox because it was
suggested that he would be interested, as the original proposer of
daemonize() -- I don't know if that's true or no.  If you're not
interested, Alan, I apologize for bothering you.)

Alan Stern


