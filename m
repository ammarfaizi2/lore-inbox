Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280876AbRKTEnR>; Mon, 19 Nov 2001 23:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280902AbRKTEnH>; Mon, 19 Nov 2001 23:43:07 -0500
Received: from h00010256f583.ne.mediaone.net ([66.31.45.140]:28131 "EHLO
	portent.dyndns.org") by vger.kernel.org with ESMTP
	id <S280876AbRKTEm4>; Mon, 19 Nov 2001 23:42:56 -0500
Message-Id: <200111200443.fAK4hlJ25287@portent.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
From: Lev Makhlis <mlev@despammed.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: Bug or feature? Priority in /proc/<pid>/stat for RT processes
Date: Mon, 19 Nov 2001 23:43:46 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111191131.fAJBVC058828@saturn.cs.uml.edu>
In-Reply-To: <200111191131.fAJBVC058828@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 06:31 am, Albert D. Cahalan wrote:

> > On Monday 19 November 2001 01:01 am, Albert D. Cahalan wrote:
> >> Do not do this. Just supply the raw value for ps(1) and top(1) to use.
> >> Also supply the scheduling policy type. You can tack this on the end
> >> of /proc/<pid>/stat and tell me when Linus accepts it so that I can
> >> make ps(1) and top(1) support the new info.
> >
> > [snip]
> > I think the Right Thing would be to use a f(x) = c - x transormation,
> > where c could be 100, or 0, or -20, or -100, or something else.
> > -20 or -100 have the advantage of preserving the order relationship
> > between priorities across the scheduling policies.
> >
> > The patch below uses c=-100 -- as an example.
>
> I can tell you what procps will do. The very first thing is
> to undo your transformation. Don't bother having the kernel
> muck with the numbers. The procps code will transform the
> numbers as needed to match UNIX convention and/or the tools
> which users run to set these values.

Hmm, how would you explain that the kernel mucks with the numbers
for SCHED_OTHER, but not for SCHED_FIFO/SCHED_RR?
IIRC, procps does not attempt to undo the f(x) = 20 - (10x + 5) / 10
(assuming HZ=100) transformation currently used for SCHED_OTHER.

Granted, procps can do the transformation itself, but procps does not
have a monopoly on using procfs data -- any other performance-monitoring
application would have to duplicate the transformation, if it is to be
consistent with the standard (procps) tools.  I thought it would be
nice if the kernel provided a consistent interface through procfs to
begin with.
