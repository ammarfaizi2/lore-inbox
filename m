Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbSKFUAi>; Wed, 6 Nov 2002 15:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266092AbSKFUAi>; Wed, 6 Nov 2002 15:00:38 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:1446 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S266091AbSKFUAh>;
	Wed, 6 Nov 2002 15:00:37 -0500
Date: Wed, 6 Nov 2002 15:07:16 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: /prod/PID-related proc fs question
In-Reply-To: <Pine.LNX.3.95.1021106144738.5400A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33L2.0211061505250.5858-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, Richard B. Johnson wrote:

> On Wed, 6 Nov 2002, Calin A. Culianu wrote:
>
> >
> > I just noticed something today that I found odd and I know there must be a
> > good reason for it, but I can't think of what it might be..
> >
> > Basically if I am listing the contents of a /proc/PID directory, it seems
> > that the cwd, exe, and root (symlink) entries are invalid unless the
> > process corresponding to PID is a process owned by me, or I am root.  Why
> > is this?
> >
> > Is this feature security related?
> >
> > If so I can't really think of any security issues that would arise from
> > having that information as a non-priviledged user.
> >
> > It would seem reasonable to me that users seeing each other's
> > /prod/PID/root and /proc/PID/exe symlinks isn't really much of a security
> > vulnerability.. Plus it would make possible a non-root user to grab
> > statistics on the most popular running binaries, the number of chrooted
> > processes.. etc..  probably trivial statistics but it still would be nice
> > to see if any other instance of an application is running (unless there
> > already is another mechanism for this that I am unaware of).
> >
> > Anyway any answers appreciated...
> >
> > -Calin
>
>
>
> Well you know that you can send a "secret" message
> from one task to another using Morse code?
>
> As a trivial example, I could use a lot of CPU time
> for a second:
>      while(time(NULL) == saved)
>             ;
>
> I could call this a "dash".
>
> Then I could use a tiny bit and call it a "dot":
>     sleep(1);
>
> I could then use a little bit and call it a space:
>     while(time(NULL) == saved)
>         usleep(1);
>
> If another task knew this, and could have access to my
> task's CPU time statistics, I could send messages through
> an "undocumented" or "rogue" channel.
>
> This may seem dumb, and the example is, however there
> are commercial systems out there where you don't want any
> undocumented communications paths between tasks. They
> might be performing stock transactions for competing
> clients, etc. A back-door communications path could
> be used to steal. So, it might not be a good idea to give
> away information that another task doesn't have a "need-to-know".
>

Well then in this case why not block out /proc/PID/maps then?  In general
the first entry of this file _IS_ /proc/PID/exe!!

Also, in such systems there exist modification to the proc fs so that
processes can't see any other users, and so that proc fs is VERY empty
and provides minimal information.


This still isn't a good reason for not allowing people to see
/prod/PID/exe.. anyone else have an idea as to why this policy exists in
the kernel?

-Calin

