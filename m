Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263103AbSJGPaP>; Mon, 7 Oct 2002 11:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263104AbSJGPaP>; Mon, 7 Oct 2002 11:30:15 -0400
Received: from bohnice.netroute.lam.cz ([212.71.169.62]:25331 "EHLO
	vagabond.cybernet.cz") by vger.kernel.org with ESMTP
	id <S263103AbSJGPaF>; Mon, 7 Oct 2002 11:30:05 -0400
Date: Mon, 7 Oct 2002 17:34:38 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
Cc: Oliver Neukum <oliver@neukum.name>, Helge Hafting <helgehaf@aitel.hist.no>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Message-ID: <20021007153438.GA14993@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	Jesse Pollard <pollard@admin.navo.hpc.mil>,
	Oliver Neukum <oliver@neukum.name>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <m17yUp7-006fgcC@Mail.ZEDAT.FU-Berlin.DE> <20021007141122.GA14423@vagabond> <200210071001.22467.pollard@admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210071001.22467.pollard@admin.navo.hpc.mil>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 10:01:22AM -0500, Jesse Pollard wrote:
> On Monday 07 October 2002 09:11 am, Jan Hudec wrote:
> > On Mon, Oct 07, 2002 at 11:18:44AM +0200, Oliver Neukum wrote:
> > > On Monday 07 October 2002 10:08, Helge Hafting wrote:
> [snip]
> > >
> > > How does one measure and profile application startup other than with
> > > a stopwatch ? I'd like to gather some objective data on this.
> >
> > Add some debuging output to the program (mainly at the very begining of
> > main) and then launch it with simple program that will note time right
> > before it forks and then wait for the application to output something
> > (which should be the debuging write at the start od main) and note time
> > it returned from select.
> 
> nope... It has to be after input parameters have been evaluated, after
> X window initialization has been done, and possibly after the application
> windows are created. For a benchmark, it would likely be good to have
> them at ALL such locations. Even on exit (how long does it take to
> cleanup?).

Well, depends on what we want to measure. If it's on the begining of
main, it measures library loading time. Then argument parsing, library
initialization, X initialization etc. can be measured. All those parts
should be timed so we can see where most time is spent and which can be
sped up.

> > > > A snappy desktop is trivial with 2.5, even with a slow machine.
> > > > Just stay away from gnome and kde, use a ugly fast
> > >
> > > A desktop machine needs to run a desktop enviroment. Only a window
> > > manager is not enough.
> >
> > Please, could someone explain to me, what is desktop enviroment in
> > addition to window manager and horde of libraries for UI and IPC.
> >
> > (No, panel is not important thing and even if it were, it's a simple
> > fast application, providing it's implemented sanely (I mean, gnome panel
> > is currently buggy))
> 
> The applications that USE that horde of libraries that must be running.
> Otherwise, a blank screen would have been considered sufficient. Some
> of these applications are: tool chest (sometimes part of a WM), multiple
> desktop support (usually part of the WM, but not necessarily), WP or
> other applications activated - depending on what the user wants.

Tool chest definitely does not need most of the horde of libraries. And
it's part of most window managers (except sawfish and icewm(?))
Multiple desktop support is _the_ windowmanager. I asked what in
	addition to window manager.
Application is application using the desktop enviroment.

Thus we come back to that desktop enviroment is only a window manager
(which either provides toolchest or uses separate process to do it, but
that process does not have to be that much complicated) and a horde of
libraries for applications to cooperate together well. Some basic
application must of course be there, like a file manager.

> What you end up having to do is define what the base desktop is
> required to have to be considered "functional", and the amount of
> time available for the desktop to be ready for use. I've even seen
> M$ windows with 50-75 icons already present. Until they are initialized
> the user didn't consider the system "usable". And that took several minutes
> on an 800 MHZ system. During some of that setup the mouse was just
> unusable (frozen) or it would jump around trying to catch up with the
> users activity.

And each of them was redrawn three times during the setup...
unfortunately gnome is not far from there too.

> The other part of "usable" is how long it takes for an application to
> "start". A simple fork/exec is quite fast. But that isn't a "started" 
> application. A responsive system means that the time between
> the selection of the application to the time the user can enter data
> (ie. make a menu selection/start typing) is as short as possible. The
> users desire is about 1/4th of a second. With a large number of applications, 
> this activity requires a LOT of swap in code. Not something done fast.

Here the larger the horde of libraries used is and the larger
individual libraries in it are, the worse.

> One way some systems used to do this is to guarantee a MINIMUM of
> 50-100K of the application to be loaded BEFORE a context switch
> to the application is done. Of course, this assumes that all of the 
> initialization code can actually FIT in the first 100K. Usually it doesn't
> because a lot of that initialization is for general runtime support and X
> library initialization. Hopefully, this is already loaded and resident by a
> pre-existing application (the window manger). Unfortunately, the WM
> initialization may have already been swapped out. and some of the X
> libraries too.
> 
> The only solution for this is to not swap out at all, and have enough
> memory for everything. Which is also the first recommendation to
> improve M$ Windows performance. (got that one when a laptop
> was alread maxed out "... not enough resources, why don't you
> get some more memory...")

Well, one of worst part is loading that horde of libraries in memory.
When you take a typical gnome application, the dynamic linker has quite
hard time there, because it must at least locate all of them and mmap
them. And must do that recursively for all the dependencied (fortunately
it can use cache the ld.cache where dependencies are listed). With
many gnome applications, many of these libraries will never be used or
will be used for just one or two functions, only once ... but they are
all mmaped, which means opened, which means looked up.

So what could help quite a lot would be to try hard to make as many
things as possible lazy (both in dynamic linker and in initialization of
all those libraries).

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
