Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSJ1HoB>; Mon, 28 Oct 2002 02:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263077AbSJ1HoB>; Mon, 28 Oct 2002 02:44:01 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:31753 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S263039AbSJ1Hn6>; Mon, 28 Oct 2002 02:43:58 -0500
Date: Sun, 27 Oct 2002 23:50:12 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: warped security
Message-ID: <20021028075012.GD21165@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20021027184548.GB21165@pegasys.ws> <200210280601.g9S612d334569@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210280601.g9S612d334569@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 01:01:02AM -0500, Albert D. Cahalan wrote:
> jw schultz writes:
> > On Sun, Oct 27, 2002 at 03:24:28AM -0500, Albert D. Cahalan wrote:
> 
> >> As a non-root user:
> >>
> >> a. I can't do readlink() on /proc/1/exe ("ls -l /proc/1/exe")
> >> b. I can do "cat /proc/1/maps" to see what files are mapped
> >>
> >> That's backwards. If a user can read /proc/1/cmdline, then
> >> they might as well be permitted to readlink() on /proc/1/exe
> >> as well. Reading /proc/1/maps is quite another matter,
> >> exposing more info than the (prohibited) /proc/1/fd/* does.
> >
> > It seems to have been this way since at least 2.2.  It isn't
> > exclusive to the /proc/*/exe.  It applies to all symlinks in
> > /proc/$pid.
> 
> Guessing:
> 
> 1. readlink and follow permissions were not distinct
> 2. symlink following in /proc wasn't done normally
> 3. therefore, readlink implied access to the target's data
> 
> Rather than fix #1 or #2, readlink() got restricted.

That is my guess regarding 2.2 (and earlier).  2.4 and
future it is explicitly tested in proc_fd_readlink() which
only applies to the links in /proc/$pid

> > As near as i can tell it seems to be a
> > functional-equivalency carryover from 2.2.  It isn't causing
> > much harm but i do wonder if this is intentional and if so,
> > why.  I'm at a loss to see why refusing to allow non-owners
> > to identify a process's cwd, exe, and root would be
> > desirable.  The only other things we refuse are mem, fd/
> > and eviron, the reasons for which are obvious and the
> > restrictions are per-file rather than as a class.
> 
> Being able to readlink() in the fd directory is much less
> revealing than the content of the maps file. IMHO both of
> them should be restricted, but the "maps" file matters more.

And i can so no reason why either should be restricted.  There
is no confidential information therein and these symlinks do
not open any access that wouldn't already exist.

> Just look at this:   cat /proc/1/maps

So what?  If the reason for your post was to suggest that
the maps file should be 400 then you should have said so.  I
don't think doing so would have any security value unless
you believe in security through obscurity.  The only
indiscretion i can think of would be to reveal the existence
of a file in a directory with --x perms (occasionally good for privacy,
always poor for security) in which case you would want maps
and all the /proc/$pid/* links restricted.

> This all looks completely mixed up. Users SHOULD NOT be able
> to read /proc/1/maps, but SHOULD be able to readlink at least
> any /proc/1/* symlink that has meaning in the current namespace.
> (so not if the observer is in a chroot environment)

Proc mounted inside a chrooted or jailed namespace is a
completely different issue.  As would be the value of the
links where the observed is chrooted.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
