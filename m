Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbSKFUJH>; Wed, 6 Nov 2002 15:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265940AbSKFUJH>; Wed, 6 Nov 2002 15:09:07 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:3238 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S265909AbSKFUJG>;
	Wed, 6 Nov 2002 15:09:06 -0500
Date: Wed, 6 Nov 2002 15:15:45 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: /prod/PID-related proc fs question
In-Reply-To: <Pine.LNX.4.33L2.0211061505250.5858-100000@rtlab.med.cornell.edu>
Message-ID: <Pine.LNX.4.33L2.0211061509390.5858-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, Calin A. Culianu wrote:

> On Wed, 6 Nov 2002, Richard B. Johnson wrote:
>
> > On Wed, 6 Nov 2002, Calin A. Culianu wrote:
> >
> > >
> > > I just noticed something today that I found odd and I know there must be a
> > > good reason for it, but I can't think of what it might be..
> > >
> > > Basically if I am listing the contents of a /proc/PID directory, it seems
> > > that the cwd, exe, and root (symlink) entries are invalid unless the
> > > process corresponding to PID is a process owned by me, or I am root.  Why
> > > is this?
> > >
> > > Is this feature security related?
> > >
> > > If so I can't really think of any security issues that would arise from
> > > having that information as a non-priviledged user.
> > >
> > > It would seem reasonable to me that users seeing each other's
> > > /prod/PID/root and /proc/PID/exe symlinks isn't really much of a security
> > > vulnerability.. Plus it would make possible a non-root user to grab
> > > statistics on the most popular running binaries, the number of chrooted
> > > processes.. etc..  probably trivial statistics but it still would be nice
> > > to see if any other instance of an application is running (unless there
> > > already is another mechanism for this that I am unaware of).
> > >
> > > Anyway any answers appreciated...
> > >
> > > -Calin
> >
> >
> >
> > Well you know that you can send a "secret" message
> > from one task to another using Morse code?
> >
> > As a trivial example, I could use a lot of CPU time
> > for a second:
> >      while(time(NULL) == saved)
> >             ;
> >
> > I could call this a "dash".
> >
> > Then I could use a tiny bit and call it a "dot":
> >     sleep(1);
> >
> > I could then use a little bit and call it a space:
> >     while(time(NULL) == saved)
> >         usleep(1);
> >
> > If another task knew this, and could have access to my
> > task's CPU time statistics, I could send messages through
> > an "undocumented" or "rogue" channel.

Also, this is still possible even without a proc fs.  You can do this as
you mentioned but instead of looking in /proc for cpu time stats you can
just keep issuing sleep() then gettimeofday() syscalls... and the jitter
with respect to how long it takes you to wake up each sleep cycle could
possibly be your 'morse code' dot-dash scheme.

It is still going to be a _very_ noisy communication channel, and probably
requries some adaptive algorithm that can negotiate the meaning of
a 'dot' and 'dash' in a system-specific way.. (and can re-negotiate
it to cope with unforseen load on the system)...


-Calin


