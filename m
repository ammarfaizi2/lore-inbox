Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263069AbSJGO55>; Mon, 7 Oct 2002 10:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263071AbSJGO55>; Mon, 7 Oct 2002 10:57:57 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:17572 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S263069AbSJGO5z> convert rfc822-to-8bit; Mon, 7 Oct 2002 10:57:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Jan Hudec <bulb@ucw.cz>, Oliver Neukum <oliver@neukum.name>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Mon, 7 Oct 2002 10:01:22 -0500
User-Agent: KMail/1.4.1
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <m17yUp7-006fgcC@Mail.ZEDAT.FU-Berlin.DE> <20021007141122.GA14423@vagabond>
In-Reply-To: <20021007141122.GA14423@vagabond>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210071001.22467.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 09:11 am, Jan Hudec wrote:
> On Mon, Oct 07, 2002 at 11:18:44AM +0200, Oliver Neukum wrote:
> > On Monday 07 October 2002 10:08, Helge Hafting wrote:
[snip]
> >
> > How does one measure and profile application startup other than with
> > a stopwatch ? I'd like to gather some objective data on this.
>
> Add some debuging output to the program (mainly at the very begining of
> main) and then launch it with simple program that will note time right
> before it forks and then wait for the application to output something
> (which should be the debuging write at the start od main) and note time
> it returned from select.

nope... It has to be after input parameters have been evaluated, after
X window initialization has been done, and possibly after the application
windows are created. For a benchmark, it would likely be good to have
them at ALL such locations. Even on exit (how long does it take to
cleanup?).

> > > A snappy desktop is trivial with 2.5, even with a slow machine.
> > > Just stay away from gnome and kde, use a ugly fast
> >
> > A desktop machine needs to run a desktop enviroment. Only a window
> > manager is not enough.
>
> Please, could someone explain to me, what is desktop enviroment in
> addition to window manager and horde of libraries for UI and IPC.
>
> (No, panel is not important thing and even if it were, it's a simple
> fast application, providing it's implemented sanely (I mean, gnome panel
> is currently buggy))

The applications that USE that horde of libraries that must be running.
Otherwise, a blank screen would have been considered sufficient. Some
of these applications are: tool chest (sometimes part of a WM), multiple
desktop support (usually part of the WM, but not necessarily), WP or
other applications activated - depending on what the user wants.

What you end up having to do is define what the base desktop is
required to have to be considered "functional", and the amount of
time available for the desktop to be ready for use. I've even seen
M$ windows with 50-75 icons already present. Until they are initialized
the user didn't consider the system "usable". And that took several minutes
on an 800 MHZ system. During some of that setup the mouse was just
unusable (frozen) or it would jump around trying to catch up with the
users activity.

The other part of "usable" is how long it takes for an application to
"start". A simple fork/exec is quite fast. But that isn't a "started" 
application. A responsive system means that the time between
the selection of the application to the time the user can enter data
(ie. make a menu selection/start typing) is as short as possible. The
users desire is about 1/4th of a second. With a large number of applications, 
this activity requires a LOT of swap in code. Not something done fast.

One way some systems used to do this is to guarantee a MINIMUM of
50-100K of the application to be loaded BEFORE a context switch
to the application is done. Of course, this assumes that all of the 
initialization code can actually FIT in the first 100K. Usually it doesn't
because a lot of that initialization is for general runtime support and X
library initialization. Hopefully, this is already loaded and resident by a
pre-existing application (the window manger). Unfortunately, the WM
initialization may have already been swapped out. and some of the X
libraries too.

The only solution for this is to not swap out at all, and have enough
memory for everything. Which is also the first recommendation to
improve M$ Windows performance. (got that one when a laptop
was alread maxed out "... not enough resources, why don't you
get some more memory...")

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
