Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbUCDE6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 23:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUCDE6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 23:58:46 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:64964 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261436AbUCDE6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 23:58:43 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>
Subject: Re: [Kgdb-bugreport] [PATCH][2/3] Update CVS KGDB's have kgdb_{schedule,process}_breakpoint
Date: Thu, 4 Mar 2004 10:28:33 +0530
User-Agent: KMail/1.5
Cc: Tom Rini <trini@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
References: <20040225213626.GF1052@smtp.west.cox.net> <200403031043.59092.amitkale@emsyssoft.com> <40467662.4050309@mvista.com>
In-Reply-To: <40467662.4050309@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403041028.33638.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Mar 2004 5:50 am, George Anzinger wrote:
> Amit S. Kale wrote:
> > On Wednesday 03 Mar 2004 2:49 am, George Anzinger wrote:
> >>Amit S. Kale wrote:
> >>>On Friday 27 Feb 2004 4:49 am, George Anzinger wrote:
> >>>>Amit S. Kale wrote:
> >>>>>On Thursday 26 Feb 2004 3:13 am, Tom Rini wrote:
> >>>>>>The following adds, and then makes use of kgdb_process_breakpoint /
> >>>>>>kgdb_schedule_breakpoint.  Using it i kgdb_8250.c isn't strictly
> >>>>>>needed, but it isn't wrong either.
> >>>>>
> >>>>>That makes 8250 response it a _bit_ slower. A user will notice when
> >>>>> kgdb doesn't respond within a millisecond of pressing Ctrl+C :-)
> >>>>
> >>>>Hm...  I have been wondering if it might not be a good idea to put some
> >>>>comments to the user at or around the breakpoint.  Possibly we might
> >>>> want to tell the user about where the info files are or some such. 
> >>>> This would then come up on his screen when the source code at the
> >>>> breakpoint is displayed.
> >>>
> >>>Err, well, I don't seem to understand this.
> >>>
> >>>Do you mean we print a (gdb) console message that indicates something
> >>>about a breakpoint? If we do that, there has to be a way to turn it off.
> >>>I have a (rather bad) habit of stepping through kernel code :-)
> >>
> >>No that is not what I mean.  I don't want to try to send messages to the
> >>gdb console (it is not supported by gdb at this time).  Rather, the hard
> >>coded breakpoint instruction that we use to get to the the stub when the
> >>user enters a ^C is in a particular bit of source code.  Most gdb front
> >>ends display this bit of source centered on the breakpoint instruction.
> >>What I am asking about is puting something useful here from the user
> >> point of view.  For example we might have this:
> >>
> >>/*
> >>  * This is the KGDB control C break point.  For additional info on KGDB
> >>options * and suggested macros see .../Documentation/kgdb/* in your
> >> kernel tree. * KGDB version XX.YY
> >>  */
> >>	BREAKPOINT;
> >>
> >>--------------------------------------
> >
> > This is definitely a good point.
> >
> > We may also report the exact location where kernel was running when
> > Ctrl+C came in. We have pt_regs available in do_IRQ. We can pass that to
> > process breakpoint function. The process breakpoint function can then
> > straight call handle_exception passing it pt_regs instead of going
> > through breakpoint. That will save some stack also.
>
> Uh, I would think that "bt" should cover this.  Why muddy the waters with
> other stuff.  I think the user should see exactly where he is going to go
> on the continue.  One really good reason for this is that this is the

User _will_ see the exact context where he is going to continue. If we type 
$pc=foo \n continue pc will be changed and will run in the same register 
values where the serial irq occured.


> context any
>
> p fun()

p fun() will push arguments on stack over the place where irq occured, which 
is exactly how it''ll run.

-Amit

>
> will run in.
>
> ~

